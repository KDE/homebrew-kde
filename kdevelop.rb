class Kdevelop < Formula
  desc "Integrated Development Environment for KDE"
  homepage "http://kdevelop.org"
  stable do
    url "https://download.kde.org/stable/kdevelop/5.1.2/src/kdevelop-5.1.2.tar.xz"
    version "5.1.2"
    sha256 "af54e807847d145fe5f3eb55962ed0d22e6363c2bc6c32167e51ca4823c00ac7"
    depends_on "haraldf/kf5/kdevplatform"
  end

  head "git://anongit.kde.org/kdevelop.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "llvm"

  depends_on "haraldf/kf5/kdevelop-pg-qt"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kitemmodels"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-knewstuff"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-ktexteditor"
  depends_on "haraldf/kf5/kf5-kwallet"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "haraldf/kf5/kf5-breeze-icons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"

    # mkdir_p "#{Etc.getpwuid.dir}/Library/Application Support/kdevelop"
    # system "ln", "-sf", "#{HOMEBREW_PREFIX}/share/icons/breeze/breeze-icons.rcc", "#{Etc.getpwuid.dir}/Library/Application Support/kdevelop/icontheme.rcc"
  end

  def caveats; <<-EOS.undent
      You need to make sime manual steps in order to make this formula work:
        mkdir -p "~/Library/Application Support/kdevelop"
        ln -sf "#{HOMEBREW_PREFIX}/share/icons/breeze/breeze-icons.rcc" "~/Library/Application Support/kdevelop/icontheme.rcc"
      EOS
  end
end
