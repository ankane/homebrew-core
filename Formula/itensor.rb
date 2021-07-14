class Itensor < Formula
  desc "C++ library for efficient tensor network calculations"
  homepage "https://itensor.org"
  url "https://github.com/ITensor/ITensor/archive/v3.1.3.tar.gz"
  sha256 "ff6b04f9c642c6795acd3485f44619282a2dde7a49a4e0dee89b47b69dc3853e"
  license "Apache-2.0"

  def install
    cp "options.mk.sample", "options.mk"
    inreplace "options.mk", "#CCCOM=clang++", "CCCOM=clang++"
    system "make"
    lib.install Dir["lib/*.a"]
    include.install "itensor"
    pkgshare.install "sample", "tutorial"
  end

  test do
    cp pkgshare/"tutorial/01_one_site/one.cc", testpath
    system ENV.cxx, "-std=c++17", "one.cc", "-o", "test", "-I#{include}",
                    "-L#{lib}", "-litensor", "-lblas", "-llapack"
    assert_match "ITensor", shell_output("./test")
  end
end
