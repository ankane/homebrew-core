class Jellyfish < Formula
  desc "Fast multi-threaded k-mer counter"
  homepage "https://github.com/gmarcais/Jellyfish"
  url "https://github.com/gmarcais/Jellyfish/releases/download/v2.3.0/jellyfish-2.3.0.tar.gz"
  sha256 "e195b7cf7ba42a90e5e112c0ed27894cd7ac864476dc5fb45ab169f5b930ea5a"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    system bin/"jellyfish", "count", "-m", "21", "-s", "100M", "-t", "10", "-C", "test.fasta"
    assert_predicate testpath/"mer_counts.jf", :exist?
  end
end
