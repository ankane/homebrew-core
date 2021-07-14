class Nmslib < Formula
  desc "Efficient similarity search library"
  homepage "https://github.com/nmslib/nmslib"
  url "https://github.com/nmslib/nmslib/archive/v2.0.6.tar.gz"
  sha256 "7da2aeeeea456fa97cb8f3a779f91021e9d34f470f56d4a92ff1c8f336fdf81a"

  depends_on "cmake" => :build

  def install
    cd "similarity_search" do
      system "cmake", ".", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "sample_standalone_app", "sample_data"
  end

  test do
    cp pkgshare/"sample_standalone_app/sample_standalone_app2.cc", testpath
    cp_r pkgshare/"sample_data/.", testpath
    system ENV.cxx, "-std=c++11", "sample_standalone_app2.cc", "-o", "test",
                    "-I#{include}", "-L#{lib}", "-lNonMetricSpaceLib"
    output = shell_output("./test l2 sift_10k.txt final128_10K.txt")
    assert_match "Small-world index is created!", output
  end
end
