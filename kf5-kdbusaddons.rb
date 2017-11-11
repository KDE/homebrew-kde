require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kdbusaddons-5.40.0.tar.xz"
  sha256 "24a6268127bdfb5095d156f5251052e69a09523ec62499daa606c34f916feb27"
  desc "Addons to QtDBus"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"
  depends_on "dbus"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
