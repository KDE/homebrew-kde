require "formula"

class Kf5Khtml < Formula
  desc "KHTML APIs"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/portingAids/khtml-5.39.0.tar.xz"
  sha256 "a284c7c60bf0df22c4b92e9c341ca080cd49730c5218f572ed88a885365ff624"

  head "git://anongit.kde.org/khtml.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "openssl@1.1"
  depends_on "jpeg"
  depends_on "giflib"
  depends_on "libpng"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-kxmlgui"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DOPENSSL_CRYPTO_LIBRARY=#{HOMEBREW_PREFIX}/opt/openssl@1.1/lib/libcrypto.dylib"
    args << "-DOPENSSL_SSL_LIBRARY=#{HOMEBREW_PREFIX}/opt/openssl@1.1/lib/libssl.1.1.dylib"
    args << "-DOPENSSL_INCLUDE_DIR=#{HOMEBREW_PREFIX}opt/openssl@1.1"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
