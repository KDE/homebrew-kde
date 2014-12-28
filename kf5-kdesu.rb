require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kdesu-5.5.0.tar.xz"
  sha1 "64183575ae240d6173602391297578c351e96463"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build

  def patches
    DATA
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
From: Marko Käning <mk-lists@email.de>
Date: Sat, 13 Dec 2014 14:00:15 +0000
Subject: fix build on OSX
X-Git-Url: http://quickgit.kde.org/?p=kdesu.git&a=commitdiff&h=163d9f1598596cfe8090f21c2562e25e64ad151b
---
fix build on OSX

adds additional guard against using X11 on OSX

CCMAIL: lukas@kde.org
---


--- a/src/kdesud/kdesud.cpp
+++ b/src/kdesud/kdesud.cpp
@@ -73,7 +73,7 @@
 #include "repo.h"
 #include "handler.h"
 
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
 #include <X11/X.h>
 #include <X11/Xlib.h>
 #endif
@@ -94,7 +94,7 @@
 Repository *repo;
 QString Version(QStringLiteral("1.01"));
 QByteArray sock;
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
 Display *x11Display;
 #endif
 int pipeOfDeath[2];
@@ -107,7 +107,7 @@
 
 // Borrowed from kdebase/kaudio/kaudioserver.cpp
 
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
 extern "C" int xio_errhandler(Display *);
 
 int xio_errhandler(Display *)
@@ -307,7 +307,7 @@
     if (pid)
         _exit(0);
 
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
     // Make sure we exit when the display gets closed.
     int x11Fd = initXconnection();
     maxfd = qMax(maxfd, x11Fd);
@@ -344,7 +344,7 @@
     FD_ZERO(&active_fds);
     FD_SET(sockfd, &active_fds);
     FD_SET(pipeOfDeath[0], &active_fds);
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
     if (x11Fd != -1)
         FD_SET(x11Fd, &active_fds);
 #endif
@@ -352,7 +352,7 @@
     while (1)
     {
         tmp_fds = active_fds;
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
         if(x11Display)
             XFlush(x11Display);
 #endif
@@ -396,7 +396,7 @@
                 while(result > 0);
             }
 
-#ifdef HAVE_X11
+#if defined(HAVE_X11) && !defined(Q_OS_MAC)
             if (i == x11Fd)
             {
                 // Discard X events
