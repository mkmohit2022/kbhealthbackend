# Healthcare Application Backend (Android Client Support)

This backend system is designed for a healthcare Android application used by frontline health workers to provide basic services to pregnant women, children, and others. 

---

## System Architecture
- The backend system design architecture supports **offline-first functionality**, **data encryption**, **high availability**, **rate limiting**, and **secure bi-directional synchronization**.

### Key Points
- Microservice architecture with scalable deployment (Kubernetes-ready or load balancer based)
- API Gateway for routing, authentication, and rate limiting for APIs
- PostgreSQL with encrypted fields using AES and TDE for full database encryption
- Redis for rate limiting, caching, and token sessions management
- Sync microservice for offline-first Android app to sync data everytime when have internet
- Kafka/RabbitMQ for async data handling
- SSL/TLS supported by HTTPS for all API traffic data protenction
- Key Management System (Vault / AWS KMS)

### Follow the folder architecture for design diagram and the file for more details

---

## Database Schema

Includes:
- Institution, Staff, Patient
- Checkup, Disease, Medicine
- Prescription and CheckupDisease (join tables)


### Encrypted Fields essential on database
| Table     | Field               | Encryption |
|-----------|---------------------|------------|
| `patient` | name, address, phone| AES-256-GCM|
| `staff`   | contact             | AES-256-GCM|
| `checkup` | notes               | AES-256-GCM|

> Encryption is applied at the application level for sensitive PII using encryption with keys managed by Key Management System (Vault, AWS KMS, etc).

---

## Security Strategy

### Key Points for security of data 

- In Transit: TLS 1.3 with HTTPS enforced 
- At rest (database): TDE (Transparent Data Encryption) + Field-level AES-256 encryption 
- Authentication: OAuth 2.0 + JWT (Access & Refresh tokens)
- Authorization: Role-Based Access Control (RBAC) can be decoded using issued JWT at authentication
- Key Management: KMS (HashiCorp Vault / AWS KMS) 

### Key Rotation
- KEK: Rotated every 90 days
- DEK: Rotated per update or per-patient if required

---