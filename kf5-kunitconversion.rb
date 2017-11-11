require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kunitconversion-5.40.0.tar.xz"
  sha256 "dc6e28c07835f392be2740787dcb9880af2ecc7fb60810576f0bcea31b93e0e2"
  desc "Support for unit conversion"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kunitconversion.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
