#!/bin/zsh

# Check if a project name is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

PROJECT_NAME="$1"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

# Create main.cpp
cat << EOF > main.cpp
#include <QApplication>
#include <QWidget>

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QWidget window;
    window.setWindowTitle("$PROJECT_NAME");
    window.resize(400, 300);
    window.show();
    return app.exec();
}
EOF

# Create qmake .pro file
cat << EOF > "$PROJECT_NAME.pro"
QT += core gui widgets

CONFIG += c++11

SOURCES += main.cpp
EOF

# Create CMakeLists.txt
cat << EOF > CMakeLists.txt
cmake_minimum_required(VERSION 3.16)
project($PROJECT_NAME LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

add_executable(\${PROJECT_NAME} main.cpp)

target_link_libraries(\${PROJECT_NAME} Qt6::Core Qt6::Gui Qt6::Widgets)
EOF

# Create .gitignore
cat << EOF > .gitignore
build/
EOF

# Create .clangd configuration
cat << EOF > .clangd
CompileFlags:
  Add: [-std=c++17, -I/usr/include/qt6, -I/usr/include/qt6/QtCore, -I/usr/include/qt6/QtGui, -I/usr/include/qt6/QtWidgets]
EOF

echo "Qt project '$PROJECT_NAME' created successfully with qmake, CMake, and Clangd support."
