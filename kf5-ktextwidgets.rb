require "formula"

class Kf5Ktextwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.40/ktextwidgets-5.40.0.tar.xz"
  sha256 "d95412d49025c4c52dafb1056d1d153726126b0cad940841f85ff98dd4b4a236"
  desc "Advanced text editing widgets"
  homepage "http://www.kde.org/"

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
