class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/applications/18.08.3/src/analitza-18.08.3.tar.xz"
  sha256 "f1a848c5eb0a00405b34cdcb65aea4ad5a8a85a4d1539613277f10ae53c45b0e"

  head "git://anongit.kde.org/analitza.git"

  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "kf5-extra-cmake-modules" => :build
  depends_on "kf5-kdoctools" => :build

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
