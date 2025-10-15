class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.10.tar.gz"
  version "0.1.10"
  sha256 "3316efc9f77240551e78ca9865e0b1e29f2136e5100a8c40d8e1ab2f32eb7418"



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

