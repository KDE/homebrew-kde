class Kdenlive < Formula
  desc "Video editor"
  homepage "https://www.kdenlive.org/"
  url "https://download.kde.org/stable/applications/18.04.3/src/kdenlive-18.04.3.tar.xz"
  sha256 "9505ac2e5f4918932b868f0ccc1d74b1ae545283033081fab92415cc0d1d435f"

  head "git://anongit.kde.org/kdenlive.git"

  depends_on "cmake" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdoctools" => :build
  depends_on "kf5-kfilemetadata"
  depends_on "kf5-knewstuff"
  depends_on "kf5-knotifyconfig"
  depends_on "mlt"
  depends_on "qt-webkit"
  depends_on "cdrtools" => :optional
  depends_on "dvdauthor" => :optional
  depends_on "ffmpeg" => :optional
  depends_on "libdv" => :optional

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
    args << "-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def post_install
    mkdir_p "#{HOMEBREW_PREFIX}/share/kdenlive"
    ln_sf "#{HOMEBREW_PREFIX}/share/icons/breeze/breeze-icons.rcc", "#{HOMEBREW_PREFIX}/share/kdenlive/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sfv "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
       mkdir -pv "$HOME/Applications/KDE"
       ln -sfv "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app" "$HOME/Applications/KDE"
  EOS
  end

  test do
    assert "$(brew --prefix)/opt/kdenlive/bin/kdenlive.app/Contents/MacOS/kdenlive --help | grep -- --help"
  end
end
