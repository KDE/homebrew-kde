require "formula"

class Kdevplatform < Formula
  desc "KDevelop Platform"
  homepage "http://kdevelop.org"

  stable do
    url "https://download.kde.org/stable/kdevelop/5.1.2/src/kdevplatform-5.1.2.tar.xz"
    sha256 "e622ddad552a678baaf1166d5cbdc5fd1192d2324300c52ef2d25f1c6778664a"
    depends_on "qt" => ["with-qtwebkit"]
  end

  head do
    url "git://anongit.kde.org/kdevplatform.git"
    depends_on "qt"
  end

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-threadweaver"
  depends_on "KDE-mac/kde/kf5-kdeclarative"

  depends_on "KDE-mac/kde/grantlee5"
  depends_on "KDE-mac/kde/libkomparediff2"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
