class BehaviortreeCpp < Formula
  desc "Behavior Trees Library in C++"
  homepage "https://www.behaviortree.dev/"
  url "https://github.com/BehaviorTree/BehaviorTree.CPP/archive/3.5.3.tar.gz"
  sha256 "aa479ba1fd96a5798dd1d1db193843ffd0c0b91ec8253318d31f82f28f001ac4"
  license "MIT"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "cppzmq"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_UNIT_TESTS=OFF"
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/t03_generic_ports.cpp", testpath/"test.cpp"
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lbehaviortree_cpp_v3", "-o", "test"
    assert_match "Target positions: [ -1.0, 3.0 ]", shell_output("./test")
  end
end
