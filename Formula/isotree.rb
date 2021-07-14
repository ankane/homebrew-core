class Isotree < Formula
  desc "Extended Isolation Forest, SCiForest, Fair-Cut Forest, with some additions"
  homepage "https://github.com/david-cortes/isotree"
  license "BSD-2-Clause"
  head "https://github.com/david-cortes/isotree.git"

  depends_on "cmake" => :build
  depends_on "libomp"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "example"
  end

  test do
    cp pkgshare/"example/isotree_cpp_ex.cpp", testpath
    system ENV.cxx, "-std=c++11", "isotree_cpp_ex.cpp", "-L#{lib}", "-lisotree", "-o", "test"
    assert_equal "Point with highest outlier score: [3, 3]\n", shell_output("./test")
  end
end
