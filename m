Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9AFCCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:33 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22623.1792361012124927922
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f8xGh2hK;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398b3c37877so858629a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361011; x=1792965811; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qk4+8bzFkrX+sRTdVQISxBwqemqiTrg96GW7aAMxgXo=;
        b=f8xGh2hK/VplHNxyJLW36v6w7aJlTCoL/ocJjPOw4ZyO2NdxkAuyBEL94SNcdaZ1Aa
         fgG55XagWMeR4Cz83bUJTgcdD0zgdFp/gcKVxwJ+biFqRqCot4xPWeN1eWMpCoPakjfo
         dlmXLa8kSPIAroW7EvdC3c7bW93I0WpnREKK9RHaDoHnRuYY/qsSWSj0NwadQ9NcwyWZ
         Atiswwl43dGtYu6weHk6NKZuDKqiJhwo8tJhIm6F5uzQCLUYPRx+qm3xJeXJSgyd0u8B
         e8eRfT2nX2BpQWO8XnvM515x2NhA6zVgr91TJjOXpm4xBhrwZJO8UIKrkoX3Hk/AJiQf
         6ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361011; x=1792965811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qk4+8bzFkrX+sRTdVQISxBwqemqiTrg96GW7aAMxgXo=;
        b=KFzvrCCtN1aVjiy5v3EK8HjFMHgBQj7Knn4DiJQ41ZzOnZHG0RA2vGzQ5mBw9sHMnB
         VFYMjONb9vIHM+B8L96Wtue350u2RsOxofRN8mN1JArv6KXxTKPSc1ZdWAXpaKwgRW4j
         heB0Pd980qw5qeEj8D9nZo0clU7EWhD89YxOB1v9HjnD9EcgFGA0bEZ8uusQNzdGYS4H
         7cc+2IzMim8022YrxW7ijJ7fFQHtUoZ7gFt9GeGJc2Y9pgqx+gVgj8o1lDaiYuU1I3fx
         OzQoH6GThoYogE0DddoSgYGUmasktQLtqRRyTnM2od75PzKcJ2mi7NivI3ePch2x459a
         ckBg==
X-Gm-Message-State: AFq9FYI2ko26/Im/QLd9JyqduLWxB1dkub3lAWslJyfisGzoswi6QGnh
	wDSO7REWTsFFgyxCaJOMCk8wMTDgZNC9x4AJCFNL3TVsLKNaUMXpIm3k4//JYbr5
X-Gm-Gg: AYBFou1ZFMsNV3Iumn90g8QDiCxmsS1qh1TVT0xd5EPgcH2XQwhfuPU/Z4ZDsXE/dV6
	fGp/kM9pdQTLeSuJp9DLv20SZ+lNoUV9QS+n0Gt/4Ix3VV22rTtTxnSLHUwsnboR81E70vAIHLM
	E650jsNvt7rq4G+JlyWOzterAfuex5KnRDACXKo8uEVeZqHX9lPXUMD5wdHbItG0MBVicoZaAFK
	vaafG0P1yG/arhVWwcWRVwBpKYskR0IwmKddKUNrXJEs+SyzMpFubScz5pu5qOrGYFmqIvrWePA
	Uc3f8xRLo59u4sLTo5Y6u0gXEwZZutLL8xLLVpp4us8MwXZGpS0USl27Vik+UCtNdEWdaiFvbOO
	QNFocD5WBdbMiHvWZ6omr4wVML7tKX2+2p47MU2x+dVrhWne0FrV1ZwVca0EWjPKJaUW8Upgdwj
	1OUUe+Oz63RuHbwy8i8mKC5hvR1nQqgKQXEAMVZqW85znj+aUVvgzwmELRNGKhfh6imV1LvNodK
	up3VcSNAZLO8UvhFFz33vMgWtZ5N5U=
X-Received: by 2002:a17:90b:37cd:b0:3a4:ee64:b82c with SMTP id 98e67ed59e1d1-3acef60f75cmr4935293a91.66.1792361010118;
        Sun, 18 Oct 2026 15:03:30 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:28 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 07/10] Format the README files as Markdown
Date: Sun, 18 Oct 2026 15:03:05 -0700
Message-ID: <20261018220308.72731-8-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5089

Use Markdown headings, lists, code blocks and inline code, a table for
the core layer values and links between the files. Placeholders such
as <service> and <username> are now in code, where they would
otherwise be dropped as HTML tags. The wording is unchanged.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.devel.md  | 155 +++++++++++-------
 README.md        | 401 +++++++++++++++++++++++++----------------------
 README.rrs.md    |  50 +++---
 README.vscode.md |  55 ++++---
 4 files changed, 362 insertions(+), 299 deletions(-)

diff --git a/README.devel.md b/README.devel.md
index ae41c8c..f5b56ec 100644
--- a/README.devel.md
+++ b/README.devel.md
@@ -1,33 +1,36 @@
-Standalone Setup
-----------------
+## Standalone Setup
 
-NOTE: The standalone setup is most suitable for development and is not
+**NOTE:** The standalone setup is most suitable for development and is not
 recommended for production; for production use the Docker-based setup
-covered in the main README.md.
+covered in the main [README.md](README.md).
 
 In order to run this application standalone, you will need:
 
-* Python 3.10+
-* Django 5.2 LTS, as pinned in requirements.txt
-* RabbitMQ
-* For production usage, a web server set up to host Django applications
+- Python 3.10+
+- Django 5.2 LTS, as pinned in `requirements.txt`
+- RabbitMQ
+- For production usage, a web server set up to host Django applications
   (not needed for local-only testing/development)
-* A database system supported by Django (SQLite, MariaDB/MySQL, etc.).
-* Third-party Django/python modules as detailed by requirements.txt.
+- A database system supported by Django (SQLite, MariaDB/MySQL, etc.).
+- Third-party Django/python modules as detailed by `requirements.txt`.
   If you're using pip, you can install these by running:
-    pip install -r requirements.txt
+
+  ```sh
+  pip install -r requirements.txt
+  ```
+
   (See below for a virtualenv-based setup which is easy to work with.)
-* On the machine that will run the backend update script (which does not
+- On the machine that will run the backend update script (which does not
   have to be the same machine as the web server, however it does still
   have to have Django installed, have the same or similar configuration
-  in settings.py and have access to the database used by the web
+  in `settings.py` and have access to the database used by the web
   application):
-  * A Python version supported both by Django and by the BitBake of
+  - A Python version supported both by Django and by the BitBake of
     the OpenEmbedded branches being parsed
-  * Python dependencies as per requirements.txt (we still need Django
+  - Python dependencies as per `requirements.txt` (we still need Django
     etc. here since we interact with the database through Django's ORM.)
 
-Example virtualenv-based setup for the above:
+### Example virtualenv-based setup for the above
 
 Python's virtualenv provides an easy way to isolate the python dependencies
 of applications such as the layer index. Here's an example of setting up a
@@ -39,27 +42,37 @@ distros).
    pip to build the dependencies; it's also assumed you want MariaDB as
    the database backend):
 
+   ```sh
    sudo apt-get update
    sudo apt-get install python3-venv libmariadb-dev build-essential python3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-dev mariadb-server rabbitmq-server
+   ```
 
 2. Work around path issues (you may not need this):
 
+   ```sh
    sudo ln -s /usr/bin/mariadb_config /usr/bin/mysql_config
+   ```
 
 3. Create a Python 3 virtualenv (path can be anywhere you like):
 
+   ```sh
    python3 -m venv /path/to/desired/venv
+   ```
 
 4. Activate the virtualenv:
 
+   ```sh
    . /path/to/desired/venv/bin/activate
+   ```
 
 5. Install requirements:
 
+   ```sh
    pip install -r requirements.txt
+   ```
 
 
-Setting up MariaDB/MySQL:
+### Setting up MariaDB/MySQL
 
 Assuming you wish to use MariaDB/MySQL for storing the database - the
 following is completely standard, but to save you having to look it up
@@ -67,38 +80,51 @@ elsewhere:
 
 1. Start the server:
 
+   ```sh
    sudo /etc/init.d/mysql start
+   ```
 
 2. Set the root password and secure the database server:
 
+   ```sh
    sudo mysql_secure_installation
+   ```
 
 3. Create a database (substituting "mydatabase" with desired database
    name):
 
+   ```sh
    mysql -u root -p
+   ```
+
+   ```sql
    CREATE DATABASE mydatabase CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
+   ```
 
 
-Configuration and running:
+### Configuration and running
 
-1. Edit settings.py to specify a database, EMAIL_HOST, SECRET_KEY and
+1. Edit `settings.py` to specify a database, `EMAIL_HOST`, `SECRET_KEY` and
    other settings specific to your installation. Ensure you set
-   LAYER_FETCH_DIR to an absolute path to a location with sufficient
-   space for fetching layer repositories. Modify RABBIT_BROKER
-   and RABBIT_BACKEND to reflect the settings used by your RabbitMQ
+   `LAYER_FETCH_DIR` to an absolute path to a location with sufficient
+   space for fetching layer repositories. Modify `RABBIT_BROKER`
+   and `RABBIT_BACKEND` to reflect the settings used by your RabbitMQ
    server.
 
 2. Run the following commands within the layerindex-web directory to
    initialise the database:
 
+   ```sh
    ./manage.py migrate
    ./manage.py createsuperuser
+   ```
 
-3. You can test the web application locally by setting DEBUG = True in
-   settings.py and running the following:
+3. You can test the web application locally by setting `DEBUG = True` in
+   `settings.py` and running the following:
 
+   ```sh
    ./manage.py runserver
+   ```
 
    Then visit http://127.0.0.1:8000/layerindex/ with your browser. As
    with all Django applications there is an admin interface available
@@ -106,84 +132,97 @@ Configuration and running:
    will be those you entered in the step above when creating an admin
    account.
 
-   NOTE: This local server should only be used for testing - for
-   production you need to use a proper web server and have DEBUG set
-   to False (or use the Docker-based setup).
+   **NOTE:** This local server should only be used for testing - for
+   production you need to use a proper web server and have `DEBUG` set
+   to `False` (or use the Docker-based setup).
 
-   3.1. In order to process asynchronous tasks like sending email,
-        you will need to run a Celery worker:
+   1. In order to process asynchronous tasks like sending email,
+      you will need to run a Celery worker:
 
-        celery -A layerindex.tasks worker --loglevel=info
+      ```sh
+      celery -A layerindex.tasks worker --loglevel=info
+      ```
 
 4. To import layer data from the public instance at layers.openembedded.org
    you can run the following (defaults to the master branch only):
 
+   ```sh
    layerindex/tools/import_layers.py -d https://layers.openembedded.org
+   ```
 
    Alternatively you can add layers individually using the separate
-   layerindex/tools/import_layer.py script or through the admin interface.
+   `layerindex/tools/import_layer.py` script or through the admin interface.
 
 
-SMTP test server
-----------------
+## SMTP test server
 
 If you want to test email functionality (e.g. for password reset, layer
 submission or other notifications) without sending real emails, set Django's
-console email backend in settings.py:
+console email backend in `settings.py`:
 
+```python
 EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
+```
 
 Every email is then printed to the console running the server (or the Celery
 worker, for emails sent from background tasks) instead of being sent.
 
 
-Running the tests
------------------
+## Running the tests
 
-The tests use pytest and pytest-django, which are not in requirements.txt:
+The tests use pytest and pytest-django, which are not in `requirements.txt`:
 
-    pip install pytest pytest-django
+```sh
+pip install pytest pytest-django
+```
 
 To run the full suite as CI does, in the Docker image against a throwaway
 MariaDB container, run this from the top of the source tree:
 
-    docker/run-tests.sh
+```sh
+docker/run-tests.sh
+```
 
-This is the only way to run tests/test_update.py, which fetches
+This is the only way to run `tests/test_update.py`, which fetches
 openembedded-core, meta-layerindex-test and BitBake from the network and runs
 the update scripts (BitBake only runs on Linux).
 
-To run the other tests directly, set SECRET_KEY in settings.py and point it
+To run the other tests directly, set `SECRET_KEY` in `settings.py` and point it
 at a MariaDB/MySQL server where your database user may create databases
-(pytest-django creates and removes a test_<name> database), then run:
+(pytest-django creates and removes a `test_<name>` database), then run:
 
-    pytest --ignore=tests/test_update.py tests/
+```sh
+pytest --ignore=tests/test_update.py tests/
+```
 
-tests/test_dockersetup.py tests the files dockersetup.py writes. It needs only
+`tests/test_dockersetup.py` tests the files `dockersetup.py` writes. It needs only
 pytest and PyYAML, and is skipped inside the Docker image:
 
-    python3 -m pytest tests/test_dockersetup.py
+```sh
+python3 -m pytest tests/test_dockersetup.py
+```
 
-On GitHub, .github/workflows/ci.yml runs docker/run-tests.sh and
-tests/test_dockersetup.py for pushes to master and master-next and for pull
-requests to master. .github/workflows/safety.yml scans the packages
+On GitHub, `.github/workflows/ci.yml` runs `docker/run-tests.sh` and
+`tests/test_dockersetup.py` for pushes to master and master-next and for pull
+requests to master. `.github/workflows/safety.yml` scans the packages
 installed in the Docker image for known vulnerabilities on each push and
-weekly, if the repository has a SAFETY_API_KEY secret.
+weekly, if the repository has a `SAFETY_API_KEY` secret.
 
 
-
-Updating OpenEmbedded data
---------------------------
+## Updating OpenEmbedded data
 
 You will likely want to update the OpenEmbedded layer information on a regular
 basis. To do that:
 
-   Incremental update:
-
-       layerindex/update.py
+Incremental update:
 
-   Reload all data (should only be needed if the database structure has
-   changed as part of an upgrade of the application code):
+```sh
+layerindex/update.py
+```
 
-       layerindex/update.py -r
+Reload all data (should only be needed if the database structure has
+changed as part of an upgrade of the application code):
 
+```sh
+layerindex/update.py -r
+```
diff --git a/README.md b/README.md
index 32572c5..d33bb5d 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,4 @@
-OE Layer Index web interface
-============================
+# OE Layer Index web interface
 
 This is a small Django-based web application that provides a way to
 manage an index of OpenEmbedded metadata layers for use on top of
@@ -9,121 +8,124 @@ There are two main methods of setting up this application - within
 a set of Docker containers, or standalone. The Docker-based setup
 is more suited for production whereas standalone is a bit easier
 for development. This document will consider only the Docker-based
-setup; for standalone please see README.devel.md.
+setup; for standalone please see [README.devel.md](README.devel.md).
 
 
-Docker Setup
-------------
+## Docker Setup
 
-The dockersetup.py script will set up and configure a cluster of 5 or 6
+The `dockersetup.py` script will set up and configure a cluster of 5 or 6
 docker containers:
 
-  - layersapp: the application
-  - layersdb: the database
-  - layersweb: NGINX web server (as a proxy and for serving static content)
-  - layerscelery: Celery (for running background jobs)
-  - layersrabbit: RabbitMQ (required by Celery)
-  - layerscertbot: Runs certbot to keep letsencrypt certificates up-to-date
-                   (optional, default disabled)
+- `layersapp`: the application
+- `layersdb`: the database
+- `layersweb`: NGINX web server (as a proxy and for serving static content)
+- `layerscelery`: Celery (for running background jobs)
+- `layersrabbit`: RabbitMQ (required by Celery)
+- `layerscertbot`: Runs certbot to keep letsencrypt certificates up-to-date
+  (optional, default disabled)
 
 The script will edit all necessary configuration files, build and launch all
 containers, and do the initial database setup. It is advised that you start
 with a .sql database file to prepopulate your database. The following
 instructions will walk you through the setup.
 
-1) Install docker and docker-compose per instructions:
+1. Install docker and docker-compose per instructions:
 
-        https://docs.docker.com/compose/install/
+   https://docs.docker.com/compose/install/
 
-   ** Note: for latest docker-compose version follow the directions above,
-      rather than using a perhaps outdated one provided by your distribution.
+   **Note:** for latest docker-compose version follow the directions above,
+   rather than using a perhaps outdated one provided by your distribution.
 
-2) Run the setup script (dockersetup.py). You can optionally supply your
+2. Run the setup script (`dockersetup.py`). You can optionally supply your
    hostname, proxy settings, a sql database file of layer mappings to import,
    and a host to container port mapping. For more information, run:
 
-        ./dockersetup.py -h
+   ```sh
+   ./dockersetup.py -h
+   ```
 
    Example command to run containers with a proxy and with a database to
    import:
 
-        ./dockersetup.py -d ~/databasedump.sql -p http://<proxyserver>:<port>
+   ```sh
+   ./dockersetup.py -d ~/databasedump.sql -p http://<proxyserver>:<port>
+   ```
 
-   NOTE: If you want email sending to work (required for user registration and
-   password resets), you should use the -e/--email-host option to specify your
+   **NOTE:** If you want email sending to work (required for user registration and
+   password resets), you should use the `-e`/`--email-host` option to specify your
    outgoing email server.
 
    During the setup you will be asked for a username, email and password to
    set up a super user for the database.
 
-3) Once the script completes, open a web browser and navigate to the URL
+3. Once the script completes, open a web browser and navigate to the URL
    printed out by the script. By default that would be: https://localhost:8081
 
-4) If you have chosen to not supply a prepopulated database and are instead
+4. If you have chosen to not supply a prepopulated database and are instead
    starting fresh, you should now follow the instructions in the
    "Database Setup" section of the main README.
 
-5) If you need to rerun this script for any reason a second time, you'll need
+5. If you need to rerun this script for any reason a second time, you'll need
    to choose between two modes:
 
-   A) Updating (-u/--update) - updates the code and runs any database upgrades
+   1. Updating (`-u`/`--update`) - updates the code and runs any database upgrades
       if applicable, or
 
-   B) Reinstalling (-r/--reinstall) - deletes the containers and reinstalls
+   2. Reinstalling (`-r`/`--reinstall`) - deletes the containers and reinstalls
       from scratch. Be warned that this will throw away all data in the
       database.
 
-   Note that updating with -u/--update will only work if the configuration
-   changes originally made by dockersetup.py upon installation (e.g. passwords,
+   Note that updating with `-u`/`--update` will only work if the configuration
+   changes originally made by `dockersetup.py` upon installation (e.g. passwords,
    hostname, etc.) are still present in the source tree. The generated
-   passwords and secret key are written to .env.local.* files, which git
+   passwords and secret key are written to `.env.local.*` files, which git
    ignores; keep them, and do not commit them.
 
-Environment files:
+### Environment files
 
 The containers read their settings (secret key, database and RabbitMQ
-credentials, email server, DEBUG) from .env.<context>.<service> files, where
-<context> is dev, staging or prod and <service> is app, celery, db or rabbit:
+credentials, email server, `DEBUG`) from `.env.<context>.<service>` files, where
+`<context>` is `dev`, `staging` or `prod` and `<service>` is `app`, `celery`, `db` or `rabbit`:
 
-  - docker-compose.yml uses the .env.dev.* files, which hold development-only
-    values. dockersetup.py copies them to .env.local.*, fills in the secrets
-    it generates, and points docker-compose.yml at those copies.
-  - docker-compose.staging.yml and docker-compose.prod.yml use the
-    .env.staging.* and .env.prod.* files. Their secrets are commented out, so
-    nothing starts with a known password. Set the real values, and the
-    hostname in the compose file, in a local commit on the server and never
-    push them. Then run, for example:
+- `docker-compose.yml` uses the `.env.dev.*` files, which hold development-only
+  values. `dockersetup.py` copies them to `.env.local.*`, fills in the secrets
+  it generates, and points `docker-compose.yml` at those copies.
+- `docker-compose.staging.yml` and `docker-compose.prod.yml` use the
+  `.env.staging.*` and `.env.prod.*` files. Their secrets are commented out, so
+  nothing starts with a known password. Set the real values, and the
+  hostname in the compose file, in a local commit on the server and never
+  push them. Then run, for example:
 
-        docker compose -f docker-compose.prod.yml up -d --build
+  ```sh
+  docker compose -f docker-compose.prod.yml up -d --build
+  ```
 
-The .env* files are excluded from the Docker images.
+The `.env*` files are excluded from the Docker images.
 
 Other settings the app and celery files can set:
 
-  - DEBUG: 1, true or yes enables Django's debug mode; anything else, or
-    leaving it unset, keeps it off. Never enable it on a public site.
-  - ENABLE_RRS: 1 enables the Recipe Reporting System (see README.rrs.md).
-  - DATABASE_PORT (default 3306) and STATIC_ROOT (default
-    /usr/share/nginx/html/static/).
+- `DEBUG`: `1`, `true` or `yes` enables Django's debug mode; anything else, or
+  leaving it unset, keeps it off. Never enable it on a public site.
+- `ENABLE_RRS`: `1` enables the Recipe Reporting System (see [README.rrs.md](README.rrs.md)).
+- `DATABASE_PORT` (default `3306`) and `STATIC_ROOT` (default
+  `/usr/share/nginx/html/static/`).
 
-
-
-TROUBLESHOOTING:
+### Troubleshooting
 
 - Network issues behind a proxy when building container: On some systems
-  (particularly where dnsmasq is installed), /etc/resolv.conf is set to
+  (particularly where dnsmasq is installed), `/etc/resolv.conf` is set to
   127.0.0.x, rather than your local DNS server. Docker will look there for
   your DNS server, and when it fails to find it it will default to using a
   public one (frequently 8.8.8.8). Many corporate proxies blocks public DNS
   servers, so you will need to manually supply the DNS server to docker using
-  /etc/docker/daemon.json:
-
-        {"dns": ["xx.xx.xx.xx] }
+  `/etc/docker/daemon.json`:
 
+  ```json
+  {"dns": ["xx.xx.xx.xx] }
+  ```
 
 
-Database Setup
---------------
+## Database Setup
 
 Once the application is running you'll need to do a bit of further
 setup within it:
@@ -132,42 +134,46 @@ setup within it:
    need layer data. To import the full set for the master branch from the
    public instance at layers.openembedded.org you can run the following:
 
+   ```sh
    docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
+   ```
 
    Alternatively, you can populate the database manually -
    you'll need to add at least the openembedded-core layer to the
-   database, or some equivalent that contains conf/bitbake.conf for
+   database, or some equivalent that contains `conf/bitbake.conf` for
    the base system configuration. To add this, follow these steps:
 
-   1.1. With the server running, go to the admin page -
-        http://localhost:8080/admin/ by default (the hostname must
-        match what the web server is configured for i.e. what you
-        specified when running dockersetup.py). Use the login/password
-        for the admin account specified during setup.
-
-   1.2. Click on the "Submit Layer" button in the top right and
-        enter the details for the core layer. To use the real
-        openembedded-core layer, use these values:
-
-        Layer name:               openembedded-core
-        Layer type:               Base
-        Summary:                  Core metadata
-        Description:              Core metadata
-        Repository URL:           https://git.openembedded.org/openembedded-core
-        Repository subdirectory:  meta
-
-        Once you have filled in the required values, click on the
-        "Submit Layer" button.
-
-        NOTE: The name of the layer must be "openembedded-core",
-        unless you change CORE_LAYER_NAME in settings.py to match
-        whatever alternative name you use here.
-
-   1.3. The layer has been added but is not yet published. (For the
-        public index this provides some protection against spam and
-        malformed entries.) To publish it, click on the orange number
-        next to your login name at the top right, click on the
-        newly added layer entry, and then click on "Publish Layer".
+   1. With the server running, go to the admin page -
+      http://localhost:8080/admin/ by default (the hostname must
+      match what the web server is configured for i.e. what you
+      specified when running `dockersetup.py`). Use the login/password
+      for the admin account specified during setup.
+
+   2. Click on the "Submit Layer" button in the top right and
+      enter the details for the core layer. To use the real
+      openembedded-core layer, use these values:
+
+      | Field                   | Value                                            |
+      |-------------------------|--------------------------------------------------|
+      | Layer name              | `openembedded-core`                              |
+      | Layer type              | Base                                             |
+      | Summary                 | Core metadata                                    |
+      | Description             | Core metadata                                    |
+      | Repository URL          | `https://git.openembedded.org/openembedded-core` |
+      | Repository subdirectory | `meta`                                           |
+
+      Once you have filled in the required values, click on the
+      "Submit Layer" button.
+
+      **NOTE:** The name of the layer must be "openembedded-core",
+      unless you change `CORE_LAYER_NAME` in `settings.py` to match
+      whatever alternative name you use here.
+
+   3. The layer has been added but is not yet published. (For the
+      public index this provides some protection against spam and
+      malformed entries.) To publish it, click on the orange number
+      next to your login name at the top right, click on the
+      newly added layer entry, and then click on "Publish Layer".
 
 2. If you need to support multiple branches of OpenEmbedded/BitBake
    where some require Python 2.x and others require Python 3.x, then
@@ -186,69 +192,71 @@ setup within it:
 
 4. You may wish to customise some of the page templates to suit your
    installation, in particular:
-   * templates/base.html
-   * templates/layerindex/about.html
-
+   - `templates/base.html`
+   - `templates/layerindex/about.html`
 
 
-Updating OpenEmbedded data
---------------------------
+## Updating OpenEmbedded data
 
 You will likely want to update the OpenEmbedded layer information on a regular
 basis. To do that by fetching and parsing all layer repositories, run the
 following:
 
-   Incremental update:
+Incremental update:
 
-       docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py
+```sh
+docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py
+```
 
-   Reload all data (should only be needed if the database structure has
-   changed as part of an upgrade of the application code):
+Reload all data (should only be needed if the database structure has
+changed as part of an upgrade of the application code):
 
-       docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py -r
+```sh
+docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py -r
+```
 
 Alternatively, you can update the data from an existing layer index instance
 (as per above during setup):
 
-    docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
+```sh
+docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
+```
 
 
-
-Upgrading from an earlier version
----------------------------------
+## Upgrading from an earlier version
 
 To upgrade the Docker-based setup from a previous release, update the code
-(e.g. with git pull) and then run:
+(e.g. with `git pull`) and then run:
 
+```sh
 ./dockersetup.py -u
+```
 
 This will rebuild the containers and run any required database migrations.
 
-Installations set up by dockersetup.py before it used environment files
+Installations set up by `dockersetup.py` before it used environment files
 (see "Environment files" above) have their secret key and passwords in the
-environment sections of docker-compose.yml. Carry them over by hand once:
+environment sections of `docker-compose.yml`. Carry them over by hand once:
 
-1. Copy docker-compose.yml somewhere safe, then restore the tracked version
-   (git checkout docker-compose.yml) and update the code.
+1. Copy `docker-compose.yml` somewhere safe, then restore the tracked version
+   (`git checkout docker-compose.yml`) and update the code.
 
-2. For each of app, celery, db and rabbit, copy .env.dev.<service> to
-   .env.local.<service> and fill in the values from the matching service
-   in the old file: SECRET_KEY, DATABASE_USER, DATABASE_PASSWORD,
-   MYSQL_ROOT_PASSWORD, RABBITMQ_DEFAULT_USER, RABBITMQ_DEFAULT_PASS and any
-   EMAIL_* settings. Set DEBUG=0 in .env.local.app, and make the files
-   readable only by you (chmod 600 .env.local.*).
+2. For each of `app`, `celery`, `db` and `rabbit`, copy `.env.dev.<service>` to
+   `.env.local.<service>` and fill in the values from the matching service
+   in the old file: `SECRET_KEY`, `DATABASE_USER`, `DATABASE_PASSWORD`,
+   `MYSQL_ROOT_PASSWORD`, `RABBITMQ_DEFAULT_USER`, `RABBITMQ_DEFAULT_PASS` and any
+   `EMAIL_*` settings. Set `DEBUG=0` in `.env.local.app`, and make the files
+   readable only by you (`chmod 600 .env.local.*`).
 
-3. In docker-compose.yml, change the env_file entries from .env.dev.* to
-   .env.local.*, and reapply your other changes from the old file (hostname,
+3. In `docker-compose.yml`, change the `env_file` entries from `.env.dev.*` to
+   `.env.local.*`, and reapply your other changes from the old file (hostname,
    ports, certificate volumes and, if you use Let's Encrypt, the
-   layerscertbot service).
-
-4. Run ./dockersetup.py -u as above.
+   `layerscertbot` service).
 
+4. Run `./dockersetup.py -u` as above.
 
 
-Support for OE-Classic
-----------------------
+## Support for OE-Classic
 
 The Layer index optionally provides a means to index OE-Classic on a
 one-off import basis and then compare what was there to what you have
@@ -257,32 +265,40 @@ been migrated/superseded). If you want to enable this, do the following:
 
 1. From the admin interface, create a Branch record with the following
    values:
-     - Name: oe-classic (must be exactly this!)
-     - Bitbake branch: 1.12
-     - Enable updates: NOT ticked
-     - Comparison: ticked
-     - Update environment: if you have set up Python environments (for
-       python2 vs python3 across different branches) then you'll need
-       to select the python2 environment that you created here
+   - Name: `oe-classic` (must be exactly this!)
+   - Bitbake branch: `1.12`
+   - Enable updates: NOT ticked
+   - Comparison: ticked
+   - Update environment: if you have set up Python environments (for
+     python2 vs python3 across different branches) then you'll need
+     to select the python2 environment that you created here
 
 2. Clone OE-Classic somewhere locally on the machine running the
    layer index:
 
+   ```sh
    git clone https://git.openembedded.org/openembedded
+   ```
 
 3. Clone a bitbake somewhere locally and check out the 1.12 branch:
 
+   ```sh
    git clone https://git.openembedded.org/bitbake -b 1.12
+   ```
 
-4. Run import_classic.py, specifying the path to OE-Classic and
+4. Run `import_classic.py`, specifying the path to OE-Classic and
    the bitbake you checked out:
 
+   ```sh
    layerindex/tools/import_classic.py /path/to/bitbake112 /path/to/oeclassic
+   ```
 
 5. Update the migration status of OE-Classic recipes based on other
    layers in the database:
 
+   ```sh
    layerindex/tools/update_classic_status.py
+   ```
 
 If you refresh the main page of the website, the OE-Classic data should
 now show up at the bottom of the branch drop-down menu. On a periodic
@@ -291,13 +307,11 @@ new recipes are brought across (or replacements are created). Users with
 sufficient permissions can also manually update the migration status on
 the OE-Classic recipe detail pages within the website, which is useful
 for example when there's a replacement recipe in another layer that
-doesn't have the same name, so the update_classic_status.py script
+doesn't have the same name, so the `update_classic_status.py` script
 wouldn't be able to pick it up.
 
 
-
-Setting up other distro comparisons
------------------------------------
+## Setting up other distro comparisons
 
 The Layer Index also provides optional functionality to enable comparison
 with other distributions (currently RPM-based only) in a similar manner to
@@ -306,48 +320,54 @@ the following steps:
 
 1. From the admin interface, set up the appropriate entries:
 
-   1.1. Create a Branch with the following values:
-        - Bitbake branch: <any dummy value>
-        - Enable updates: NOT enabled
-        - Comparison: enabled
+   1. Create a Branch with the following values:
+      - Bitbake branch: `<any dummy value>`
+      - Enable updates: NOT enabled
+      - Comparison: enabled
 
-   1.2. Create a Layer. Typically this would have the same name as
-        the branch although that is not a requirement. The "Comparison"
-        checkbox should be ticked. If the packages are in separate
-        repositories (one per package, as is typical in RPM-based
-        distributions such as Fedora) then in order to make the links
-        through to files work correctly you may need to use repository web
-        interface URLs similar to these:
+   2. Create a Layer. Typically this would have the same name as
+      the branch although that is not a requirement. The "Comparison"
+      checkbox should be ticked. If the packages are in separate
+      repositories (one per package, as is typical in RPM-based
+      distributions such as Fedora) then in order to make the links
+      through to files work correctly you may need to use repository web
+      interface URLs similar to these:
 
-        Repository web interface tree base URL:
-          https://github.com/organisationname/%pathelement[0]%/tree/master/%pathelement[1:]%
-        Repository web interface file base URL:
-          https://github.com/organisationname/%pathelement[0]%/blob/master/%pathelement[1:]%
+      - Repository web interface tree base URL:
+        `https://github.com/organisationname/%pathelement[0]%/tree/master/%pathelement[1:]%`
+      - Repository web interface file base URL:
+        `https://github.com/organisationname/%pathelement[0]%/blob/master/%pathelement[1:]%`
 
-   1.3. Create a LayerBranch to link the Branch and Layer that you
-        created in the previous steps. You don't need to enter anything
-        special here.
+   3. Create a LayerBranch to link the Branch and Layer that you
+      created in the previous steps. You don't need to enter anything
+      special here.
 
 2. Run the import script, specifying the branch and layer names and the path
    to the base of the packages (where each subdirectory contains a package,
    notably a spec file describing the package):
 
+   ```sh
    layerindex/tools/import_otherdistro.py import-pkgspec <branchname> <layername> <pkgpath>
+   ```
 
 3. Update the comparison status of recipes based on layers in the database:
 
+   ```sh
    layerindex/tools/update_classic_status.py -l <layername> -b <branchname>
+   ```
 
-4. Optionally enable the Update button in the UI by setting COMPARISON_UPDATE
-   in settings.py to map each other distro branch to the command that should
+4. Optionally enable the Update button in the UI by setting `COMPARISON_UPDATE`
+   in `settings.py` to map each other distro branch to the command that should
    be run in the background when the button is pressed. For example:
 
-COMPARISON_UPDATE = [
-    {
-        'branch_name': 'otherlinux',
-        'update_command': 'layerindex/tools/import_otherdistro.py import-pkgspec otherlinux otherlinux /path/to/pkgs -u %update%; layerindex/tools/update_classic_status.py -b otherlinux -l otherlinux -u %update%',
-    },
-]
+   ```python
+   COMPARISON_UPDATE = [
+       {
+           'branch_name': 'otherlinux',
+           'update_command': 'layerindex/tools/import_otherdistro.py import-pkgspec otherlinux otherlinux /path/to/pkgs -u %update%; layerindex/tools/update_classic_status.py -b otherlinux -l otherlinux -u %update%',
+       },
+   ]
+   ```
 
 If you refresh the main page of the website, the other distro data should
 now show up at the bottom of the branch drop-down menu. On a periodic
@@ -355,7 +375,7 @@ basis you can repeat steps 2 and 3 to refresh the data as changes occur on
 both sides. Users with sufficient permissions can also manually update the
 migration status on the other distro recipe detail pages within the website,
 which is useful for example when there's an equivalent recipe in another
-layer that doesn't have the same name, so the update_classic_status.py
+layer that doesn't have the same name, so the `update_classic_status.py`
 script wouldn't be able to pick it up.
 
 If you want to show links to additional upstream pages associated with
@@ -364,30 +384,32 @@ for each type of link you want to be shown. For example, Fedora provides
 a summary page for each package - acl's one is at
 https://apps.fedoraproject.org/packages/acl, so you would create a
 Layer Recipe Extra URL entry with the template URL
-"https://apps.fedoraproject.org/packages/%pn%" and then links would be
+`https://apps.fedoraproject.org/packages/%pn%` and then links would be
 shown for this under the detail page for each package in the other distro.
 If you have the rrs application enabled the link will also be shown in the
 "Distros" section of the maintenance detail page for the covering recipe.
 
 
-
-Security Considerations
------------------------
+## Security Considerations
 
 Some things to be aware of from a security perspective:
 
-* By default, anyone can register themselves an account. If you wish to
+- By default, anyone can register themselves an account. If you wish to
   disable new user registration and manage users manually through the admin
-  interface instead, then add the following line to docker/settings.py:
+  interface instead, then add the following line to `docker/settings.py`:
 
-REGISTRATION_OPEN = False
+  ```python
+  REGISTRATION_OPEN = False
+  ```
 
-  Then, assuming you have already run dockersetup.py to install the
+  Then, assuming you have already run `dockersetup.py` to install the
   application, run the following command to update it:
 
-./dockersetup.py -u
+  ```sh
+  ./dockersetup.py -u
+  ```
 
-* By default, dockersetup.py enables connection to the web server via
+- By default, `dockersetup.py` enables connection to the web server via
   HTTPS using a self-signed certificate; connections via HTTP are
   re-directed to HTTPS. However, the self-signed certificate is only
   intended to provide a minimum level of security, but will result in
@@ -397,19 +419,21 @@ REGISTRATION_OPEN = False
   or alternatively if the application is accessible to the internet you
   can use Let's Encrypt.
 
-* If you provide your own certificates for HTTPS, you should probably
+- If you provide your own certificates for HTTPS, you should probably
   also enable HSTS in your configuration. Refer to the Django Security
   guide for details on how to do that:
 
   https://docs.djangoproject.com/en/stable/topics/security/#ssl-https
 
-* To reset a forgotten account password, you can either use the password
-  reset function ( /accounts/password_reset/ ) or alternatively from the
+- To reset a forgotten account password, you can either use the password
+  reset function (`/accounts/password_reset/`) or alternatively from the
   backend you can run the following command:
 
+  ```sh
   docker-compose exec layersapp /opt/layerindex/manage.py changepassword <username>
+  ```
 
-* The web-based password reset function will ask the user answers to
+- The web-based password reset function will ask the user answers to
   security questions they selected and answered when they created the
   account. Admins can configure the selectable security questions in
   the admin interface under "Security questions"; however, be cautious
@@ -426,22 +450,24 @@ REGISTRATION_OPEN = False
   into the application and then going to Edit Profile on the top-right
   user drop-down menu.
 
-* Security question answers are stored using the same mechanism as
+- Security question answers are stored using the same mechanism as
   for passwords, i.e. a secure one-way hash; thus answers cannot be
   retrieved from the database once set. Additionally, if a user wants
   to change one of their answers via the Edit Profile function, they
   will be required to re-specify all of them.
 
-* Account lockout: this application will lock out the user in two ways:
+- Account lockout: this application will lock out the user in two ways:
 
   - By IP address (using django-axes) after too many invalid login attempts.
     (default 4, resets after an hour). The lockout can be removed
     immediately using the following command:
 
+    ```sh
     docker-compose exec layersapp /opt/layerindex/manage.py axes_reset
+    ```
 
     If you wish to disable this, remove or comment out "axes" in
-    INSTALLED_APPS. For more information on configuring axes, see:
+    `INSTALLED_APPS`. For more information on configuring axes, see:
 
     https://django-axes.readthedocs.io/en/latest/
 
@@ -449,46 +475,44 @@ REGISTRATION_OPEN = False
     this lockout, log into the admin interface, go to Users, click on the
     the user, tick the Active checkbox and then save.
 
-* The REST API inherited from the OpenEmbedded layerindex upon which this
+- The REST API inherited from the OpenEmbedded layerindex upon which this
   application is based has been disabled, since it has no access controls
   on querying data (since the OE layer index operates entirely on publicly
   accessible information, whereas this application may not in actual usage).
 
 
-
-Backup and restore
-------------------
+## Backup and restore
 
 To back up the database within the docker-based setup, you can run the
-following command (no need to substitute ${MYSQL_ROOT_PASSWORD}, it's
+following command (no need to substitute `${MYSQL_ROOT_PASSWORD}`, it's
 already present within the container environment):
 
+```sh
 docker-compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root --password=${MYSQL_ROOT_PASSWORD} --max_allowed_packet=512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
+```
 
 To restore one of these backups you would run the following command (take
 care, this will overwrite the data immediately without prompting!):
 
+```sh
 zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c '/usr/bin/mariadb -u root --password=${MYSQL_ROOT_PASSWORD} layersdb'
+```
 
 
-
-Maintenance
------------
+## Maintenance
 
 The code for this application is maintained by the Yocto Project.
 
 The latest version of the code can always be found here:
 
-  https://git.yoctoproject.org/layerindex-web/
+https://git.yoctoproject.org/layerindex-web/
 
 Contributions are welcome. Please send patches / pull requests to
 yocto-patches@lists.yoctoproject.org with '[layerindex-web]' in the
 subject.
 
 
-
-License
--------
+## License
 
 This application is based upon the Django project template, whose files
 are covered by the BSD license and are copyright (c) Django Software
@@ -508,5 +532,4 @@ under the MIT license.
 
 All other content is copyright (C) 2013-2019 Intel Corporation and
 licensed under the MIT license (unless otherwise noted) - see
-COPYING.MIT for details.
-
+[COPYING.MIT](COPYING.MIT) for details.
diff --git a/README.rrs.md b/README.rrs.md
index b6e3724..7850656 100644
--- a/README.rrs.md
+++ b/README.rrs.md
@@ -1,51 +1,51 @@
-Recipe Reporting System
-=======================
+# Recipe Reporting System
 
 Recipe reporting system is a web-based application that provides information
 about recipe maintenance for OpenEmbedded layers, tracking how up-to-date each
 recipe is per recipe. It is an add-on for the OpenEmbedded layer index
 application.
 
-Setup
------
+## Setup
 
-NOTE: Currently the only supported database backend is MySQL (or MariaDB)
+**NOTE:** Currently the only supported database backend is MySQL (or MariaDB)
 version 10.2 or newer, due to some raw SQL usage for performance reasons.
 This requirement may be removed in future.
 
 Setup procedure:
 
-1. Follow the layer index setup instructions in the README.md file first.
+1. Follow the layer index setup instructions in the [README.md](README.md) file first.
    The openembedded-core layer (or whatever replacement you have pointed
-   CORE_LAYER_NAME to in settings.py) must be present in order to run the
+   `CORE_LAYER_NAME` to in `settings.py`) must be present in order to run the
    Recipe Reporting System database migrations.
 
-2. Edit settings.py:
+2. Edit `settings.py`:
 
-   * Add 'rrs' to INSTALLED_APPS. In the Docker-based setup, set
-     ENABLE_RRS=1 in the app and celery environment files instead (see
-     "Environment files" in README.md)
+   - Add `'rrs'` to `INSTALLED_APPS`. In the Docker-based setup, set
+     `ENABLE_RRS=1` in the app and celery environment files instead (see
+     "Environment files" in [README.md](README.md))
 
-   * Configure TOOLS_LOG_DIR if you wish the logs to be written somewhere
+   - Configure `TOOLS_LOG_DIR` if you wish the logs to be written somewhere
      other than the current directory when the scripts are run
 
-3. Uncomment the include lines in conf/local.conf.
+3. Uncomment the include lines in `conf/local.conf`.
 
 4. Run database migrations:
 
-$ python3 manage.py migrate rrs
+   ```sh
+   python3 manage.py migrate rrs
+   ```
 
 5. Set up the maintenance plan. A "default" plan will likely have been
    created during upgrade, you can use this if it's there, otherwise create
    one. Ensure that you set the following:
 
-   * "Enable updates" should be ticked
+   - "Enable updates" should be ticked
 
-   * Have at least one layer branch against the plan (lower part of the admin
+   - Have at least one layer branch against the plan (lower part of the admin
      page for the plan). You should select the master or equivalent branch
      for each layer.
 
-   * If you are importing history earlier than the Python 3 switchover, and
+   - If you are importing history earlier than the Python 3 switchover, and
      you are using virtualenv or have some other environmental requirement
      for different python versions, you'll need to set up a Python Environment
      record for Python 2 and Python 3 (or reuse the ones you've set up for
@@ -54,11 +54,13 @@ $ python3 manage.py migrate rrs
 
 6. For the first run, regenerate recipe upgrade information:
 
-$ ./layerindex/update.py
-$ ./rrs/tools/rrs_maintainer_history.py -d
-$ ./rrs/tools/rrs_upgrade_history.py -d
-$ ./rrs/tools/rrs_upstream_history.py -d
-$ ./rrs/tools/rrs_distros.py -d
+   ```sh
+   ./layerindex/update.py
+   ./rrs/tools/rrs_maintainer_history.py -d
+   ./rrs/tools/rrs_upgrade_history.py -d
+   ./rrs/tools/rrs_upstream_history.py -d
+   ./rrs/tools/rrs_distros.py -d
+   ```
 
-7. Configure cron to run daily update, set rrs_dir and venv_activate in
-   rrs/tools/daily_run.sh.
+7. Configure cron to run daily update, set `rrs_dir` and `venv_activate` in
+   `rrs/tools/daily_run.sh`.
diff --git a/README.vscode.md b/README.vscode.md
index db72329..bb4ea89 100644
--- a/README.vscode.md
+++ b/README.vscode.md
@@ -1,50 +1,49 @@
-VSCode + DevContainers Setup
-----------------------------
+## VSCode + DevContainers Setup
 
 If you already use VSCode and Docker, you can setup the local development
 environment using preconfigured DevContainers extension.
 
-Getting Started
----------------
+## Getting Started
 
-1. Install Dev Containers extension (ms-vscode-remote.remote-containers)
+1. Install Dev Containers extension (`ms-vscode-remote.remote-containers`)
 2. Open local clone of this repository in VSCode
 3. Click on "Reopen in Container" when prompted by VSCode
 4. Wait 1-2 minutes for VSCode to setup your DevContainer
 
 Once the DevContainer setup process is completed, you'll have access to:
 
-* Django development server running at http://localhost:8000
-* All Django database migrations applied
-* PyTest autodiscovery and debugger configured
-* Database client extension configured with the local server
-* Code linting and formatting with ruff
-* Command line git support with your SSH keys mounted in the container
+- Django development server running at http://localhost:8000
+- All Django database migrations applied
+- PyTest autodiscovery and debugger configured
+- Database client extension configured with the local server
+- Code linting and formatting with ruff
+- Command line git support with your SSH keys mounted in the container
 
-FAQ
----
+## FAQ
 
-1.  How do I import master branch from the public instance?
+1. How do I import master branch from the public instance?
 
-    Run the following command in the VSCode Terminal:
+   Run the following command in the VSCode Terminal:
 
-    $ layerindex/tools/import_layers.py https://layers.openembedded.org
+   ```sh
+   layerindex/tools/import_layers.py https://layers.openembedded.org
+   ```
 
+2. How do I see emails sent by the development system?
 
-2.  How do I see emails sent by the development system?
+   Emails are logged to the standard output of the layerindex-web container.
 
-    Emails are logged to the standard output of the layerindex-web container.
+   To see the logs:
 
-    To see the logs:
+   1. Open the Command Palette: Ctrl+Shift+P / Cmd+Shift+P
+   2. Type: "Remote Explorer: Focus on Dev Containers View"
+   3. Right-click on the layerindex-web container
+   4. Select "Show Container Log"
 
-    1. Open the Command Palette: Ctrl+Shift+P / Cmd+Shift+P
-    2. Type: "Remote Explorer: Focus on Dev Containers View"
-    3. Right-click on the layerindex-web container
-    4. Select "Show Container Log"
+3. How do I interact with Django's `manage.py` script?
 
+   Open a new terminal window in VSCode and type:
 
-3.  How do I interact with Django's manage.py script?
-
-    Open a new terminal window in VSCode and type:
-
-    $ ./manage.py ...
\ No newline at end of file
+   ```sh
+   ./manage.py ...
+   ```
-- 
2.56.0


