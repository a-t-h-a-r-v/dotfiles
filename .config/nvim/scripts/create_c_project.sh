#!/bin/bash

# Check if the user provided an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Assign project name
PROJECT_NAME=$1

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# Create main.c with boilerplate code
cat > main.c <<EOF
#include <stdio.h>

int main(int argc, char *argv[]) {
    return 0;
}
EOF

# Create Makefile
cat > Makefile <<EOF
CC = gcc
CFLAGS = -Wall -Wextra
TARGET = $PROJECT_NAME
SRC = main.c

all: \$(TARGET)

\$(TARGET): \$(SRC)
	\$(CC) \$(CFLAGS) -o \$(TARGET) \$(SRC)

clean:
	rm -f \$(TARGET)
EOF

# Success message
echo "C project '$PROJECT_NAME' created successfully!"
