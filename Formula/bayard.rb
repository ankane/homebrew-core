class Bayard < Formula
  desc "Full-text search and indexing server written in Rust"
  homepage "https://github.com/bayard-search/bayard"
  url "https://github.com/bayard-search/bayard/archive/v0.8.1.tar.gz"
  sha256 "7773265d3ba1ffd25fd33fd4fa2eae46300c9ce8e3f28b0e22e1601efb390480"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "jq" => :build
  depends_on "rust" => :build

  def install
    system "make", "build"
    pp Dir["**/*"]
    bin.install Dir["bin/*"]
  end

  test do
  end
end
