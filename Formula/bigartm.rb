class Bigartm < Formula
  desc "Fast topic modeling platform"
  homepage "https://bigartm.org/"
  url "https://github.com/bigartm/bigartm/archive/v0.10.1.tar.gz"
  sha256 "559e82c2fb868e4effe5aaf1b339add706f2809764e5b8e7bcf0b2bb82a2484c"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "boost"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
      system "make"
      system "make", "install"
    end
    pkgshare.install "test_data"
  end

  test do
    cp_r pkgshare/"test_data/.", testpath
    system bin/"bigartm", "-d", "docword.parser_test.txt",
                          "-v", "vocab.parser_test.txt",
                          "--write-model-readable", "model.txt"
    assert_predicate testpath/"model.txt", :exist?
  end
end
