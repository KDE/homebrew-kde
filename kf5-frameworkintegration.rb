require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.36/frameworkintegration-5.36.0.tar.xz"
  sha256 "345f6dc25d5f864aaeeffec8b5888c25b3248dcab16210c60663e2a65d1143e1"
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
