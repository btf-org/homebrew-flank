class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.8.tar.gz"
  version "0.1.8"
  sha256 "d5d0eff002d38b73128f8f88571cf13374c4bdd7ab32f803deb3ba2b037b8960"



  def install
    bin.install "flank" => "flank" if File.exist?("flank")
    bin.install "iflank" => "iflank" if File.exist?("iflank")
    system "gcc", "flankserver.c", "-o", "flankserver"
    bin.install "flankserver"

    pkgshare.install "index.html"

    (prefix/"INSTALL_LOG.txt").write("Installed at #{Time.now}")
  end

  def caveats
    <<~EOS

      Flank has been installed!
      
      If you care, there are three components:
        1. The restricted shell, installed at
            #{bin}/iflank
        2. The server that chats with the shell, at
            #{bin}/flankserver
        3. The CLI utility, installed at
            #{bin}/flank
      
      The webpage is stored at
        #{pkgshare}/index.html

      Your programs will be stored in files in
        #{var}/flank

      #####################################
      ##   To get started, run `flank`   ##
      ##     $ flank                     ##
      #####################################

    EOS
  end

  def post_install
    (var/"flank").mkpath
  end
end

