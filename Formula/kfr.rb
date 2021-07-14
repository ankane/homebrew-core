class Kfr < Formula
  desc "Fast, modern C++ DSP framework"
  homepage "https://www.kfr.dev"
  url "https://github.com/kfrlib/kfr/archive/4.2.0.tar.gz"
  sha256 "45f1a5cce8f86dcfc60ae79c0fbab3f0877983a736db2e53a02af85604cdaa1d"
  license "GPL-2.0"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCPU_ARCH=nehalem", "-DENABLE_CAPI_BUILD=ON"
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp (pkgshare/"examples/dft.cpp"), testpath
    system ENV.cxx, "-std=c++17", "dft.cpp", "-L#{lib}", "-lkfr_dft", "-lkfr_io",
                    "-I#{include}", "-mno-sse3", "-o", "test"
    assert_match "KFR #{version}", shell_output("./test")
  end
end
