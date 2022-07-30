require_relative "../lib/cmake"

class Kpimtextedit < Formula
  desc "Textedit with PIM-specific features"
  homepage "https://api.kde.org/kdepim/kpimtextedit/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.3/src/kpimtextedit-22.04.3.tar.xz"
  sha256 "2dbc53584524477e8bbf8f8a919438e47c2ae1345ace5787f2e3989e2db260bd"
  head "https://invent.kde.org/pim/kpimtextedit.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5PIMTextEdit REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
