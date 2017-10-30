require "formula"

class Kf5Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kiconthemes-5.39.0.tar.xz"
  sha256 "2edd03b3424fcc02d203ac8e3238c17436ccc951892bfcda498494ff871199cc"

  head "git://anongit.kde.org/kiconthemes.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kitemviews"
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
