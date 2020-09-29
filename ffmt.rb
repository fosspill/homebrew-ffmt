class Dotnet < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    dotnet is required; install it via one of:
      brew cask install dotnet-sdk
      the official dotnet install instructions
    EOS
  end
end

class Ffmt < Formula
  desc "FFXIV Modding Tool is the Cross-platform Commandline interface alternative for TexTools"
  homepage "https://ffmt.pwd.cat/"
  url "https://github.com/fosspill/FFXIV_Modding_Tool.git", :tag => "v0.9.6.1", :revision => "aecef7ec6af82672fb98875500f14a7b0205d9c7"
  license "GPL-3.0"

  depends_on Dotnet => :build

  def install
  	shellscript = "#!/bin/bash\nINSTALL_DIR=#{prefix}/ffmt\ndotnet $INSTALL_DIR/ffmt.dll \"$@\""
    system "./build.sh"
    cp_r "FFXIV_Modding_Tool/bin/Release/netcoreapp3.1", "#{prefix}/ffmt"
    File.write('./ffmt', shellscript)
    bin.install "ffmt"
  end

  test do
    system "false"
  end
end
