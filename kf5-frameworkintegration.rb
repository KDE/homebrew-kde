require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.38/frameworkintegration-5.38.0.tar.xz"
  sha256 "08cb88ef7c7ceb7cd43cbc7f3040daf7128d22bb75f8eb3956d55afd3e1b3670"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/frameworkintegration.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
  end
end
