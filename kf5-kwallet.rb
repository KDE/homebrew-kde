require "formula"

class Kf5Kwallet < Formula
  desc "Secure and unified container for user passwords"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kwallet-5.39.0.tar.xz"
  sha256 "5f83a5ca245773abfe5b31c536996ca1aee312d512181d133edcd890874f9fee"

  head "git://anongit.kde.org/kwallet.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-knotifications"
  depends_on "qt"
  depends_on "libgcrypt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      mkdir -p "~/Applications/KDE"
      ln -sf "#{prefix}/bin/kwallet-query.app" "~/Applications/KDE/"
      ln -sf "#{prefix}/bin/kwalletd5.app" "~/Applications/KDE/"
    EOS
  end
end
