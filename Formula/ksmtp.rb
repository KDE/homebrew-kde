require_relative "../lib/cmake"

class Ksmtp < Formula
  desc "Job-based library to send email through an SMTP server"
  homepage "https://api.kde.org/kdepim/ksmtp/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.3/src/ksmtp-22.04.3.tar.xz"
  sha256 "9f50f4a0caace0511f6e13ea98bb07f32826d638ce27b2171772ee5abb3f1cd0"
  head "https://invent.kde.org/pim/ksmtp.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KPimSMTP REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
