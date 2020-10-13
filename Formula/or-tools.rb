class OrTools < Formula
  desc "Google's Operations Research tools"
  homepage "https://developers.google.com/optimization/"
  url "https://github.com/google/or-tools/archive/v8.0.tar.gz"
  sha256 "ac01d7ebde157daaeb0e21ce54923a48e4f1d21faebd0b08a54979f150f909ee"
  license "Apache-2.0"
  head "https://github.com/google/or-tools.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "abseil"
  depends_on "cbc"
  depends_on "cgl"
  depends_on "clp"
  depends_on "coinutils"
  depends_on "gflags"
  depends_on "glog"
  depends_on "osi"
  depends_on "protobuf"

  def install
    mkdir "build" do
      # SCIP license is not open source and avoid installing example binaries
      system "cmake", "..", *std_cmake_args, "-DUSE_SCIP=OFF", "-DBUILD_EXAMPLES=OFF"
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/cpp/random_tsp.cc", testpath
    system ENV.cxx, "-std=c++17", "random_tsp.cc",
                    "-L#{lib}", "-lortools",
                    "-L#{Formula["gflags"].opt_lib}", "-lgflags",
                    "-L#{Formula["glog"].opt_lib}", "-lglog",
                    "-L#{Formula["protobuf"].opt_lib}", "-lprotobuf",
                    "-o", "test"
    system "./test"
  end
end
