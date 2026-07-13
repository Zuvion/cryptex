---
name: Support chat uploads safety
description: Rules for rendering user files/messages in support chat without XSS
---
- Rule: never interpolate user-controlled fields (message text, file names/paths) into `innerHTML`; build chat DOM via `createElement` + `textContent` / `img.src`. Server must rename uploads to `timestamp_uuid.ext` with an extension whitelist (jpg/jpeg/png/webp/gif/pdf/txt) and reject others with 400.
- **Why:** architect review caught a stored XSS — original code used raw `file.filename` in the public URL and `innerHTML` templating, letting a crafted filename or message execute JS in the mini app.
- **How to apply:** any new chat/message/file rendering in app.js or new upload endpoints in main.py must follow the same pattern (see /api/support upload + support chat renderer as reference).
