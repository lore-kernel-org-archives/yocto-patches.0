Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B652CCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:42:13 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22122.1792359725271039455
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iaUhnhVn;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e95bd1c14cso12169125ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359725; x=1792964525; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evjIbHw4iZNi7/CmL9SlFKce31efpRil9A7cNnn7D5E=;
        b=iaUhnhVnh1rc6xf8GjhsDH/a4OVLBJEmDv6tW2VJAkrtNbca1paH5Lvc2o6T11zRIa
         Ln2WrX5Awnd1eQ/tJmijcy7ozQEXFfpI+iDxjjADob6uIsV0rgtrpHz/gT/sQlN3kpxx
         tLsH4t94GfnS9HIBGM/5UC6C1Bli5O4zYMok1sfcXXouBsZMYVXAuPd8K87cBMXbGcGk
         TEE+Mrnse/8JrYNMwQJq8Q0ykZcDKmaedkGswRFV3ZJbbRMIKcHovYF1fhAHIYV1ajUX
         Dx+7kTc8jL+mDW3w2/S4TdFglHOdakLn9gGix0oMGzKFZ4QrjagC4WpO125ZviJqpiNi
         OZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359725; x=1792964525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evjIbHw4iZNi7/CmL9SlFKce31efpRil9A7cNnn7D5E=;
        b=pA80hBpEiU91hsH1tDvNhKOr+gl2hkKSirFCIs0xNjs8zNgHDHSRcxGgCSpZxT0Uu2
         ysDb9XjDRFUZVrbMu82mn+EUo9V9DeJNbTx6s6aJMBpqnjupT16N6YjAx4tTSlq1O/C+
         yD3890uZMyDWlt8PfvXB2R5QRY+YtY9zOc4djmEylPo9jdZzZBoElSF9zTBO+cnA0iss
         KbxIrhtfP5Bzez+dxBvTkBIgA/Q0Sv0ythWE/QP+B/EGLac0wsZcaPl5B7b1LhOsG38k
         3qdJopttN3WH2hIXYqdTiTSZlCWSBvJ+CcDV3LRH+u7MO0j4AL86ydwWf0cQoB4/C/FT
         A/yg==
X-Gm-Message-State: AFq9FYJ9NKDvDEYvhN7tpJefSqpUf/B+SHkkE2z1b+BuMN2lBOGiqw5J
	VUemdQuqLRK9CzFWrJbypUGTV44/lSeFtdQSicARSZv0z6DNJTnwJWbXhgJVBk2B
X-Gm-Gg: AYBFou27EdB5qZJPrwr4nFPoPkXEqA6tfcuqoCJxzV5hyOyPMyN7nPYrMg6uZeaoRbB
	O3gKsYGE1ZI8fKZIYlrQm5NAK+pgywcZTSBQvod+om0oR9gvl8TM/S+r7vvBEi+Y8C+rtm21QtP
	iC3tUmhHf+/5smyiYRY8a4vNg8ONR+ekySIpLu6GeFc4OkpRlQPqyQCFIkkhyyt2DKQj8g/BZXp
	bK2E8WPgsCQqqHJlD2u1Hw1AmAPrVNIL004anCEW1qeXDCwlMrhEbC2f1ZD88OR2mV+XzdGY8IO
	7OhRdsA1wethJjhqj0PgrE81HX8/lFkEYtIHOpDg7xCuUaIBvLniAdcYZILjueOoxPPD7DKIpyW
	cMWJslA8WJn0iMju3yXmSCo4bjZVAOEEzcQG+4wUMArPALOncHe/ehhs9PkHW/hvAtkL/66iEjB
	3wAhvcKIsDyXafnSRrx4Dxwq7oRfNHWPrrOBPdTWj9cO9nVilh4cO+n2GOzhnV8vldekvqmhUrN
	eqjtROaY5shD85rFSZGbiYrdWQdbrnD
X-Received: by 2002:a17:903:19e7:b0:2e9:5008:3ecf with SMTP id d9443c01a7336-2e9a6843749mr54803095ad.3.1792359724537;
        Sun, 18 Oct 2026 14:42:04 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e9d3fa9ffdsm9004155ad.58.2026.10.18.14.42.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:42:03 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] docker/settings.py: read more settings from the environment
Date: Sun, 18 Oct 2026 14:41:45 -0700
Message-ID: <20261018214146.67856-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214146.67856-1-tim.orling@konsulko.com>
References: <20261018214146.67856-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5075

Let DATABASE_PORT (default 3306) and STATIC_ROOT be overridden from the
environment, and add ENABLE_RRS: set it to 1 to add the 'rrs'
(Recipe Reporting System) app to INSTALLED_APPS. It is off by default.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/docker/settings.py b/docker/settings.py
index c33731c..820c4bb 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -22,7 +22,7 @@ DATABASES = {
         'USER': os.getenv('DATABASE_USER', 'root'),
         'PASSWORD': os.getenv('DATABASE_PASSWORD', 'testingpw'),
         'HOST': os.getenv('DATABASE_HOST', 'layersdb'),
-        'PORT': '',
+        'PORT': os.getenv('DATABASE_PORT', '3306'),
     }
 }
 
@@ -65,7 +65,7 @@ MEDIA_URL = ''
 # Don't put anything in this directory yourself; store your static files
 # in apps' "static/" subdirectories and in STATICFILES_DIRS.
 # Example: "/home/media/media.lawrence.com/static/"
-STATIC_ROOT = '/usr/share/nginx/html/static/'
+STATIC_ROOT = os.getenv('STATIC_ROOT', '/usr/share/nginx/html/static/')
 
 # URL prefix for static files.
 # Example: "http://media.lawrence.com/static/"
@@ -164,6 +164,9 @@ INSTALLED_APPS = (
     'corsheaders',
 )
 
+if os.getenv('ENABLE_RRS', '0') == '1':
+    INSTALLED_APPS += ('rrs',)
+
 AUTHENTICATION_BACKENDS = [
     'axes.backends.AxesBackend',
     'django.contrib.auth.backends.ModelBackend',
-- 
2.56.0


