class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.82.tar.gz"
  version "0.1.82"
  sha256 "c205cff96fac40434f6dcf911d9e2c97b94702b8c76a90fdb12895858bc0bccb"
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

