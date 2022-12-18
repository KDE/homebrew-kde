require_relative "../lib/cmake"

class KdeconnectKde < Formula
  desc "Multi-platform app that allows your devices to communicate"
  homepage "https://community.kde.org/KDEConnect"
  url "https://download.kde.org/stable/release-service/22.12.0/src/kdeconnect-kde-22.12.0.tar.xz"
  sha256 "a652994b4d7280effb384483ee41d022827efd17f6dc7c5f748b9f95e8d47688"
  head "https://invent.kde.org/network/kdeconnect-kde.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kdeclarative" => :build
  depends_on "ninja" => :build
  depends_on "gettext"
  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kf5-kcmutils"
  depends_on "kde-mac/kde/kf5-kconfigwidgets"
  depends_on "kde-mac/kde/kf5-kdbusaddons"
  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kirigami2"
  depends_on "kde-mac/kde/kf5-knotifications"
  depends_on "kde-mac/kde/kf5-kpeople"
  depends_on "kde-mac/kde/kf5-kservice"
  depends_on "kdoctools"
  depends_on "ki18n"
  depends_on "qca"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_match "help", shell_output("#{bin}/kdeconnect-cli --help")
  end
end
