require_relative "../lib/cmake"

class Kf5Knotifications < Formula
  desc "Abstraction for system notifications"
  homepage "https://api.kde.org/frameworks/knotifications/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.87/knotifications-5.87.0.tar.xz"
  sha256 "830583877f13dfd8c7fc512151ab23b7a34fa0a8229e144b1bff5b1a2253f90f"
  head "https://invent.kde.org/frameworks/knotifications.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kwindowsystem"
  depends_on "kde-mac/kde/phonon"
  depends_on "libcanberra"

  def install
    args = kde_cmake_args

    # setBadgeLabelText method is deprecated since 5.12
    args << "-DCMAKE_C_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00"
    args << "-DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Notifications REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
