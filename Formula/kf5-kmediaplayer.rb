class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/portingAids/kmediaplayer-5.56.0.tar.xz"
  sha256 "508251507d8432ad29d6cde3d5da258b9d8c14519014901c46f3060a485c982e"

  head "git://anongit.kde.org/kmediaplayer.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kparts"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
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
      ln -sfv "$(brew --prefix)/share/kservicetypes5" "$HOME/Library/Application Support"
  EOS
  end
end
