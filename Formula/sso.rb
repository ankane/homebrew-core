class Sso < Formula
  desc "Single sign-on solution for securing internal services"
  homepage "https://github.com/buzzfeed/sso"
  url "https://github.com/buzzfeed/sso/archive/v2.1.0.tar.gz"
  sha256 "753ef14f7a3a15ab7ac5f52ae9130b4507040fb47cfd94e7d487434275425afb"
  license "MIT"

  depends_on "go" => :build

  def install
    system "make", "build"
  end

  test do
  end
end
