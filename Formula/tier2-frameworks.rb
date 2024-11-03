require_relative "../lib/cmake"

class Tier2Frameworks < Formula
  desc "Metapackage for Tier 2 KF6 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "6.7.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    skip "Meta package"
  end

#  depends_on "kde-mac/kde/kactivities"
  depends_on "kde-mac/kde/kauth"
  depends_on "kde-mac/kde/kcompletion"
  depends_on "kde-mac/kde/kcrash"
  depends_on "kde-mac/kde/kfilemetadata"
  depends_on "kde-mac/kde/kimageformats"
  depends_on "kde-mac/kde/kjobwidgets"
  depends_on "kde-mac/kde/knotifications"
  depends_on "kde-mac/kde/kpackage"
  depends_on "kde-mac/kde/kpeople"
  depends_on "kde-mac/kde/kpty"
  depends_on "kde-mac/kde/kunitconversion"
  depends_on "kde-mac/kde/tier1-frameworks"
  depends_on "kdoctools"

  def install
    touch "empty"
    prefix.install "empty"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF6Auth REQUIRED)
      find_package(KF6Completion REQUIRED)
      find_package(KF6Crash REQUIRED)
      find_package(KF6FileMetaData REQUIRED)
      find_package(KF6JobWidgets REQUIRED)
      find_package(KF6Notifications REQUIRED)
      find_package(KF6Package REQUIRED)
      find_package(KF6People REQUIRED)
      find_package(KF6Pty REQUIRED)
      find_package(KF6UnitConversion REQUIRED)
      find_package(KF6DocTools REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
    # kimageformats
    imageformats_lib = Formula["kimageformats"].opt_lib
    imageformats_share = Formula["kimageformats"].opt_share
    assert_predicate imageformats_lib/"qt6/plugins/imageformats/kimg_eps.so", :exist?
    assert_predicate imageformats_share/"kservices6/qimageioplugins/eps.desktop", :exist?
  end
end
