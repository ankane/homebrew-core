class Proxysql < Formula
  desc "High-performance MySQL proxy"
  homepage "https://www.proxysql.com"
  url "https://github.com/sysown/proxysql.git",
      tag:      "v2.0.16",
      revision: "4d7358ff99593ea6e892c9aaa838f57bf3f7d2b9"
  license "GPL-3.0-only"

  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "gpatch"
  depends_on "openssl@1.1"

  def install
    git_version = `git describe --long --tags --always`.chomp
    system "make", "GIT_VERSION=#{git_version}"
    system "make", "install"
  end

  test do
    system bin/"proxysql"
  end
end
