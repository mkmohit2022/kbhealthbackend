# Healthcare App Rate Limiting Strategy



## Rate Limiting Algorithms

| Algorithm       | Description                                                  |
|----------------|--------------------------------------------------------------|
| **Token Bucket** | Allows bursts and smooth rate over time. Tokens refill at fixed intervals. |
| **Leaky Bucket** | Smooths out bursty traffic, emits at fixed rate            |
| **Sliding Window** | More accurate and fair than fixed window                  |
| **Fixed Window**   | Simplest, but prone to burst exploitation                 |

- Should Use combination of  **Token Bucket** with **Sliding Window** for optimal control. As token bucket will allow bursts and smooth rate over time along with tokens refill at fixed intervals and sliding window will not restrict any fixed number.

---

## Distributed Rate Limiting with Redis

- Use **Redis** as a central in-memory store to share rate limits across horizontally scaled backend servers  
 
---

## Role-Based Rate Limits

| Role   | Limit              |
|--------|--------------------|
| Admin  | 1000 requests/min  |
| Staff  | 500 requests/min   |
| Public | 60 requests/min    |

---

## Per-Endpoint Rate Limits

| Endpoint            | Limit         |
|---------------------|---------------|
| `/auth/login`       | 5 req/min     |
| `/patients/search`  | 100 req/min   |
| `/sync/upload`      | 50 req/min    |
| `/checkups/create`  | 30 req/min    |

---

## Rate Limit Enforcement

- Return `429 Too Many Requests` if the limit is exceeded  
- Include the following headers in **every API response**:

  ```http
  X-RateLimit-Limit: <total allowed requests>
  X-RateLimit-Remaining: <remaining requests>
  X-RateLimit-Reset: <time until reset (in seconds)>

---

## Emergency Bypass Strategy

- Allow override for emergency actions via a bypass token

- Token Requirements:

    - Time-limited (e.g., 15 minutes)

    - Requires OTP or admin authorization

---

## Implementation: Rate Limiting in Node.js + Redis

- Using Redis TTL (Time To Live) to reset rate counts automatically
- Using user ID or IP address as the key for rate limiting
- Storing role info in JWT token or session and apply dynamic limits
- Monitor Redis usage to avoid memory bloat