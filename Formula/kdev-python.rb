class KdevPython < Formula
  desc "KDevelop plugin which provides Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/kdevelop/5.4.4/src/kdev-python-5.4.4.tar.xz"
  sha256 "62755863daa31f9f7dbfebdf1b49397afadcaff331c488294403746c594d0378"
  head "git://anongit.kde.org/kdev-python.git"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
