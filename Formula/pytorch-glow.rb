class PytorchGlow < Formula
  desc "Compiler for Neural Network hardware accelerators"
  homepage "https://github.com/pytorch/glow"
  url "https://github.com/pytorch/glow.git"
  version "0.0.0"
  sha256 ""
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "wget" => :build
  depends_on "graphviz"
  depends_on "libpng"
  depends_on "protobuf"
  depends_on "glog"
  depends_on "autopep8"
  depends_on "llvm"
  depends_on "boost"
  depends_on "double-conversion"
  depends_on "gflags"
  depends_on "jemalloc"
  depends_on "libevent"
  depends_on "lz4"
  depends_on "openssl@1.1"
  depends_on "pkg-config"
  depends_on "snappy"
  depends_on "xz"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
  end
end
