class Lwan < Formula
  desc "Experimental, scalable, high performance HTTP server"
  homepage "https://lwan.ws"
  url "https://github.com/lpereira/lwan/archive/v0.3.tar.gz"
  sha256 "c3df960351095bc1c42b1c976801f1c4aa49682606b07fb6fe40f181f84c5320"
  license "GPL-2.0"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
    end
    bin.install "src/bin/lwan/lwan"
  end

  test do
  end
end
