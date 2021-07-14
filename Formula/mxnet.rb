class Mxnet < Formula
  desc "Flexible and efficient library for deep learning"
  homepage "https://mxnet.apache.org"
  url "https://github.com/apache/incubator-mxnet/releases/download/1.6.0/apache-mxnet-src-1.6.0-incubating.tar.gz"
  sha256 "01eb06069c90f33469c7354946261b0a94824bbaf819fd5d5a7318e8ee596def"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "ccache"
  depends_on "libomp"
  depends_on "opencv"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DUSE_CUDA=OFF",
                      "-DUSE_OPENMP=OFF", "-DUSE_CPP_PACKAGE=1"
      system "make"
      system "make", "install"
    end
    pkgshare.install "cpp-package/example"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <mxnet-cpp/MxNetCpp.h>

      int main()
      {
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lmxnet", "-o", "test"
    system "./test"
  end
end
