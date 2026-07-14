class BearFormatter < Formula
  desc "Cute little formatter for Bear notes"
  homepage "https://github.com/chasefinch/bear-formatter"
  license "MIT"
  head "https://github.com/chasefinch/bear-formatter.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "hello\n", shell_output("#{bin}/bear-format --code hello")
  end
end
