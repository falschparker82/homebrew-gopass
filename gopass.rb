class Gopass < Formula
  desc ""
  homepage ""
  url "https://github.com/justwatchcom/gopass/releases/download/v1.2.0-rc1/gopass-1.2.0-rc1-darwin-amd64.tar.gz"
  version "1.2.0-rc1"
  sha256 "4a407016b59434c0f265023fedb66dd1a7c8e9ad2926bab05968fc79ead11887"

  def install
    bin.install "gopass"
  end
end
