cask "dotbuddy" do
  version "2.2.0"
  sha256 "334533a39d2b0355b30885482b4fb20baaff01fedbe5273c4a4e6d8c1bc0e53f"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.2.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
