class DexIdp < Formula
  desc "OpenID Connect Identity (OIDC) and OAuth 2.0 Provider"
  homepage "https://github.com/dexidp/dex"
  url "https://github.com/dexidp/dex/archive/v2.24.0.tar.gz"
  sha256 "5c8a36d5fa4d71372130de73a07b5a312ab6016b191a7e35892ff3bc29ed9cd9"
  license "Apache-2.0"

  depends_on "go" => :build

  conflicts_with "dex", because: "both install `dex` binaries"

  def install
    system "go", "build", *std_go_args, "-o", bin/"dex", "./cmd/dex"
    libexec.install "web"
    pkgshare.install "examples"
  end

  test do
    port = free_port
    (testpath/"config.yaml").write <<~EOS
      issuer: http://127.0.0.1:#{port}/dex
      storage:
        type: sqlite3
        config:
          file: #{testpath}/dex.db
      web:
        http: 0.0.0.0:#{port}
      frontend:
        dir: #{libexec}/web
      connectors:
      - type: mockCallback
        id: mock
        name: Example
    EOS

    fork { exec bin/"dex", "serve", "config.yaml" }
    sleep 3
    output = shell_output("curl -s localhost:#{port}/dex/.well-known/openid-configuration")
    assert_match "issuer", output
  end
end
