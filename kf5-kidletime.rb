require "formula"

class Kf5Kidletime < Formula
  desc "Monitoring user activity"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kidletime-5.39.0.tar.xz"
  sha256 "a8ada849a4c740a4346bc3c073e38761b8cfe38be6eb0ffc9221d85932bb0506"

  head "git://anongit.kde.org/kidletime.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
