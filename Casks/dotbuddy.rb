cask "dotbuddy" do
  version "2.6.1"
  sha256 "61ad3c8a98f9d7c80935e51e6e522f2b7d69416557e73ec938cccf8cface594c"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.6.1/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
