Return-Path: <piotr@qbee.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA8CFC29F
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 20:34:38 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20933.1763757275676479674
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 12:34:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=NwMUWjQD;
 spf=pass (domain: qbee.io, ip: 209.85.208.169, mailfrom: piotr@qbee.io)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a34702a20so21278841fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1763757273; x=1764362073; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpZnHLmmPVNXeCnc2sUqPRKbLrXH65rG77XaoVgU17U=;
        b=NwMUWjQD/m4rrEKLH/yFAJg2IKF0KxP8m2s3hdNtG9X7TBwC13AjH3WD518EwfWxqO
         NpXeGUXB+sTakoEUeSMZiW6+iMzwsHm7BEhcDSo3JOkHq5uWYsW/bVxCZZ1ATfxW22Pz
         Di7nE1ieOtUQXcarSy2m07UBgaGT2nVyru4uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763757273; x=1764362073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpZnHLmmPVNXeCnc2sUqPRKbLrXH65rG77XaoVgU17U=;
        b=uA24tYyqx8b6Rx6OJPZ0PDQaUAtecZoYdv+vT1stlGMepApOwYIkPTQNpa/LtW6NHc
         NaOGwraP2hVDeX9vzt6YfdbADhLfS4dKY5nloCA+2BDQXrt2q3cOMDLnSqBr3TTT03Oi
         xarQNy2KQAb8KNVG4d9bMs9QgjMWHqq/X6Iw+rIKPRqZVmApf4XlOYxbpHBZlhkaxv8D
         dBtNgkhekzoPiVqctOt1pBFy9gK2QhREuH+gApvMp2m6DdhKImK7UF0itkgZKmlU+Ivf
         qM+j0yjkhNrF+eCxPbc+CehYaJ/Y2Gz10FO6tXxLUzj5ZJEwUOHUSC5uNW7GYM7Uw9b8
         zPOw==
X-Gm-Message-State: AOJu0YxWAM1Zcl7aPHLzdBUz0za4YjrTbwe/dYLtqR5sEX730TCrS+St
	Z5lAihWrzEpTpdWGEdV8ih+Q2F5ZYDZD0hfoYaS3Bu7J5q7sEzHNjKOYliJOaO8IoQFFperKwuY
	mN+XIumo=
X-Gm-Gg: ASbGncuQWEutzqHAplymGkbXQW55EjIkre566Fd7+zOZgpRdhNpxAjjIl2cHwAU0J40
	OPKSJ0Xsbu5MgDxE34iFrfXOm/eod5bVB+Z83JSV4PvgbWgDx9l3q4QiYpUvGMxTrKmgLLoiSjU
	LpOyKDGq34FPJAsRnwLJPhsE6bKX0Gpu0b38A1x4r5/1IyJl8AMs4srmo0QVcjpjOZgVp3IAH3l
	jkH+/igutIyLj8D+9coeeNeVWhHqzCQUirynRr677pmq5j4dNv+B9AuwJEwKII/iyPlQitRHZYK
	/kBDd8GZZRGzTET4uarAfF2XCfuuLNF43X5ISw5FrJsQfzQ/6Kzi9fn3aWaUy2LeC+1KK5gi9jD
	P9plRqadBGvBwtZqfeapbDOeYky5G4m2u6mZSWqNo2rl7QQj5D3SsN22OA8XwASIWXFYi24rxDG
	2pPrtUGLSZl9SGIKHU9BK4vlZ6lH0tS6sPFd65UFDI
X-Google-Smtp-Source: AGHT+IG0nrQtj+8TOycZ6jcDHqxjSGfGrYGSj4OI9WkUjeP5sWaZniKkekTbkgj7pyzhMwA6RrvWWA==
X-Received: by 2002:a2e:97cf:0:b0:37b:9dd9:d203 with SMTP id 38308e7fff4ca-37cd9197979mr8627061fa.11.1763757272981;
        Fri, 21 Nov 2025 12:34:32 -0800 (PST)
Received: from localhost (80.89-10-247.nextgentel.com. [89.10.247.80])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37cc6b59d3esm12980751fa.14.2025.11.21.12.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 12:34:32 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
Subject: [layerindex-web][PATCH 3/3] Extend support for environmental variables in docker/settings.py
Date: Fri, 21 Nov 2025 21:33:50 +0100
Message-ID: <20251121203350.55855-3-piotr@qbee.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121203350.55855-1-piotr@qbee.io>
References: <20251121203350.55855-1-piotr@qbee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 20:34:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2654

This change will allow devcontainer (or any other way of deploying the
system) to provide values for BASE_DIR and EMAIL_BACKEND through
environmental varialbles.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
---
 docker/settings.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docker/settings.py b/docker/settings.py
index c202585..9a96e83 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -50,7 +50,7 @@ USE_I18N = True
 USE_L10N = True
 
 # Avoid specific paths
-BASE_DIR = os.path.dirname(__file__)
+BASE_DIR = os.getenv('BASE_DIR', os.path.dirname(__file__))
 
 # Absolute filesystem path to the directory that will hold user-uploaded files.
 # Example: "/home/media/media.lawrence.com/media/"
@@ -231,6 +231,9 @@ MESSAGE_TAGS = {
 
 # Registration settings
 ACCOUNT_ACTIVATION_DAYS = 2
+EMAIL_BACKEND = os.getenv(
+    "EMAIL_BACKEND", "django.core.mail.backends.smtp.EmailBackend"
+)
 EMAIL_HOST = os.getenv('EMAIL_HOST', 'layers.test')
 EMAIL_PORT = os.getenv('EMAIL_PORT', '25')
 EMAIL_USE_TLS = os.getenv('EMAIL_USE_TLS', False)

