cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  # TODO: eventually also handle release versions (e.g. release-24.08 etc.)?
  base_url = "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-#{arch}"

  version "4694"
  sha256 arm:   "458f8a38f78710634e4c956bab5a0dce97e5eb415798ab38247c9a351d8fc82a",
         intel: "5ec22aea70476f632affe0a0946b920e6c361e0a10f651a418ca8c11df01a500"

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
