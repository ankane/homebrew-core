class Tvm < Formula
  desc "Open deep learning compiler stack"
  homepage "https://tvm.apache.org/"
  url "https://github.com/apache/incubator-tvm/releases/download/v0.6.1/apache-tvm-src-v0.6.1-incubating.tar.gz"
  sha256 "288d4d4413b4a179f01b86ba3c676840fe1cc472f0581c5489f6ab6736d6e012"

  depends_on "cmake" => :build

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
