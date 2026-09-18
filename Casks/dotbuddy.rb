cask "dotbuddy" do
  version "2.2.1"
  sha256 "b8bece692d055952e11a11d8a59fa20b3e7d740b44197b8c3bb8353410967d76"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.2.1/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
