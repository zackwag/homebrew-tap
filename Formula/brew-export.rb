class BrewExport < Formula
  desc "Export your Homebrew setup and dotfiles into a portable tarball"
  homepage "https://github.com/zackwag/brew-export"
  version "1.1.0"
  url "https://github.com/zackwag/brew-export/archive/refs/tags/v#{version}.tar.gz"
  sha256 "d00d4f1c1682dbd0a19af892bdf011e4751ee37048c7352c1cd1d0e293bd67cf"
  license "MIT"

  depends_on :macos

  def install
    bin.install "brew_export.sh" => "brew-export"
  end

  test do
    assert_predicate bin/"brew-export", :executable?
  end
end
