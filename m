Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.97408.1712543185816376547
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 07 Apr 2024 19:26:26 -0700
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4382016n016174
	for <yocto-patches@lists.yoctoproject.org>; Mon, 8 Apr 2024 02:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=jmWOMjKwCCIysCkRM5p6UTK80kJmkEmTKlBlmRmdQ5k=; b=
	h2D+W06yCOTWRfDKaCfib0JO8rovZYw0xAlCbTp9IQl0Mi5xHJK2/uN0FmkKt0R5
	QBzzNttURl2gipX1z1Artml3K+V5HEr71lwXt9pKi0H6wAaRl+cyQOA3dK2xfoCA
	/cGCf9g/7550dvrUk7hXGarsuQwIZCUpF0LEfsGDt/v3zdkiJBM+moT5Wcj40x4p
	vKGY1oJSGZiltkZKAiTiPJXdpjThXHDTRCT3wboGW+qCIs/NkaFE1JkM9MhpILQW
	fU89pJfQDqL+YzOnsJjYvYonGOL3fpenPvIHEd72ULVTJvijhKSpLqxSKJtV2kmq
	R3zDuhQUenOpGCBGCFYS1w==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xawc6h8v5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Apr 2024 02:26:24 +0000 (GMT)
From: "Changqing Li" <changqing.li@eng.windriver.com>
Subject: [error-report-web][PATCH V2 2/2] Dockerizing error-report-web
Date: Mon, 8 Apr 2024 10:26:21 +0800
Message-ID: <20240408022621.3124140-2-changqing.li@windriver.com>
In-Reply-To: <20240408022621.3124140-1-changqing.li@windriver.com>
References: <20240408022621.3124140-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

From: Changqing Li <changqing.li@windriver.com>

Follow steps to test:
1. docker-compose build
2. docker-compose up
3. docker-compose run backend /app/test-data/test-send-error.py http://localhost:8000/ClientPost/JSON/ /app/test-data/test-payload.json

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 .env                                        |  5 +++
 Dockerfile                                  | 17 +++++++++
 README                                      |  7 ++--
 docker-compose.yaml                         | 38 +++++++++++++++++++++
 project/settings.py                         | 20 +++++------
 project/{settings.py => settings.py.docker} | 18 ++++------
 project/{settings.py => settings.py.host}   |  0
 7 files changed, 78 insertions(+), 27 deletions(-)
 create mode 100644 .env
 create mode 100644 Dockerfile
 create mode 100644 docker-compose.yaml
 copy project/{settings.py => settings.py.docker} (93%)
 copy project/{settings.py => settings.py.host} (100%)

diff --git a/.env b/.env
new file mode 100644
index 0000000..a6ea41c
--- /dev/null
+++ b/.env
@@ -0,0 +1,5 @@
+# MySQL settings
+MYSQL_ROOT_PASSWORD=root
+MYSQL_DATABASE=errorreport_db
+MYSQL_USER=errorreport
+MYSQL_PASSWORD=errorreport
diff --git a/Dockerfile b/Dockerfile
new file mode 100644
index 0000000..080befc
--- /dev/null
+++ b/Dockerfile
@@ -0,0 +1,17 @@
+# Use an official Python runtime as a parent image
+FROM python:3.10
+
+# Set environment variables
+ENV PYTHONDONTWRITEBYTECODE 1
+ENV PYTHONUNBUFFERED 1
+
+# Set the working directory
+WORKDIR /app
+
+# Install dependencies
+COPY requirements.txt /app/
+RUN pip install -r requirements.txt
+
+# Copy the project code into the container
+COPY . /app/
+RUN cp -rf /app/project/settings.py.docker /app/project/settings.py
diff --git a/README b/README
index d56fdbd..35c11a7 100644
--- a/README
+++ b/README
@@ -22,9 +22,10 @@ Setup instructions:
 
 1. Initialise and activate a python virtual environment. `virtualenv venv && source ./venv/bin/activate`
 2. Install the dependencies via `pip install -r requirements.txt`
-3. Set DATABASES.default.ENGINE in settings.py to use the database engine of your choice.
-4. Set a SECRET_KEY in settings.py
-5. Setup the database schema with the Django model. Run `python manage.py migrate`.
+3. cp settings.py.host settings.py
+4. Set DATABASES.default.ENGINE in settings.py to use the database engine of your choice.
+5. Set a SECRET_KEY in settings.py
+6. Setup the database schema with the Django model. Run `python manage.py migrate`.
 
 
 Usage
diff --git a/docker-compose.yaml b/docker-compose.yaml
new file mode 100644
index 0000000..642fa89
--- /dev/null
+++ b/docker-compose.yaml
@@ -0,0 +1,38 @@
+version: '3'
+services:
+  db:
+    image: mysql:8.0.36
+    container_name: error_report_web_db
+    restart: always
+    volumes:
+      - data:/var/lib/mysql
+    environment:
+      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
+      MYSQL_DATABASE: ${MYSQL_DATABASE}
+      MYSQL_USER: ${MYSQL_USER}
+      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
+    ports:
+      - "3306:3306"
+    healthcheck:
+      test: ["CMD", "mysql", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}", "-e", "SELECT 1"]
+      timeout: 20s
+      retries: 10
+  
+  backend:
+    build: 
+      context: .
+      dockerfile: Dockerfile
+    container_name: error_report_web_backend
+    command: sh -c "python3 manage.py migrate --noinput && python3 manage.py runserver 0.0.0.0:8000"
+    volumes:
+      - .:/app
+    restart: always
+    ports:
+      - "8000:8000"
+    env_file:
+      - .env
+    depends_on:
+      db:
+         condition: service_healthy
+volumes:
+  data:
diff --git a/project/settings.py b/project/settings.py
index a0697ea..9d503d0 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -17,18 +17,12 @@ MANAGERS = ADMINS
 
 DATABASES = {
     'default': {
-        # exmplae backends: 'postgresql_psycopg2', 'mysql', 'sqlite3'
-        # or 'oracle'.
-        'ENGINE': 'django.db.backends.sqlite3',
-        # Or path to database file if using sqlite3.
-        'NAME': 'error-report-db.sqlite3',
-        # Not used with sqlite3.
-        'USER': '',
-        'PASSWORD': '',
-        # Set to empty string for localhost.
-        'HOST': '',
-        # Set to empty string for default.
-        'PORT': '',
+        'ENGINE': 'django.db.backends.mysql',
+        'NAME': os.environ.get('MYSQL_DATABASE'),
+        'USER': os.environ.get('MYSQL_USER'),
+        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
+        'HOST': os.environ.get('DB_HOST', 'db'),
+        'PORT': os.environ.get('DB_PORT', '3306'),
     }
 }
 
@@ -214,3 +208,5 @@ LOGIN_REDIRECT_URL = '/Errors'
 
 TEST_RUNNER = 'django.test.runner.DiscoverRunner'
 DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
+
+ALLOWED_HOSTS = ['*']
diff --git a/project/settings.py b/project/settings.py.docker
similarity index 93%
copy from project/settings.py
copy to project/settings.py.docker
index a0697ea..8ba0b55 100644
--- a/project/settings.py
+++ b/project/settings.py.docker
@@ -17,18 +17,12 @@ MANAGERS = ADMINS
 
 DATABASES = {
     'default': {
-        # exmplae backends: 'postgresql_psycopg2', 'mysql', 'sqlite3'
-        # or 'oracle'.
-        'ENGINE': 'django.db.backends.sqlite3',
-        # Or path to database file if using sqlite3.
-        'NAME': 'error-report-db.sqlite3',
-        # Not used with sqlite3.
-        'USER': '',
-        'PASSWORD': '',
-        # Set to empty string for localhost.
-        'HOST': '',
-        # Set to empty string for default.
-        'PORT': '',
+        'ENGINE': 'django.db.backends.mysql',
+        'NAME': os.environ.get('MYSQL_DATABASE'),
+        'USER': os.environ.get('MYSQL_USER'),
+        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
+        'HOST': os.environ.get('DB_HOST', 'db'),
+        'PORT': os.environ.get('DB_PORT', '3306'),
     }
 }
 
diff --git a/project/settings.py b/project/settings.py.host
similarity index 100%
copy from project/settings.py
copy to project/settings.py.host
-- 
2.34.1

