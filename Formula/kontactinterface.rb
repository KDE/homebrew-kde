class Kontactinterface < Formula
  desc "Support libraries to assist integration with Kontact"
  homepage "https://api.kde.org/kdepim/kontactinterface/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.3/src/kontactinterface-22.04.3.tar.xz"
  sha256 "35b1ff8dcddcd8c81533989819508beb5effc41c4063d538bae2ddb733edea5a"
  head "https://invent.kde.org/pim/kontactinterface.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KontactInterface REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
