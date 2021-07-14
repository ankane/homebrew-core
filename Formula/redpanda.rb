class Redpanda < Formula
  desc "Real-time streaming engine for modern apps"
  homepage "https://github.com/vectorizedio/redpanda"
  url "https://github.com/vectorizedio/redpanda/archive/release-20.11.6.tar.gz"
  sha256 "9c22c24ca6047b5e0a3012f594fdf58a9dc1669dd8e7de7eb76908f0267d452d"
  license "BUSL-1.1" # non-OSI

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"rpk", "--help"
  end
end
