class Elisa < Formula
  desc "KDE Music Player"
  homepage "https://community.kde.org/Elisa"
  url "https://download.kde.org/stable/release-service/20.04.2/src/elisa-20.04.2.tar.xz"
  sha256 "d46b8eab27aa183362d6298dacbcec04e57126f25b122f1db31f6819f42dd893"
  head "https://anongit.kde.org/elisa.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "hicolor-icon-theme"
  depends_on "KDE-mac/kde/kf5-kcmutils"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin and QML2 path
    mkdir "getqmlpath" do
      (Pathname.pwd/"main.cpp").write <<~EOS
        #include <QTextStream>
        #include <QLibraryInfo>
        int main() {
          QTextStream out(stdout);
          out << QLibraryInfo::location(QLibraryInfo::Qml2ImportsPath) << endl;
        }
      EOS

      (Pathname.pwd/"qmlpath.pro").write <<~EOS
        QT += core
        TEMPLATE = app
        TARGET = qmlpath
        CONFIG += cmdline
        CONFIG += silent
        SOURCES += main.cpp
      EOS

      system "#{Formula["qt"].bin}/qmake"
      system "make"
    end
    qtpp = Utils.safe_popen_read("#{Formula["qt"].bin}/qtpaths --plugin-dir").chomp
    qml2pp = Utils.safe_popen_read("./getqmlpath/qmlpath").chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "-c", "Add :LSEnvironment:QML2_IMPORT_PATH string \"#{qml2pp}\:#{HOMEBREW_PREFIX}/lib/qt5/qml\"",
      "#{bin}/elisa.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/elisa"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/elisa/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert `"#{bin}/elisa.app/Contents/MacOS/elisa" --help | grep -- --help`.include?("--help")
  end
end
