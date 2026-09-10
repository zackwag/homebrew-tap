class Media2mqtt < Formula
  desc "Publish macOS media app playback state to Home Assistant via MQTT"
  homepage "https://github.com/zackwag/media2mqtt"
  version "1.2.1"
  url "https://github.com/zackwag/media2mqtt/archive/refs/tags/v#{version}.tar.gz"
  sha256 "bdf9897580885331efcd09e609ead20c3705e86c6d08aa87822c92a19c2f2ac5"
  license "MIT"

  depends_on :macos
  depends_on "nowplaying-cli"
  depends_on "python@3.13"

  resource "paho-mqtt" do
    url "https://files.pythonhosted.org/packages/39/15/0a6214e76d4d32e7f663b109cf71fb22561c2be0f701d67f93950cd40542/paho_mqtt-2.1.0.tar.gz"
    sha256 "12d6e7511d4137555a3f6ea167ae846af2c7357b10bc6fa4f7c3968fc1723834"
  end

  def install
    venv = libexec/"venv"
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", venv
    venv_pip = venv/"bin/pip"

    resource("paho-mqtt").stage do
      system venv_pip, "install", "--no-deps", "."
    end

    libexec.install "main.py", "media_apps.py", "mqtt_publisher.py"

    (bin/"media2mqtt").write <<~BASH
      #!/usr/bin/env bash
      set -euo pipefail

      CONFIG_FILE="${MEDIA2MQTT_CONFIG:-#{etc}/media2mqtt/config}"

      if [ ! -f "$CONFIG_FILE" ]; then
          echo "ERROR: Config file not found: $CONFIG_FILE"
          echo "Create it from the default:"
          echo "    cp #{etc}/media2mqtt/config.default $CONFIG_FILE"
          exit 1
      fi

      while IFS='=' read -r key value; do
          [[ -z "$key" || "$key" == \\#* ]] && continue
          [ -n "$value" ] && export "$key=$value"
      done < "$CONFIG_FILE"

      exec "#{libexec}/venv/bin/python" "#{libexec}/main.py"
    BASH

    (etc/"media2mqtt").mkpath
    rm_f etc/"media2mqtt/config.default"
    (etc/"media2mqtt/config.default").write <<~EOS
      MQTT_HOST=
      MQTT_PORT=1883
      MQTT_USERNAME=
      MQTT_PASSWORD=
      MQTT_DISCOVERY_PREFIX=homeassistant
      MQTT_TOPIC_PREFIX=media2mqtt
      DEVICE_NAME=
      ENABLED_APPS=music
      POLL_INTERVAL_SECONDS=1
    EOS

    unless (etc/"media2mqtt/config").exist?
      cp etc/"media2mqtt/config.default", etc/"media2mqtt/config"
    end
  end

  def caveats
    <<~EOS
      Edit the config file with your MQTT broker details:
          #{etc}/media2mqtt/config

      Then start the service:
          brew services start media2mqtt
    EOS
  end

  service do
    run [opt_bin/"media2mqtt"]
    keep_alive true
    log_path var/"log/media2mqtt.log"
    error_log_path var/"log/media2mqtt.log"
    working_dir var
  end

  test do
    assert_predicate bin/"media2mqtt", :executable?
  end
end
