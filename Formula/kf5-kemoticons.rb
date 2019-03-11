class Kf5Kemoticons < Formula
  desc "Support for emoticons and emoticons themes"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kemoticons-5.56.0.tar.xz"
  sha256 "82eeb425a0b4eebd60c743433e09bb6aadcb512dce27c5dbd7ce73fb12680b02"

  revision 1
  head "git://anongit.kde.org/kemoticons.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kservice"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/emoticons" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
  EOS
  end
end
