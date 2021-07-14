class Pomerium < Formula
  desc "Identity-aware access proxy"
  homepage "https://www.pomerium.io"
  # url "https://github.com/pomerium/pomerium/archive/v0.9.2.tar.gz"
  # sha256 "9209c85766654c46e1f407a11396dc869a173284fd3ebc32b62f59fbab299862"
  head "https://github.com/pomerium/pomerium.git"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "make"
  end

  test do
  end
end
