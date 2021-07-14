class Oidn < Formula
  desc "Intel Open Image Denoise library"
  homepage "http://www.openimagedenoise.org/"
  url "https://github.com/OpenImageDenoise/oidn.git",
      :tag      => "v1.2.1",
      :revision => "29a2957e9cdcbe53ed744179c6a5b978b111f0b9"

  depends_on "cmake" => :build
  depends_on "git-lfs" => :build
  depends_on "ispc" => :build
  depends_on "tbb"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
  end
end
