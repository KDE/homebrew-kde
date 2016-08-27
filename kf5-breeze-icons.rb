require "formula"

class Kf5BreezeIcons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.25/breeze-icons-5.25.0.tar.xz"
  sha256 "e274c7f5c71c177e2e9d8ced9c49cd052ec2f726cb693c7df73e96af12277e8f"

  head 'git://anongit.kde.org/breeze-icons.git'

  depends_on "cmake" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
    ln_sf Dir["#{HOMEBREW_PREFIX}/share/icons"], "#{Etc.getpwuid.dir}/Library/Application Support/"
  end

  def caveats; <<-EOS.undent
      A symlink "#{ENV['HOME']}/Library/Application Support/icons" was created
      So that KF5 can find the breeze themes.

      This symlink can be removed when this formula is uninstalled.
  EOS
  end
end
