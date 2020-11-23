class Libksysguard < Formula
  desc "Libraries for ksysguard"
  homepage "https://www.kde.org/workspaces/plasmadesktop/"
  url "https://download.kde.org/stable/plasma/5.20.2/libksysguard-5.20.2.tar.xz"
  sha256 "9f57a3719d665df6d6b3c494a62bb7d60c79b06f30c0e9c75eb03568d2046d71"

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
