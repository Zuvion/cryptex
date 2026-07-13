---
name: Deposit provider pattern
description: Convention for adding a new payment provider (deposit method) to CRYPTEXA.
---

All deposit providers (OxaPay, xRocket, CryptoBot) follow the same shape:

- Backend: `POST /api/deposit/<provider>/create` (creates pending Transaction with `details.invoice_id = "<provider>_<id>"` and `details.method`), `GET /api/deposit/<provider>/check` (polls provider API; on paid → `process_deposit_payment`), `POST /api/<provider>/webhook` (added to `_SKIP_AUTH_PATHS`, MUST verify signature and be fail-closed when the provider token is not configured).
- Crediting goes only through `process_deposit_payment` — it is idempotent (row lock + status check under `FOR UPDATE`) and handles referral bonus and non-USDT wallets.
- Frontend: method card in `showDepositMethodSelection`, currency picker, amount screen with presets, payment screen with 5s polling; history label mapped by `details.method` / invoice prefix.
- i18n: add ru+en keys in `i18n/translations.json` (`deposit.method_<provider>`, `deposit.pay_<provider>`, `deposit.pay_via_<provider>`).

**Why:** keeping all providers symmetric makes double-credit protection and webhook security uniform; crediting outside `process_deposit_payment` would bypass idempotency.

CryptoBot specifics: API `https://pay.crypt.bot/api`, header `Crypto-Pay-API-Token`, webhook signature = HMAC-SHA256(body) keyed with SHA256(token), header `crypto-pay-api-signature`.
