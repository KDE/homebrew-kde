require_relative "../lib/cmake"

class Kf5Kwallet < Formula
  desc "Secure and unified container for user passwords"
  homepage "https://api.kde.org/frameworks/kwallet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/kwallet-5.115.0.tar.xz"
  sha256 "f2b3fc21c89440c9290703929a8bcb77461fa510fd060c33d64787c9e0eaef3d"
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
