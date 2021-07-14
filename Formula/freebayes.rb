class Freebayes < Formula
  desc "Bayesian haplotype-based genetic polymorphism discovery and genotyping"
  homepage "https://github.com/ekg/freebayes"
  head "https://github.com/ekg/freebayes.git"
      # :tag      => "v1.3.2",
      # :revision => "54bf40915ae7e46798503471ac57f593efdb5493"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
    pkgshare.install "test"
  end

  test do
    cp_r pkgshare/"test/tiny/.", testpath
    output = shell_output("#{bin}/freebayes -f q.fa NA12878.chr22.tiny.bam")
    assert_match "q\t186", output
  end
end
