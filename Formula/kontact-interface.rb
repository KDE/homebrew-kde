class KontactInterface < Formula
    desc "Support libraries to assist integration with Kontact"
    homepage "https://api.kde.org/kdepim/kontactinterface/html/index.html"
    url "https://download.kde.org/stable/release-service/22.04.1/src/kontactinterface-22.04.1.tar.xz"
    sha256 "a30ab91e4b38c691ef5e7f4b81dddb318ec6006faf5cb4a44823bd0ed618ca6b"
    head "https://invent.kde.org/pim/kontactinterface.git", branch: "master"
  
    depends_on "cmake" => [:build,:test]
    depends_on "doxygen" => :build
    depends_on "extra-cmake-modules" => [:build, :test]
    depends_on "ninja" => :build
  
    depends_on "qt@5"
    depends_on "kde-mac/kde/kf5-kparts"
  
    def install
      args = kde_cmake_args
  
      system "cmake", *args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
      prefix.install "build/install_manifest.txt"
    end

    test do
        (testpath/"CMakeLists.txt").write("find_package(KF5KontactInterface REQUIRED)")
        system "cmake", ".", "-Wno-dev"
    end
end
  