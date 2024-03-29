Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.12856.1711702976323822237
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 Mar 2024 02:02:56 -0700
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42T8eXQB000824
	for <yocto-patches@lists.yoctoproject.org>; Fri, 29 Mar 2024 09:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=7XLr7JzitHe3hqAp88nhX66zkdqLQH7m7iU0X1XN9ss=; b=
	ELxkjriOlGwgDMTOFbHxhGK1gPSWp2+zo95AbFQvBvhXsTmG4BMqU25SbHk4PeC8
	A0RDIaAnmNt2RDkxtUZwgyhJZYp92kbRhgx4PCtRt6KpWFEkxdHEMOKY/n8M6beH
	oSxhzT3hdyYJAW0jEq2GPYJKxqX1hBErLH9fNYVdWkA5aY3yNXxSmNzQwCirQY27
	aAMiPeq0E22nmBOqdm1TJ3CN6v2eX6m2pEJn7pRDcVkjpgpgZTiNpxyaOtAYdBwD
	oZYBmtmBd8EVeVSLN4MK6BNi5mIiSbLH65HRxRx5vgDQ69ppiyaEz04DXcvOqs6C
	Tw2hSi4MI6mXPYoaSieY6w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x1p26r0ap-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 29 Mar 2024 09:02:55 +0000 (GMT)
From: "Changqing Li" <changqing.li@eng.windriver.com>
Subject: [error-report-web][PATCH 2/2] Dockerizing error-report-web
Date: Fri, 29 Mar 2024 17:02:52 +0800
Message-ID: <20240329090252.4165596-2-changqing.li@windriver.com>
In-Reply-To: <20240329090252.4165596-1-changqing.li@windriver.com>
References: <20240329090252.4165596-1-changqing.li@windriver.com>
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
 .env                       |   5 +
 Dockerfile                 |  17 +++
 docker-compose.yaml        |  36 +++++++
 project/settings.py.docker | 210 +++++++++++++++++++++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 .env
 create mode 100644 Dockerfile
 create mode 100644 docker-compose.yaml
 create mode 100644 project/settings.py.docker

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
diff --git a/docker-compose.yaml b/docker-compose.yaml
new file mode 100644
index 0000000..5ef4913
--- /dev/null
+++ b/docker-compose.yaml
@@ -0,0 +1,36 @@
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
diff --git a/project/settings.py.docker b/project/settings.py.docker
new file mode 100644
index 0000000..8ba0b55
--- /dev/null
+++ b/project/settings.py.docker
@@ -0,0 +1,210 @@
+# SPDX-License-Identifier: MIT
+#
+# Django settings for error-reporting-tool project.
+# Based on settings.py from the Django project template
+# Copyright (c) Django Software Foundation and individual contributors.
+
+import os
+
+DEBUG = True
+TEMPLATE_DEBUG = DEBUG
+
+ADMINS = (
+    # ('Your Name', 'your_email@example.com'),
+)
+
+MANAGERS = ADMINS
+
+DATABASES = {
+    'default': {
+        'ENGINE': 'django.db.backends.mysql',
+        'NAME': os.environ.get('MYSQL_DATABASE'),
+        'USER': os.environ.get('MYSQL_USER'),
+        'PASSWORD': os.environ.get('MYSQL_PASSWORD'),
+        'HOST': os.environ.get('DB_HOST', 'db'),
+        'PORT': os.environ.get('DB_PORT', '3306'),
+    }
+}
+
+
+# Uncomment to add a tab in the UI which is similar to the latest errors page
+# but all queries on it are additionally filtered by the submitter being the
+# string defined below.
+#
+# SPECIAL_SUBMITTER = {
+#     'name' : "yocto-autobuilder", # Submitter name to filter on
+#     'title' : "Autobuilder", # Title that is displayed
+#     'link' : "Autobuilder", # Must be valid for a url
+# }
+
+# Maximum upload size for the payload send by send-error-rpoert
+MAX_UPLOAD_SIZE = "5242880"
+
+# Tolerance value to determine the distance between similar errors
+SIMILAR_FAILURE_DISTANCE = 10
+
+
+# Local time zone for this installation. Choices can be found here:
+# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
+# although not all choices may be available on all operating systems.
+# In a Windows environment this must be set to your system time zone.
+TIME_ZONE = 'America/Chicago'
+
+# Language code for this installation. All choices can be found here:
+# http://www.i18nguy.com/unicode/language-identifiers.html
+LANGUAGE_CODE = 'en-us'
+
+SITE_ID = 1
+
+# If you set this to False, Django will make some optimizations so as not
+# to load the internationalization machinery.
+USE_I18N = True
+
+# If you set this to False, Django will not format dates, numbers and
+# calendars according to the current locale.
+USE_L10N = True
+
+# If you set this to False, Django will not use timezone-aware datetimes.
+USE_TZ = True
+
+# Absolute filesystem path to the directory that will hold user-uploaded files.
+# Example: "/home/media/media.lawrence.com/media/"
+
+CURRENT_PATH = os.getcwd()
+TEMPLATES_PATH = CURRENT_PATH + "/templates"
+
+MEDIA_ROOT = TEMPLATES_PATH
+
+# URL that handles the media served from MEDIA_ROOT. Make sure to use a
+# trailing slash.
+# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
+MEDIA_URL = ''
+
+# Absolute path to the directory static files should be collected to.
+# Don't put anything in this directory yourself; store your static files
+# in apps' "static/" subdirectories and in STATICFILES_DIRS.
+# Example: "/home/media/media.lawrence.com/static/"
+STATIC_ROOT = ''
+
+# URL prefix for static files.
+# Example: "http://media.lawrence.com/static/"
+STATIC_URL = '/static/'
+
+STATICFILES_DIRS = (
+    # Put strings here, like "/home/html/static" or "C:/www/django/static".
+    # Always use forward slashes, even on Windows.
+    # Don't forget to use absolute paths, not relative paths.
+    CURRENT_PATH + "/Post/static",
+)
+
+# List of finder classes that know how to find static files in
+# various locations.
+STATICFILES_FINDERS = (
+    'django.contrib.staticfiles.finders.FileSystemFinder',
+    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
+    # 'django.contrib.staticfiles.finders.DefaultStorageFinder',
+)
+
+# Make this unique, and don't share it with anybody.
+SECRET_KEY = 'changeme'
+
+# List of callables that know how to import templates from various sources.
+TEMPLATE_LOADERS = (
+    'django.template.loaders.filesystem.Loader',
+    'django.template.loaders.app_directories.Loader',
+    # 'django.template.loaders.eggs.Loader',
+)
+
+MIDDLEWARE = [
+    'django.middleware.common.CommonMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.middleware.csrf.CsrfViewMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+    'django.contrib.auth.middleware.AuthenticationMiddleware',
+    'django.contrib.messages.middleware.MessageMiddleware',
+    # Uncomment the next line for simple clickjacking protection:
+    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
+]
+
+ROOT_URLCONF = 'project.urls'
+
+# Python dotted path to the WSGI application used by Django's runserver.
+WSGI_APPLICATION = 'project.wsgi.application'
+
+TEMPLATES = [
+    {
+        "BACKEND": "django.template.backends.django.DjangoTemplates",
+        "DIRS": [CURRENT_PATH + "/templates"],
+        "APP_DIRS": True,
+        "OPTIONS": {
+            'context_processors': [
+                'django.template.context_processors.debug',
+                'django.template.context_processors.request',
+                'django.contrib.auth.context_processors.auth',
+                'django.contrib.messages.context_processors.messages',
+            ],
+       },
+    },
+]
+
+INSTALLED_APPS = (
+    'django.contrib.auth',
+    'django.contrib.contenttypes',
+    'django.contrib.sessions',
+    'django.contrib.sites',
+    'django.contrib.messages',
+    'django.contrib.staticfiles',
+    'Post',
+    # Uncomment the next line to enable the admin:
+    'django.contrib.admin',
+    # Uncomment the next line to enable admin documentation:
+    'django.contrib.admindocs',
+    # 'registration',
+    )
+
+# A sample logging configuration. The only tangible logging
+# performed by this configuration is to send an email to
+# the site admins on every HTTP 500 error when DEBUG=False.
+# See http://docs.djangoproject.com/en/dev/topics/logging for
+# more details on how to customize your logging configuration.
+LOGGING = {
+    'version': 1,
+    'disable_existing_loggers': False,
+    'filters': {
+        'require_debug_false': {
+            '()': 'django.utils.log.RequireDebugFalse'
+        }
+    },
+    'handlers': {
+        'mail_admins': {
+            'level': 'ERROR',
+            'filters': ['require_debug_false'],
+            'class': 'django.utils.log.AdminEmailHandler'
+        }
+    },
+    'loggers': {
+        'django.request': {
+            'handlers': ['mail_admins'],
+            'level': 'ERROR',
+            'propagate': True,
+        },
+    }
+}
+
+TEMPLATE_CONTEXT_PROCESSORS = (
+  'django.contrib.auth.context_processors.auth',
+  'django.core.context_processors.request',
+  'Post.views.common_context',
+)
+
+AUTH_PROFILE_MODULE = 'registration.RegistrationProfile'
+
+BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
+
+ACCOUNT_ACTIVATION_DAYS = 2
+EMAIL_HOST = 'localhost'
+DEFAULT_FROM_EMAIL = 'noreply@example.com'
+LOGIN_REDIRECT_URL = '/Errors'
+
+TEST_RUNNER = 'django.test.runner.DiscoverRunner'
+DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
-- 
2.34.1

