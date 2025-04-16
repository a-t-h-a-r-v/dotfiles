#!/bin/zsh

# Check for project name argument
if [[ -z "$1" ]]; then
  echo "❌ Please provide a project name!"
  echo "Usage: ./create_cpp_project.zsh <project_name>"
  exit 1
fi

project_name="$1"

# Create project directory
mkdir -p "$project_name"
cd "$project_name" || exit

# Create main.cpp
cat <<EOF > main.cpp
#include <iostream>

int main(int argc, char **argv) {
  std::cout << "Hello, world!" << std::endl;
  return 0;
}
EOF

# Create Makefile
cat <<EOF > Makefile
CXX=g++
CXXFLAGS=-Wall -Wextra -std=c++20
TARGET=${project_name}

all:
	\$(CXX) \$(CXXFLAGS) main.cpp -o \$(TARGET)

clean:
	rm -f \$(TARGET)
EOF

echo "✅ C++ project '$project_name' created successfully!"
