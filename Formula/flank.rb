class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.85.tar.gz"
  version "0.1.85"
  sha256 "dfbe973ed2525dd74f7d4a4bb46cb301333817209d1f388d4760eeefb72f3cbc"
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

