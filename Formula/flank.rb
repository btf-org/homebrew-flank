class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v0.1.0.tar.gz"
  version "0.1.0"
  sha256 "5e98ec67cd08abe9daa1eddf8faf371209a929091f8ebaffc19249feea2f6f06"



  def install
    bin.install "flank" => "flank" if File.exist?("flank")

    system "gcc", "iflank.c", "-o", "iflank"
    bin.install "iflank"

    system "gcc", "server.c", "-o", "flankserver"
    bin.install "flankserver"

    (prefix/"INSTALL_LOG.txt").write("Installed at #{Time.now}")
  end

  def post_install
    (var/"flank").mkpath
  end
end

