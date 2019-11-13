#!/bin/sh

echo "docker-entrypoint.sh"

ls -lah
python test_env.py
python manage.py check
python manage.py migrate

# echo "from django.contrib.auth.models import User;
# User.objects.create_superuser('admin', 'admin@gmail.com', '123123')" | python manage.py shell

cat <<EOF | python manage.py shell
from django.contrib.auth.models import User;

User.objects.filter(username='admin').exists() or \
    User.objects.create_superuser('admin', 'admin@gmail.com', '123123')
EOF

gunicorn \
    --bind :8000 \
    --config /etc/gunicorn/conf.py \
    --chdir music_api music_api.wsgi:application

# -b --bind
# -c --config
# -w --workers