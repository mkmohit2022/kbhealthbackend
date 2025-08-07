# Healthcare App Security Strategy

## Data Encryption Strategy

### a. In Transit

- **Protocol**: TLS 1.3 (HTTPS) for all API communications  
- **Certificate Management**: Managed via AWS ACM / GCP Certificates  
- **Enforced via**:
  - HTTP Strict Transport Security (HSTS)
  - HTTPS-only API Gateway

### b. At Rest

#### Database Encryption

- Transparent Data Encryption (TDE) at the database level (for postgreSQL)
- Encrypts the entire database storage, including backups

#### Field-Level Encryption

- Use **AES-256-GCM** to encrypt sensitive fields:
  - Patient Name
  - Contact Information
  - Checkup Notes
  - Address

### c. Encryption Algorithm Selection

| Use Case             | Algorithm      | Reason                                |
|----------------------|----------------|----------------------------------------|
| Field-Level Encryption | AES-256-GCM    | Authenticated, fast, secure            |
| Hashing Passwords     | Argon2 / bcrypt| Slow hashing, mitigates brute force    |
| Token Signing         | RS256 / HS256  | Industry-standard for JWT              |

---

## Key Management System (KMS)

### a. Design Overview

- Keys are stored and managed by **HashiCorp Vault**, **AWS KMS**, or **GCP KMS**
- **Envelope Encryption** implemented:
  - Data encrypted with **DEK** (Data Encryption Key)
  - DEK encrypted with **KEK** (Key Encryption Key)

### b. Key Lifecycle & Rotation

- **Rotation Frequency**:
  - KEKs: every 90 days
  - DEKs: regenerated upon patient re-registration or record update
- **Key Versioning**: Maintain previous versions for backward decryption
- **Revocation Support**: Disable access to old keys if compromised

### c. Access Control

- RBAC (Role-Based Access Control) to restrict access to KMS
- Audit logs for every key access

---

## Authentication & Authorization

### a. Authentication

- **OAuth 2.0** with **JWT tokens**
- **Token Types**:
  - Access Token (short-lived)
  - Refresh Token (long-lived)
- **Token Payload Includes**:
  - User ID
  - Role
  - Expiry
  - Signature
  -- These can ne used at the backend for verification for every API request

### b. Authorization

- Role-Based Access Control (RBAC):
  - **Admin**: Full access
  - **Staff/Nurse**: Access to assigned patients only
- Fine-grained access enforced at the API layer

---