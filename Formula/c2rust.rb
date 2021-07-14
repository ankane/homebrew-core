class C2rust < Formula
  desc "Migrate C code to Rust"
  homepage "https://c2rust.com/"
  url "https://github.com/immunant/c2rust/archive/0.14.0.tar.gz"
  sha256 "efa90f45e725402f32ad8de9b4f159f80de12ed2ce4173083912e0ca9b4e51c3"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "llvm" => :build
  depends_on "openssl" => :build
  depends_on "python3" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
  end
end
