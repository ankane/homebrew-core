class Monocypher < Formula
  desc "Easy to use, easy to deploy crypto library"
  homepage "https://monocypher.org"
  url "https://github.com/LoupVaillant/Monocypher/releases/download/3.1.2/monocypher-3.1.2.tar.gz"
  sha256 "f80a2e16d553e4b119634fd0e85ff86fc42afb4c9cc4569077854d1b6f5ef4f9"
  license "BSD-2-Clause"

  def install
    system "make"
    system "make", "install"
  end

  test do
  end
end
