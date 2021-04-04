require_relative "../lib/cmake"

class Libalkimia < Formula
  desc "Library used by KDE Finance applications"
  homepage "https://kmymoney.org"
  revision 1
  head "https://invent.kde.org/office/alkimia.git"

  stable do
    url "https://download.kde.org/stable/alkimia/8.0.4/alkimia-8.0.4.tar.xz"
    sha256 "0004a7068dff0aa2cb6f47f70d21c129073be11f2edb21f14512bc4470487d1f"
    depends_on "kde-mac/kde/kf5-kdelibs4support"
  end

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "gmp"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-plasma-framework"
  depends_on "kde-mac/kde/qt-webkit"

  def install
    args = kde_cmake_args
    args << "-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(LibAlkimia5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
