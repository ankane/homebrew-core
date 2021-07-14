class Libfm < Formula
  desc "Library for factorization machines"
  homepage "https://github.com/srendle/libfm"
  license "GPL-3.0"
  head "https://github.com/srendle/libfm.git"

  def install
    system "make"
    bin.install "bin/libFM"
  end

  test do
    system bin/"libFM"
  end
end
