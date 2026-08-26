class MacTemp < Formula
  desc "Lightweight CLI to read CPU and thermal sensor temperatures on Apple Silicon Macs"
  homepage "https://github.com/zackwag/mac-temp"
  version "1.1.0"
  url "https://github.com/zackwag/mac-temp/releases/download/v#{version}/mac-temp"
  sha256 "31b0a25fb01e1934819bf6061ae8bf7437397354be9494d07908a4b1da551dc0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "mac-temp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mac-temp --version", 1)
  end
end
