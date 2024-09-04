require_relative "../lib/cmake"

class Kf6Kcontacts < Formula
  desc "Support for vCard contacts"
  homepage "https://api.kde.org/frameworks/kcontacts/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kcontacts-6.5.0.tar.xz"
  sha256 "b711e098469a5821044bf99bd74d0a16b804731a347cf53609a4bd1b5fa5fdc4"
  head "https://invent.kde.org/frameworks/kcontacts.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kcoreaddons"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "ki18n"
  depends_on "kde-mac/kde/kf6-kcodecs"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6Contacts REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
