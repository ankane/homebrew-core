class LibpgQuery < Formula
  desc "C library for accessing the PostgreSQL parser outside of the server environment"
  homepage "https://github.com/pganalyze/libpg_query"
  url "https://github.com/pganalyze/libpg_query/archive/refs/tags/13-2.0.4.tar.gz"
  sha256 "a67ef3e3b6c9cb1297f362888d6660dac165d3b020f78d23afe4293b8ceaf190"
  license "BSD-3-Clause"

  def install
    system "make"
    lib.install "libpg_query.a"
    include.install "pg_query.h"
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/simple.c", testpath
    system ENV.cc, "simple.c", "-L#{lib}", "-lpg_query", "-o", "test"
    assert_match "stmts", shell_output("./test")
  end
end
