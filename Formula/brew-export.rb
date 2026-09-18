class BrewExport < Formula
  desc "Export your Homebrew setup and dotfiles into a portable tarball"
  homepage "https://github.com/zackwag/brew-export"
  url "https://github.com/zackwag/brew-export/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "a7c135b70463067ee686ddcaaed09f152e3056a2944fa2ace6abe4dc41335af5"
  license "MIT"

  depends_on :macos

  def install
    bin.install "brew_export.sh" => "brew-export"
  end

  test do
    assert_predicate bin/"brew-export", :executable?
  end
end
