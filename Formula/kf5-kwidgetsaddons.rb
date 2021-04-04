require_relative "../lib/cmake"

class Kf5Kwidgetsaddons < Formula
  desc "Addons to QtWidgets"
  homepage "https://api.kde.org/frameworks/kwidgetsaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.80/kwidgetsaddons-5.80.0.tar.xz"
  sha256 "1a9bfd5653d4c45d55bac5d0a28c8caec8d504bce2ee192d68ecf3ce10a0fcf1"
  head "https://invent.kde.org/frameworks/kwidgetsaddons.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

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
    (testpath/"CMakeLists.txt").write("find_package(KF5WidgetsAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
