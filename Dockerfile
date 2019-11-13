FROM python:3.7

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /opt/apps/music_api

# COPY ./music_api/Pipfile /opt/apps/music_api/
# COPY ./music_api/Pipfile.lock /opt/apps/music_api/
# COPY ./music_api/requirements.txt /opt/apps/music_api/

WORKDIR /opt/apps/music_api

COPY ./music_api /opt/apps/music_api

# Install dependecies using pipenv or virtualenv
# RUN pip install pipenv && pipenv install --system
RUN pip install -r requirements.txt

RUN python manage.py collectstatic --no-input

# RUN cd music_api && python manage.py collectstatic --no-input

## Run cmd after container started
# ENTRYPOINT python manage.py migrate && /bin/bash
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh /

EXPOSE 8000

ENTRYPOINT [ "docker-entrypoint.sh" ]

# CMD ["gunicorn", "-c", "config/gunicorn/conf.py", "--bind", ":8000", "--chdir", "music_api", "music_api.wsgi:application"]
# CMD gunicorn -c /etc/gunicorn/conf.py --bind :8000 --chdir music_api music_api.wsgi:application