cask "dotbuddy" do
  version "2.5.1"
  sha256 "b4ebfe2b24cd1e7b8b3646fbe2e514d8b9942d7c6fa6073622aa0b58a10217da"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.5.1/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
