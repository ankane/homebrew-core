class Catboost < Formula
  desc "Fast, scalable, high performance gradient boosting"
  homepage "https://catboost.ai/"
  url "https://github.com/catboost/catboost/archive/v0.23.2.tar.gz"
  sha256 "789eeded452cb79a822d463df50fe8d2a603a6afed668c029510299907b8f4a1"
  license "Apache-2.0"

  def install
    cd "catboost/app" do
      system "../../ya", "make", "-r", "-DHAVE_CUDA=no"
    end
    # follow symlink
    bin.install (buildpath/"catboost/app/catboost").realpath
    pkgshare.install "catboost/tutorials"
  end

  test do
    cp_r pkgshare/"tutorials/cmdline_tutorial/.", testpath

    args = %w[
      --learn-set train.tsv
      --test-set test.tsv
      --column-description train.cd
      --loss-function Logloss
    ]
    output = shell_output("#{bin}/catboost fit #{args.join(" ")}")
    assert_match "bestIteration", output
  end
end
