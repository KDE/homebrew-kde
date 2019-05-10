class Kf5Tier2Frameworks < Formula
  desc "Metapackage for Tier 2 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.57.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "KDE-mac/kde/kf5-kactivities" => :build
  depends_on "KDE-mac/kde/kf5-kauth" => :build
  depends_on "KDE-mac/kde/kf5-kcompletion" => :build
  depends_on "KDE-mac/kde/kf5-kcrash" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kfilemetadata" => :build
  depends_on "KDE-mac/kde/kf5-kimageformats" => :build
  depends_on "KDE-mac/kde/kf5-kjobwidgets" => :build
  depends_on "KDE-mac/kde/kf5-knotifications" => :build
  depends_on "KDE-mac/kde/kf5-kpackage" => :build
  depends_on "KDE-mac/kde/kf5-kpty" => :build
  depends_on "KDE-mac/kde/kf5-kunitconversion" => :build
  depends_on "KDE-mac/kde/kf5-tier1-frameworks" => :build

  def install
    touch "empty"
    prefix.install "empty"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF5Activities REQUIRED)
      find_package(KF5Auth REQUIRED)
      find_package(KF5Completion REQUIRED)
      find_package(KF5Crash REQUIRED)
      find_package(KF5DocTools REQUIRED)
      find_package(KF5FileMetaData REQUIRED)
      find_package(KF5JobWidgets REQUIRED)
      find_package(KF5Notifications REQUIRED)
      find_package(KF5Package REQUIRED)
      find_package(KF5Pty REQUIRED)
      find_package(KF5UnitConversion REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
    # kf5-kimageformats
    imageformats_lib = Formula["kf5-kimageformats"].opt_lib
    imageformats_share = Formula["kf5-kimageformats"].opt_share
    assert_predicate imageformats_lib/"qt5/plugins/imageformats/kimg_eps.so", :exist?
    assert_predicate imageformats_share/"kservices5/qimageioplugins/eps.desktop", :exist?
  end
end
