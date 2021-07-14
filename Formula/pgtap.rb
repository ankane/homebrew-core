class Pgtap < Formula
  desc "PostgreSQL Unit Testing Suite"
  homepage "https://pgtap.org"
  url "https://github.com/theory/pgtap/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c89c56d03d796618184f6128560b7f71efc228c35646efc8fe6b51b97a1793ed"
  license "PostgreSQL"

  depends_on "postgresql"

  uses_from_macos "perl"

  resource "DBI" do
    url "https://cpan.metacpan.org/authors/id/T/TI/TIMB/DBI-1.643.tar.gz"
    sha256 "8a2b993db560a2c373c174ee976a51027dd780ec766ae17620c20393d2e836fa"
  end

  resource "DBD::Pg" do
    url "https://cpan.metacpan.org/authors/id/T/TU/TURNSTEP/DBD-Pg-3.14.2.tar.gz"
    sha256 "c973e98458960a78ec54032a71b3840f178418dd7e69d063e462a0f10ec68e4d"
  end

  resource "Module::Build" do
    url "https://cpan.metacpan.org/authors/id/L/LE/LEONT/Module-Build-0.4231.tar.gz"
    sha256 "7e0f4c692c1740c1ac84ea14d7ea3d8bc798b2fb26c09877229e04f430b2b717"
  end

  resource "TAP::Parser::SourceHandler::pgTAP" do
    url "https://cpan.metacpan.org/authors/id/D/DW/DWHEELER/TAP-Parser-SourceHandler-pgTAP-3.35.tar.gz"
    sha256 "84ee396fa7cec3d11f0f5ef6841d5feb097cd0ccfc00200c3ecdb340cf18a598"
  end

  def install
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"

    build_pl = ["TAP::Parser::SourceHandler::pgTAP"]
    resources.each do |r|
      r.stage do
        next if build_pl.include? r.name

        system "perl", "Makefile.PL", "INSTALL_BASE=#{libexec}"
        system "make"
        system "make", "install"
      end
    end

    build_pl.each do |name|
      resource(name).stage do
        system "perl", "Build.PL", "--install_base", libexec
        system "./Build"
        system "./Build", "install"
      end
    end

    system "make"
    mkdir "stage"
    system "make", "install", "DESTDIR=#{buildpath}/stage"

    (bin/"pg_prove").write_env_script("#{libexec}/bin/pg_prove", PERL5LIB: ENV["PERL5LIB"])
    (bin/"pg_tapgen").write_env_script("#{libexec}/bin/pg_tapgen", PERL5LIB: ENV["PERL5LIB"])

    (share/"postgresql/extension").install Dir["stage/**/share/postgresql/extension/*"]
  end

  test do
    mkdir "t"
    assert_match "Result: NOTESTS", shell_output("#{bin}/pg_prove")
  end
end
