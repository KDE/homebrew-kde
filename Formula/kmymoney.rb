class Kmymoney < Formula
  desc "Personal finance manager similar to MS-Money or Quicken"
  homepage "https://kmymoney.org"
  url "https://download.kde.org/stable/kmymoney/5.0.3/src/kmymoney-5.0.3.tar.xz"
  sha256 "698c0fc7ef2134c5c120a98b10f033e14dc37bff723b562c3b50a018c6ebdbf8"

  head "git://anongit.kde.org/kmymoney.git"

  depends_on "cmake" => :build
  depends_on "docbook-xsl" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "boost"
  depends_on "gpgme"
  depends_on "KDE-mac/kde/kdiagram"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-kactivities"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kdewebkit"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/libalkimia"
  depends_on "libical"
  depends_on "libofx"
  depends_on "sqlcipher"

  depends_on "KDE-mac/kde/kf5-kross" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/bin/kmymoney.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
    mkdir_p HOMEBREW_PREFIX/"share/kmymoney"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kmymoney/icontheme.rcc"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do_caveats.sh"
  EOS
  end

  test do
    assert `"#{bin}/kmymoney.app/Contents/MacOS/kmymoney" --help | grep -- --help` =~ /--help/
  end
end
