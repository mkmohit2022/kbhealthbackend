# Healthcare App Architecture

This folder contains the system architecture and components for healthcare app. The architecture supports real-time syncing, encryption, microservices, and scalable infrastructure.

## Android Client App
- Offline-first with Encrypted SQLite databse on the mobile devices for data storage oggline
- Auth token storage on app after login
- Secure bi-directional sync service between the SQLite database and the server database.

## KMS Vault
- Field-level encryption key ma
- Key management for TDE (encryprion over postgresql database) and fields(AES-256 encryption). Eg: Hashicorp vault.

## Backend Microservices
- Below are the few essential microserives required for the app and it changes based on exact requirements
    - Patient and prescription management services for frontline health workers
    - OAuth2/JWT for authentication for the application, and later using jwt to authenticate APIs using middleware
    - Async processing via Kafka/RabbitMQ using queues

## Infrastructure
- Both ways of infra can be used based on exact requirements again.
    - Kubernetes (Auto-scaling) based on the load on servers
    - Load Balancer (AWS/GCP/Azure), When know about the approx load on server and the delpyments are not containerized.

## API Gateway
- HTTPS, Authentication, Rate Limiting
- Request forwarding to microservices

## Database
- PostgreSQL with Transparent Data Encryption for full DB encryption
- Redis for session and cache


## Messaging
- Kafka / RabbitMQ for async tasks

## Monitoring (optional)
- ELK Stack, Prometheus + Grafana
---


+----------------------------+
|    Android Mobile App     |
| +----------------------+  |
| | Local Encrypted DB   |  |
| | Offline Data Cache   |  |
| +----------------------+  |
|        |        ^         |
|        v        |         |
|  Background Sync Service  |
+------------|-------------+
             |
             v
     +------------------+
     |   API Gateway    |
     |  (Auth + Rate    |
     |   Limiting)      |
     +------------------+
             |
    +--------+--------+
    |        |        |
    v        v        v
+--------+ +---------+ +-----------+
| Auth   | | Patient | | Sync      |
|Service | | Service | | Service   |
+--------+ +---------+ +-----------+
    |        |        |
    v        v        v
+---------------------------------+
|         PostgreSQL DB           |
|   (Encrypted fields + TDE)      |
+---------------------------------+
             |
             v
+--------------------------------+
|         Redis (Rate Limit,     |
|       Caching, Sessions)       |
+--------------------------------+
             |
             v
+------------------------------+
| Key Management System (KMS) |
| e.g., HashiCorp Vault        |
+------------------------------+
