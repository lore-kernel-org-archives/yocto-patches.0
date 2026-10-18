Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B774CCF2CA
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:23 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22492.1792360996382884508
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=X+YzwMRO;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so786388a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360996; x=1792965796; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNKy+tLo2s9D1hKO6VHKcLRCazYnLZDBzyIWFP/lrj8=;
        b=X+YzwMROjTNaOYaNVDKj65L/XQj1rRYcnomg4a7tQVyadpVHLZ9ZuzCxQaMiSwCBwY
         PfoDicj1H4jqkGWPfUgVe9FTXOZqxkDSvShgUOOiq8ejq8NWrqYF6i32I2x9aS7Ssoci
         74KX1HjbHD94beEheMvxMhjG8V/7wc6xS6Zp0Dv/e8PBS5wdkikHW0b12m0d6sCte6oI
         iriIiSV1yHk3x/TfG7+GfLcNa4su9f5ut+Qr6cm0oI/Fm3807FjuS+8hIcsZyiZsJsnb
         Ja5JJAWmPpU7JyOa7rAj5nGiF38roAr1kGwlj8NFva7cuKTUtYkM/o7TSV1gOnc1FN87
         dvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360996; x=1792965796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNKy+tLo2s9D1hKO6VHKcLRCazYnLZDBzyIWFP/lrj8=;
        b=ZTRjhWfvZormxoSWNICqLrvCMm/+WIazXe1R+7/kYNRVzX2kl90cJxvwG7h9gcBR6I
         eKUfubsIBtnzYjhJyu4jK1GufOVdmwKQzv9MVIHpYRFi+wOWcDYnjCDGLp+MI3udms3G
         cpusDyf83TIKO/+XSK9Bqfy7GqfrynH5gzIJgikqDmMcj+KTC6BN4KpJDdOVgVXRpHtj
         arfQakSBn/4lf3NidpIbG12w+yIhkLQKJBFGFmlMV2L4kV4LvK3jM8pSrwCXLADGsWsO
         apAhnjzuKY0p1OdMOKx4NQmTxnbD8nwSbvHs1vFnKRV9+U+xOybPjT2y5UbFkJ5TNMcE
         reIQ==
X-Gm-Message-State: AFq9FYJsupacS/y4LJGml8DwUh+p3hiZ2iOfsrNrCkFNTSATVI84r3fy
	FVga0PV/R9RJKqn2kFLQKJz/5RthYgR3N+OTWa4Zdl75AL70s8yBvtnuZRoODB91
X-Gm-Gg: AYBFou31ltvQXmrJbn0v4GbPwxxhU1FJyYERhElBTf9HaqZ7nWZEm6BhLtQW/ulO1fX
	bbtzrtlHijxwrplv2hu3CrE5i58A0uDJRk0J7ddJk+VF3yvUr6Gl6HavNQn8NR1Wao31qKafJLj
	0Jt4Y+WXhbLzyD6mDHVWebFis7pRyDmQX18kXlVYWLmUT9/sLw4OfQgnRf+0yKhrw2sWS08sRhe
	Uz/m1hNroaAXe7a/vQbMiQQYs+bVmkFGFRpiqKKkRgkSpLqy5FVSxHei9bVkXJUuziEQFrCeMZ4
	fn1idFU5wNFaCl+2N68bGHCJfl8ZrP0h+UJCbuqnpLs//A6ZA/SnbPFDAMQSGBaUS+EVVYEh+iv
	44UuWT0RwLHxwjVaVo6yhKpXN8vIpphTdScnw3y8RzT2JRh54Dq3eZLiE02HVU4PDVmpxwjysVC
	qsTeO9FvoSUQv9IyWU914JYFv+j7CQ2kwhh2TPMUhtxv9XHtzLl+iAZzxlERNicO5WtnTJKS7fP
	WqgXzTqBesJqbxZOqnjwPOf5USJx9QVJfn18TlG1Q==
X-Received: by 2002:a17:90b:164c:b0:3ac:e6a:1b27 with SMTP id 98e67ed59e1d1-3acef29e770mr4582148a91.42.1792360995698;
        Sun, 18 Oct 2026 15:03:15 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:14 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 01/10] README.devel: document running the tests; update requirements
Date: Sun, 18 Oct 2026 15:02:59 -0700
Message-ID: <20261018220308.72731-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5083

Add a "Running the tests" section covering docker/run-tests.sh (the
only way to run tests/test_update.py), running the other tests against
a local database, tests/test_dockersetup.py, and what the CI and Safety
workflows run.

The requirements still listed Python 3.6+ and Django 3.2; Django 5.2
needs Python 3.10 or later. The SMTP test server instructions used
python3 -m smtpd, which was removed in Python 3.12; use Django's console
email backend instead, which needs nothing extra.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.devel | 56 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/README.devel b/README.devel
index de370e5..31460ef 100644
--- a/README.devel
+++ b/README.devel
@@ -7,9 +7,9 @@ covered in the main README.
 
 In order to run this application standalone, you will need:
 
-* Python 3.6+
-* Django 3.2.x (not compatible with 3.0 or older)
-* RabbitMQ 3.8.x
+* Python 3.10+
+* Django 5.2 LTS, as pinned in requirements.txt
+* RabbitMQ
 * For production usage, a web server set up to host Django applications
   (not needed for local-only testing/development)
 * A database system supported by Django (SQLite, MariaDB/MySQL, etc.).
@@ -22,8 +22,8 @@ In order to run this application standalone, you will need:
   have to have Django installed, have the same or similar configuration
   in settings.py and have access to the database used by the web
   application):
-  * Python 3.5+ to match with the version of BitBake
-    for the OpenEmbedded branch being parsed
+  * A Python version supported both by Django and by the BitBake of
+    the OpenEmbedded branches being parsed
   * Python dependencies as per requirements.txt (we still need Django
     etc. here since we interact with the database through Django's ORM.)
 
@@ -128,17 +128,47 @@ SMTP test server
 ----------------
 
 If you want to test email functionality (e.g. for password reset, layer
-submission or other notifications) you can do so without dealing with actual
-emails being sent by running python's built-in SMTP test server (in a
-separate shell session):
+submission or other notifications) without sending real emails, set Django's
+console email backend in settings.py:
 
-python3 -m smtpd -n -c DebuggingServer localhost:1025
+EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
 
-This will stay running and print out any email that is sent to it. All you
-need to do then is edit settings.py and set it to point to the server:
+Every email is then printed to the console running the server (or the Celery
+worker, for emails sent from background tasks) instead of being sent.
 
-EMAIL_HOST = 'localhost'
-EMAIL_PORT = 1025
+
+Running the tests
+-----------------
+
+The tests use pytest and pytest-django, which are not in requirements.txt:
+
+    pip install pytest pytest-django
+
+To run the full suite as CI does, in the Docker image against a throwaway
+MariaDB container, run this from the top of the source tree:
+
+    docker/run-tests.sh
+
+This is the only way to run tests/test_update.py, which fetches
+openembedded-core, meta-layerindex-test and BitBake from the network and runs
+the update scripts (BitBake only runs on Linux).
+
+To run the other tests directly, set SECRET_KEY in settings.py and point it
+at a MariaDB/MySQL server where your database user may create databases
+(pytest-django creates and removes a test_<name> database), then run:
+
+    pytest --ignore=tests/test_update.py tests/
+
+tests/test_dockersetup.py tests the files dockersetup.py writes. It needs only
+pytest and PyYAML, and is skipped inside the Docker image:
+
+    python3 -m pytest tests/test_dockersetup.py
+
+On GitHub, .github/workflows/ci.yml runs docker/run-tests.sh and
+tests/test_dockersetup.py for pushes to master and master-next and for pull
+requests to master. .github/workflows/safety.yml scans the packages
+installed in the Docker image for known vulnerabilities on each push and
+weekly, if the repository has a SAFETY_API_KEY secret.
 
 
 
-- 
2.56.0


