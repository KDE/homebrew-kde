class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.45/kitemmodels-5.45.0.tar.xz"
  sha256 "81cf879c8ca546bb1626c3c3fcd82d365f0d5ee45aba5066be8b3b468ddeab22"

  head "git://anongit.kde.org/kitemmodels.git"

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
