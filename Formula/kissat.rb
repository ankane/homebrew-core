class Kissat < Formula
  desc "Bare metal SAT solver"
  homepage "https://github.com/arminbiere/kissat"
  url "https://github.com/arminbiere/kissat.git"
  version "0.0.0"
  license "MIT"

  def install
    system "./configure"
    system "make"

    bin.install "build/kissat"
    lib.install "build/libkissat.a"
    pkgshare.install "test"
  end

  test do
    output = shell_output("#{bin}/kissat #{pkgshare}/test/cnf/xor1.cnf", 10)
    assert_match "SATISFIABLE", output
  end
end
