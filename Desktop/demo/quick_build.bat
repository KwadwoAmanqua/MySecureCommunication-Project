@echo off
echo 🔧 Quick Build - Secure Communication Protocol
echo ==============================================

REM Set up Visual Studio environment
echo 📋 Setting up Visual Studio environment...
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\vsdevcmd\ext\vcvars.bat"

REM Check if cl is now available
where cl >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Visual Studio C++ compiler not found after environment setup.
    echo 💡 Please install Visual Studio Build Tools manually.
    pause
    exit /b 1
)

echo ✅ Visual Studio environment setup complete

REM Create build directory
if exist build rmdir /s /q build
mkdir build
cd build

REM Configure with CMake
echo ⚙️  Configuring with CMake...
cmake .. -G "Visual Studio 17 2022" -DCMAKE_BUILD_TYPE=Release
if %errorlevel% neq 0 (
    echo ❌ CMake configuration failed!
    pause
    exit /b 1
)

REM Build the project
echo 🔨 Building project...
cmake --build . --config Release
if %errorlevel% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

REM Check if build was successful
if exist "Release\server.exe" if exist "Release\client.exe" (
    echo.
    echo ✅ Build successful!
    echo 📦 Generated executables:
    echo    - Release\server.exe (Secure Communication Server)
    echo    - Release\client.exe (Secure Communication Client)
    echo.
    echo 🚀 To run:
    echo    Terminal 1: Release\server.exe
    echo    Terminal 2: Release\client.exe 127.0.0.1
    echo.
    echo 📖 For more information, see README.md
) else (
    echo ❌ Build failed! Check the error messages above.
    pause
    exit /b 1
)

cd ..
pause 