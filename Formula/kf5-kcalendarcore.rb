require_relative "../lib/cmake"

class Kf5Kcalendarcore < Formula
  desc "The KDE calendar access library"
  homepage "https://api.kde.org/frameworks/kcalendarcore/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.94/kcalendarcore-5.94.0.tar.xz"
  sha256 "3bab1ae2e8214fb889b742d4a4f2c6acfd0bf40a4c4933cc91c66d21d77c042b"
  head "https://invent.kde.org/frameworks/kcalendarcore.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "qt@5"
  depends_on "libical"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5CalendarCore REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
