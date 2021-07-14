class Cppzmq < Formula
  desc "Header-only C++ binding for libzmq"
  homepage "http://www.zeromq.org"
  url "https://github.com/zeromq/cppzmq/archive/v4.7.1.tar.gz"
  sha256 "9853e0437d834cbed5d3c223bf1d755cadee70e7c964c6e42c4c6783dee5d02c"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "zeromq"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCPPZMQ_BUILD_TESTS=OFF"
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/hello_world.cpp", testpath
    system ENV.cxx, "hello_world.cpp", "-I#{include}", "-o", "test"
    system "./test"
  end
end
