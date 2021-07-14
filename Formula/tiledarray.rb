class Tiledarray < Formula
  desc "Massively-parallel, block-sparse tensor framework"
  homepage "https://github.com/ValeevGroup/tiledarray"
  url "https://github.com/ValeevGroup/tiledarray/archive/v1.0.0.tar.gz"
  sha256 "47b3dacd2b14872cde6e2c16c79e24f27349de3426d90471a8544ae81cb985d5"
  license "GPL-3.0"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "lapack"
  depends_on "open-mpi"
  depends_on "tbb"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/demo/demo.cpp", testpath
    system ENV.cxx, "-std=c++17", "demo.cpp",
                    "-I#{include}", "-I#{Formula["eigen"].opt_include}/eigen3",
                    "-L#{lib}", "-ltiledarray", "-lMADworld",
                    "-L#{Formula["open-mpi"].opt_lib}", "-lmpi", "-lblas",
                    "-o", "test"
    assert_match "a1: tile", shell_output("./test")
  end
end
