class Flank < Formula
  desc "Test formula that installs the flank script"
  homepage "https://github.com/btf-org/flank"
  url "https://github.com/btf-org/flank/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  sha256 "4816e613d998f4fb4cf98578860c58987ea9e206a5bc2b03b61f5c8a8d480396"



  def install
    bin.install "flank" => "flank" if File.exist?("flank")

    (prefix/"INSTALL_LOG.txt").write("Installed at #{Time.now}")
  end

  def post_install
    (var/"flank").mkpath
  end
end

