cask "remindersync" do
  version "0.3.0"
  sha256 "ece72eaa73ad7440bce22cd1e086d50847ed0de0218308572c4e7d6a7e477889"

  url "https://github.com/zackwag/remindersync/releases/download/v#{version}/ReminderSync.zip"
  name "ReminderSync"
  desc "Sync Apple Reminders lists with Skylight lists and chores"
  homepage "https://github.com/zackwag/remindersync"

  depends_on macos: :sonoma

  app "ReminderSync.app"
  binary "#{appdir}/ReminderSync.app/Contents/MacOS/remindersync"

  uninstall launchctl: "com.zackwag.remindersync",
  delete:    "~/Library/LaunchAgents/com.zackwag.remindersync.plist"

  zap trash: [
    "~/Library/Application Support/remindersync",
    "~/Library/Logs/remindersync",
  ]

  caveats <<~EOS
    Set up a sync pair, then run the daemon in the background:
      remindersync config
      remindersync install
  EOS
end
