class Kf5Solid < Formula
  desc "Hardware integration and detection"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/solid-5.57.0.tar.xz"
  sha256 "fbdb0678a5a1b9f902661b4823dbae4629a88708b729d827dd0598799f727209"

  head "git://anongit.kde.org/solid.git"

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "flex" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    # The setTime_t function is deprecated since 5.8.
    args << "-DCMAKE_C_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050700"
    args << "-DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050700"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
