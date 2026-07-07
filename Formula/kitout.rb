class Kitout < Formula
  desc "The agent-era workstation bootstrapper — declarative, DAG-executed machine setup"
  homepage "https://github.com/beaubutton/kitout"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beaubutton/kitout/releases/download/v0.1.2/kitout-aarch64-apple-darwin.tar.xz"
      sha256 "2edf0ba05cfdd4731b2ccbe14cd8152831af8cde8c799c44d3bea32c3cbbe342"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beaubutton/kitout/releases/download/v0.1.2/kitout-x86_64-apple-darwin.tar.xz"
      sha256 "4d6152a4c68bf2cf4f8a14a4dbd74e83e053cdf8307d994cc5b05c05ccd1af24"
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
