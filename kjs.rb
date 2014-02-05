require "formula"

class Kjs < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kjs-4.95.0.tar.xz"
  sha1 "6e34a43606295cfcf90a5c87748db97161940c6e"

  head 'git://anongit.kde.org/kjs.git'

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "pcre"

  def patches
    DATA
  end
  
  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 99b0c4e..ee02b56 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,6 +43,9 @@ option(KJS_FORCE_DISABLE_PCRE "Force building of KJS without PCRE. Doing this wi
 # TODO: Remove these
 remove_definitions(-DQT_NO_CAST_FROM_ASCII)
 
+# required to make ftello and friends visible
+add_definitions(-D_DARWIN_C_SOURCE)
+
 add_subdirectory(src)
 add_subdirectory(autotests)
 add_subdirectory(tests)
diff --git a/src/kjs/ConfigureChecks.cmake b/src/kjs/ConfigureChecks.cmake
index 473da1c..7023336 100644
--- a/src/kjs/ConfigureChecks.cmake
+++ b/src/kjs/ConfigureChecks.cmake
@@ -33,6 +33,7 @@ check_function_exists(gettimeofday    HAVE_GETTIMEOFDAY)
 
 check_function_exists(copysign HAVE_FUNC_COPYSIGN)
 check_function_exists(_copysign HAVE_FUNC__COPYSIGN)
+check_symbol_exists(signbit "math.h" HAVE_FUNC_SIGNBIT)
 check_function_exists(__signbit HAVE_FUNC___SIGNBIT)
 check_cxx_symbol_exists(signbit "cmath" HAVE_FUNC_STD_SIGNBIT)
 
diff --git a/src/kjs/global.h.cmake b/src/kjs/global.h.cmake
index d821a72..9b04380 100644
--- a/src/kjs/global.h.cmake
+++ b/src/kjs/global.h.cmake
@@ -110,6 +110,7 @@
 
 #cmakedefine01 HAVE_FUNC_COPYSIGN
 #cmakedefine01 HAVE_FUNC__COPYSIGN
+#cmakedefine01 HAVE_FUNC_SIGNBIT
 #cmakedefine01 HAVE_FUNC___SIGNBIT
 #cmakedefine01 HAVE_FUNC_STD_SIGNBIT
 
diff --git a/src/kjs/interpreter.cpp b/src/kjs/interpreter.cpp
index e699651..e4f97f6 100644
--- a/src/kjs/interpreter.cpp
+++ b/src/kjs/interpreter.cpp
@@ -113,8 +113,10 @@ void TimeoutChecker::startTimeoutCheck(Interpreter *interpreter)
     s_executingInterpreter = interpreter;
 
     itimerval tv = {
-        { interpreter->m_timeoutTime / 1000, (interpreter->m_timeoutTime % 1000) * 1000 },
-        { interpreter->m_timeoutTime / 1000, (interpreter->m_timeoutTime % 1000) * 1000 }
+        { time_t(interpreter->m_timeoutTime / 1000),
+          suseconds_t((interpreter->m_timeoutTime % 1000) * 1000) },
+        { time_t(interpreter->m_timeoutTime / 1000),
+          suseconds_t((interpreter->m_timeoutTime % 1000) * 1000) }
     };
     setitimer(ITIMER_REAL, &tv, &m_oldtv);
 
diff --git a/src/kjs/operations.h b/src/kjs/operations.h
index a54f366..8ce19d6 100644
--- a/src/kjs/operations.h
+++ b/src/kjs/operations.h
@@ -133,8 +133,10 @@ inline bool isInf(double d)
 
 inline double signBit(double d)
 {
-#if HAVE(FUNC_SIGNBIT)
+#if HAVE(FUNC_STD_SIGNBIT)
     return std::signbit(d);
+#elif HAVE(FUNC_SIGNBIT)
+    return ::signbit(d);
 #elif HAVE(FUNC___SIGNBIT)
     return __signbit(d);
 #elif HAVE(FUNC__COPYSIGN)
