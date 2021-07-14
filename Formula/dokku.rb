class Dokku < Formula
  desc "Command-line interface for the Dokku PaaS"
  homepage "http://dokku.viewdocs.io/dokku/"
  url "https://github.com/dokku/dokku/archive/v0.21.3.tar.gz"
  sha256 "45da71a461fe568df8cac7b7563d82c4e2f63667d4eac1979cc4e7c272339311"
  license "MIT"

  def install
    bin.install "contrib/dokku_client.sh" => "dokku"
  end

  test do
    # doesn't run main function in test with bin prefix
    # set ENV["DOKKU_TRACE"] = "1" to see more info
    output = shell_output("dokku 2>&1", 20)
    assert_match "Configure the DOKKU_HOST environment variable", output
  end
end
