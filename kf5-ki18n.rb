require "formula"

class Kf5Ki18n < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/ki18n-5.34.0.tar.xz"
  sha256 "c767457c419055f3a6f5bfe0e2de140461c91f6451a5d3a385e6d6007cad9b3e"

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "qt5"

  def patches
      DATA
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/klocalizedstring.h b/src/klocalizedstring.h
index eff6bf9..0be43d7 100644
--- a/src/klocalizedstring.h
+++ b/src/klocalizedstring.h
@@ -163,7 +163,7 @@ public:
      *
      * \return finalized translation
      */
-    QString toString() const Q_REQUIRED_RESULT;
+    Q_REQUIRED_RESULT QString toString() const;
 
     /**
      * Like \c toString, but look for translation only in given languages.
@@ -175,7 +175,7 @@ public:
      * \param languages list of language codes (by decreasing priority)
      * \return finalized translation
      */
-    QString toString(const QStringList &languages) const Q_REQUIRED_RESULT;
+    Q_REQUIRED_RESULT QString toString(const QStringList &languages) const;
 
 #if 0 // until locale system is ready
     /**
@@ -198,7 +198,7 @@ public:
      * \param domain the translation domain
      * \return finalized translation
      */
-    QString toString(const char *domain) const Q_REQUIRED_RESULT;
+    Q_REQUIRED_RESULT QString toString(const char *domain) const;
 
     /**
      * Like \c toString, but resolve KUIT markup into given visual format.
@@ -211,7 +211,7 @@ public:
      * \param format the target visual format
      * \return finalized translation
      */
-    QString toString(Kuit::VisualFormat format) const Q_REQUIRED_RESULT;
+    Q_REQUIRED_RESULT QString toString(Kuit::VisualFormat format) const;
 
     /**
      * Indicate to look for translation only in given languages.
@@ -219,7 +219,7 @@ public:
      * \param languages list of language codes (by decreasing priority)
      * \return updated \c KLocalizedString
      */
-    KLocalizedString withLanguages(const QStringList &languages) const Q_REQUIRED_RESULT;
+    KLocalizedString withLanguages(const QStringList &languages) const;
 
 #if 0 // until locale system is ready
     /**
@@ -237,7 +237,7 @@ public:
      * \param domain the translation domain
      * \return updated \c KLocalizedString
      */
-    KLocalizedString withDomain(const char *domain) const Q_REQUIRED_RESULT;
+    KLocalizedString withDomain(const char *domain) const;
 
     /**
      * Indicate to resolve KUIT markup into given visual format.
@@ -247,7 +247,7 @@ public:
      * \param format the target visual format
      * \return updated \c KLocalizedString
      */
-    KLocalizedString withFormat(Kuit::VisualFormat format) const Q_REQUIRED_RESULT;
+    KLocalizedString withFormat(Kuit::VisualFormat format) const;
 
     /**
      * Substitute an int argument into the message.
@@ -262,7 +262,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(int a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute an unsigned int argument into the message.
@@ -277,7 +277,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(uint a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute a long argument into the message.
@@ -292,7 +292,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(long a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute an unsigned long argument into the message.
@@ -307,7 +307,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(ulong a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute a long long argument into the message.
@@ -322,7 +322,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(qlonglong a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute an unsigned long long argument into the message.
@@ -337,7 +337,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(qulonglong a, int fieldWidth = 0, int base = 10,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute a double argument into the message.
@@ -353,7 +353,7 @@ public:
      */
     KLocalizedString subs(double a, int fieldWidth = 0,
                           char format = 'g', int precision = -1,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute a \c QChar argument into the message.
@@ -366,7 +366,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(QChar a, int fieldWidth = 0,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute a \c QString argument into the message.
@@ -379,7 +379,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(const QString &a, int fieldWidth = 0,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Substitute another \c KLocalizedString into the message.
@@ -392,7 +392,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString subs(const KLocalizedString &a, int fieldWidth = 0,
-                          QChar fillChar = QLatin1Char(' ')) const Q_REQUIRED_RESULT;
+                          QChar fillChar = QLatin1Char(' ')) const;
 
     /**
      * Add dynamic context to the message.
@@ -404,7 +404,7 @@ public:
      * \return updated \c KLocalizedString
      */
     KLocalizedString inContext(const QString &key,
-                               const QString &value) const Q_REQUIRED_RESULT;
+                               const QString &value) const;
 
     /**
      * Relax matching between placeholders and arguments.
@@ -423,7 +423,7 @@ public:
      *
      * \return updated \c KLocalizedString
      */
-    KLocalizedString relaxSubs() const Q_REQUIRED_RESULT;
+    KLocalizedString relaxSubs() const;
 
     /**
      * Do not resolve KUIT markup.
@@ -435,7 +435,7 @@ public:
      *
      * \return updated \c KLocalizedString
      */
-    KLocalizedString ignoreMarkup() const Q_REQUIRED_RESULT;
+    KLocalizedString ignoreMarkup() const;
 
     /**
      * Set the given domain as application's main domain.
@@ -572,7 +572,7 @@ public:
      *
      * \return path to the localized file if found, original path otherwise
      */
-    static QString localizedFilePath(const QString &filePath) Q_REQUIRED_RESULT;
+    static QString localizedFilePath(const QString &filePath);
 
     /**
      * Remove accelerator marker from a UI text label.
@@ -588,7 +588,7 @@ public:
      * \param label UI label which may contain an accelerator marker
      * \return label without the accelerator marker
      */
-    static QString removeAcceleratorMarker(const QString &label) Q_REQUIRED_RESULT;
+    static QString removeAcceleratorMarker(const QString &label);
 
     /**
      * Translate a message with Qt semantics.
@@ -606,7 +606,7 @@ public:
      *             Qt's \c lupdate and \c lconvert commands.
      */
     KI18N_DEPRECATED static QString translateQt(const char *context, const char *text,
-                               const char *comment, int n) Q_REQUIRED_RESULT;
+                               const char *comment, int n);
 
     /**
      * Add another domain to search for Qt translations.
