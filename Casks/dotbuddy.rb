cask "dotbuddy" do
  version "1.2.0"
  sha256 "1be260d2789e13ce899ce79900ceba8e05545607e70f44e0c2f6bc40c00e5567"

  url "https://github.com/zackwag/DotBuddy/releases/download/v#{version}/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
