class Mimalloc < Formula
  desc "Compact general purpose allocator"
  homepage "https://github.com/microsoft/mimalloc"
  url "https://github.com/microsoft/mimalloc/archive/v1.6.4.tar.gz"
  sha256 "fa616b1ae76b558ec38c411c59afa52b5963d7e7ac70551955e0607212d80aad"
  license "MIT"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      # installs files in wrong directory
      # https://github.com/microsoft/mimalloc/issues/223
      system "make", "install"
    end
    pkgshare.install "test"
  end

  test do
    cp pkgshare/"test/main.c", testpath
    system ENV.cc, "main.c", "-L#{lib}", "-lmimalloc", "-o", "test"
    system "./test"
  end
end
