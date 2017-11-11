require "formula"

class Kf5Kauth < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kauth-5.40.0.tar.xz"
  sha256 "5a27f1ef5af517662e8c0d350c7f0b20a78c6f44b5db190c16d07ba637945c1c"
  desc "Abstraction to system policy and authentication features"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
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
