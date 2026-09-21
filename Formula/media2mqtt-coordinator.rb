class Media2mqttCoordinator < Formula
  desc "Grouped media_player coordinator for multi-Mac media2mqtt setups"
  homepage "https://github.com/zackwag/media2mqtt"
  url "https://github.com/zackwag/media2mqtt/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "19b5d317fa257c08741fbb0a1ef9c0ddfbe6d431e85873a52ec2eac2c396c6a3"
  license "MIT"

  depends_on "python@3.13"

  resource "paho-mqtt" do
    url "https://files.pythonhosted.org/packages/39/15/0a6214e76d4d32e7f663b109cf71fb22561c2be0f701d67f93950cd40542/paho_mqtt-2.1.0.tar.gz"
    sha256 "12d6e7511d4137555a3f6ea167ae846af2c7357b10bc6fa4f7c3968fc1723834"
  end

  def install
    venv = libexec/"venv"
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", venv
    venv_pip = venv/"bin/pip"

    resource("paho-mqtt").stage do
      system venv_pip, "install", "--no-deps", "."
    end

    libexec.install "coordinator.py"

    (bin/"media2mqtt-coordinator").write <<~BASH
      #!/usr/bin/env bash
      set -euo pipefail

      CONFIG_FILE="${MEDIA2MQTT_COORDINATOR_CONFIG:-#{etc}/media2mqtt-coordinator/config}"

      if [ ! -f "$CONFIG_FILE" ]; then
          echo "ERROR: Config file not found: $CONFIG_FILE"
          echo "Create it from the default:"
          echo "    cp #{etc}/media2mqtt-coordinator/config.default $CONFIG_FILE"
          exit 1
      fi

      while IFS='=' read -r key value; do
          [[ -z "$key" || "$key" == \\#* ]] && continue
          [ -n "$value" ] && export "$key=$value"
      done < "$CONFIG_FILE"

      exec "#{libexec}/venv/bin/python" "#{libexec}/coordinator.py"
    BASH

    (etc/"media2mqtt-coordinator").mkpath
    (etc/"media2mqtt-coordinator/config.default").atomic_write <<~EOS
      MQTT_HOST=
      MQTT_PORT=1883
      MQTT_USERNAME=
      MQTT_PASSWORD=
      MQTT_DISCOVERY_PREFIX=homeassistant
      MQTT_TOPIC_PREFIX=media2mqtt
      GROUP_NAME=Now Playing
      GROUP_DEVICE_NAME=media2mqtt
    EOS

    unless (etc/"media2mqtt-coordinator/config").exist?
      cp etc/"media2mqtt-coordinator/config.default", etc/"media2mqtt-coordinator/config"
    end
  end

  def caveats
    <<~EOS
      Edit the config file with your MQTT broker details:
          #{etc}/media2mqtt-coordinator/config

      Then start the service:
          brew services start media2mqtt-coordinator
    EOS
  end

  service do
    run [opt_bin/"media2mqtt-coordinator"]
    keep_alive true
    log_path var/"log/media2mqtt-coordinator.log"
    error_log_path var/"log/media2mqtt-coordinator.log"
    working_dir var
  end

  test do
    assert_predicate bin/"media2mqtt-coordinator", :executable?
  end
end
