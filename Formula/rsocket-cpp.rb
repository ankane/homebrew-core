class RsocketCpp < Formula
  desc "C++ implementation of RSocket"
  homepage "http://rsocket.io"
  url "https://github.com/rsocket/rsocket-cpp/archive/v2020.06.15.00.tar.gz"
  sha256 "802e742a1268c76737f31c2ca7c33b4e9625df13a29b5bef41a17a4c7ecd0392"

  depends_on "cmake" => :build
  depends_on "folly"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_BENCHMARKS=OFF",
                      "-DBUILD_EXAMPLES=OFF", "-DBUILD_TESTS=OFF"
      system "make"
      system "make", "install"
    end
    pkgshare.install "rsocket/examples"
  end

  test do
    cp_r (pkgshare/"examples/request-response-hello-world/."), testpath

    args = %W[
      -std=c++14
      -I#{include}
      -I#{Formula["openssl@1.1"].opt_include}
      -L#{lib}
      -L#{Formula["folly"].opt_lib}
      -L#{Formula["gflags"].opt_lib}
      -L#{Formula["glog"].opt_lib}
      -L#{Formula["openssl@1.1"].opt_lib}
      -lfolly
      -lgflags
      -lglog
      -lReactiveSocket
      -lssl
      -lyarpl
    ]

    system ENV.cxx, "RequestResponseHelloWorld_Server.cpp", "-o", "server", *args
    system ENV.cxx, "RequestResponseHelloWorld_Client.cpp", "-o", "client", *args

    port = free_port
    fork { exec "./server", "-port", port.to_s }
    sleep 1
    # terminates with newline
    _, status = Open3.capture2("./client", "-port", port.to_s, :stdin_data => "\n")
    assert status.success?
  end
end
