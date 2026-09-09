class BrewExport < Formula
  desc "Export your Homebrew setup and dotfiles into a portable tarball"
  homepage "https://github.com/zackwag/brew-export"
  version "1.0.0"
  url "https://github.com/zackwag/brew-export/archive/refs/tags/v#{version}.tar.gz"
  sha256 "0e094aae0722757af94075c2976e95b84b4e9ddf71542a397d2e8dca7b2aeb4c"
  license "MIT"

  depends_on :macos

  def install
    bin.install "brew_export.sh" => "brew-export"
  end

  test do
    assert_predicate bin/"brew-export", :executable?
  end
end
