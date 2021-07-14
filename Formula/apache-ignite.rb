class ApacheIgnite < Formula
  desc "Distributed Database For High-Performance Computing"
  homepage "https://ignite.apache.org/"
  url "https://downloads.apache.org//ignite/2.9.1/apache-ignite-2.9.1-src.zip"
  sha256 "0b7815032d90c4788e5c94426646388d74cd132074728b874ec0a0a0ec656aed"
  license "Apache-2.0"

  depends_on "maven" => :build

  # Java 15 not supported yet
  # https://forums.gridgain.com/community-home/digestviewer/viewthread?GroupId=151&MessageKey=ac90b9d5-c26e-4231-8fc3-5bb0fed23f32&CommunityKey=f0fde549-1cb8-4f9d-a2b6-8ece1e74d10b
  depends_on "openjdk@11"

  def install
    system "mvn", "clean", "install", "-Pall-java,all-scala,licenses", "-DskipTests"

    libexec.install %w[bin config libs]
    pkgshare.install "examples"

    bin.install Dir["#{libexec}/bin/*.sh"]
    bin.env_script_all_files libexec/"bin", JAVA_HOME: Formula["openjdk@11"].opt_prefix
  end

  test do
    ENV["IGNITE_WORK_DIR"] = testpath

    fork do
      exec bin/"ignite.sh", pkgshare/"examples/config/example-ignite.xml"
    end
    sleep 10

    assert_match "Cluster is active", shell_output("#{bin}/control.sh --state")
  ensure
    system "pkill", "-9", "-f", "ignite"
  end
end
