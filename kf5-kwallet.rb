require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kwallet-5.40.0.tar.xz"
  sha256 "cd2219a1c7fb64e282ad9b9cfe4c885ad834013553f233325fc2268adb1edd53"
  desc "Secure and unified container for user passwords"
  homepage "http://www.kde.org/"

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
      mkdir -p "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kwallet-query.app" "$HOME/Applications/KDE"
      ln -sf "#{prefix}/bin/kwalletd5.app" "$HOME/Applications/KDE"
    EOS
  end
end
