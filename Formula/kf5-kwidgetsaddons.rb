class Kf5Kwidgetsaddons < Formula
  desc "Addons to QtWidgets"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/kwidgetsaddons-5.42.0.tar.xz"
  sha256 "8f9f7a4f06edd558b5786cc2852ba362e72d04d5a7c42b2bb63f47c09866d0a5"
  revision 1

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

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
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
     EOS
  end
end
