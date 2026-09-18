class DockerContainerShim < Formula
  desc "Shim rewriting docker subcommands to Apple's container CLI syntax"
  homepage "https://github.com/zackwag/docker-container-shim"
  url "https://github.com/zackwag/docker-container-shim/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c302b69a9351ff728a59d17844cd9115144c9bb89745083a25724859c03b6d07"
  license "MIT"

  depends_on :macos

  def install
    pkgshare.install "docker_container_shim.sh"
  end

  def caveats
    <<~EOS
      This is a shell function, not an executable — add this to your
      ~/.zshrc (or ~/.bashrc) to use it:
        source "#{HOMEBREW_PREFIX}/share/docker-container-shim/docker_container_shim.sh"
    EOS
  end

  test do
    system "bash", "-c", "source #{pkgshare}/docker_container_shim.sh && declare -f docker"
  end
end
