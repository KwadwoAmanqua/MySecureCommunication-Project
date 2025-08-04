cmake_minimum_required(VERSION 3.16)
project(SecureComm VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required packages
find_package(PkgConfig REQUIRED)
pkg_check_modules(OPENSSL REQUIRED openssl)

# Find Qt6 for GUI client
find_package(Qt6 COMPONENTS Core Widgets Network REQUIRED)

# Enable Qt MOC, UIC, and RCC
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/include)
include_directories(${CMAKE_SOURCE_DIR}/crypto)

# Add server executable
add_executable(server
    server/server.cpp
    crypto/crypto_utils.cpp
)

# Add client executable
add_executable(client
    client/client.cpp
    crypto/crypto_utils.cpp
)

# Add GUI client executable
add_executable(gui_client
    client/gui_client.cpp
    client/gui_client.h
    client/gui_client.ui
    crypto/crypto_utils.cpp
)

# Link libraries for server
target_link_libraries(server
    ${OPENSSL_LIBRARIES}
    pthread
)

# Link libraries for client
target_link_libraries(client
    ${OPENSSL_LIBRARIES}
    pthread
)

# Link libraries for GUI client
target_link_libraries(gui_client
    ${OPENSSL_LIBRARIES}
    Qt6::Core
    Qt6::Widgets
    Qt6::Network
    pthread
)

# Set compiler flags
target_compile_options(server PRIVATE ${OPENSSL_CFLAGS})
target_compile_options(client PRIVATE ${OPENSSL_CFLAGS})
target_compile_options(gui_client PRIVATE ${OPENSSL_CFLAGS})

# Set linker flags
target_link_options(server PRIVATE ${OPENSSL_LDFLAGS})
target_link_options(client PRIVATE ${OPENSSL_LDFLAGS})
target_link_options(gui_client PRIVATE ${OPENSSL_LDFLAGS})