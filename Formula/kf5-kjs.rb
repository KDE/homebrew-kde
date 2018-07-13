class Kf5Kjs < Formula
  desc "Support for JS scripting in applications"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.47/portingAids/kjs-5.47.0.tar.xz"
  sha256 "18b997486179a660f0cc16490e3572aa08ca788497df8c018c88645d79ab1be6"

  head "git://anongit.kde.org/kjs.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "pcre"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
    EOS
  end
end
