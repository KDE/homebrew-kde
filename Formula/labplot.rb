class Labplot < Formula
  desc "Application for interactive graphing and analysis of scientific data"
  homepage "https://labplot.kde.org/"
  url "https://download.kde.org/stable/labplot/2.5.0/labplot-2.5.0.tar.xz"
  sha256 "f1ef2d95a4d4f18902e38cd1f2f79d041d4eeed1eb7f6284ec9a6a6954792225"
  revision 2

  head "git://anongit.kde.org/labplot.git"

  depends_on "cmake" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdelibs4support" => :build
  depends_on "kf5-kdesignerplugin" => :build
  depends_on "kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gettext"
  depends_on "gsl"
  depends_on "libcerf"
  depends_on "netcdf"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/labplot2"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/labplot2/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sfv "$(brew --prefix)/share/labplot2" "$HOME/Library/Application Support"
       ln -sfv "$(brew --prefix)/opt/labplot/bin/labplot2.app" "/Applications"
       ln -sfv "$(brew --prefix)/opt/labplot/share/kxmlgui5/labplot2/labplot2ui.rc" \
          "$(brew --prefix)/opt/labplot/bin/labplot2.app/Contents/Resources"
  EOS
  end

  test do
    assert `"#{bin}/labplot.app/Contents/MacOS/labplot" --help | grep -- --help` =~ /--help/
  end
end
