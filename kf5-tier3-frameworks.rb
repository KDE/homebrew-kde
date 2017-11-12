class Kf5Tier3Frameworks < Formula
  desc "Metapackage for Tier 3 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  url "https://sl1pkn07.wtf/paste/view/raw/f4513d60"
  sha256 "54d626e08c1c802b305dad30b7e54a82f102390cc92c7d4db112048935236e9c"

  depends_on "KDE-mac/kde/kf5-kbookmarks" => :build
  depends_on "KDE-mac/kde/kf5-kcmutils" => :build
  depends_on "KDE-mac/kde/kf5-kconfigwidgets" => :build
  depends_on "KDE-mac/kde/kf5-kdeclarative" => :build
  depends_on "KDE-mac/kde/kf5-kded" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "KDE-mac/kde/kf5-kdesu" => :build
  depends_on "KDE-mac/kde/kf5-kdewebkit" => :build
  depends_on "KDE-mac/kde/kf5-kemoticons" => :build
  depends_on "KDE-mac/kde/kf5-kglobalaccel" => :build
  depends_on "KDE-mac/kde/kf5-kiconthemes" => :build
  depends_on "KDE-mac/kde/kf5-kinit" => :build
  depends_on "KDE-mac/kde/kf5-kio" => :build
  depends_on "KDE-mac/kde/kf5-knewstuff" => :build
  depends_on "KDE-mac/kde/kf5-knotifyconfig" => :build
  depends_on "KDE-mac/kde/kf5-kparts" => :build
  depends_on "KDE-mac/kde/kf5-kpeople" => :build
  depends_on "KDE-mac/kde/kf5-krunner" => :build
  depends_on "KDE-mac/kde/kf5-kservice" => :build
  depends_on "KDE-mac/kde/kf5-ktexteditor" => :build
  depends_on "KDE-mac/kde/kf5-ktextwidgets" => :build
  depends_on "KDE-mac/kde/kf5-kwallet" => :build
  depends_on "KDE-mac/kde/kf5-kxmlgui" => :build
  depends_on "KDE-mac/kde/kf5-kxmlrpcclient" => :build
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :build

  def install
    FileUtils.touch "empty"
    prefix.install "empty"
  end
end

