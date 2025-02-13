cmake_minimum_required(VERSION 3.16)

# Set project name and languages
project(MyQtProject LANGUAGES CXX)

# Find Qt6 (Adjust modules as needed)
find_package(Qt6 REQUIRED COMPONENTS Widgets)

# Add executable
add_executable(${PROJECT_NAME} main.cpp)

# Link Qt libraries
target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Widgets)

# Enable C++17 (or later)
set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
)
