---
name: Env vars vs Secrets on Replit
description: Shared env vars are stored in plaintext inside .replit (committed to repo); sensitive keys must be Secrets.
---

Rule: never store API keys/tokens as shared environment variables — Replit writes them in plaintext into `.replit` under `[userenv.shared]`, which is committed alongside the code (and pushed to GitHub).

**Why:** ADMIN_API_KEY was found hardcoded in `.replit` during a security review (July 2026) — a critical credential exposure. It was removed, and a new value was stored as a Secret instead.

**How to apply:** any sensitive value goes into Replit Secrets (via requestEnvVar). If a key is ever found inside `.replit` or the repo history, treat it as compromised: delete it from `.replit` and ask the user to generate/rotate a new one.
