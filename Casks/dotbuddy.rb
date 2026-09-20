cask "dotbuddy" do
  version "2.3.0"
  sha256 "c9bb2e66d6dfaed8b7900d0b02deda65f9af77c5de1f7c3b6f0eac52c574a1b4"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.3.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
