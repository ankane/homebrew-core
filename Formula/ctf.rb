class Ctf < Formula
  desc "Cyclops Tensor Framework"
  homepage "https://github.com/cyclops-community/ctf"
  # url "https://github.com/cyclops-community/ctf/archive/v1.5.5.tar.gz"
  # sha256 "e53a011a4795d3f41a6226b335ddeb248aadaa206eb9d7013a8e2fd607cd5aa1"
  url "https://github.com/cyclops-community/ctf.git"
  version "0.0.0"
  license "BSD-2-Clause"

  depends_on "open-mpi"
  depends_on "openblas"
  depends_on "scalapack"

  def install
    system "./configure", "--install-dir=#{prefix}", "CXX=mpicxx"
    system "make"
    system "make", "install"
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/matmul.cxx", testpath
    system ENV.cxx, "-std=c++11", "matmul.cxx", "-o", "test",
                    "-L#{lib}", "-lctf",
                    "-L#{Formula["open-mpi"].opt_lib}", "-lmpi"
    assert_match "iterations completed", shell_output("./test")
  end
end
