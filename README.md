Web интерфейс с подготовленными образами iPXE
=====

## Демонстрация
Вы можете посмотреь, как выглядит данный проект на сайте: [ipxe.pcserviceburgas.com](https://ipxe.pcserviceburgas.com/). Этот проект является русификацией действующего проекта [rom-o-matic.dev](https://github.com/lps-rocks/rom-o-matic)

## Зачем
Web интерфейс с подготовленными образами. Многие пользователи предпочитают скачать подготовленные образы iPXE вместо того, чтоб собирать их из исходного кода.

## Что
Основанный на web пользовательский интерфейс предоставляет возможность выбрать различные опции сборки iPXE, указать встроенный скрипт, и т.д., после чрго собрать и скачать файл.

## Как
Пользовательский интерфейс использует HTML, CSS, а так же Javascript (jQuery) и подходящий язык на стороне сервера (Perl).
Все GUI настройки (git version/nics list/compile options) генерируются из исходного кода iPXE динамически.
Скрипт build.fcgi написан на Perl уважаемым Michael Brown.

## Использование образа DockerHub

[![dockeri.co](https://dockeri.co/image/sebaxakerhtc/rom-o-matic)](https://hub.docker.com/r/sebaxakerhtc/rom-o-matic)

* Поддерживаемые теги:

    `latest` - Latest ([Dockerfile](https://github.com/sebaxakerhtc/rom-o-matic/blob/master/Dockerfile))

* Поддерживаемые архитектуры: x86-64

* Запуск rom-o-matic 

После успешной [установки Docker](https://docs.docker.com/engine/installation/) Вам достаточно выполнить в терминале следующую команду:

```bash
docker run  -d \
	--publish 8080:80 \
	--name rom-o-matic \
    sebaxakerhtc/rom-o-matic	
```

## Тест с использованием Docker

* Установите Docker
[Документация по установке Docker (Eng)](https://docs.docker.com/engine/installation/)

Docker deb пакет подходит для Ubuntu и Debian.

```bash
$ wget http://get.docker.io/ -O - | sh
```

* Сборка образов

Следующая команда произведёт сборку прямо из репозитория Github.

Процес займёт определённое время, необходимое для загрузки образа Alpine и его настройки.
```bash
$ docker build --rm=true --no-cache=true -t sebaxakerhtc/rom-o-matic github.com/sebaxakerhtc/rom-o-matic.git
```

Или Вы можете клонировать репозиторий и запустить сборку командой.
```bash
$ docker build --rm=true --no-cache=true -t sebaxakerhtc/rom-o-matic .
```

* Запуск контейнера

Запуск контейнера без подключения
```bash
$ docker run -d -p 8080:80 -t sebaxakerhtc/rom-o-matic
```

Или запуск контейнера с подключением к терминалу
```
$ docker run -i --rm -p 22:22 -p 8080:80 -t sebaxakerhtc/rom-o-matic /bin/bash
```

* Проверка IP

```bash
$ docker ps -a
$ docker inspect CONTAINER_ID | grep IPA
```

* Просмотр логов

```bash
$ docker logs CONTAINER_ID
```

* Пользуйтесь!
