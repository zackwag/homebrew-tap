cask "dotbuddy" do
  version "2.1.0"
  sha256 "c2282a7b5491def3f8c53a1219697ca0d1e8b39594d0d45802941f43e545a8d6"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.1.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
