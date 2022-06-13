require_relative "../lib/cmake"

class Kf5Kcontacts < Formula
  desc "Address book API for KDE"
  homepage "https://api.kde.org/frameworks/kcontacts/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.94/kcontacts-5.94.0.tar.xz"
  sha256 "f7f317dfd9b270249cf168a699b39236490b5b21ec2ef1d186b59e29566252f8"
  head "https://invent.kde.org/frameworks/kcontacts.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@5"
  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcoreaddons"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Contacts REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
