---
name: Price lookup fallbacks
description: Where to get crypto prices when OKX/CMC fail (TON case)
---
- OKX spot has NO TON pairs (checked July 2026) — okx_get_price("TON") returns None.
- CoinMarketCap `symbol=TON` resolves to a wrong asset ("Ton" = AT&T tokenized stock), so cmc_simple_price("TON") fails/returns wrong data.
- Reliable fallback: CryptoBot `getExchangeRates` (header Crypto-Pay-API-Token: CRYPTO_PAY_TOKEN) — gives source→USD rates for TON, BTC, ETH, USDT, SOL, TRX, DOGE, LTC, BNB.
**Why:** min-deposit USDT-equivalent checks are fail-closed; without this fallback all TON deposits get rejected with "курс недоступен".
**How to apply:** any USDT-equivalent conversion for deposit currencies should cascade OKX → CMC → CryptoBot rates.
