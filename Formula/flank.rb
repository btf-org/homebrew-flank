class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  sha256 "79c9df6eab9bff7f88109cead0f4e17786fd6e5521838b0c1955de2c4a32edc3"



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

