class Gopass < Formula
  desc "The slightly more awesome Standard Unix Password Manager for Teams."
  homepage "https://www.gopass.pw/"
  url "https://github.com/gopasspw/gopass/releases/download/v1.8.2/gopass-1.8.2.tar.gz"
  version "1.8.2"
  sha256 "ca6d24db014a760f71fbf0edaad0c97c283a670b260275a78eda3a7456fbea93"
  head "https://github.com/gopasspw/gopass.git"
  
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
