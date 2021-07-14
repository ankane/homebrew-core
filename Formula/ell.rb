class Ell < Formula
  desc "Embedded Learning Library"
  homepage "https://microsoft.github.io/ELL"
  url "https://github.com/microsoft/ELL/archive/v3.1.0.tar.gz"
  sha256 "b3826dbad7e4259a7f53f4752fee63fc96fde9e63fba65b6f16c7e631020ae0a"

  depends_on "cmake" => :build
  depends_on "flake8"
  depends_on "llvm@8"
  depends_on "python@3.8"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DDISABLE_PYTHON=ON"
      system "make"
      system "make", "install"
    end
  end

  test do
  end
end
