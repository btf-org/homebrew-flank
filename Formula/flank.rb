class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.64.tar.gz"
  version "0.1.64"
  sha256 "249493bde796bd49aeaccf619a5c66b3c4964b64bdd799404b13b50ed7653e45"

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

      brew services start flank

    To stop:

      brew services stop flank

    EOS
  end

  def post_install
    (var/"flank").mkpath
    (var/"log/flank").mkpath
  end

  service do
    run [opt_bin/"flankserver"]
    keep_alive true
    log_path var/"log/flank/flankserver.log"
    error_log_path var/"log/flank/flankserver.err"
  end
end

