require "formula"

class Kf5Kmymoney < Formula
  desc "Personal finance manager for KDE which operates similarly to MS-Money or Quicken"
  homepage "http://kmymoney.org/"

  head "git://anongit.kde.org/kmymoney.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-alkimia"
  depends_on "KDE-mac/kde/kf5-kdiagram"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-khtml"
  depends_on "KDE-mac/kde/kf5-kdelibs4support"
  depends_on "qt"

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
      ln -sf "#{prefix}/bin/kmymoney.app" "$HOME/Applications/KDE"
    EOS
  end
end
