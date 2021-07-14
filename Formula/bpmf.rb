class Bpmf < Formula
  desc "Bayesian Probabilistic Matrix Factorization using Markov Chain Monte Carlo"
  homepage "https://github.com/ExaScience/bpmf"
  url "https://github.com/ExaScience/bpmf/archive/v0.2.tar.gz"
  sha256 "9aed26581a690e68dcc73c2f2afa5065b85ed567b3241189b7fc4e084f7de3b7"
  license "MIT"
  head "https://github.com/ExaScience/bpmf.git"

  depends_on "eigen" => :build
  depends_on "libomp" => :build

  def install
    cd "build/makefiles/macos/nocomm-omp" do
      system "make"
      bin.install "bpmf"
    end
    pkgshare.install "data"
  end

  test do
    cp_r pkgshare/"data/tiny/.", testpath
    system bin/"bpmf", "-n", "train.mtx", "-p", "test.mtx"
  end
end
