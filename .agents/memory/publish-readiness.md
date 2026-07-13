---
name: Publish readiness for this app
description: Why past publishes failed and what the app needs in production
---
- The app must be published as **Reserved VM**, not Autoscale: it runs in-process background pollers (pending deposits every 30s, expired trades every 2s) that Autoscale kills. All historical publish attempts were Autoscale (cloud_run) and failed; `.replit` now targets `vm`.
- **Why:** Autoscale is stateless/request-scoped; background asyncio tasks and Telegram webhook auto-setup need an always-on process.
- **How to apply:** When the user publishes, remind them to pick Reserved VM. Production URL detection must gate on `REPLIT_DEPLOYMENT` + `REPLIT_DOMAINS` — `REPLIT_DEV_DOMAIN` may still be present in prod secrets and would silently point webhooks at the dev domain.
