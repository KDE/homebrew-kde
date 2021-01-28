class Kile < Formula
  desc "Integrated LaTeX Editing Environment"
  homepage "https://kile.sourceforge.io"
  url "https://downloads.sourceforge.net/project/kile/unstable/kile-3.0b3/kile-2.9.93.tar.bz2"
  sha256 "04499212ffcb24fb3a6829149a7cae4c6ad5d795985f080800d6df72f88c5df0"
  revision 1
  head "https://invent.kde.org/office/kile.git"

  depends_on "cmake" => :build
  depends_on "kde-extra-cmake-modules" => :build
  depends_on "kde-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/okular"

  depends_on "KDE-mac/kde/konsole" => [:optional]

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "cmake", "--build", "."
      system "cmake", "--install", "."
      prefix.install "install_manifest.txt"
    end

    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kile.app/Contents/Info.plist"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
       "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kile.app/Contents/MacOS/Kile --help")
  end
end
