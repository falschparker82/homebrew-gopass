class Gopass < Formula
  desc ""
  homepage ""
  url "https://github.com/justwatchcom/gopass/releases/download/v1.2.0-rc2/gopass-1.2.0-rc2-darwin-amd64.tar.gz"
  version "1.2.0-rc2"
  sha256 "82a9adee34256b9b25b598e9a3b2fd36226cfa7f62c536e0ef65faaba36ebd70"

  def install
    bin.install "gopass"
  end
end
