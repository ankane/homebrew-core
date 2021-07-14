class Imageflow < Formula
  desc "High-performance image manipulation for web servers"
  homepage "https://docs.imageflow.io/"
  url "https://github.com/imazen/imageflow.git",
      tag:      "v1.4.10-rc50",
      revision: "1a7e1eecd8f04cab4413b48c2bf8bd5bbf140f5d"
  license "AGPL-3.0"

  depends_on "nasm" => :build
  depends_on "dssim" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  def install
    # system "cargo", "install", *std_cargo_args
    system "./build.sh", "release"
    system "./build.sh", "install", "INSTALL_BASE=#{prefix}"
  end

  test do
    system bin/"imageflow_tool", "examples", "--generate"
  end
end
