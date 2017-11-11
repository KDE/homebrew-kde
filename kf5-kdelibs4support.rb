require "formula"

class Kf5Kdelibs4support < Formula
  url "http://download.kde.org/stable/frameworks/5.40/portingAids/kdelibs4support-5.40.0.tar.xz"
  sha256 "f9d7508aa6a72a186ba7d922e82ca49a5ac5d76e1fa02af995d17208128995df"
  desc "Porting aid from KDELibs4"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdelibs4support.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kded"
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin"
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kunitconversion"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "qt"
  depends_on "openssl@1.1"

  patch do
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"
    args << "-DOPENSSL_CRYPTO_LIBRARY=/usr/local/opt/openssl@1.1/lib/libcrypto.dylib"
    args << "-DOPENSSL_SSL_LIBRARY=/usr/local/opt/openssl@1.1/lib/libssl.1.1.dylib"
    args << "-DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl@1.1/"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kdebugdialog5.app" "$HOME/Applications/KDE"
    EOS
  end
end
