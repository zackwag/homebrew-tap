class SudoTouchid < Formula
  desc "Enable Touch ID for sudo on macOS"
  homepage "https://github.com/zackwag/sudo-touchid"
  url "https://github.com/zackwag/sudo-touchid/releases/download/v1.1.3/sudo-touchid"
  sha256 "b168049c7fb7583b5749619d4591f7e2459a771a8f2c8ed8cba4452a959dd6b5"
  license "MIT"

  depends_on :macos

  def install
    bin.install "sudo-touchid"
  end

  def caveats
    <<~EOS
      Run `sudo sudo-touchid` to enable Touch ID for sudo.
      Run `sudo sudo-touchid --disable` to remove it.
      Run `sudo-touchid --status` to check current configuration.
    EOS
  end

  test do
    assert_predicate bin/"sudo-touchid", :executable?
  end
end
