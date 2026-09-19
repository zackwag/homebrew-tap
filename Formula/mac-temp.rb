class MacTemp < Formula
  desc "CLI to read CPU and thermal sensor temperatures on Apple Silicon"
  homepage "https://github.com/zackwag/mac-temp"
  url "https://github.com/zackwag/mac-temp/releases/download/v1.3.1/mac-temp"
  version "1.3.1"
  sha256 "31b0a25fb01e1934819bf6061ae8bf7437397354be9494d07908a4b1da551dc0"
  license "MIT"

  depends_on :macos

  def install
    bin.install "mac-temp"
  end

  test do
    system "true"
  end
end
