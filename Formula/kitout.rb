class Kitout < Formula
  desc "Agent-era workstation bootstrapper — declarative, DAG-executed machine setup"
  homepage "https://github.com/beaubutton/kitout"
  version "0.1.0"
  license "MIT OR Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/beaubutton/kitout/releases/download/v0.1.0/kitout-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "03f4481c55302bb0dcba26e1ff4d43ac5be0610c5a867654612a627b6e2b7c5a"
    else
      url "https://github.com/beaubutton/kitout/releases/download/v0.1.0/kitout-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a29ed4bda3d484ce0f498b2520efff5dd81a5f28bc785166e724b939a43b35ca"
    end
  end

  def install
    bin.install "kitout"
  end

  test do
    system "#{bin}/kitout", "--version"
  end
end
