require "formula"

class Kf5Kdesignerplugin < Formula
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kdesignerplugin-5.39.0.tar.xz"
  sha256 "ee9c33c583caa1209b112119b2ba6c1f3c14f015b6bafd6e54c97acd8db1f9ac"

  head "git://anongit.kde.org/kdesignerplugin.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  #  depends_on "haraldf/kf5/kf5-kdewebkit"
  depends_on "haraldf/kf5/kf5-kplotting"
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
