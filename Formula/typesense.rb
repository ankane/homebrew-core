class Typesense < Formula
  desc "Fast, typo tolerant search engine for building delightful search experiences"
  homepage "https://typesense.org"
  url "https://github.com/typesense/typesense/archive/v0.15.0.tar.gz"
  sha256 "d338f92e1dab2bef09c11721740d7164052d89fd9687ab4145b3a5ed887fd03e"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "curl-openssl"
  depends_on "gflags"
  depends_on "glog"
  depends_on "icu4c"
  depends_on "leveldb"
  depends_on "libuv"
  depends_on "nghttp2"
  depends_on "openssl@1.1"
  depends_on "protobuf"
  depends_on "snappy"
  depends_on "wslay"
  depends_on "zlib"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    mkdir testpath/"data"
    api_port = free_port
    fork do
      exec bin/"typesense-server", "--api-key=test",
                                   "--api-port=#{api_port}",
                                   "--data-dir=#{testpath}/data",
                                   "--peering-port=#{free_port}"
    end
    sleep 3
    response = shell_output("curl -s 127.0.0.1:#{api_port}/health")
    assert JSON.parse(response)["ok"]
  end
end
