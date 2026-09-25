cask "dotbuddy" do
  version "2.7.0"
  sha256 "b1c1c613a88c59af952ff4a3edd2055ef4b163de375a88a115ca5e118093d272"

  url "https://github.com/zackwag/DotBuddy/releases/download/v2.7.0/DotBuddy.zip"
  name "DotBuddy"
  desc "Manage your shell aliases and environment variables"
  homepage "https://github.com/zackwag/DotBuddy"

  depends_on macos: :sonoma

  app "DotBuddy.app"

  zap trash: "~/Library/Preferences/dev.zackwag.DotBuddy.plist"
end
