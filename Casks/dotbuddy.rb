cask "dotbuddy" do
  version "2.8.0"
  sha256 "8891e40bfd6d3e8a7ef79b849c8f327df01990141ba6964565c266cef4ebfc54"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.8.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
