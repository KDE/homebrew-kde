require "formula"

class Kf5Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/ktexteditor-5.39.0.tar.xz"
  sha256 "c5d9c67532ab6f3abee8ae2623ff21e6ca5280d5ea9ca5d23bdb55f937e565ae"

  head "git://anongit.kde.org/ktexteditor.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-syntax-highlighting"

  patch do
    # Fix broken indentation in some languages
    url "https://cgit.kde.org/ktexteditor.git/patch/?id=aeebeadb"
    sha256 "a87ef171d67e2dca50a1ec979d316c58e540a46cb135ffd9480ea9237b419b69"
  end

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

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/katepart5" ~/Library/"Application Support"
      ln -sf "$(brew --prefix)/share/kservicetypes5" ~/Library/"Application Support"
    EOS
  end
end
