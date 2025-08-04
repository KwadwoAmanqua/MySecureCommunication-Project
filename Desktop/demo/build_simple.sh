#!/bin/bash

# Simple build script for Secure Communication Protocol
# Builds only server and client (no GUI client)

set -e  # Exit on any error

echo "🔧 Building Secure Communication Protocol (Server + Client only)"
echo "================================================================"

# Check if we're in the right directory
if [ ! -f "CMakeLists.txt" ]; then
    echo "❌ Error: CMakeLists.txt not found. Please run this script from the project root directory."
    exit 1
fi

# Check for required tools
echo "📋 Checking prerequisites..."

if ! command -v cmake &> /dev/null; then
    echo "❌ Error: CMake not found. Please install CMake first."
    exit 1
fi

if ! command -v make &> /dev/null; then
    echo "❌ Error: Make not found. Please install build tools first."
    exit 1
fi

# Check for OpenSSL
if ! pkg-config --exists openssl; then
    echo "❌ Error: OpenSSL development libraries not found."
    exit 1
fi

echo "✅ Prerequisites check passed"

# Create build directory
echo "📁 Creating build directory..."
rm -rf build_simple
mkdir -p build_simple
cd build_simple

# Configure with CMake (disable Qt to avoid GUI client issues)
echo "⚙️  Configuring with CMake..."
cmake .. -DCMAKE_BUILD_TYPE=Release -DQt6_DIR="" -DQt5_DIR=""

# Build only server and client
echo "🔨 Building server and client..."
make server client

# Check if build was successful
if [ -f "server" ] && [ -f "client" ]; then
    echo ""
    echo "✅ Build successful!"
    echo "📦 Generated executables:"
    echo "   - server (Secure Communication Server)"
    echo "   - client (Secure Communication Client)"
    echo ""
    echo "🚀 Usage:"
    echo "   Terminal 1: ./server [port]"
    echo "   Terminal 2: ./client <server_ip> [port]"
    echo ""
    echo "📖 For more information, see README.md"
else
    echo "❌ Build failed! Check the error messages above."
    exit 1
fi 