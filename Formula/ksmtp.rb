require_relative "../lib/cmake"

class Ksmtp < Formula
  desc "Job-based library to send email through an SMTP server"
  homepage "https://api.kde.org/kdepim/ksmtp/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.1/src/ksmtp-22.04.1.tar.xz"
  sha256 "f445692c54310c737d6afffeb8a2ce9d6c17164ca6145fc7f983f8adfe79f458"
  head "https://invent.kde.org/pim/ksmtp.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "qt@5"
  depends_on "kde-mac/kde/kf5-kio"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KPimSMTP REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
