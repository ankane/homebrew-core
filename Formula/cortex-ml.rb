class CortexMl < Formula
  desc "Build machine learning APIs"
  homepage "https://github.com/cortexlabs/cortex"
  url "https://github.com/cortexlabs/cortex/archive/v0.18.1.tar.gz"
  sha256 "39aad95be37e7063af89bf3c0c2c14256a52d69ac86d95013925cd012bc798fe"
  license "Apache-2.0"

  depends_on "go" => :build

  conflicts_with "cortex", :because => "both install `cortex` binaries"

  def install
    system "go", "build", *std_go_args, "-o", bin/"cortex", "./cli"
    pkgshare.install "examples"
  end

  test do
    output = shell_output("#{bin}/cortex get 2>&1", 1)
    assert_match "error: unable to connect to the Docker daemon", output
  end
end
