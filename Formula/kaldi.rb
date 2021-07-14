class Kaldi < Formula
  desc "Speech Recognition Toolkit"
  homepage "https://kaldi-asr.org/"
  url "https://github.com/kaldi-asr/kaldi.git",
      revision: "7a50987e76bc23c97d9c6ed78e120d5b335f2184"
  version "5.5.636" # https://kaldi-asr.org/doc/versions.html
  license "Apache-2.0"

  # depends_on "autoconf" => :build
  # depends_on "automake" => :build
  depends_on "cmake" => :build
  # depends_on "libtool" => :build
  depends_on "python@3.8" => :build
  # depends_on "wget" => :build
  # depends_on "gcc" # for gfortran
  # depends_on "sox"

  def install
    ENV.prepend_path "PATH", Formula["python@3.8"].opt_libexec/"bin"

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON", "-DKALDI_BUILD_TEST=OFF"
      system "make"
      system "make", "install"
    end

    # cd "tools" do
    #   system "extras/check_dependencies.sh"
    #   system "make"
    #   # system "make", "install"
    # end

    # cd "src" do
    #   system "./configure", "--shared"
    #   system "make", "depend"
    #   system "make"
    #   # system "make", "install"
    # end
  end

  test do
  end
end
