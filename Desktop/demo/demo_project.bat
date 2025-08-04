@echo off
setlocal enabledelayedexpansion

echo 🔐 Secure Communication Protocol
echo ==========================================
echo Project Demo and Information
echo.

echo 📁 Project Structure Check:
echo ------------------------------
if exist "CMakeLists.txt" (
    echo ✅ CMakeLists.txt
) else (
    echo ❌ CMakeLists.txt
)

if exist "include\common.h" (
    echo ✅ include\common.h
) else (
    echo ❌ include\common.h
)

if exist "crypto\crypto_utils.h" (
    echo ✅ crypto\crypto_utils.h
) else (
    echo ❌ crypto\crypto_utils.h
)

if exist "crypto\crypto_utils.cpp" (
    echo ✅ crypto\crypto_utils.cpp
) else (
    echo ❌ crypto\crypto_utils.cpp
)

if exist "server\server.cpp" (
    echo ✅ server\server.cpp
) else (
    echo ❌ server\server.cpp
)

if exist "client\client.cpp" (
    echo ✅ client\client.cpp
) else (
    echo ❌ client\client.cpp
)

if exist "README.md" (
    echo ✅ README.md
) else (
    echo ❌ README.md
)

echo.

echo 🔧 Tool Availability Check:
echo ------------------------------
where cmake >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ cmake - CMake build system
) else (
    echo ❌ cmake - CMake build system
)

where cl >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ cl - Visual Studio C++ compiler
) else (
    echo ❌ cl - Visual Studio C++ compiler
)

where g++ >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ g++ - GNU C++ compiler
) else (
    echo ❌ g++ - GNU C++ compiler
)

where make >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ make - Make build tool
) else (
    echo ❌ make - Make build tool
)

echo.

echo 📋 Project Information:
echo ------------------------------
echo Project Name: Secure Communication Protocol
echo Language: C++17
echo Cryptography: OpenSSL
echo Network: TCP Sockets
echo Build System: CMake
echo Security Features:
echo   • RSA-2048 key exchange
echo   • Diffie-Hellman forward secrecy
echo   • AES-256-GCM encryption
echo   • Digital signatures
echo   • Key rotation
echo   • Session management
echo.

echo 🔒 Security Features:
echo ------------------------------
echo • Key Exchange: RSA-2048 for initial key exchange, Diffie-Hellman for forward secrecy
echo • Encryption: AES-256-GCM for authenticated encryption
echo • Authentication: Digital signatures using RSA-2048
echo • Forward Secrecy: Automatic key rotation every 10 messages
echo • Session Management: Secure session tracking and authentication
echo • Random Generation: Cryptographically secure random number generation
echo • Key Derivation: PBKDF2 for secure key derivation
echo • Message Integrity: HMAC-SHA256 for message authentication
echo.

echo 🔄 Protocol Flow:
echo ------------------------------
echo 1. Client connects to server
echo 2. Handshake initiation (RSA key exchange)
echo 3. Diffie-Hellman key exchange for forward secrecy
echo 4. Session key derivation using PBKDF2
echo 5. Secure message exchange using AES-256-GCM
echo 6. Automatic key rotation for forward secrecy
echo 7. Digital signature verification for authentication
echo.

echo 🚀 Usage Instructions:
echo ------------------------------
echo 1. Build the project:
echo    • Windows: .\build.bat or .\build_vs.bat
echo    • Linux/macOS: ./build.sh
echo.
echo 2. Run the server:
echo    • server.exe [port]
echo    • Default port: 8080
echo.
echo 3. Run the client:
echo    • client.exe ^<server_ip^> [port]
echo    • Example: client.exe 127.0.0.1 8080
echo.
echo 4. Interactive client commands:
echo    • Type messages to send encrypted data
echo    • 'rotate' - Request key rotation
echo    • 'quit' or 'exit' - Close client
echo.

echo 📊 Summary:
echo ------------------------------
if exist "CMakeLists.txt" (
    echo ✅ Project structure is complete
) else (
    echo ❌ Some project files are missing
)

set tools_found=0
where cmake >nul 2>&1 && set /a tools_found+=1
where cl >nul 2>&1 && set /a tools_found+=1
where g++ >nul 2>&1 && set /a tools_found+=1
where make >nul 2>&1 && set /a tools_found+=1

if %tools_found% gtr 0 (
    echo ✅ Found %tools_found% build tools
    where cmake >nul 2>&1 && echo ✅ CMake is available - you can build the project!
) else (
    echo ❌ No build tools found
    echo 💡 To build this project, you need:
    echo    • CMake (✅ already installed)
    echo    • A C++ compiler (Visual Studio, MinGW, or GCC)
    echo    • OpenSSL development libraries
)

echo.
echo 🎯 Next Steps:
echo 1. Install a C++ compiler if not available
echo 2. Run the build script: .\build.bat
echo 3. Start the server: server.exe
echo 4. Connect with client: client.exe 127.0.0.1
echo.
echo 📖 For detailed information, see README.md 