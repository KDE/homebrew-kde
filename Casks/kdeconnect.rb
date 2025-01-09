cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # TODO: eventually also handle release versions (e.g. release-24.08 etc.)?
  base_url = "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-#{arch}"

  version "4657"
  sha256 arm:   "55f85d7afab329acd792f80e72436a556eea228d19f4e0af356e103eea2717e4",
         intel: "563890b634eb46afe4ebea1faf59efc734feafd40f14324d4dcab4da480eb1f8"

  url "#{base_url}/kdeconnect-kde-master-#{version}-macos-clang-#{arch}.dmg"
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    url base_url
    regex(/href=.*?kdeconnect-kde-master-(\d+(?:)+)-macos-clang-#{arch}\.dmg/i)
  end

  app "kdeconnect-indicator.app", target: "KDE Connect.app"
  binary "#{appdir}/KDE Connect.app/Contents/MacOS/kdeconnect-cli",
         target: "kdeconnect"

  uninstall quit: "org.kde.kdeconnect"

  zap trash: [
    "~/Library/Application Support/kpeoplevcard",
    "~/Library/Caches/kdeconnect.sms",
    "~/Library/Preferences/kdeconnect",
    "~/Library/Preferences/kdeconnect_runcommand",
    "~/Library/Preferences/kdeconnect_sendnotifications",
    "~/Library/Preferences/kdeconnect_share",
    "~/Library/Preferences/org.kde.kdeconnect.plist",
  ]
end
