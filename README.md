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