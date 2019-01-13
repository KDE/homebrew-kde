class Kf5Solid < Formula
  desc "Hardware integration and detection"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.54/solid-5.54.0.tar.xz"
  sha256 "29d70bbed462baac31cce45cf3082600a12ccf53ad1da0a49a3168d72c4cb042"

  head "git://anongit.kde.org/solid.git"

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "flex" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
