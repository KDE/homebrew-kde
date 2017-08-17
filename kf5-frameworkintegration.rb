require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.37/frameworkintegration-5.37.0.tar.xz"
  sha256 "aa8ca045ba97899b739077e07a961b9e402520a0abfcee8be90baa85251c9e5d"
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
