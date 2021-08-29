require_relative "../lib/cmake"

class Libalkimia < Formula
  desc "Library used by KDE Finance applications"
  homepage "https://kmymoney.org"
  head "https://invent.kde.org/office/alkimia.git", branch: "master"

  stable do
    url "https://download.kde.org/stable/alkimia/8.1.0/alkimia-8.1.0.tar.xz"
    sha256 "916807352707b0490cdd9ca65682eff73b00ca523029bda6fe7a2749a1bc927c"
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
