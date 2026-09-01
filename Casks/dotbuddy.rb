cask "dotbuddy" do
  version "2.0.1"
  sha256 "9cc75c42e0a27d52e649a1d1891c9323728977e4e463cde36bc1fb2490a3224b"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.0.1/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
