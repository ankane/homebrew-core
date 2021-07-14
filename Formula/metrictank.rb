class Metrictank < Formula
  desc "Multi-tenant timeseries store for Graphite"
  homepage "https://github.com/grafana/metrictank"
  url "https://github.com/grafana/metrictank.git",
      tag:      "v1.0",
      revision: "548af88de77d34f3d588185fae89a76ae0003331"
  license "AGPL-3.0"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/grafana/metrictank").install buildpath.children
    cd "src/github.com/grafana/metrictank" do
      system "dep", "ensure", "-vendor-only"
      system "make", "bin"
      bin.install Dir["build/*"]

      inreplace "metrictank-sample.ini", "/etc/metrictank", etc/"metrictank"
      etc.install "metrictank-sample.ini" => "metrictank.ini"
      (etc/"metrictank").install Dir["scripts/config/*.conf"]
    end
  end

  test do
    cp etc/"metrictank.ini", testpath
    system bin/"metrictank", "-config", "metrictank.ini"
  end
end
