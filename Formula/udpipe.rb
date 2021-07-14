class Udpipe < Formula
  desc "Trainable pipeline for natural language processing"
  homepage "https://github.com/ufal/udpipe"
  license "MPL-2.0"
  head "https://github.com/ufal/udpipe.git"

  def install
    cd "src" do
      system "make"
      bin.install "udpipe"
    end
    pkgshare.install "releases/test_data"
  end

  test do
    cp pkgshare/"test_data/test.model", testpath
    touch "input.txt" # need better test
    system bin/"udpipe", "test.model", "input.txt"
  end
end
