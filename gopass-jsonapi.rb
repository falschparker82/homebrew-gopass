class GopassJsonapi < Formula
  desc "Gopass Browser Bindings"
  homepage "https://github.com/gopasspw/gopass-jsonapi"
  url "https://github.com/gopasspw/gopass-jsonapi/archive/v1.11.1.tar.gz"
  sha256 "3c1666cdbf78a73736b089c3188c06724de53a96e43cb1d82fedd7e9543c120f"
  license "MIT"

  depends_on "go" => :build
  depends_on "gopass"

  def install
    ENV["GOBIN"] = bin
    system "go", "install", "-ldflags", "-s -w -X main.version=#{version}", "./..."
  end

  def caveats
    "You need to run gopass-jsonapi configure for each browser you want to use with gopass."
  end

  test do
    require "open3"

    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS

    begin
      system Formula["gnupg"].opt_bin/"gpg", "--batch", "--gen-key", "batch.gpg"

      system Formula["gopass"].opt_bin/"gopass", "init", "--path", testpath, "noop", "testing@foo.bar"
      system Formula["gopass"].opt_bin/"gopass", "generate", "Email/other@foo.bar", "15"
    ensure
      system Formula["gnupg"].opt_bin/"gpgconf", "--kill", "gpg-agent"
      system Formula["gnupg"].opt_bin/"gpgconf", "--homedir", "keyrings/live",
                                                 "--kill", "gpg-agent"
    end

    assert_match version.to_s, shell_output("#{bin}/gopass-jsonapi --version")

    msg='{"type": "query", "query": "foo.bar"}'
    out, _err, _status = Open3.capture3("#{bin}/gopass-jsonapi listen", stdin_data: [msg.length].pack("L<")+msg)
    assert_match %r{Email/other@foo.bar}, out
  end
end
