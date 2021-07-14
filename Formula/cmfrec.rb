class Cmfrec < Formula
  desc "Collective matrix factorization"
  homepage "https://github.com/david-cortes/cmfrec"
  url "https://github.com/david-cortes/cmfrec.git",
      revision: "d9e69573d22ab496e34cd7846082b40554dc7b4b"
  version "2.3.3"
  license "MIT"
  # head "https://github.com/david-cortes/cmfrec.git"

  depends_on "cmake" => :build
  depends_on "libomp"

  def install
    # doesn't work from build due to cmfrec.h path
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
    pkgshare.install "example"
  end

  test do
    cp pkgshare/"example/c_example.c", testpath
    system ENV.cc, "c_example.c", "-L#{lib}", "-lcmfrec", "-o", "test"
    assert_match "Approximation of X", shell_output("./test")
    system "./test"
  end
end
