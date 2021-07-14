class Toshi < Formula
  desc "Full-text search engine in Rust"
  homepage "https://github.com/toshi-search/Toshi"
  license "MIT"
  head "https://github.com/toshi-search/Toshi.git"

  depends_on "rust" => :build

  def install
    cd "toshi-server" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    port = free_port
    fork { exec bin/"toshi" }
    sleep 3
    output = shell_output("curl -s localhost:#{port}/")
    assert_match "Toshi Search", output
  end
end
