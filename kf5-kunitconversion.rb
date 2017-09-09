require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kunitconversion-5.38.0.tar.xz"
  sha256 "6c538b35e727f75e90178b6b5b17d299a3ce797bd82a6adb0af4e41096eb6082"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kunitconversion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
