cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # TODO: eventually also handle release versions (e.g. release-24.08 etc.)?
  base_url = "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-#{arch}"

  version "5234"
  sha256 arm:   "15df86bbaa22c3e9a890c983d1035b5875371a7ddef9ce3f2d4176a9917e185c",
         intel: "797f89ec5b945a34c74f0a822ff961ee83df29893afe38af82fea17273cbe757"

  url "#{base_url}/kdeconnect-kde-master-#{version}-macos-clang-#{arch}.dmg"
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    url base_url
    regex(/href=.*?kdeconnect-kde-master-(\d+(?:)+)-macos-clang-#{arch}\.dmg/i)
  end

  app "KDE Connect.app"
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
