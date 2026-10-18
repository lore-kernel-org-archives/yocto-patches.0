Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B75CCCF2D4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:23 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22591.1792360998484500266
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=M9WLyB1g;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1428016a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360998; x=1792965798; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4hOn2rMoFcSx85bpOrfIhZ1QwBfSg0mrNGVUg1W2/M=;
        b=M9WLyB1gkAo0oGw41rsy6nTTGmOuACaiy2d/Utzo4u/AKcP11nrdKWP/FHGqwjtpLF
         1vMTN6qQUzzxsE5tGrC/eZc/MC2xk2ZAylqlehAHXVckYDy17KjEu9DL8mGLPXUiP7ZZ
         7yxUzUFlbA3zjMUWom0QU0bBWF4PEQ+jbgPmLZmu/k3grEU0jknk4BdF/VxXfcnC+NSe
         mzAopjR8tuKD+hORLlq0iXN6H5i9thVnSX6HkXfzeMuple11GooyPS3TVZzaHB1Rlxb3
         f7cUB+2ku18UaGLHC7hUfpZVd9gWbCmQwlrIkS0mlzBYdCDEtHy2pR+jkPP4DBXNgigh
         A9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360998; x=1792965798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4hOn2rMoFcSx85bpOrfIhZ1QwBfSg0mrNGVUg1W2/M=;
        b=l/r1VPRBH0c7G1JiC6pTXFtO3j+F5ffTFT2ai1Y4cNkRlWconOYx9b+CPORMhtieIO
         EuSjrnQuRp4cQWvXEfjQrD5W1T65vPN8zwPmYD0HACnHHlnrFy19/dbz0ejVMZcmjkFd
         WwN0TYIbQxlhWVJD7WoGqA7GoXonGv9xUUt6JpDhQqDaNVvc4ruYvAfJlqaKL1nZDIjx
         icmS1cYJvu5Ur6WJTV3UZ06xptsPTKLMuyOOz5fBh36GlQPQGq0x5ZPWd1pxOyWAPNjL
         OKb60uwedO000I5ZZYXxR2pPGkFYstWuBJIp6B27uPHoL2OuxjD7tdRTnPqW0krLb5qB
         S4mA==
X-Gm-Message-State: AFq9FYJc9iYV/F2uLjRu6Ao7WlOwft4b0dSAULo6k9LACtwfkFl84ozm
	kHpWTwaSDo8itIsMZrbVZ82SLR0cqBaN5nf8jkd838XGCPPfuYhC99Gq52M0kg==
X-Gm-Gg: AYBFou3jWtI5bmMe7fILOwUdJUW4zMnFLsCNhE/dpiTmFO/lnOKxGpTqhLX+7PyaIL4
	zC+B/GSAmpfTOaiT+oa7W6WoZ5g7NhLIJutk3G8i3zXAfrQ601qSITY2AzElOpFlSeEGb8AFjHr
	yEOdufhm1kt/ktkyCfhaWs9+IUcOFAIhq3Sqk0LplMN9uAgZVQPa3hkg+Sj5sWEezgqHVFmcoEt
	HXkPZhYG7Sh1jet6rIOcoL7ylyDE2Zn+tJUOfj5T0F9RDD1dt5LfIPSeg26GZclzuBCnJvU2Qx4
	6rxvN1eyyF2T93wB4+HTgxPedrWDwKZMQY4i3yEnuAMweLZ7/UttYigs/EfEDtmH2uKoZFSmv/D
	U73sbC1EXozcNLtULriAkJsII3rKw9k6pzCQL/Xvk1hAfpsf3DZ0w95JwWJUSUFfV11T1VWIY6S
	YhHdfjQxOrynpmKCU47RL6+A1LzlKXlGRhPkIfK/VIDh6cUC9ApCcZTQnigUmbH7ico3TEM/Qw3
	KpKWu4n9HuEt+WOqWosBCJrBybQuuQ28/N5BihglQ==
X-Received: by 2002:a17:90b:28c7:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3acef15c97cmr5125608a91.66.1792360997815;
        Sun, 18 Oct 2026 15:03:17 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:16 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 02/10] README: document upgrading to env files and the new settings
Date: Sun, 18 Oct 2026 15:03:00 -0700
Message-ID: <20261018220308.72731-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5084

dockersetup.py -u does not update the code itself, so say to update it
first. Installations set up before the move to environment files keep
their secrets in docker-compose.yml, which the update replaces; describe
how to carry them over to .env.local.* files once.

List the optional DEBUG, ENABLE_RRS, DATABASE_PORT and STATIC_ROOT
settings, and point the HSTS link at the current Django documentation
rather than Django 1.11's.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 3f733af..49ce4d3 100644
--- a/README
+++ b/README
@@ -98,6 +98,14 @@ credentials, email server, DEBUG) from .env.<context>.<service> files, where
 
 The .env* files are excluded from the Docker images.
 
+Other settings the app and celery files can set:
+
+  - DEBUG: 1, true or yes enables Django's debug mode; anything else, or
+    leaving it unset, keeps it off. Never enable it on a public site.
+  - ENABLE_RRS: 1 enables the Recipe Reporting System (see README.rrs).
+  - DATABASE_PORT (default 3306) and STATIC_ROOT (default
+    /usr/share/nginx/html/static/).
+
 
 
 TROUBLESHOOTING:
@@ -209,11 +217,33 @@ Alternatively, you can update the data from an existing layer index instance
 Upgrading from an earlier version
 ---------------------------------
 
-To upgrade the Docker-based setup from a previous release, simply run:
+To upgrade the Docker-based setup from a previous release, update the code
+(e.g. with git pull) and then run:
 
 ./dockersetup.py -u
 
-This will update the code and run any required database migrations.
+This will rebuild the containers and run any required database migrations.
+
+Installations set up by dockersetup.py before it used environment files
+(see "Environment files" above) have their secret key and passwords in the
+environment sections of docker-compose.yml. Carry them over by hand once:
+
+1. Copy docker-compose.yml somewhere safe, then restore the tracked version
+   (git checkout docker-compose.yml) and update the code.
+
+2. For each of app, celery, db and rabbit, copy .env.dev.<service> to
+   .env.local.<service> and fill in the values from the matching service
+   in the old file: SECRET_KEY, DATABASE_USER, DATABASE_PASSWORD,
+   MYSQL_ROOT_PASSWORD, RABBITMQ_DEFAULT_USER, RABBITMQ_DEFAULT_PASS and any
+   EMAIL_* settings. Set DEBUG=0 in .env.local.app, and make the files
+   readable only by you (chmod 600 .env.local.*).
+
+3. In docker-compose.yml, change the env_file entries from .env.dev.* to
+   .env.local.*, and reapply your other changes from the old file (hostname,
+   ports, certificate volumes and, if you use Let's Encrypt, the
+   layerscertbot service).
+
+4. Run ./dockersetup.py -u as above.
 
 
 
@@ -371,7 +401,7 @@ REGISTRATION_OPEN = False
   also enable HSTS in your configuration. Refer to the Django Security
   guide for details on how to do that:
 
-  https://docs.djangoproject.com/en/1.11/topics/security/#ssl-https
+  https://docs.djangoproject.com/en/stable/topics/security/#ssl-https
 
 * To reset a forgotten account password, you can either use the password
   reset function ( /accounts/password_reset/ ) or alternatively from the
-- 
2.56.0


