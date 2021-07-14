class ClairScanner < Formula
  desc "Docker containers vulnerability scan"
  homepage "https://github.com/arminc/clair-scanner"
  url "https://github.com/arminc/clair-scanner/archive/v13.tar.gz"
  sha256 "5dc7fb1e7cf694b494db0d9711d5a3317a7bcf465413dca98482461f91c8de52"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    # system "go", "build", *std_go_args
    system "make", "installLocal"
  end

  test do
  end
end
