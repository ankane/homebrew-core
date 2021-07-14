class RnaStar < Formula
  desc "RNA-seq aligner"
  homepage "https://github.com/alexdobin/STAR"
  url "https://github.com/alexdobin/STAR/archive/master.zip"
  # url "https://github.com/alexdobin/STAR/archive/2.7.5a.tar.gz"
  # sha256 "da6c7a502d978381434e59c1ea930ad8a7dfcc16ba21874e906df20db541f621"
  version "0.0.0"

  fails_with :clang

  def install
    cd "source" do
      # inreplace "Makefile", "-static-libgcc", ""
      system "make", "STARforMacStatic", "STARlongForMacStatic"
      bin.install "STAR", "STARlong"
    end
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    output = shell_output("#{bin}/STAR --runMode genomeGenerate --genomeFastaFiles test.fasta")
    assert_match "finished successfully", output
  end
end
