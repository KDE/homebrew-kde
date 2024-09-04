require_relative "../lib/cmake"

class Kf6Tier3Frameworks < Formula
  desc "Metapackage for Tier 3 KF6 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "6.5.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    skip "Meta package"
  end

  depends_on "kde-mac/kde/kf6-kbookmarks"
  depends_on "kde-mac/kde/kf6-kcmutils"
  depends_on "kde-mac/kde/kf6-kconfigwidgets"
  depends_on "kde-mac/kde/kf6-kdeclarative"
  depends_on "kde-mac/kde/kf6-kded"
#  depends_on "kde-mac/kde/kf6-kemoticons"
  depends_on "kde-mac/kde/kf6-kglobalaccel"
  depends_on "kde-mac/kde/kf6-kiconthemes"
#  depends_on "kde-mac/kde/kf6-kinit"
  depends_on "kde-mac/kde/kf6-kio"
  depends_on "kde-mac/kde/kf6-knewstuff"
  depends_on "kde-mac/kde/kf6-knotifyconfig"
  depends_on "kde-mac/kde/kf6-kparts"
  depends_on "kde-mac/kde/kf6-kservice"
  depends_on "kde-mac/kde/kf6-ktexteditor"
  depends_on "kde-mac/kde/kf6-ktextwidgets"
  depends_on "kde-mac/kde/kf6-kwallet"
  depends_on "kde-mac/kde/kf6-kxmlgui"
  depends_on "kde-mac/kde/kf6-tier2-frameworks"

  def install
    touch "empty"
    prefix.install "empty"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(ECM REQUIRED)
      set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
      find_package(KF6Bookmarks REQUIRED)
      find_package(KF6KCMUtils REQUIRED)
      find_package(KF6ConfigWidgets REQUIRED)
      find_package(KF6Declarative REQUIRED)
      find_package(KDED REQUIRED)
      find_package(KF6Su REQUIRED)
      find_package(KF6GlobalAccel REQUIRED)
      find_package(KF6IconThemes REQUIRED)
      find_package(KF6KIO REQUIRED)
      find_package(KF6NewStuff REQUIRED)
      find_package(KF6NewStuffCore REQUIRED)
      find_package(KF6NewStuffQuick REQUIRED)
      find_package(KF6NotifyConfig REQUIRED)
      find_package(KF6Parts REQUIRED)
      find_package(KF6People REQUIRED)
      find_package(KF6Runner REQUIRED)
      find_package(KF6Service REQUIRED)
      find_package(KF6TextEditor REQUIRED)
      find_package(KF6TextWidgets REQUIRED)
      find_package(KF6Wallet REQUIRED)
      find_package(KF6XmlGui REQUIRED)
      find_package(KF6XmlRpcClient REQUIRED)
      find_package(KF6Plasma REQUIRED)
      find_package(KF6PlasmaQuick REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
