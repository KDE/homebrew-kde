# frozen_string_literal: true

require "formula"

def kde_cmake_args
  std_cmake_args + %W[
    -G Ninja
    -B build
    -S .
    -D BUILD_QCH=ON
    -D BUILD_TESTING=ON
    -D BUILD_TESTS=ON
    -D BUILD_UNITTESTS=ON
    -D CMAKE_INSTALL_BUNDLEDIR=#{bin}
    -D KDE_INSTALL_LIBDIR=lib
    -D KDE_INSTALL_PLUGINDIR=lib/qt5/plugins
    -D KDE_INSTALL_QMLDIR=lib/qt5/qml
    -D KDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins
  ]
end
