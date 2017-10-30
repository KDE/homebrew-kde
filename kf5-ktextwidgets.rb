require "formula"

class Kf5Ktextwidgets < Formula
  desc "Advanced text editing widgets"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/ktextwidgets-5.39.0.tar.xz"
  sha256 "5849d104e99be94d554bff229646df8fde84e3396c82e21a3e390ee08b09d05c"

  head "git://anongit.kde.org/ktextwidgets.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcompletion"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-sonnet"
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
