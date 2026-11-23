cask "dotbuddy" do
  version "2.9.2"
  sha256 "3cd207a8e2046d3da598622c49787009a532257bed2c708bdd5e53fd918c2441"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.9.2/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
