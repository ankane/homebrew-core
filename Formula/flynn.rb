class Flynn < Formula
  desc "Next generation platform as a service"
  homepage "https://flynn.io"
  url "https://github.com/flynn/flynn/archive/v20200329.0.tar.gz"
  sha256 "9571e3071d14200efa1bab96104f51c3c1b245571baa89b0086084abdf340baf"
  license "BSD-3-Clause"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cli"
  end

  test do
    output = shell_output("#{bin}/flynn cluster")
    assert_match "NAME", output
  end
end
