clone:
	git clone --single-branch --branch docker git@github.com:ravuthz/music_api_deploy.git music_api

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	stop start

git-pull:
	cd music_api; git pull

shell-app:
	docker exec -ti app bash