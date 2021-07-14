class Atlas < Formula
  desc "In-memory dimensional time series database"
  homepage "https://github.com/Netflix/atlas"
  # url "https://github.com/Netflix/atlas/archive/v1.6.6.tar.gz"
  # sha256 "781d34f11b815f20e7cd02e223af3681b3f8b9d15563013f62def2902c5fd76b"
  url "https://github.com/Netflix/atlas/releases/download/v1.6.5/atlas-1.6.5-standalone.jar"
  license "Apache-2.0"
  head "https://github.com/Netflix/atlas.git"

  # depends_on "sbt" => :build
  depends_on "openjdk"

  def install
    # system "make"
    # pp Dir["**/*"]
    libexec.install "atlas-#{version}-standalone.jar"
    bin.write_jar_script libexec/"atlas-#{version}-standalone.jar", "atlas"
  end

  test do
    fork do
      exec bin/"atlas"
    end
    sleep 5

    # TODO use free port
    output = shell_output("curl -s 127.0.0.1:7101/api/v1/tags")
    assert_match "statistic", output
  end
end
