cask "remindersync" do
  version "0.5.0"
  sha256 "b8ebfdfd7308f88e26e8e8f490de9c000e26f9d2d2a483eab8f0e9e0182e90a6"

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
