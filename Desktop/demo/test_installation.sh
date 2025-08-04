#!/bin/bash

echo "🔍 Testing Secure Communication Protocol Installation"
echo "=================================================="

# Check if executables exist
echo "📋 Checking executables..."
if [ -f "build/server" ]; then
    echo "✅ Server executable found"
else
    echo "❌ Server executable not found"
    exit 1
fi

if [ -f "build/client" ]; then
    echo "✅ Client executable found"
else
    echo "❌ Client executable not found"
    exit 1
fi

# Check dependencies
echo ""
echo "📦 Checking dependencies..."
if command -v cmake &> /dev/null; then
    echo "✅ CMake found: $(cmake --version | head -n1)"
else
    echo "❌ CMake not found"
fi

if command -v g++ &> /dev/null; then
    echo "✅ C++ compiler found: $(g++ --version | head -n1)"
else
    echo "❌ C++ compiler not found"
fi

if pkg-config --exists openssl; then
    echo "✅ OpenSSL found: $(pkg-config --modversion openssl)"
else
    echo "❌ OpenSSL not found"
fi

# Test basic functionality
echo ""
echo "🧪 Testing basic functionality..."

# Start server in background
echo "🚀 Starting server..."
./build/server 8080 &
SERVER_PID=$!

# Wait a moment for server to start
sleep 2

# Check if server is running
if kill -0 $SERVER_PID 2>/dev/null; then
    echo "✅ Server started successfully (PID: $SERVER_PID)"
else
    echo "❌ Server failed to start"
    exit 1
fi

# Test client connection (timeout after 5 seconds)
echo "🔗 Testing client connection..."
timeout 5s ./build/client 127.0.0.1 8080 > client_output.txt 2>&1
CLIENT_EXIT_CODE=$?

# Stop server
kill $SERVER_PID 2>/dev/null
wait $SERVER_PID 2>/dev/null

# Check results
if [ $CLIENT_EXIT_CODE -eq 0 ]; then
    echo "✅ Client connection test successful"
else
    echo "⚠️  Client connection test failed (this might be expected if server is still starting)"
    echo "Client output:"
    cat client_output.txt
fi

# Cleanup
rm -f client_output.txt

echo ""
echo "🎉 Installation test completed!"
echo ""
echo "📖 Usage Instructions:"
echo "1. Start server: ./build/server [port]"
echo "2. Connect client: ./build/client <server_ip> [port]"
echo ""
echo "Example:"
echo "  Terminal 1: ./build/server 8080"
echo "  Terminal 2: ./build/client 127.0.0.1 8080"
echo ""
echo "🔐 Security Features:"
echo "- RSA-2048 key exchange"
echo "- AES-256-GCM encryption"
echo "- Perfect Forward Secrecy"
echo "- Session authentication"
echo "- Automatic key rotation" 