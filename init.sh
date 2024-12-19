#!/bin/sh -x


touch __init__.py

pip install --no-cache-dir -r /app/requirements.txt -t . --no-user
