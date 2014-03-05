require "formula"

class Kf5OxygenIcons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/4.12.0/src/oxygen-icons-4.12.0.tar.xz"
  sha1 "4bb0de73e52d237c906903c383c2e36cb2d5c143"

  head 'svn://anonsvn.kde.org/home/kde/trunk/kdesupport/oxygen-icons'

  depends_on "cmake" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/icons"], "#{ENV['HOME']}/Library/Application Support/"
  end

  def caveats; <<-EOS.undent
      A symlink "#{ENV['HOME']}/Library/Application Support/icons" was created
      So that KF5 can find the oxygen themes.

      This symlink can be removed when this formula is uninstalled.
  EOS
  end
end
