#!/usr/bin/env bash
set -e
cd /backend/backend
/opt/conda/envs/HSSE/bin/python manage.py migrate
/opt/conda/envs/HSSE/bin/python manage.py collectstatic --noinput

exec /opt/conda/envs/HSSE/bin/gunicorn hsse_backend.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3