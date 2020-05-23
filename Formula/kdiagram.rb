class Kdiagram < Formula
  desc "Powerful libraries for creating business diagrams"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/kdiagram/2.7.0/kdiagram-2.7.0.tar.xz"
  sha256 "63a2eabfa1554ceb1d686d5f17ed6308139b6d9155aaf224e0309585b070fbdd"
  head "git://anongit.kde.org/kdiagram.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
