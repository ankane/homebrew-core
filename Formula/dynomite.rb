class Dynomite < Formula
  desc "Generic dynamo implementation for different k-v storage engines"
  homepage "https://github.com/Netflix/dynomite"
  url "https://github.com/Netflix/dynomite/archive/v0.6.22.tar.gz"
  sha256 "9c3c60d95b39939f3ce596776febe8aa00ae8614ba85aa767e74d41e302e704a"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@1.1"

  def install
    system "autoreconf", "-fvi"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--sbindir=#{bin}"
    system "make"
    system "make", "install"
  end

  test do
    stats_port = free_port
    (testpath/"dynomite.yml").write <<~EOS
      dyn_o_mite:
        listen: 127.0.0.1:#{free_port}
        dyn_listen: 127.0.0.1:#{free_port}
        stats_listen: 127.0.0.1:#{stats_port}
        servers:
        - 127.0.0.1:22122:1
    EOS

    fork { exec bin/"dynomite", "-c", "dynomite.yml" }
    sleep 1
    assert_match "OK", shell_output("curl -s 127.0.0.1:#{stats_port}")
  end
end
