require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdesignerplugin-5.40.0.tar.xz"
  sha256 "0d57e158e8247a06b148ff9f65c013257b0f374301dd0f05c5a0c70040239403"
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesignerplugin.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  #  depends_on "KDE-mac/kde/kf5-kdewebkit"
  depends_on "KDE-mac/kde/kf5-kplotting"
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
