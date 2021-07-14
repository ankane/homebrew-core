class Burrow < Formula
  desc "Kafka Consumer Lag Checking"
  homepage "https://github.com/linkedin/Burrow"
  url "https://github.com/linkedin/Burrow/archive/v1.3.4.tar.gz"
  sha256 "e1fe093753a31363e893b8186f98474cd7d418437b48468893919fb5779b0ac6"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
    libexec.install "config"
  end

  test do
    cp_r libexec/"config", testpath/"config"
    system bin/"burrow", "--config-dir", "config"
  end
end
