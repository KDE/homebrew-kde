require "formula"

class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kguiaddons-5.39.0.tar.xz"
  sha256 "6ee0f5a2b1d66d5266cd2045ff06329efeb394441261a9ce9ea7f5f35689e9ab"

  head "git://anongit.kde.org/kguiaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
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
