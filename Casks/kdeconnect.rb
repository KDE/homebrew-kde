cask "kdeconnect" do
  version "26.04.2"
  sha256 :no_check

  url "https://invent.kde.org/packaging/homebrew-kde/-/raw/master/README.md"
  name "KDE Connect Moved"
  desc "Dummy transient cask, feel free to remove"
  homepage "https://kdeconnect.kde.org/"

  livecheck do
    skip "Meta package"
  end

  depends_on cask: "homebrew/cask/kde-connect"

  stage_only true
end
