class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://www.kde.org/workspaces/plasmadesktop/"
  url "https://download.kde.org/stable/plasma/5.19.3/libksysguard-5.19.3.tar.xz"
  sha256 "9546c4264d47c5d9ffdf12bb4075218e43995c194ec8b43bb423acd535cf1938"

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
