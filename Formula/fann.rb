class Fann < Formula
  desc "Fast Artificial Neural Network Library"
  homepage "https://github.com/libfann/fann"
  license "LGPL-2.1"
  head "https://github.com/libfann/fann.git"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples/.", testpath
    system ENV.cc, "xor_train.c", "-L#{lib}", "-lfann", "-o", "test"
    assert_match "Saving network", shell_output("./test")
  end
end
