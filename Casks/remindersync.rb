cask "remindersync" do
  version "0.5.1"
  sha256 "baa97ad477d19acfc0daba7706434c4ff6b6dd15c4ff3162f1e2a150245f3c03"

  url "https://github.com/zackwag/remindersync/releases/download/v#{version}/ReminderSync.zip"
  name "ReminderSync"
  desc "Sync Apple Reminders lists with Skylight lists and chores"
  homepage "https://github.com/zackwag/remindersync"

  depends_on macos: :sonoma

  app "ReminderSync.app"
  binary "#{appdir}/ReminderSync.app/Contents/MacOS/remindersync"

  # The agent is removed in zap rather than uninstall, because brew
  # runs the old version's uninstall stanza on every upgrade, which
  # would stop the daemon until the next `remindersync install`.
  # Left alone, the daemon restarts itself onto the new build.
  zap launchctl: "com.zackwag.remindersync",
      delete:    "~/Library/LaunchAgents/com.zackwag.remindersync.plist",
      trash:     [
        "~/Library/Application Support/remindersync",
        "~/Library/Logs/remindersync",
      ]

  caveats <<~EOS
    Set up a sync pair, then run the daemon in the background:
      remindersync config
      remindersync install

    Before uninstalling, stop the daemon with `remindersync uninstall`,
    or uninstall with `brew uninstall --zap remindersync`.
  EOS
end
