class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/portingAids/kmediaplayer-5.57.0.tar.xz"
  sha256 "521dcb4b3f9a67203e9eac27b8d777cb22557861b9fae0006c2aecda96d9bad4"

  head "git://anongit.kde.org/kmediaplayer.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kparts"

  def install
    args = std_cmake_args
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
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do_caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5MediaPlayer REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
