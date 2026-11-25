
#!/usr/bin/env bash
# exit on error

set -o errexit

pip install -r requirements.txt
python manage.py collectstatic --no-input
python manage.py migrate
python -c "import os, django; os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'negocio.settings'); django.setup(); from django.contrib.auth import get_user_model; U = get_user_model(); u, _ = U.objects.get_or_create(username=os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')); u.set_password(os.environ.get('DJANGO_SUPERUSER_PASSWORD', 'Admin12345!')); u.is_staff = True; u.is_superuser = True; u.save(); print('SUPERUSER_OK:', u.username)"