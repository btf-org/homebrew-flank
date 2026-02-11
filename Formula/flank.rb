class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.72.tar.gz"
  version "0.1.72"
  sha256 "53d9f6dbf6a7956551057ca567911bcd64d00d923209c2d281e99aaccbabb491"

  def install
    bin.install "iflank" => "iflank" if File.exist?("iflank")
    system "gcc", "flankserver.c", "-o", "flankserver"
    bin.install "flankserver"

    pkgshare.install "index.html"
    (var/"flank/Quickstarts/hello_world").install "build/var/flank/Quickstarts/hello_world/template.sh"

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
    (var/"log/flank").mkpath
  end

  service do
    run [opt_bin/"flankserver"]
    keep_alive true
    log_path var/"log/flank/flankserver.log"
    error_log_path var/"log/flank/flankserver.err"
  end
end

