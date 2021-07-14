class Libmaxdiv < Formula
  desc "Maximally Divergent Intervals for Anomaly Detection"
  homepage "https://github.com/cvjena/libmaxdiv"
  license "LGPL-3.0"
  head "https://github.com/cvjena/libmaxdiv.git"
  # url "https://github.com/cvjena/libmaxdiv/archive/v1.0.tar.gz"
  # sha256 "379ba50633a5578ba92f5f3ad86e789a4291daebc68d7c2936215de7f43cfb4e"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "eigen"

  def install
    mkdir "maxdiv/libmaxdiv/build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      lib.install Dir["*.dylib"]
      bin.install "maxdiv_cli"
    end
    pkgshare.install "experiments"
  end

  test do
    cp pkgshare/"experiments/HPW_2012_41046_standardized.csv", testpath
    output = shell_output("#{bin}/maxdiv_cli HPW_2012_41046_standardized.csv")
    # cp pkgshare/"experiments/coastdat/historic_storms.csv", testpath
    # output = shell_output("#{bin}/maxdiv_cli historic_storms.csv")

    p output
  end
end
