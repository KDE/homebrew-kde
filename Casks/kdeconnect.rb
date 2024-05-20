cask "kdeconnect" do
  arch arm: "arm64", intel: "x86_64"

  version :latest
  sha256 :no_check

  url do
    require "open-uri"
    base_url = "https://cdn.kde.org/ci-builds/network/kdeconnect-kde/master/macos-#{arch}/"
    version = URI(base_url.to_s)
              .open
              .read
              .scan(/href=.*?kdeconnect-kde[._-]v?(\d+(?:[.-]\d+)+)-macos-clang-.*?\.dmg/i)
              .flatten
              .first # should only be one mach
    file = "kdeconnect-kde-#{version}-macos-clang-#{arch}.dmg"
    "#{base_url}/artifact/#{file}"
  end
  name "KDE Connect"
  desc "Enabling communication between all your devices"
  homepage "https://kdeconnect.kde.org/"

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
