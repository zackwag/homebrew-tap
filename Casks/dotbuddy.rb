cask "dotbuddy" do
  version "2.1.1"
  sha256 "c9f30eb8a76606668b26ead7981aa5cdc6163bf0d2568eee037e58375f2ea5dc"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.1.1/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
