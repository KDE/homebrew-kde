class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/knewstuff-5.57.0.tar.xz"
  sha256 "6a9d77a62b036b4ed0f32ffaa9f204db1403030d01dbe8fb055d02361db2f981"

  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5NewStuff REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
