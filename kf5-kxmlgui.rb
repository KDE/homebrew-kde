require "formula"

class Kf5Kxmlgui < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kxmlgui-5.40.0.tar.xz"
  sha256 "dbec84a483138efdff17955eeb794d2305812b07c5dd0327a756730c6882471d"
  desc "User configurable main windows"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kxmlgui.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
  depends_on "KDE-mac/kde/kf5-attica"
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
