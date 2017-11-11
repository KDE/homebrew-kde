require "formula"

class Kf5Knotifications < Formula
  url "http://download.kde.org/stable/frameworks/5.40/knotifications-5.40.0.tar.xz"
  sha256 "1b54fdccee857c3f66ffa6c830d738bd968cf4c1f9ef2ac8f52a516e94287904"
  desc "Abstraction for system notifications"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knotifications.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-phonon"
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
