class Kf5Kauth < Formula
  desc "Abstraction to system policy and authentication features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/kauth-5.42.0.tar.xz"
  sha256 "91ebf3554551c3815e89e53e577e42d7cc3ac1f4966215fbbc93a60ca1587812"
  revision 2

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "gpgme"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"

  patch :DATA

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
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
     EOS
  end
end

__END__

diff --git a/src/backends/fake/kauth-policy-gen-polkit.cpp b/src/backends/fake/kauth-policy-gen-polkit.cpp
index d103414..5575620 100644
--- a/src/backends/fake/kauth-policy-gen-polkit.cpp
+++ b/src/backends/fake/kauth-policy-gen-polkit.cpp
@@ -38,7 +38,7 @@ const char policy_tag[] = ""
 
 const char dent[] = "   ";
 
-void output(QList<Action> actions, QMap<QString, QString> domain)
+void output(QList<Action> actions, const QMap<QString, QString> &domain)
 {
     Q_UNUSED(domain)
 
diff --git a/src/backends/mac/kauth-policy-gen-mac.cpp b/src/backends/mac/kauth-policy-gen-mac.cpp
index e146c46..ccfc0e7 100644
--- a/src/backends/mac/kauth-policy-gen-mac.cpp
+++ b/src/backends/mac/kauth-policy-gen-mac.cpp
@@ -26,7 +26,7 @@
 
 using namespace std;
 
-void output(QList<Action> actions, QMap<QString, QString> domain)
+void output(QList<Action> actions, const QMap<QString, QString> &domain)
 {
     AuthorizationRef auth;
     AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment, kAuthorizationFlagDefaults, &auth);
diff --git a/src/backends/policykit/kauth-policy-gen-polkit.cpp b/src/backends/policykit/kauth-policy-gen-polkit.cpp
index 4f29cb0..c215275 100644
--- a/src/backends/policykit/kauth-policy-gen-polkit.cpp
+++ b/src/backends/policykit/kauth-policy-gen-polkit.cpp
@@ -39,7 +39,7 @@ const char policy_tag[] = ""
 
 const char dent[] = "   ";
 
-void output(QList<Action> actions, QHash<QString, QString> domain)
+void output(QList<Action> actions, const QMap<QString, QString> &domain)
 {
     QTextStream out(stdout);
     out.setCodec("UTF-8");


