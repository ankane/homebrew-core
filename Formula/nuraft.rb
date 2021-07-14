class Nuraft < Formula
  desc "C++ implementation of Raft core logic as a replication library"
  homepage "https://github.com/eBay/NuRaft"
  url "https://github.com/eBay/NuRaft/archive/v1.1.2.tar.gz"
  sha256 "5594f6ab7d8c778f0890e9ad8f9d8fddfb05de3916eb45a316aa209484e31d53"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "openssl@1.1"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp_r pkgshare/"examples/.", testpath
    system ENV.cxx, "-std=c++11", "quick_start.cxx", "logger.cc", "in_memory_log_store.cxx",
                    "-I#{include}/libnuraft", "-I#{testpath}/echo",
                    "-L#{lib}", "-lnuraft", "-o", "test"
    assert_match "hello world", shell_output("./test")
  end
end
