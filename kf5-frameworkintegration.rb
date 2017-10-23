require "formula"

class Kf5Frameworkintegration < Formula
  desc "Framework providing components to allow applications to integrate with a KDE Workspace"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/frameworkintegration-5.39.0.tar.xz"
  sha256 "50b427b53dfdf667d3e6d8de2b1662a7bea508cbf361163f0383a9e82143da8c"

  head "git://anongit.kde.org/frameworkintegration.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"
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
