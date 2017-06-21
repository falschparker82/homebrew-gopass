class Gopass < Formula
  desc ""
  homepage ""
  url "https://github.com/justwatchcom/gopass/releases/download/v1.2.0-rc3/gopass-1.2.0-rc3-darwin-amd64.tar.gz"
  version "1.2.0-rc3"
  sha256 "f2e2099a4f10a0c369702cd09626d21990d1ee65b1ff358ab2c51f7147a3a865"

  def install
    bin.install "gopass"
  end
end
