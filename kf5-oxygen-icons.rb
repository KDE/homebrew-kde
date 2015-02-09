require "formula"

class Kf5OxygenIcons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/applications/14.12.2/src/oxygen-icons-14.12.2.tar.xz"
  sha1 "048417ffa951f9dd881662152d4f14f66e2b9ed6"

  head 'svn://anonsvn.kde.org/home/kde/trunk/kdesupport/oxygen-icons'

  depends_on "cmake" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/icons"], "#{ENV['HOME']}/Library/Application Support/"
  end

  def caveats; <<-EOS.undent
      A symlink "#{ENV['HOME']}/Library/Application Support/icons" was created
      So that KF5 can find the oxygen themes.

      This symlink can be removed when this formula is uninstalled.
  EOS
  end
end
