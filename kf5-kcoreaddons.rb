require "formula"

class Kf5Kcoreaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kcoreaddons-5.40.0.tar.xz"
  sha256 "25109dd486891c113f8b01d55f4c02e35b65b456c3879eb7da5045e595db8f58"
  desc "Addons to QtCore"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcoreaddons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
