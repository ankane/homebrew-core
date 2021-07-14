class Modsecurity < Formula
  desc "Web application firewall (WAF) engine for Apache, IIS and Nginx"
  homepage "https://www.modsecurity.org"
  url "https://github.com/SpiderLabs/ModSecurity.git",
      branch: "v3/master"
  version "0.0.0"
  # url "https://github.com/SpiderLabs/ModSecurity/archive/v3.0.4.tar.gz"
  # sha256 "20e3d316aa795987319d560502c3927ed5d6b96db509cd359854d55125abe164"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./build.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
  end
end
