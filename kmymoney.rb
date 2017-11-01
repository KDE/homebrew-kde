require "formula"

class Kmymoney < Formula
  desc "Personal finance manager for KDE which operates similarly to MS-Money or Quicken"
  homepage "http://kmymoney.org/"
  url "https://download.kde.org/stable/kmymoney/4.8.1/src/kmymoney-4.8.1.7z"
  sha256 "4435acabb3c9771dd39471651767c857087b5fe4f5cd43132c19cdc92aa6cbab"

  head "git://anongit.kde.org/kmymoney.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-khtml"
  depends_on "KDE-mac/kde/kf5-kdelibs4support"
  depends_on "KDE-mac/kde/libalkimia"
  depends_on "KDE-mac/kde/kdiagram"

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
      mkdir -p ~/Applications/KDE
      ln -sf "#{prefix}/bin/kmymoney.app" ~/Applications/KDE/
    EOS
  end
end
