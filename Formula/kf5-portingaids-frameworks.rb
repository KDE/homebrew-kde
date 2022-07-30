require_relative "../lib/cmake"

class Kf5PortingaidsFrameworks < Formula
  desc "Metapackage for PortingAids KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.96.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    skip "Meta package"
  end

  depends_on "kde-mac/kde/kf5-kdelibs4support"
  depends_on "kde-mac/kde/kf5-kdesignerplugin"
  depends_on "kde-mac/kde/kf5-kdewebkit"
  depends_on "kde-mac/kde/kf5-khtml"
  depends_on "kde-mac/kde/kf5-kjs"
  depends_on "kde-mac/kde/kf5-kjsembed"
  depends_on "kde-mac/kde/kf5-kmediaplayer"
  depends_on "kde-mac/kde/kf5-kross"
  depends_on "kde-mac/kde/kf5-kxmlrpcclient"
  depends_on "kde-mac/kde/kf5-tier4-frameworks"

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
      find_package(KF5KDELibs4Support REQUIRED)
      find_package(KF5KDE4Support REQUIRED)
      find_package(KF5DesignerPlugin REQUIRED)
      find_package(KF5WebKit REQUIRED)
      find_package(KF5KHtml REQUIRED)
      find_package(KF5JS REQUIRED)
      find_package(KF5JsEmbed REQUIRED)
      find_package(KF5MediaPlayer REQUIRED)
      find_package(KF5Kross REQUIRED)
      find_package(KF5XmlRpcClient REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
