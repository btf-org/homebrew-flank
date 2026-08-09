class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.86.tar.gz"
  version "0.1.86"
  sha256 "994e0c8c7467ae28778b6973aca871e2a11367e2785fe51035f7a7c565727812"
  depends_on "graphviz"
  depends_on "makefile2graph"
  depends_on "util-linux"

  def install
    bin.install "iflank" => "iflank" if File.exist?("iflank")
    system "gcc", "flankserver.c", "-o", "flankserver"
    bin.install "flankserver"

    pkgshare.install "index.html"

    (prefix/"INSTALL_LOG.txt").write("Installed at #{Time.now}")
  end

  def caveats
    <<~EOS

    To start the server:

      nohup $(which flankserver) >> $(brew --prefix)/var/log/flank/flankserver.log 2>> $(brew --prefix)/var/log/flank/flankserver.err

    To stop:

      kill $(pgrep -f flankserver)

    EOS
  end

  def post_install
    (var/"log/flank").mkpath
  end
end

