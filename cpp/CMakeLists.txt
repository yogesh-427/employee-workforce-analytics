cmake_minimum_required(VERSION 3.16)
project(EmployeeWorkforceAnalytics LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Connector/C++ CMake package names vary across distributions and versions.
# Adjust find_package and the imported target to match your installed connector.
find_package(mysql-concpp REQUIRED)

add_executable(employee_workforce_app main.cpp)
target_link_libraries(employee_workforce_app PRIVATE mysql::concpp)
