require_relative "../lib/cmake"

class Kf5Kidentitymanagement < Formula
  desc "Library to assist in handling user identities"
  homepage "https://api.kde.org/kdepim/kidentitymanagement/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.1/src/kidentitymanagement-22.04.1.tar.xz"
  sha256 "746a01e43dae1841ec412257f64cc25dd19139403e9119ff746882883ac80738"
  head "https://invent.kde.org/pim/kidentitymanagement.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

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
