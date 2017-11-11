require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kcompletion-5.40.0.tar.xz"
  sha256 "842a26485d381581bdbe7fe3b6d91d404928a47fb589e9a26ebdf5520c55bf9d"
  desc "Text completion helpers and widgets"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
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
