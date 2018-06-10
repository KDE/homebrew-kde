class Kf5BreezeIcons < Formula
  desc "Breeze icon themes"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.47/breeze-icons-5.47.0.tar.xz"
  sha256 "a759fb54f07e9fb2be0e6ddb973de17917d828d23c6919f7af20a36c5298df3b"

  head "git://anongit.kde.org/breeze-icons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DBINARY_ICONS_RESOURCE=TRUE"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/icons" "$HOME/Library/Application Support"
    EOS
  end
end
