class Kf5Tier3Frameworks < Formula
  desc "Metapackage for Tier 3 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.54.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

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
  depends_on "KDE-mac/kde/kf5-tier2-frameworks" => :build

  def install
    touch "empty"
    prefix.install "empty"
  end
end
