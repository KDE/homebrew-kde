class KdeconnectKde < Formula
  desc "Multi-platform app that allows your devices to communicate"
  homepage "https://community.kde.org/KDEConnect"
  url "https://download.kde.org/stable/release-service/20.12.1/src/kdeconnect-kde-20.12.1.tar.xz"
  sha256 "fc15b7dba854b5ccc0fbaf1f7accb2c60ef89f311925c89e0c76c5e653182160"
  head "https://github.com/KDE/kdeconnect-kde.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "KDE-mac/kde/kf5-kdeclarative" => :build
  depends_on "ninja" => :build
  depends_on "gettext"
  depends_on "hicolor-icon-theme"
  depends_on "kde-ki18n"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kirigami2"
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "KDE-mac/kde/kf5-kpeople"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "qca"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    assert `"#{bin}/kdeconnect-cli" --help | grep -- --help`.include?("--help")
  end
end
