class TrustDns < Formula
  desc "Rust-based DNS client, server, and resolver"
  homepage "https://github.com/bluejekyll/trust-dns"
  url "https://github.com/bluejekyll/trust-dns/archive/0.19.5.tar.gz"
  sha256 "8e0b6b829e9a870ae52860aa3fed33c50c5a2b1a2875cf03f3ee280bb3933698"
  license "MIT"

  depends_on "rust" => :build
  depends_on "openssl"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
  end
end
