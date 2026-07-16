class Kitout < Formula
  desc "The agent-era workstation bootstrapper — declarative, DAG-executed machine setup"
  homepage "https://github.com/beaubutton/kitout"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beaubutton/kitout/releases/download/v0.5.1/kitout-aarch64-apple-darwin.tar.xz"
      sha256 "97d80000e9dfafaad5b18e4eaecd83201c4788bc2132a6cda0eee20d49d94b1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beaubutton/kitout/releases/download/v0.5.1/kitout-x86_64-apple-darwin.tar.xz"
      sha256 "1dcc128f58c9f8ca1d995796586a857379df2175809d2e6d522ad95eac2fe3d1"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "kitout" if OS.mac? && Hardware::CPU.arm?
    bin.install "kitout" if OS.mac? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
