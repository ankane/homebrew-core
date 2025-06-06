class Circleci < Formula
  desc "Enables you to reproduce the CircleCI environment locally"
  homepage "https://circleci.com/docs/2.0/local-cli/"
  # Updates should be pushed no more frequently than once per week.
  url "https://github.com/CircleCI-Public/circleci-cli.git",
      tag:      "v0.1.32067",
      revision: "fedb2291435fc9e184de657758c5408e0f9e9b16"
  license "MIT"
  head "https://github.com/CircleCI-Public/circleci-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a4cbc3defd06403f2f5e058d30479fca499a1bf046f2983c0030d13cc4d6a1b6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a4cbc3defd06403f2f5e058d30479fca499a1bf046f2983c0030d13cc4d6a1b6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a4cbc3defd06403f2f5e058d30479fca499a1bf046f2983c0030d13cc4d6a1b6"
    sha256 cellar: :any_skip_relocation, sonoma:        "951ea51427fe8f67445286296bd6aaced4dfe3d617114418e337a6af1ecc7fea"
    sha256 cellar: :any_skip_relocation, ventura:       "951ea51427fe8f67445286296bd6aaced4dfe3d617114418e337a6af1ecc7fea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5c0c457b77cc30bf05b105d696c213df6850bba3ef1d935dc6662b227edc4da"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/CircleCI-Public/circleci-cli/version.packageManager=#{tap.user.downcase}
      -X github.com/CircleCI-Public/circleci-cli/version.Version=#{version}
      -X github.com/CircleCI-Public/circleci-cli/version.Commit=#{Utils.git_short_head}
      -X github.com/CircleCI-Public/circleci-cli/telemetry.SegmentEndpoint=https://api.segment.io
    ]
    system "go", "build", *std_go_args(ldflags:)

    generate_completions_from_executable(bin/"circleci", "--skip-update-check", "completion",
                                        shells: [:bash, :zsh])
  end

  test do
    ENV["CIRCLECI_CLI_TELEMETRY_OPTOUT"] = "1"
    # assert basic script execution
    assert_match(/#{version}\+.{7}/, shell_output("#{bin}/circleci version").strip)
    (testpath/".circleci.yml").write("{version: 2.1}")
    output = shell_output("#{bin}/circleci config pack #{testpath}/.circleci.yml")
    assert_match "version: 2.1", output
    # assert update is not included in output of help meaning it was not included in the build
    assert_match(/update.+This command is unavailable on your platform/, shell_output("#{bin}/circleci help 2>&1"))
    assert_match "update is not available because this tool was installed using homebrew.",
      shell_output("#{bin}/circleci update")
  end
end
