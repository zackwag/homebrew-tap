class Dockhide < Formula
  desc "Hide any macOS app's Dock icon"
  homepage "https://github.com/zackwag/dockhide"
  url "https://github.com/zackwag/dockhide/releases/download/v1.0.0/dockhide"
  sha256 "d68ed05e05eb819ffda081dfc4797d1b405d92b0dc0da4af50edcf0b208503d4"
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
