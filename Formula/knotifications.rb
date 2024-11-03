require_relative "../lib/cmake"

class Knotifications < Formula
  desc "Abstraction for system notifications"
  homepage "https://api.kde.org/frameworks/knotifications/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/knotifications-6.7.0.tar.xz"
  sha256 "9e972f015d9b31b3283bf842a32d270096224d127c13a6e79450f4f0452de5e7"
  head "https://invent.kde.org/frameworks/knotifications.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kconfig"
  depends_on "libcanberra"

  def install
    # setBadgeLabelText method is deprecated since 5.12
    args = %w[
      -DCMAKE_C_FLAGS_RELEASE=-DNDEBUG
      -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00
      -DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG
      -DQT_DISABLE_DEPRECATED_BEFORE=0x050b00
    ]

    system "cmake", *args, *kde_cmake_args
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
    (testpath/"CMakeLists.txt").write("find_package(KF6Notifications REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
