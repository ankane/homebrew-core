class Weld < Formula
  desc "High-performance runtime for data analytics applications"
  homepage "https://www.weld.rs"
  url "https://github.com/weld-project/weld/archive/v0.4.0.tar.gz"
  sha256 "1eff3375f67c5e892a8cb0a5d6ad9584960af853474a4aa02335f736e3f412a1"
  license "BSD-3-Clause"

  depends_on "rust" => :build
  depends_on "llvm@6" => :build

  def install
    ENV["WELD_HOME"] = buildpath
    system "cargo", "install", *std_cargo_args
  end

  test do
    # TODO
  end
end
