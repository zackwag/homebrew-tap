cask "dotbuddy" do
  version "1.1.0"
  sha256 "22669ad4287cbeec1d12f23c6a97f4e5f3a1067a140a516c4c09aee73efd8ee8"

  url "https://github.com/zackwag/DotBuddy/releases/download/v#{version}/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: ">= :sonoma"

  app "DotBuddy.app"

  zap trash: [
    "~/Library/Preferences/dev.zackwag.DotBuddy.plist",
  ]
end
