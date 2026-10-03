class Dockhide < Formula
  desc "Hide any macOS app's Dock icon"
  homepage "https://github.com/zackwag/dockhide"
  url "https://github.com/zackwag/dockhide/releases/download/v1.0.1/dockhide"
  sha256 "064bcdc83a164eb315df211a705f0331057657e54cd1279633c5f70bd476355d"
  license "MIT"

  depends_on :macos

  def install
    bin.install "dockhide"
  end

  def caveats
    <<~EOS
      App updates undo dockhide's change; run `dockhide hide <app>` again after updating.
      Run `dockhide list` to see which apps dockhide has hidden.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dockhide --version")
  end
end
