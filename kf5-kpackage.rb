require "formula"

class Kf5Kpackage < Formula
  desc "Framework that lets applications manage user installable packages of non-binary assets"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kpackage-5.39.0.tar.xz"
  sha256 "713eff23f61d9766f02b40cc6cfa73acd31d126a0c6a775903f79c9adebc77c5"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
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
