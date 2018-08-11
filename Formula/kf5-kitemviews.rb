class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.49/kitemviews-5.49.0.tar.xz"
  sha256 "b75d7cfcde8c3a9c0d24b1509db074bdd835d2eac2819856265c9c2b700146aa"

  head "git://anongit.kde.org/kitemviews.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
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
