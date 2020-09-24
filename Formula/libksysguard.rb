class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://www.kde.org/workspaces/plasmadesktop/"
  url "https://download.kde.org/stable/plasma/5.19.5/libksysguard-5.19.5.tar.xz"
  sha256 "d8adb311dae1a699a3fd3fbdc9e6cdde037503ca303b70f12d33b985ee80a0cd"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-plasma-framework" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"

  def install
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *std_cmake_args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5SysGuard REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
