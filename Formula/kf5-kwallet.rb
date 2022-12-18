require_relative "../lib/cmake"

class Kf5Kwallet < Formula
  desc "Secure and unified container for user passwords"
  homepage "https://api.kde.org/frameworks/kwallet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.101/kwallet-5.101.0.tar.xz"
  sha256 "ca0197fa350b8336ab8c7f0b142cbaf58f9ed8e8410b22f9bc7ae2e3bd7a5457"
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
