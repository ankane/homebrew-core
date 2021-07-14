class Libffm < Formula
  desc "Library for Field-aware Factorization Machines"
  homepage "https://github.com/ycjuan/libffm"
  url "https://github.com/ycjuan/libffm/archive/v123.tar.gz"
  sha256 "c74b502c6a8ade03164b2466fc604805815a22ba7607f45d8dedccf4584c13d5"
  license "BSD-3-Clause"

  depends_on "libomp"

  def install
    inreplace "Makefile", "-fopenmp", "-Xpreprocessor -fopenmp -lomp"
    system "make"
    bin.install "ffm-train", "ffm-predict"
  end

  test do
    (testpath/"data.txt").write <<~EOS
      0 0:0:1
      1 1:0:2
    EOS
    system bin/"ffm-train", "data.txt", "model.txt"
    system bin/"ffm-predict", "data.txt", "model.txt", "output.txt"
    assert_predicate testpath/"output.txt", :exist?
  end
end
