class Libxsmm < Formula
  desc "Library for specialized dense and sparse matrix operations, and deep learning primitives"
  homepage "https://libxsmm.readthedocs.io/"
  url "https://github.com/hfp/libxsmm/archive/1.16.1.tar.gz"
  sha256 "93dc7a3ec40401988729ddb2c6ea2294911261f7e6cd979cf061b5c3691d729d"
  license "BSD-3-Clause"

  def install
    system "make", "install", "PREFIX=#{prefix}", "STATIC=0"
    pkgshare.install "samples"
  end

  test do
    cp pkgshare/"samples/hello/hello.c", testpath
    system ENV.cc, "hello.c", "-I#{include}", "-L#{lib}", "-lxsmm", "-o", "test"
    system "./test"
  end
end
