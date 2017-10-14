require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.39/kdesu-5.39.0.tar.xz"
  sha256 "9d9b1d202ad09993dd6c0bfe3bf4738e1867dc563bcd49b664e3026534fc5b0d"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
