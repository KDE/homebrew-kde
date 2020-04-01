class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://www.kde.org/workspaces/plasmadesktop/"
  url "https://download.kde.org/stable/plasma/5.18.4/libksysguard-5.18.4.1.tar.xz"
  sha256 "357be91db541876fa257b9be903484beb6577502a05f1610480ed0b198d16824"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
