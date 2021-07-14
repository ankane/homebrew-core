class Liblbfgs < Formula
  desc "Limited-memory Broyden-Fletcher-Goldfarb-Shanno"
  homepage "https://github.com/chokkan/liblbfgs"
  license "MIT"
  head "https://github.com/chokkan/liblbfgs.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    inreplace "autogen.sh", "libtool", "glibtool"
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    pkgshare.install "sample"
  end

  test do
    cp pkgshare/"sample/sample.c", testpath
    system ENV.cc, "sample.c", "-L#{lib}", "-llbfgs", "-o", "test"
    system "./test"
  end
end
