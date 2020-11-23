class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/20.08.2/src/kmime-20.08.2.tar.xz"
  sha256 "9f23e2814e62ae6c4a67fd3223315ef875776f9d098b4d11c7d06a726a725435"
  head "https://invent.kde.org/pim/kmime.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-ki18n"
  depends_on "KDE-mac/kde/kf5-kcodecs"

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

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Mime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
