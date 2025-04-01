#!/bin/zsh

# Check for project name argument
if [[ -z "$1" ]]; then
  echo "❌ Please provide a project name!"
  echo "Usage: ./create_c_project.zsh <project_name>"
  exit 1
fi

project_name="$1"

# Create project directory
mkdir -p "$project_name"
cd "$project_name" || exit

# Create main.c
cat <<EOF > main.c
#include <stdio.h>

int main() {
  printf("Hello, world!\\n");
  return 0;
}
EOF

# Create Makefile
cat <<EOF > Makefile
CC=gcc
CFLAGS=-Wall -Wextra -std=c11
TARGET=${project_name}

all:
	\$(CC) \$(CFLAGS) main.c -o \$(TARGET)

clean:
	rm -f \$(TARGET)
EOF

echo "✅ C project '$project_name' created successfully!"
