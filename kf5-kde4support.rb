require "formula"

class Kf5Kde4support < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kde4support-4.98.0.tar.xz"
  sha1 "20923eb89c8d64ce455f8b0132be34eb42fbc38a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kde4support.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kglobalaccel"

  def patches
    if not build.head?
      DATA
    end
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/kdecore/kgenericfactory.h b/src/kdecore/kgenericfactory.h
index 0994f54..13f7fba 100644
--- a/src/kdecore/kgenericfactory.h
+++ b/src/kdecore/kgenericfactory.h
@@ -36,14 +36,14 @@ class KGenericFactoryBase : public KPluginFactory
 {
 public:
     explicit KGenericFactoryBase(const char *componentName)
-        : KPluginFactory(componentName)
+        : KPluginFactory()
     {
         s_self = this;
         s_createComponentDataCalled = false;
     }
 
     explicit KGenericFactoryBase(const KAboutData *data)
-        : KPluginFactory(data->componentName().toUtf8().constData())
+        : KPluginFactory()
     {
         KAboutData::registerPluginData(*data);
         s_self = this;
