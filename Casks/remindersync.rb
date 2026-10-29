cask "remindersync" do
  version "0.4.0"
  sha256 "490b1b21a948c5cba2c846efd63d818e11a7abf86a4b84a30a6069fcc3f45fa9"

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
