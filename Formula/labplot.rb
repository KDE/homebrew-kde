require_relative "../lib/cmake"

class Labplot < Formula
  desc "Application for interactive graphing and analysis of scientific data"
  homepage "https://labplot.kde.org/"
  url "https://download.kde.org/stable/labplot/labplot-2.10.1.tar.xz"
  sha256 "2b6e181517cfb6e0dfff7b895f3eb20c7ce359e6732d38545e0757c9aea2daef"
  head "https://invent.kde.org/education/labplot.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "kf5-kdelibs4support" => :build
  depends_on "kf5-kdesignerplugin" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gettext"
  depends_on "gsl"
  depends_on "libcerf"
  depends_on "netcdf"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # see https://github.com/KDE-mac/homebrew-kde/pull/242
    ln_sf "#{share}/kxmlgui5/labplot2/labplot2ui.rc", "#{bin}/labplot2.app/Contents/Resources/labplot2ui.rc"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    mkdir_p HOMEBREW_PREFIX/"share/labplot2"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/labplot2/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
         "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/labplot.app/Contents/MacOS/labplot --help")
  end
end
