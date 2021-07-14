class Mtail < Formula
  desc "Tool for extracting metrics from application logs"
  homepage "https://github.com/google/mtail"
  url "https://github.com/google/mtail/archive/v3.0.0-rc36.tar.gz"
  sha256 "cd3818d2dc4a6d5283703b8ebc726ec02c763d2c76e4435d83b0af4d70f477e7"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "examples"
  end

  test do
    port = free_port
    fork do
      exec bin/"mtail", "--logs", testpath/"test.log",
                        "--port", port.to_s,
                        "--progs", pkgshare/"examples/linecount.mtail"
    end
    sleep 3

    (testpath/"test.log").write <<~EOS
      hello
    EOS
    sleep 3

    output = shell_output("curl -s localhost:#{port}/json")
    program = JSON.parse(output).first
    assert_equal "linecount.mtail", program["Program"]
    assert_equal 1, program["LabelValues"].first["Value"]["Value"]
  end
end
