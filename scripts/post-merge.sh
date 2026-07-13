#!/bin/bash
set -e

# Установка python-зависимостей (идемпотентно)
if [ -f requirements.txt ]; then
  pip install -r requirements.txt --quiet
fi

# Миграции БД выполняются автоматически при старте приложения (main.py startup)
echo "Post-merge setup complete"
