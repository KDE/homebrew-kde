require_relative "../lib/cmake"

class Kf5Kidentitymanagement < Formula
  desc "Library to assist in handling user identities"
  homepage "https://api.kde.org/kdepim/kidentitymanagement/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.3/src/kidentitymanagement-22.04.3.tar.xz"
  sha256 "1cb598d9feafbc742235840d1240ce573ea02a170edeafbbfbedd49629ef317c"
  head "https://invent.kde.org/pim/kidentitymanagement.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "doxygen" => :build

  depends_on "qt@5"
  depends_on "kde-mac/kde/Kpimtextedit"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5IdentityManagement REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
