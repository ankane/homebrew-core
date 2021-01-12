class Ifopt < Formula
  desc "Light-weight C++ Interface to Nonlinear Programming Solvers"
  homepage "https://wiki.ros.org/ifopt"
  url "https://github.com/ethz-adrl/ifopt/archive/2.0.7.tar.gz"
  sha256 "0e8e5434c722fec40ec723f85416e08bfaed859d44f9acbf37685d88d4a7406d"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "ipopt"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "ifopt_ipopt/test"
  end

  test do
    cp pkgshare/"test/ex_test_ipopt.cc", "test.cpp"
    system ENV.cxx, "-std=c++11", "test.cpp",
                    "-I#{Formula["eigen"].opt_include}/eigen3",
                    "-L#{lib}", "-lifopt_core", "-lifopt_ipopt",
                    "-o", "test"
    assert_match "Optimal Solution Found", shell_output("./test")
  end
end
