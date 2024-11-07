require_relative "../lib/cmake"

class KdeconnectKde < Formula
  desc "Multi-platform app that allows your devices to communicate"
  homepage "https://community.kde.org/KDEConnect"
  url "https://download.kde.org/stable/release-service/24.08.3/src/kdeconnect-kde-24.08.3.tar.xz"
  sha256 "10e05e89bdaa02291d8b6d07ec1af90040a87ec2bc01bf96a68c8a11434fff68"
  head "https://invent.kde.org/network/kdeconnect-kde.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kdeclarative" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kcmutils"
  depends_on "kde-mac/kde/kconfigwidgets"
  depends_on "kde-mac/kde/kdbusaddons"
  depends_on "kde-mac/kde/kiconthemes"
  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/kirigami"
  depends_on "kde-mac/kde/knotifications"
  depends_on "kde-mac/kde/kpeople"
  depends_on "kde-mac/kde/kservice"
  depends_on "ki18n"
  depends_on "qca"
  depends_on "qt@6"

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
