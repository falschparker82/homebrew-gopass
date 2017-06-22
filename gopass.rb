class Gopass < Formula
  desc ""
  homepage ""
  url "https://github.com/justwatchcom/gopass/releases/download/v1.2.0/gopass-1.2.0-darwin-amd64.tar.gz"
  version "1.2.0"
  sha256 "eab43d5fe4a9802870a014270e36a2e62534e58e19893788a5c3ee1ae0e789af"

  def install
    bin.install "gopass"
  end
end
