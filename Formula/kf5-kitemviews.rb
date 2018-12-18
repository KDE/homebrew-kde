class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.53/kitemviews-5.53.0.tar.xz"
  sha256 "b87a79f360683149af0b65d63d192b89ae6b0786b08daf6a52fa9e09d2adc064"

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
