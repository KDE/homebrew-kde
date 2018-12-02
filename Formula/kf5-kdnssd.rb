class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://www.kde.org"

  head "git://anongit.kde.org/kdnssd.git"

  stable do
    url "https://download.kde.org/stable/frameworks/5.52/kdnssd-5.52.0.tar.xz"
    sha256 "fe50259eb7d16ee2a3353af34889273b6e5332859f87e7ff501491fdfc1413c1"
    # upstream: https://phabricator.kde.org/D15479
    patch :DATA
  end

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
end

__END__

diff --git a/src/mdnsd-publicservice.cpp b/src/mdnsd-publicservice.cpp
index 7f39ef6..7451d71 100644
--- a/src/mdnsd-publicservice.cpp
+++ b/src/mdnsd-publicservice.cpp
@@ -160,7 +160,7 @@ void PublicService::publishAsync()
     TXTRecordCreate(&txt, 0, 0);
     QMap<QString, QByteArray>::ConstIterator itEnd = d->m_textData.cend();
     for (QMap<QString, QByteArray>::ConstIterator it = d->m_textData.cbegin(); it != itEnd; ++it) {
-        if (TXTRecordSetValue(&txt, it.key().toUtf8(), it.value().length(), it.value()) != kDNSServiceErr_NoError) {
+        if (TXTRecordSetValue(&txt, it.key().toUtf8().constData(), it.value().length(), it.value().constData()) != kDNSServiceErr_NoError) {
             TXTRecordDeallocate(&txt);
             emit published(false);
             return;
@@ -171,7 +171,7 @@ void PublicService::publishAsync()
     Q_FOREACH (const QString &subtype, d->m_subtypes) {
         fullType += ',' + subtype;
     }
-    if (DNSServiceRegister(&ref, 0, 0, d->m_serviceName.toUtf8(), fullType.toLatin1().constData(), domainToDNS(d->m_domain), NULL,
+    if (DNSServiceRegister(&ref, 0, 0, d->m_serviceName.toUtf8().constData(), fullType.toLatin1().constData(), domainToDNS(d->m_domain).constData(), NULL,
                            htons(d->m_port), TXTRecordGetLength(&txt), TXTRecordGetBytesPtr(&txt), publish_callback,
                            reinterpret_cast<void *>(d)) == kDNSServiceErr_NoError) {
         d->setRef(ref);
diff --git a/src/mdnsd-remoteservice.cpp b/src/mdnsd-remoteservice.cpp
index d15725b..88f75f3 100644
--- a/src/mdnsd-remoteservice.cpp
+++ b/src/mdnsd-remoteservice.cpp
@@ -82,8 +82,8 @@ void RemoteService::resolveAsync()
     d->m_resolved = false;
     //qDebug() << this << ":Starting resolve of : " << d->m_serviceName << " " << d->m_type << " " << d->m_domain << "\n";
     DNSServiceRef ref;
-    if (DNSServiceResolve(&ref, 0, 0, d->m_serviceName.toUtf8(), d->m_type.toLatin1().constData(),
-                          domainToDNS(d->m_domain), (DNSServiceResolveReply)resolve_callback, reinterpret_cast<void *>(d))
+    if (DNSServiceResolve(&ref, 0, 0, d->m_serviceName.toUtf8().constData(), d->m_type.toLatin1().constData(),
+                          domainToDNS(d->m_domain).constData(), (DNSServiceResolveReply)resolve_callback, reinterpret_cast<void *>(d))
             == kDNSServiceErr_NoError) {
         d->setRef(ref);
     }
diff --git a/src/mdnsd-servicebrowser.cpp b/src/mdnsd-servicebrowser.cpp
index 476bb17..41ec51d 100644
--- a/src/mdnsd-servicebrowser.cpp
+++ b/src/mdnsd-servicebrowser.cpp
@@ -100,7 +100,7 @@ void ServiceBrowser::startBrowse()
         fullType = d->m_subtype + "._sub." + d->m_type;
     }
     if (DNSServiceBrowse(&ref, 0, 0, fullType.toLatin1().constData(),
-                         domainToDNS(d->m_domain), query_callback, reinterpret_cast<void *>(d))
+                         domainToDNS(d->m_domain).constData(), query_callback, reinterpret_cast<void *>(d))
             == kDNSServiceErr_NoError) {
         d->setRef(ref);
     }

