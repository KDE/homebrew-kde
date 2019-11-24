class Kdiagram < Formula
  desc "Powerful libraries for creating business diagrams"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/kdiagram/2.6.1/kdiagram-2.6.1.tar.xz"
  sha256 "bde71ca5ef70b3077696d56b24e0e1f69ae255c0bf7bf453e9596afdd25dcdb0"
  head "git://anongit.kde.org/kdiagram.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KChart REQUIRED)
      find_package(KGrantt REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
