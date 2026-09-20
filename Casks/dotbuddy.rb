cask "dotbuddy" do
  version "2.6.0"
  sha256 "114796a86ac932f3a98f0f6266f7f9e018068c189cf14b3b120121c090888a57"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.6.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
