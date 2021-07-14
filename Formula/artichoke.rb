class Artichoke < Formula
  desc "Ruby made with Rust"
  homepage "https://github.com/artichoke/artichoke"
  license "MIT"
  head "https://github.com/artichoke/artichoke.git"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    output = shell_output("#{bin}/artichoke -e 'puts RUBY_DESCRIPTION'")
    assert_match "artichoke", output
  end
end
