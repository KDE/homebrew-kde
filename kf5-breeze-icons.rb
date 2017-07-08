require "formula"

class Kf5BreezeIcons < Formula
  url "http://download.kde.org/stable/frameworks/5.36/breeze-icons-5.36.0.tar.xz"
  sha256 "c39d5bb13f1a3e81ac5cc10f44f842228c7441a98c3c370aa55ca93ffc9566a5"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/breeze-icons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DBINARY_ICONS_RESOURCE=TRUE"
    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/icons"], "#{Etc.getpwuid.dir}/Library/Application Support/"
  end

  def caveats; <<-EOS.undent
      A symlink "#{ENV["HOME"]}/Library/Application Support/icons" was created
      So that KF5 can find the breeze themes.

      This symlink can be removed when this formula is uninstalled.
  EOS
  end
end
