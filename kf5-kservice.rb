require "formula"

class Kf5Kservice < Formula
  desc "Advanced plugin and service introspection"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kservice-5.39.0.tar.xz"
  sha256 "149e0320e05abe67140f88a50cbf95d48a075a2996e9b2e3c9d123e6d1417f29"

  head "git://anongit.kde.org/kservice.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-ki18n"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kservices5" ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" ~/Library/"Application Support"
    EOS
  end
end
