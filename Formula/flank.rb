class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.4.tar.gz"
  version "0.1.4"
  sha256 "4d45b754e6982ed3017c8acbc650be60665e6a92c33ee9a2fbd1b02aa1436c55"



  def install
    bin.install "flank" => "flank" if File.exist?("flank")

    system "gcc", "iflank.c", "-o", "iflank"
    bin.install "iflank"

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

