class Verona < Formula
  desc "Research programming language for concurrent ownership"
  homepage "https://github.com/microsoft/verona"
  url "https://github.com/microsoft/verona.git"
  version "0.0.0"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-GNinja", *std_cmake_args
      system "ninja", "install"
    end
  end

  test do
  end
end
