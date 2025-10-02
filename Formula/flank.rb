class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/tags/v1.2.3.tar.gz"
  version "v0.1.0"
  sha256 "5e98ec67cd08abe9daa1eddf8faf371209a929091f8ebaffc19249feea2f6f06"



  def install
    bin.install "flank" => "flank" if File.exist?("flank")

    system "gcc", "flsh.c", "-o", "flsh"
    bin.install "flsh"

    (prefix/"INSTALL_LOG.txt").write("Installed at #{Time.now}")
  end

  def post_install
    (var/"flank").mkpath
  end
end

