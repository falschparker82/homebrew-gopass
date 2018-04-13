class Gopass < Formula
  desc "The slightly more awesome Standard Unix Password Manager for Teams."
  homepage "https://www.justwatch.com/gopass/"
  url "https://github.com/justwatchcom/gopass/releases/download/v1.6.11/gopass-1.6.11.tar.gz"
  version "1.6.11"
  sha256 "de5b27f81649548292dc83da98e8e46b9b92d8b0bb012797dee44b3207090c67"
  head "https://github.com/justwatchcom/gopass.git"
  
  depends_on "go" => :build
  
  depends_on "git"
  depends_on "gnupg"
  

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/justwatchcom/gopass").install buildpath.children
    
    cd "src/github.com/justwatchcom/gopass" do
      ENV["PREFIX"] = prefix
      system "make", "install"
    end
    
    system bin/"gopass completion bash > bash_completion.bash"
    system bin/"gopass completion zsh > zsh_completion.zsh"
    bash_completion.install "bash_completion.bash"
    zsh_completion.install "zsh_completion.zsh"
    
  end

  def caveats; <<~EOS.undent
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
      https://www.justwatch.com/gopass
      https://github.com/justwatchcom/gopass/README.md
    
  EOS
  end
  test do
    assert_match version.to_s, shell_output("#{bin}/gopass version")
    
  end

end
