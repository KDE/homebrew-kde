require "formula"

class Kf5Kauth < Formula
  desc "Abstraction to system policy and authentication features"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kauth-5.39.0.tar.xz"
  sha256 "b184b817d155b272cf42fa748c6d3c9f1713be423551d2a74e297821f6ee7221"

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "#{HOMEBREW_PREFIX}/lib/libexec/kf5"
      ln -sf "#{lib}/libexec/kauth/kauth-policy-gen" "#{HOMEBREW_PREFIX}/lib/libexec/kf5/"
    EOS
  end
end
