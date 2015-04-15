class Osm2pgsql < Formula
  homepage "http://wiki.openstreetmap.org/wiki/Osm2pgsql"
  url "https://github.com/openstreetmap/osm2pgsql/archive/0.87.0.tar.gz"
  sha1 "6f302500e52d6e42147cc8dff8f344677e3131f8"
  revision 1

  bottle do
  end

  depends_on :postgresql
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "boost"
  depends_on "geos"
  depends_on "proj"
  depends_on "protobuf-c" => :optional

  # Fixes an upstream issue:
  #   https://github.com/openstreetmap/osm2pgsql/issues/196
  # Remove the patch when upgrading
  patch do
    url "https://github.com/openstreetmap/osm2pgsql/commit/943684a9b86bee46d245970b3e5870f83afc9208.diff"
    sha1 "01c681513959b285038b3582afc1c1d63e440209"
  end

  def install
    args = [
      "--prefix=#{prefix}",
      "--disable-dependency-tracking",
      "--with-proj=#{Formula["proj"].opt_prefix}",
      "--with-boost=#{Formula["boost"].opt_prefix}",
      "--with-zlib=/usr",
      "--with-bzip2=/usr",
      # Related to the patch, remove this line when upgrading
      "--without-lockfree",
    ]
    puts args
    if build.with? "protobuf-c"
      args << "--with-protobuf-c=#{Formula["protobuf-c"].opt_prefix}"
    end
    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "version #{version}",
      shell_output("#{bin}/osm2pgsql -h 2>&1", 1)
  end
end
