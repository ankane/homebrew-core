class CarbonRelayNg < Formula
  desc "Fast carbon relay and aggregator"
  homepage "https://github.com/grafana/carbon-relay-ng"
  url "https://github.com/grafana/carbon-relay-ng/archive/v0.13.0.tar.gz"
  sha256 "f1279502d23faa5a541f5ce49195708e379de4d9a5b59ff430fdcee75c3aeea7"
  license "BSD-2-Clause"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/carbon-relay-ng"
    inreplace "examples/carbon-relay-ng.ini", "/var", var
    etc.install "examples/carbon-relay-ng.ini"
  end

  test do
    port = free_port

    cp etc/"carbon-relay-ng.ini", testpath
    inreplace "carbon-relay-ng.ini" do |s|
      s.gsub! "2004", free_port.to_s
      s.gsub! "8081", port.to_s
      s.gsub! "2003", free_port.to_s
      s.gsub! "2013", free_port.to_s
    end

    fork { exec bin/"carbon-relay-ng", "carbon-relay-ng.ini" }
    sleep 3

    output = shell_output("curl -s localhost:#{port}/")
    assert_match "Carbon-Relay-NG admin", output
  end
end
