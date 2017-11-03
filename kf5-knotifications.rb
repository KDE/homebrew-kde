require "formula"

class Kf5Knotifications < Formula
  desc "Abstraction for system notifications"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/knotifications-5.39.0.tar.xz"
  sha256 "b21daed46b95f7d109c5c0e8d3d43e9f435ac497e33912420b495c9080626838"

  head "git://anongit.kde.org/knotifications.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/phonon"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/knotifications5" ~/Library/"Application Support"
    EOS
  end
end
