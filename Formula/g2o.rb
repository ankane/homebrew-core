class G2o < Formula
  desc "General Framework for Graph Optimization"
  homepage "https://github.com/RainerKuemmerle/g2o"
  url "https://github.com/RainerKuemmerle/g2o/archive/20200410_git.tar.gz"
  version "2020-04-10"
  sha256 "b79eb1407ae7f2a9e6a002bb4b41d65402c185855db41a9ef4a6e3b42abaec4c"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "suite-sparse"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "g2o/examples"
  end

  test do
    cp pkgshare/"examples/sphere/create_sphere.cpp", testpath
    system ENV.cxx, "-std=c++11", "create_sphere.cpp", "-I#{include}",
                    "-I#{Formula["eigen"].opt_include}/eigen3",
                    "-L#{lib}", "-lg2o_core", "-lg2o_stuff", "-lg2o_types_slam3d",
                    "-o", "test"
    assert_match "EDGE_SE3", shell_output("./test")
  end
end
