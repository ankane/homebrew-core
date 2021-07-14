class Limbo < Formula
  desc "Lightweight framework for Gaussian processes"
  homepage "https://www.resibots.eu/limbo"
  url "https://github.com/resibots/limbo/archive/v2.1.0.tar.gz"
  sha256 "fbbb7abff0c45bbd314e960c3eb4ffc2d5d4ac7c85521484d37b0133e56a0a4c"
  license "CECILL-C"

  depends_on "boost"
  depends_on "eigen"
  depends_on "nlopt"
  depends_on "tbb"

  def install
    system "./waf", "configure", "--prefix=#{prefix}"
    system "./waf", "build"
  end

  test do
    # TODO
  end
end
