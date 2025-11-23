## 🚧 Challenge: MySQL Authentication & Readiness Probe Failures
**Problem**: MySQL pod running but failing readiness probes with authentication errors

**Root Causes**:
1. Base64 encoding issues with MySQL secrets
2. Readiness probe using socket connection instead of TCP
3. MySQL initialization timing issues

**Solutions Applied**:
1. Recreated secrets using `--from-literal` instead of base64
2. Changed readiness probe to use TCP connection (`127.0.0.1` instead of socket)
3. Increased initial delay for database initialization
4. Used simpler liveness probe (TCP socket check)

**Key Learning**: 
- MySQL in containers needs time to initialize
- TCP connection probes are more reliable than socket connections
- `--from-literal` is safer than manual base64 encoding for secrets
