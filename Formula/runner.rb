# The host a Mac keeps running as a service of the user's own, so that Runner's threads can run on the Mac itself.
class Runner < Formula
  desc "Runs Runner's threads on this Mac, with everything the Mac has"
  homepage "https://rnnr.app"
  url "https://github.com/chasefinch/homebrew-tap/releases/download/runner-0.1.0/runner-0.1.0-macos-arm64.tar.gz"
  version "0.1.0"
  sha256 "f33f07757453d465bab34fe5c1b3de914021405d947a61cb9c42c20c6895ddb6"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    bin.install "runner"
  end

  service do
    run [opt_bin/"runner", "--service"]
    keep_alive true
    log_path var/"log/runner.log"
    error_log_path var/"log/runner.log"
  end

  def caveats
    <<~EOS
      Start it, and keep it running from one login to the next, with:
        brew services start runner
      Then choose "This Mac (full access)" in Runner's Settings, under Workstations.
      A copy of Runner from the App Store asks for a code first, which this prints:
        runner --pair
      A thread that runs there can do anything you can do on this Mac.
    EOS
  end

  test do
    assert_match "RunnerHost", shell_output("#{bin}/runner --version")
  end
end
