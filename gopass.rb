class Gopass < Formula
  desc "The slightly more awesome Standard Unix Password Manager for Teams."
  homepage "https://www.gopass.pw/"
  url "https://github.com/dominikschulz/gopass/releases/download/v1.7.3-alpha.0/gopass-1.7.3-alpha.0.tar.gz"
  version "1.7.3-alpha.0"
  sha256 "2f42b42fe835acd51a0259be5521c66a7fe0a544bfaeb03ef8fffc8a79d2fa6e"
  head "https://github.com/dominikschulz/gopass.git"
  
  depends_on "go" => :build
  
  depends_on "git"
  depends_on "gnupg"
  

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/gopasspw/gopass").install buildpath.children
    
    cd "src/github.com/gopasspw/gopass" do
      ENV["PREFIX"] = prefix
      system "make", "install"
    end
    
    system bin/"gopass completion bash > bash_completion.bash"
    system bin/"gopass completion zsh > zsh_completion.zsh"
    bash_completion.install "bash_completion.bash"
    zsh_completion.install "zsh_completion.zsh"
    
  end

  def caveats; <<-EOS.undent
    Gopass has been installed, have fun!
    If upgrading from `pass`, everything should work as expected.
    If installing from scratch, you need to either initialize a new repository now...
      gopass init
    ...or clone one from a source:
      gopass clone git@code.example.com:example/pass.git
    In order to use the great autocompletion features (they're helpful with gopass),
    please make sure you have autocompletion for homebrew enabled:
      https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
    More information:
      https://www.gopass.pw/
      https://github.com/gopasspw/gopass/README.md
    
  EOS
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/gopass version")
    
  end

end
