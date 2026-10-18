Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34DCCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:54:16 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7882.1792288448348807256
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:54:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=T0j/NAhx;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e86dce4510so4191805ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288448; x=1792893248; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbcP5fgaYhjgPtHy4NUs4GinnR41Rj7h3j/o0rN/RPI=;
        b=T0j/NAhxXLRU6A8UXoqSWMnVzTWVrVKCuJf3qxQ7LYt2O7Ns7vULgybT4xdO/JJht5
         yKtnzzy2Ank8GVL3tU8yQj2v4W8Wmk7Igd1oI4tPQcCOej+hYNqy/X+kDKv0SMaDnXVR
         J5JHzcS3bmKziTYpWX6nxSV56XlY2oYd3Zf+gH+rjAnfEMxcroPuWpB5OQtpaRt+IyxD
         DEs7xajaAc8/gat3EWGToJPa90RZGt1gKGoigLjn5m//CbipQAghyg8LumB3krI5elVo
         S3/JevDAxCMPpBD692y60263suWSSgFrmjeA1SalRfyoqB0axX+TSBCjEbbiPIEi2Ffz
         QNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288448; x=1792893248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbcP5fgaYhjgPtHy4NUs4GinnR41Rj7h3j/o0rN/RPI=;
        b=y12vYLnfUzD3L+x1aTcQmqbZI6uZs09JGuU0aBorD4vIBgJYpNz3TWZ0u0oLCzeJXx
         Mm9i4VGuvu29XKW8FLkkkML5zuxl+IR6tts9n8d8WHG2JpB3y9lmUJRF2C9iYIoTZwwD
         meQQQYrfnEIAuYf+RFf+p1Uwp42WVz8ON6yzI6eUqr0Y0+73m3ODlbO8wI1+EaVFvGVo
         IGgybemBiGFtxRaxqkNptl6t8uDEGxzZrVC9zL1wEyN7/QhBJRlsuCzN+uFZlWYVpe1P
         XtSu9h15Nv72G3t7ZZE59+/I+dv5SnxeovqeNzZ8fFNaGfJeOAUFFCdTw/uYhHBL8DqY
         SmQA==
X-Gm-Message-State: AFq9FYKv1o2IWd6cnM7KUEoEBBPWe1+Lz9MTtFqwxKMXenaxp3FYWGyZ
	MwWZR5o2HbijAtsV66bCKTd0SUTrwnWm5I7j87eY6Avih5aJ9VqxwRXozyCPfLiw
X-Gm-Gg: AYBFou2yaXK+E49TqTWYjnEd4+zZXfPTTcduu0ne65dodhtzsf93bRXhgZ46fcgu4J7
	DiBIbGFbFJ2/pAGeSYjXfQr50Jwux4DM15V7h84E7878R/BvLq5r8tCoSSUiPqdPSphxsvH0F0y
	w7no9Frjx0ic3VLVXfop0DKX6jBHUG9S1/7+/1u+u8lSUWrDmjzeJKFl5VnG8c0D8FmDXilWipC
	IEGBh4H50ljE1yNV27SJ42gwQt2t1diHtfoKiy771lnaXKt+/iHiuUKV7p7p87Le7JyDBVVc1lR
	S4/dDMTNTQTZVRt/UZFF9m+Jxyd/4AWn7ezSCnv0Fdhu4pjUZoVFEOHTrD+YGjzA3I0oZGC0zSg
	jGOaWbYUUhJpkJqzfQw5m9D88gZYTqqYvBqV85cGenbuHnXrsW/U+Na071TXxT6K0BgOWMD/+qQ
	wbVoprl9jotPHZfMXK/zofa2jt5NP6LXAbd7A5uGJ1bdU+e5yxZjvIkEewHsp/r3U8Gs6wlXUhP
	KYHGH/uNDfPH6WDrVB9qcWWNS27YCw=
X-Received: by 2002:a17:902:f60d:b0:2dd:ad73:c983 with SMTP id d9443c01a7336-2e9a69e8bb4mr31924795ad.27.1792288447527;
        Sat, 17 Oct 2026 18:54:07 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51b5sm24626155ad.8.2026.10.17.18.54.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:54:06 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/3] Remove the broken account pages.
Date: Sat, 17 Oct 2026 18:50:38 -0700
Message-ID: <20261018015326.73748-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015326.73748-1-tim.orling@konsulko.com>
References: <20261018015326.73748-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:54:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5056

Registration and activation returned 500, login 404, and the login
links were commented out. Nothing needs a login; the admin has its own.
Remove the URLs, templates, settings and django-registration.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/test.py                                  | 10 +++++++++
 project/settings.py                           |  3 ---
 project/settings.py.docker                    |  3 ---
 project/urls.py                               |  3 +--
 requirements.txt                              |  1 -
 templates/base.html                           | 21 -------------------
 templates/registration/activate.html          | 18 ----------------
 .../registration/activation_complete.html     | 14 -------------
 templates/registration/activation_email.txt   | 14 -------------
 .../registration/activation_email_subject.txt |  1 -
 templates/registration/login.html             | 18 ----------------
 templates/registration/logout.html            |  6 ------
 .../registration/password_change_done.html    |  6 ------
 .../registration/password_change_form.html    | 11 ----------
 .../registration/password_reset_complete.html | 10 ---------
 .../registration/password_reset_confirm.html  | 21 -------------------
 .../registration/password_reset_done.html     |  6 ------
 .../registration/password_reset_email.html    |  5 -----
 .../registration/password_reset_form.html     | 14 -------------
 templates/registration/registration_base.html | 12 -----------
 .../registration/registration_complete.html   |  6 ------
 templates/registration/registration_form.html | 15 -------------
 22 files changed, 11 insertions(+), 207 deletions(-)
 delete mode 100644 templates/registration/activate.html
 delete mode 100644 templates/registration/activation_complete.html
 delete mode 100644 templates/registration/activation_email.txt
 delete mode 100644 templates/registration/activation_email_subject.txt
 delete mode 100644 templates/registration/login.html
 delete mode 100644 templates/registration/logout.html
 delete mode 100644 templates/registration/password_change_done.html
 delete mode 100644 templates/registration/password_change_form.html
 delete mode 100644 templates/registration/password_reset_complete.html
 delete mode 100644 templates/registration/password_reset_confirm.html
 delete mode 100644 templates/registration/password_reset_done.html
 delete mode 100644 templates/registration/password_reset_email.html
 delete mode 100644 templates/registration/password_reset_form.html
 delete mode 100644 templates/registration/registration_base.html
 delete mode 100644 templates/registration/registration_complete.html
 delete mode 100644 templates/registration/registration_form.html

diff --git a/Post/test.py b/Post/test.py
index d33cf97..77adc32 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -411,6 +411,16 @@ class SpecialSubmitterTest(TestCase):
             self.assertContains(client.get("/Errors/Latest/"), "Latest Autobuilder errors")
 
 
+@override_settings(ALLOWED_HOSTS=["testhost"])
+class AccountPagesRemovedTest(TestCase):
+    def test_accounts_urls_are_gone(self):
+        client = Client(HTTP_HOST="testhost")
+        for url in ("/accounts/register/", "/accounts/login/"):
+            self.assertEqual(client.get(url).status_code, 404)
+        # The admin keeps its own login page.
+        self.assertEqual(client.get("/admin/login/").status_code, 200)
+
+
 @patch("Post.management.commands.culldb.time.sleep")
 class CullDbTest(TestCase):
     def setUp(self):
diff --git a/project/settings.py b/project/settings.py
index 529086b..28e526b 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -177,7 +177,6 @@ INSTALLED_APPS = (
     'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
     'django.contrib.admindocs',
-    # 'registration',
     )
 
 # A sample logging configuration. The only tangible logging
@@ -211,10 +210,8 @@ LOGGING = {
 
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
-ACCOUNT_ACTIVATION_DAYS = 2
 EMAIL_HOST = 'localhost'
 DEFAULT_FROM_EMAIL = 'noreply@example.com'
-LOGIN_REDIRECT_URL = '/Errors'
 
 TEST_RUNNER = 'django.test.runner.DiscoverRunner'
 DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
diff --git a/project/settings.py.docker b/project/settings.py.docker
index b98006e..bce1347 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -171,7 +171,6 @@ INSTALLED_APPS = (
     'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
     'django.contrib.admindocs',
-    # 'registration',
     )
 
 # A sample logging configuration. The only tangible logging
@@ -205,10 +204,8 @@ LOGGING = {
 
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
-ACCOUNT_ACTIVATION_DAYS = 2
 EMAIL_HOST = 'localhost'
 DEFAULT_FROM_EMAIL = 'noreply@example.com'
-LOGIN_REDIRECT_URL = '/Errors'
 
 TEST_RUNNER = 'django.test.runner.DiscoverRunner'
 DEFAULT_AUTO_FIELD = 'django.db.models.AutoField'
diff --git a/project/urls.py b/project/urls.py
index 16f5b6d..79b4d34 100644
--- a/project/urls.py
+++ b/project/urls.py
@@ -6,7 +6,7 @@
 #
 # Licensed under the MIT license, see COPYING.MIT for details
 
-from django.urls import include, re_path
+from django.urls import re_path
 from django.contrib import admin
 from django.views.generic import TemplateView, RedirectView
 from django.conf import settings
@@ -26,7 +26,6 @@ urlpatterns = [
 
     # Uncomment the next line to enable the admin:
     re_path(r'^admin/', admin.site.urls),
-    re_path(r'^accounts/', include('django_registration.backends.activation.urls')),
     re_path(r'^Errors/Latest/$', post_views.search, { 'mode' : results_mode.LATEST }, name= "latest_errors"),
     re_path(r'^Errors/Latest/feed$', LatestEntriesFeed(), name="errors_feed"),
     re_path(r'^Errors/Latest/'+special_submitter+'/$', post_views.search, { 'mode' : results_mode.SPECIAL_SUBMITTER}, name= "latest_autobuilder_errors"),
diff --git a/requirements.txt b/requirements.txt
index f5022da..40f3433 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -2,4 +2,3 @@ Django>=5.2.18,<5.3
 python-Levenshtein==0.27.4
 bleach==6.4.0
 mysqlclient==2.3.0
-django-registration==5.2.1
diff --git a/templates/base.html b/templates/base.html
index 88c110d..0d327d6 100644
--- a/templates/base.html
+++ b/templates/base.html
@@ -31,27 +31,6 @@ Licensed under the MIT license, see COPYING.MIT for details
         <div class="container-fluid">
           <a class="brand logo" href="{% url "main" %}"><img src="{% static "img/logo.png" %}" /></a>
           <a class="brand" href="{% url "main" %}">Error reports</a>
-          {% comment %}
-          {% if  user.is_authenticated %}
-          <div class="dropdown pull-right">
-            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
-              <i class="icon-user"></i>{{ user.username }}
-              <b class="caret pull-right"></b>
-            </a>
-            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
-              <li><a tabindex="-1" href="{% url "auth_password_change" %}">{% trans "Change password" %}</a></li>
-              <li><a tabindex="-1" href="{% url "auth_logout" %}">{% trans "Log out" %}</a></li>
-            </ul>
-          </div>
-          {% endif %}
-          {% if not user.is_authenticated %}
-          <ul class="nav pull-right">
-            <li>
-              <a href="{% url "auth_login" %}">{% trans "log in" %}</a>
-            </li>
-          </ul>
-          {% endif %}
-          {% endcomment %}
           <form class="navbar-search pull-right" action="{% url "errors_search" %}" method="GET">
             <div class="input-append">
               <input type="text" name="query" class="span5" placeholder="Search all errors" value="{{request.GET.query}}">
diff --git a/templates/registration/activate.html b/templates/registration/activate.html
deleted file mode 100644
index 6e24890..0000000
--- a/templates/registration/activate.html
+++ /dev/null
@@ -1,18 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-{% if account %}
-
-<p>{% trans "Account successfully activated" %}</p>
-
-<p><a href="{% url "auth_login" %}">{% trans "Log in" %}</a></p>
-
-{% else %}
-
-<p>{% trans "Account activation failed" %}</p>
-
-{% endif %}
-
-{% endblock %}
diff --git a/templates/registration/activation_complete.html b/templates/registration/activation_complete.html
deleted file mode 100644
index aef17be..0000000
--- a/templates/registration/activation_complete.html
+++ /dev/null
@@ -1,14 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-{% blocktrans %}
-
-Activation is complete.
-<br/>
-You can log in now.
-
-{% endblocktrans %}
-
-{% endblock %}
diff --git a/templates/registration/activation_email.txt b/templates/registration/activation_email.txt
deleted file mode 100644
index fe8db74..0000000
--- a/templates/registration/activation_email.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-{% load i18n %}
-{% blocktrans with site.name as site_name %}
-A request has been made to activate an account at {{ site_name }} using your email address.
-
-If you made this request, please click on the link below to activate your account. The
-link is valid for {{ expiration_days }} days.
-
-{% endblocktrans %}
-
-http://{{ site.domain }}{% url "registration_activate" activation_key %}
-
-{% blocktrans %}
-If you did not make this request, please ignore this message.
-{% endblocktrans %}
diff --git a/templates/registration/activation_email_subject.txt b/templates/registration/activation_email_subject.txt
deleted file mode 100644
index 24f477c..0000000
--- a/templates/registration/activation_email_subject.txt
+++ /dev/null
@@ -1 +0,0 @@
-{% load i18n %}{% trans "Account activation on" %} {{ site.name }}
diff --git a/templates/registration/login.html b/templates/registration/login.html
deleted file mode 100644
index a6ae44f..0000000
--- a/templates/registration/login.html
+++ /dev/null
@@ -1,18 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<div class="page-header">
-    <h1>Log in to the error reporting tool</h1>
-</div>
-<form id="login_form" method="post" action=".">
-  {{ form.as_p }}
-
-  <input type="submit" class="btn" value="{% trans 'Log in' %}" />
-  <input type="hidden" name="next" value="{{ next }}" />
-  {% csrf_token %}
-</form>
-
-<p>{% trans "Forgot password" %}? <a href="{% url "auth_password_reset" %}">{% trans "Reset it" %}</a>!</p>
-<p>{% trans "Don't have an account" %}? <a href="{% url "registration_register" %}">{% trans "Create one now" %}</a>!</p>
-{% endblock %}
diff --git a/templates/registration/logout.html b/templates/registration/logout.html
deleted file mode 100644
index f8da51f..0000000
--- a/templates/registration/logout.html
+++ /dev/null
@@ -1,6 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<p>{% trans "Logged out" %}</p>
-{% endblock %}
diff --git a/templates/registration/password_change_done.html b/templates/registration/password_change_done.html
deleted file mode 100644
index 659be0a..0000000
--- a/templates/registration/password_change_done.html
+++ /dev/null
@@ -1,6 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<p>{% trans "Password changed" %}</p>
-{% endblock %}
diff --git a/templates/registration/password_change_form.html b/templates/registration/password_change_form.html
deleted file mode 100644
index d74f39e..0000000
--- a/templates/registration/password_change_form.html
+++ /dev/null
@@ -1,11 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<form method="post" action=".">
-  {{ form.as_p }}
-
-  <input type="submit" class="btn" value="{% trans 'Submit' %}" />
-  {% csrf_token %}
-</form>
-{% endblock %}
diff --git a/templates/registration/password_reset_complete.html b/templates/registration/password_reset_complete.html
deleted file mode 100644
index d9f3879..0000000
--- a/templates/registration/password_reset_complete.html
+++ /dev/null
@@ -1,10 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-<p>{% trans "Password reset successfully" %}</p>
-
-<p><a href="{% url "auth_login" %}">{% trans "Log in" %}</a></p>
-
-{% endblock %}
diff --git a/templates/registration/password_reset_confirm.html b/templates/registration/password_reset_confirm.html
deleted file mode 100644
index 186ece5..0000000
--- a/templates/registration/password_reset_confirm.html
+++ /dev/null
@@ -1,21 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-
-{% if validlink %}
-
-<form id="password_form" method="post" action=".">
-  {{ form.as_p }}
-
-  <input type="submit" class="btn" value="{% trans 'Submit' %}" />
-  {% csrf_token %}
-</form>
-
-{% else %}
-
-<p>{% trans "Password reset failed" %}</p>
-
-{% endif %}
-
-{% endblock %}
diff --git a/templates/registration/password_reset_done.html b/templates/registration/password_reset_done.html
deleted file mode 100644
index b8ef93c..0000000
--- a/templates/registration/password_reset_done.html
+++ /dev/null
@@ -1,6 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<p>{% trans "An email with password reset instructions has been sent." %}</p>
-{% endblock %}
diff --git a/templates/registration/password_reset_email.html b/templates/registration/password_reset_email.html
deleted file mode 100644
index f219c68..0000000
--- a/templates/registration/password_reset_email.html
+++ /dev/null
@@ -1,5 +0,0 @@
-{% load i18n %}
-{% blocktrans %}Reset password at {{ site_name }}{% endblocktrans %}:
-{% block reset_link %}
-{{ protocol }}://{{ domain }}{% url "auth_password_reset_confirm" uidb36=uid, token=token %}
-{% endblock %}
diff --git a/templates/registration/password_reset_form.html b/templates/registration/password_reset_form.html
deleted file mode 100644
index 067f15e..0000000
--- a/templates/registration/password_reset_form.html
+++ /dev/null
@@ -1,14 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<div class="page-header">
-	<h1>Reset your password</h1>
-</div>
-<form id="password_form" method="post" action=".">
-  {{ form.as_p }}
-
-  <input type="submit" class="btn" value="{% trans 'Submit' %}" />
-  {% csrf_token %}
-</form>
-{% endblock %}
diff --git a/templates/registration/registration_base.html b/templates/registration/registration_base.html
deleted file mode 100644
index 752ce7e..0000000
--- a/templates/registration/registration_base.html
+++ /dev/null
@@ -1,12 +0,0 @@
- {% load i18n %}
-
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
-    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
-<html>
-
-<body>
-
-    <a href="{% url "auth_login" %}">{% trans "log in" %}</a>
-
-</body>
-</html>
diff --git a/templates/registration/registration_complete.html b/templates/registration/registration_complete.html
deleted file mode 100644
index 0d1b2ef..0000000
--- a/templates/registration/registration_complete.html
+++ /dev/null
@@ -1,6 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<p>{% trans "Your account has been created, however it must now be activated. An email has been sent with instructions on how to activate your account." %}</p>
-{% endblock %}
diff --git a/templates/registration/registration_form.html b/templates/registration/registration_form.html
deleted file mode 100644
index 32cb55b..0000000
--- a/templates/registration/registration_form.html
+++ /dev/null
@@ -1,15 +0,0 @@
-{% extends "base.html" %}
-{% load i18n %}
-
-{% block content %}
-<div class="page-header">
-	<h1>Create an account</h1>
-</div>
-
-<form id="registration_form" method="post" action=".">
-  {{ form.as_p }}
-
-  <input type="submit" class="btn" value="{% trans 'Submit' %}" />
-  {% csrf_token %}
-</form>
-{% endblock %}
-- 
2.56.0


