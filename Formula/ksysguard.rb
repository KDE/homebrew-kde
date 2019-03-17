class Ksysguard < Formula
  desc "Track and control the processes running in your system"
  homepage "https://userbase.kde.org/KSysGuard"
  url "https://download.kde.org/stable/plasma/5.15.3/ksysguard-5.15.3.tar.xz"
  sha256 "38219e61ce3e1bac0463b8d8f538f582e55976750f01cd44b2be105c7d53afdb"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :build
  depends_on "ninja" => :build
  depends_on "hicolor-icon-theme"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-knewstuff"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    system "false"
  end
end
