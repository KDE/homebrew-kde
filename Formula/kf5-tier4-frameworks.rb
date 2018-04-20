class Kf5Tier4Frameworks < Formula
  desc "Metapackage for Tier 4 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "KDE-mac/kde/kf5-tier3-frameworks" => :build
  depends_on "KDE-mac/kde/kf5-frameworkintegration" => :build

  def install
    touch "empty"
    prefix.install "empty"
  end
end
