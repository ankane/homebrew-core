class Openpose < Formula
  desc "Real-time multi-person keypoint detection library"
  homepage "https://github.com/CMU-Perceptual-Computing-Lab/openpose"
  url "https://github.com/CMU-Perceptual-Computing-Lab/openpose/archive/v1.6.0.tar.gz"
  sha256 "000975f503635e60f408bf72c148b927db52b3da577c669c29904a394f4eece9"

  depends_on "cmake" => :build
  depends_on "caffe"
  depends_on "libomp"
  depends_on "opencv"

  def install
    mkdir "build" do
      args = std_cmake_args

      caffe = Formula["caffe"]
      args << "-DBUILD_CAFFE=OFF"
      args << "-DCaffe_INCLUDE_DIRS=#{caffe.opt_include}"
      args << "-DCaffe_LIBS=#{caffe.opt_lib}/libcaffe.dylib"

      # remove in next version
      # https://github.com/CMU-Perceptual-Computing-Lab/openpose/pull/1645
      args << "-DCaffe_LIBS_RELEASE=#{caffe.opt_lib}/libcaffe.dylib"

      # OpenMP not automatically detected
      libomp = Formula["libomp"]
      args << "-DOpenMP_C_FLAGS=-Xpreprocessor\ -fopenmp\ -I#{libomp.opt_include}"
      args << "-DOpenMP_C_LIB_NAMES=omp"
      args << "-DOpenMP_CXX_FLAGS=-Xpreprocessor\ -fopenmp\ -I#{libomp.opt_include}"
      args << "-DOpenMP_CXX_LIB_NAMES=omp"
      args << "-DOpenMP_omp_LIBRARY=#{libomp.opt_lib}/libomp.a"

      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/tutorial_api_cpp/01_body_from_image_default.cpp", "test.cpp"
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lopenpose",
                                "-L#{Formula["opencv"].opt_lib}", "-lopencv",
                                "-I#{include}",
                                "-I#{Formula["opencv"].opt_include}",
                                "-o", "test"
    system "./test"
  end
end
