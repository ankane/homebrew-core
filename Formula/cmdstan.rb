class Cmdstan < Formula
  desc "Probabilistic programming language for Bayesian inference"
  homepage "https://mc-stan.org/"
  url "https://github.com/stan-dev/cmdstan/releases/download/v2.25.0/cmdstan-2.25.0.tar.gz"
  sha256 "6bd90c6513d386f22007750f136c3f8db0132aa3e80c7298095516c68ab95a4a"

  def install
    system "make", "build"
    include.install "stan/src/stan"
    lib.install Dir["lib/*"]
    bin.install "bin/stansummary"
    bin.install "bin/stanc"
    pkgshare.install "examples"
  end

  test do
    cp_r (pkgshare/"examples/bernoulli/bernoulli.stan"), testpath
    system "#{bin}/stanc", "bernoulli.stan"
    system "make", "bernoulli_model.o"
  end
end
