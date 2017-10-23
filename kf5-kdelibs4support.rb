require "formula"

class Kf5Kdelibs4support < Formula
  desc "Porting aid from KDELibs4"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/kdelibs4support-5.39.0.tar.xz"
  sha256 "d735000260d8565e812b96c81d510acef14f7b66e9fcbbd2d42711bd1bfcb20f"

  head "git://anongit.kde.org/kdelibs4support.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kded"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kemoticons"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt"
  depends_on "openssl@1.1"

  patch do
    url "https://git.archlinux.org/svntogit/packages.git/plain/trunk/kdelibs4support-openssl-1.1.patch?h=packages/kdelibs4support"
    sha256  "e33de96fae2b93c3fa06b4219205ae188b214be8c5e84b8d0426217fd65a5d48"
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
      mkdir -p "~/Applications/KDE"
      ln -sf "#{prefix}/bin/kdebugdialog5.app" "~/Applications/KDE/"
    EOS
  end
end
