class Tink < Formula
  desc "Cryptographic APIs that are easy to use correctly and hard(er) to misuse"
  homepage "https://github.com/google/tink"
  url "https://github.com/google/tink/archive/v1.4.0.tar.gz"
  sha256 "4a5686ec0938920676be03b9ac147d9a97e66a786ee88d6f4542d6b31fdd62f4"

  depends_on "cmake" => :build
  # depends_on "bazel" => :build
  # depends_on "openjdk"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
      pp Dir["**/*"]
    end
    pkgshare.install "examples"

    # rm_f ".bazelversion" # Homebrew uses the latest bazel
    # cd "tools" do
    #   system "bazel", "build", "tinkey"
    # end
    # # pp Dir["**/*"]
    # pp Dir["bazel-bin/**/*"]
    # libexec.install "bazel-bin/tools/tinkey"
    # bin.install_symlink libexec/"tinkey"
    # bin.install "bazel-bin/tools/tinkey/tinkey"
    # bin.env_script_all_files(libexec/"bin", :JAVA_HOME => Formula["openjdk"].opt_prefix)
    # bin.write_jar_script libexec/"tinkey.jar", "tinkey"
  end

  test do
    cp pkgshare/"examples/helloworld/cc/hello_world.cc", testpath/"test.cc"
    system ENV.cxx, "test.cc", "-L#{lib}", "-ltink",
           "-I#{include}", "-o", "test"
    system "./test"

    # system bin/"tinkey", "create-keyset", "--key-template", "ECDSA_P256",
    #                      "--out", "private-keyset.cfg"
  end
end
