require "formula"

class KdevelopPgQt < Formula
  desc "LL(1) parser generator based on Qt"
  homepage "http://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop-pg-qt/2.1.0/src/kdevelop-pg-qt-2.1.0.tar.xz"
  sha256 "20d84d25bd40610bd6c0964e4fe0642e56c41b76a65575122dc5196649621e5d"

  head "git://anongit.kde.org/kdevelop-pg-qt.git"

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
