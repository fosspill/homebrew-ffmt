# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
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
  url "https://github.com/fosspill/FFXIV_Modding_Tool/archive/v0.9.6.1.tar.gz"
  sha256 "516833abe6f8e9566264641ee0aab6ef6d13cd79a46aeca5202c1a829b56a635"
  license "GPL-3.0"

  depends_on Dotnet => :build

  def install
  	shellscript = "#!/bin/bash\nINSTALL_DIR=#{prefix}/ffmt\n$INSTALL_DIR/ffmt \"$@\""
    system "./build.sh"
    cp_r "FFXIV_Modding_Tool/bin/Release/netcoreapp3.1", "#{prefix}/ffmt"
    File.write('./ffmt', shellscript)
    bin.install "ffmt"
  end

  test do
    system "false"
  end
end
