# Secure Communication Protocol

A comprehensive C++ implementation of a secure communication protocol with encryption, key exchange, forward secrecy, and authentication.

## 🛡️ Security Features

### Core Security Features
- **Message Encryption**: All messages are encrypted using AES-256-GCM
- **Key Exchange**: RSA-2048 and Diffie-Hellman key exchange for secure communication
- **Forward Secrecy**: Perfect Forward Secrecy (PFS) ensures past messages remain secure even if keys are compromised
- **Authentication**: Digital signatures and session verification
- **Key Rotation**: Automatic and manual key rotation for enhanced security

### Technical Implementation
- **RSA-2048**: For initial key exchange and digital signatures
- **Diffie-Hellman**: For ephemeral key generation and forward secrecy
- **AES-256-GCM**: For message encryption with authenticated encryption
- **SHA-256**: For hashing and HMAC generation
- **PBKDF2**: For key derivation with salt

## 📁 Project Structure

```
secure_comm/
├── CMakeLists.txt          # Build configuration
├── include/
│   └── common.h           # Shared data structures and constants
├── crypto/
│   ├── crypto_utils.h     # Cryptographic utilities header
│   └── crypto_utils.cpp   # Cryptographic implementation
├── server/
│   └── server.cpp         # Secure server implementation
├── client/
│   └── client.cpp         # Secure client implementation
└── README.md              # This file
```

## 🔧 Building the Project

### Prerequisites
- C++17 compatible compiler (GCC 7+, Clang 5+, MSVC 2017+)
- CMake 3.10 or higher
- OpenSSL development libraries
- POSIX-compliant system (Linux, macOS, BSD)

### Install Dependencies

#### Ubuntu/Debian:
```bash
sudo apt update
sudo apt install build-essential cmake libssl-dev
```

#### CentOS/RHEL/Fedora:
```bash
sudo yum install gcc-c++ cmake openssl-devel
# or for Fedora:
sudo dnf install gcc-c++ cmake openssl-devel
```

#### macOS:
```bash
brew install cmake openssl
```

### Build Instructions

1. **Clone and navigate to the project:**
```bash
cd secure_comm
```

2. **Create build directory:**
```bash
mkdir build && cd build
```

3. **Configure with CMake:**
```bash
cmake ..
```

4. **Build the project:**
```bash
make -j$(nproc)
```

5. **Install (optional):**
```bash
sudo make install
```

## 🚀 Usage

### Starting the Server

```bash
./server [port]
```

**Example:**
```bash
./server 8080
```

The server will:
- Generate RSA-2048 key pair
- Listen for client connections
- Perform secure handshakes
- Handle encrypted messages
- Automatically rotate keys every 10 messages

### Connecting with the Client

```bash
./client <server_ip> [port]
```

**Example:**
```bash
./client 127.0.0.1 8080
```

### Interactive Client Commands

Once connected, the client provides an interactive interface:

- **Send message**: Type any text and press Enter
- **Rotate keys**: Type `rotate` to manually rotate session keys
- **Quit**: Type `quit` or `exit` to disconnect

**Example session:**
```
> Hello, this is a secret message!
Sent encrypted message: Hello, this is a secret message!
Server response: Server received: Hello, this is a secret message!

> rotate
Key rotation successful

> Another encrypted message
Sent encrypted message: Another encrypted message
Server response: Server received: Another encrypted message

> quit
```

## 🔐 Security Protocol Details

### Handshake Process

1. **Client Init**: Client sends RSA public key and nonce
2. **Server Response**: Server generates DH key pair and sends public key
3. **Key Exchange**: Both parties perform DH key exchange
4. **Session Key**: Derive AES session key using shared secret and nonce
5. **Authentication**: Verify session and establish secure channel

### Message Encryption

1. **Generate IV**: Random initialization vector for each message
2. **Encrypt**: AES-256-GCM encryption with session key
3. **Sign**: Digital signature using RSA private key
4. **Send**: Transmit encrypted message with signature

### Forward Secrecy

- **Ephemeral Keys**: DH keys are generated per session
- **Key Rotation**: Automatic rotation every 10 messages
- **Manual Rotation**: Client can request key rotation anytime
- **Session Isolation**: Each session has unique keys

## 🛠️ API Overview

### CryptoManager Class
```cpp
// Key generation
KeyPair generate_rsa_keypair(size_t bits = 2048);
KeyPair generate_dh_keypair();

// Encryption/Decryption
std::vector<uint8_t> encrypt_aes_gcm(data, key, iv);
std::vector<uint8_t> decrypt_aes_gcm(encrypted_data, key, iv);

// Key exchange
std::vector<uint8_t> perform_dh_key_exchange(private_key, peer_public_key);
std::vector<uint8_t> derive_shared_secret(dh_result, salt);

// Digital signatures
std::vector<uint8_t> sign_data(data, private_key);
bool verify_signature(data, signature, public_key);
```

### SessionManager Class
```cpp
// Session management
SessionInfo create_session(uint32_t client_id);
SessionInfo get_session(uint32_t session_id);
void update_session_activity(uint32_t session_id);

// Authentication
bool authenticate_session(uint32_t session_id, auth_data);
AuthResult verify_session_auth(uint32_t session_id, signature);

// Key management
void set_session_key(uint32_t session_id, key);
std::vector<uint8_t> get_session_key(uint32_t session_id);
void rotate_session_key(uint32_t session_id);
```

## 🔍 Security Analysis

### Cryptographic Strength
- **RSA-2048**: 112-bit security level
- **AES-256**: 256-bit security level
- **SHA-256**: 128-bit collision resistance
- **DH-2048**: 112-bit security level

### Attack Resistance
- **Man-in-the-Middle**: Prevented by digital signatures
- **Replay Attacks**: Prevented by nonces and timestamps
- **Key Compromise**: Forward secrecy protects past messages
- **Session Hijacking**: Prevented by session authentication

### Best Practices Implemented
- **Constant-time operations**: For cryptographic comparisons
- **Secure random generation**: Using OpenSSL's RAND_bytes
- **Key rotation**: Regular key updates
- **Session expiration**: Automatic cleanup of old sessions
- **Error handling**: Secure error reporting without information leakage

## 🧪 Testing

### Basic Functionality Test
```bash
# Terminal 1: Start server
./server 8080

# Terminal 2: Connect client
./client 127.0.0.1 8080
```

### Security Verification
- Check that messages are encrypted (use Wireshark)
- Verify key rotation works
- Test session expiration
- Confirm forward secrecy

## 📝 License

This project is provided as educational software. Use at your own risk in production environments.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## ⚠️ Disclaimer

This implementation is for educational purposes. For production use, consider:
- Additional security audits
- Integration with certificate authorities
- Hardware security modules (HSM)
- Regular security updates
- Compliance with relevant standards (FIPS, Common Criteria)

## 📚 References

- [OpenSSL Documentation](https://www.openssl.org/docs/)
- [NIST Cryptographic Standards](https://www.nist.gov/cryptography)
- [RFC 5246 - TLS 1.2](https://tools.ietf.org/html/rfc5246)
- [RFC 8446 - TLS 1.3](https://tools.ietf.org/html/rfc8446) 