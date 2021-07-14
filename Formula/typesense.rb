class Typesense < Formula
  desc "Fast, typo tolerant search engine for building delightful search experiences"
  homepage "https://typesense.org"
  url "https://github.com/typesense/typesense/archive/refs/tags/v0.21.0.tar.gz"
  sha256 "ca33742dc60d5bf3e25f7d5f29af10368793a73f0a156afe00b3e6f7ab56f421"

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
