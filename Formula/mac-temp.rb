class MacTemp < Formula
  desc "Lightweight CLI to read CPU and thermal sensor temperatures on Apple Silicon Macs"
  homepage "https://github.com/zackwag/mac-temp"
  url "https://github.com/zackwag/mac-temp/releases/download/v1.0.0/mac-temp"
  version "1.0.0"
  sha256 "aea03c72f13cbb7a1d19132c347af41b7232f5bfe0d63dd81c6eb14a041115d9"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "mac-temp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mac-temp --version", 1)
  end
end
