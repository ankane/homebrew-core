class Sorbet < Formula
  desc "Fast, powerful type checker designed for Ruby"
  homepage "https://sorbet.org"
  url "https://github.com/sorbet/sorbet/archive/0.5.5846.20200724124848-88aec85bf.tar.gz"
  sha256 "8bafb513e9ed0399ade10c6de66ff85e3b1cbc5979adfd125129042225cf30c0"
  license "Apache-2.0"

  depends_on "autoconf" => :build
  depends_on "bazel" => :build
  depends_on "coreutils" => :build
  depends_on "parallel" => :build

  def install
    ENV["LOCAL_BAZEL_OVERRIDE"] = Formula["bazel"].opt_bin/"bazel"
    system "./bazel", "build", "//main:sorbet", "--config=release-mac"
    pp Dir["**/*"]
    bin.install "bazel-bin/main/sorbet"
  end

  test do
    output = shell_output("#{bin}/sorbet -e \"42 + 'hello'\"")
    p output
  end
end
