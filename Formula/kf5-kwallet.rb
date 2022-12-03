require_relative "../lib/cmake"

class Kf5Kwallet < Formula
  desc "Secure and unified container for user passwords"
  homepage "https://api.kde.org/frameworks/kwallet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.100/kwallet-5.100.0.tar.xz"
  sha256 "2bbdf57f515b36d95e8adcf56e96157bb7621f5284abfc3b6e5d63f9f2832e80"
  head "https://invent.kde.org/frameworks/kwallet.git", branch: "master"

  depends_on "boost" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "gpgme"
  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-knotifications"
  depends_on "kde-mac/kde/kf5-kservice"
  depends_on "libgcrypt"
  depends_on "qca"

  def install
    args = "-DCMAKE_CXX_FLAGS=-I#{Formula["libgpg-error"].include}"

    system "cmake", *kde_cmake_args, args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Wallet REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
