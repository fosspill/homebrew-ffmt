# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Dotnet < Requirement
  fatal true

  satisfy(:build_env => false) { which("dotnet") }

  def message; <<~EOS
    dotnet is required; install it via:
      brew cask install dotnet-sdk
    EOS
  end
end

class Ffmt < Formula
  desc "FFXIV Modding Tool is the Cross-platform Commandline interface alternative for TexTools"
  homepage "https://ffmt.pwd.cat/"
  url "https://github.com/fosspill/FFXIV_Modding_Tool.git", :tag => "v0.9.6.1", :revision => "aecef7ec6af82672fb98875500f14a7b0205d9c7"
  #sha256 "d117dc9996a5c3dd2dc9efaa1c61032e12b72dc5e1bfa16f9ee714697e24d385"
  license "GPL-3.0"
  shellscript "#!/bin/bash\nINSTALL_DIR=#{HOMEBREW_FORMULA_PREFIX}/ffmt\n$INSTALL_DIR/ffmt \"$@\""

  # depends_on "cmake" => :build
  depends_on Dotnet => :build

  def install
    system "./build.sh"
    cp_r "FFXIV_Modding_Tool/bin/Release/netcoreapp3.1", "#{HOMEBREW_FORMULA_PREFIX}/ffmt"
    File.write('./ffmt', shellscript)
    cp_r "ffmt", "#{HOMEBREW_FORMULA_PREFIX}/ffmt/ffmt.sh"
    bin.install "ffmt"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test FFXIV_Modding_Tool`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
