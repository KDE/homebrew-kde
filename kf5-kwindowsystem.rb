require "formula"

class Kf5Kwindowsystem < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kwindowsystem-5.37.0.tar.xz"
  sha256 "628a1e6512e89ef1eec2b0c50ea879e340656bbc8c57e2f8e961b75b24b0a25d"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwindowsystem.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
