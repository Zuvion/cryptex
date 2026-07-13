---
name: Legacy Railway deployment
description: Old production copy of the app lives on Railway with its own DB; bot menu button pitfalls
---
- A legacy copy of the app runs at cryptex-kripteks.up.railway.app with its OWN database — users opening the mini app via the bot's menu button may land there and see old code/data.
- **Why:** during debugging "nothing changed" reports, the real cause was the bot menu button «ЗАПУСК» pointing at Railway, not the current Replit app.
- **How to apply:** if users report missing features, first check `getChatMenuButton` and webhook URL. The DEFAULT menu button could not be changed via `setChatMenuButton` (returns ok:true but value stays — likely pinned in BotFather); per-chat `setChatMenuButton` with `chat_id` DOES work. Default must be changed in BotFather: Bot Settings → Menu Button. Also check BotFather "Main Mini App" URL.
