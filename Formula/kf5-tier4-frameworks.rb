require_relative "../lib/cmake"

class Kf5Tier4Frameworks < Formula
  desc "Metapackage for Tier 4 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.92.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  livecheck do
    skip "Meta package"
  end

  depends_on "kde-mac/kde/kf5-frameworkintegration" => [:build, :test]
  depends_on "kde-mac/kde/kf5-tier3-frameworks" => [:build, :test]

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
      find_package(KF5FrameworkIntegration REQUIRED)
      find_package(KF5QQC2DeskopStyle REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
