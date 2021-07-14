class DifferentialPrivacy < Formula
  desc "Google's C++ differential privacy library"
  homepage "https://github.com/google/differential-privacy"
  url "https://github.com/google/differential-privacy/archive/master.zip"
  version "0.0.0"
  # sha256 "cfca5c2135d9771f075d59d9c8a49928d1e22cdb704fb369068fba70d9df2bd6"

  depends_on "bazel" => :build

  def install
    cd "cc" do
      system "bazel", "build", "..."
    end
    pp Dir["**/*"]
    pkgshare.install "differential_privacy/example"
  end

  test do
  end
end
