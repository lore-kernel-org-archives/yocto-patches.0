Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F0ECD6E3
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 19:55:49 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27914.1770839746952061513
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 11:55:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=khRHQ3lC;
 spf=pass (domain: gmail.com, ip: 209.85.210.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824adc96ad2so326489b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839746; x=1771444546; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOCIcp29lq/M55SkmhIQVIhdbqF4388ZhmRXwUEe9P4=;
        b=khRHQ3lC3HW+/LFmWH4dg9E6OPGkD6SLsUAS+RP3JKos8bcth7ihfwj+TQCQTThPuR
         eK1XNFpqGap8q9Cty3CKtWUiQKScT4aEGBNOTOlzFJp1U8FDpE7Q6qu39a59tNhcwIfl
         0sX4qdYEMD8pzEmLNoE7YrPfE5qacWg1SxgaXGQzzpjVXr77B1ZhpVBWGViyr6wUZH2X
         mtG3tCllf9bN3MaHK0Hj13D6Sp14SoB/D5M4CV1p5FxijjvcqPfjWsDYwcrX5TQQS85c
         oAUkL6iEprNhtwm3DqeHI9I+o2X53iOZjkWMBT95L6mjVMqJx3TkZnlb53fXABHDDaGu
         YXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839746; x=1771444546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOCIcp29lq/M55SkmhIQVIhdbqF4388ZhmRXwUEe9P4=;
        b=kD69v10mxkQ477OTpsCwS+hlxUUZkjNX0GRCJJ9V1k/fjvVgDXAbWDSV+DNSq9XxPV
         7CdZdSLOut+OFTEMoTeaco3RIdJY4pKmG8M5ZJi1t8AyjpqGJyzMg7Z+iQmO+mpcCc4U
         Sg4/AJfwoXT3x4yTcoByUVsF80lnhcYYlddV23cHgT9n2/rL3IANa+d3FbLr9PMrAZwB
         rJG+nr/bkAkCzPMP9mM/uKApe+6Y76jj5h3mDk0bPPKg6OAvUmmacFnl5/h1w2AFgR3z
         WNTaEPeR1vfAO271YR7DXWDxwodgp1MliHEaVqjGVqmglVlF32sReg8hnePp+7YccaHm
         LFCA==
X-Gm-Message-State: AOJu0YwmapHqKwQnVLcyoeVxzt8ogHSXsNCH1z2Y03VGPns/emdfPyQf
	3lLL5MLU3wQw1A+YC7YlGDkw6VnOhqm8CJlY8FAX0VC0olqinINYDpNJLSif4Q==
X-Gm-Gg: AZuq6aLrNW3zuIPbTLMXyeeZDhhwPviOerkMZNw4ITo3NIZgrcYmVdjSsxVFylK8dfY
	BPkCKRD9vfMid+CdrKdgK4YCfnzQ/xLjJ65SuqkzTOwpQRaz0Evkz7oF7AcI6JXwX4/aHjdqWX+
	QOFthu84U8ns2M73aQyfzFuWbBTwFBf/e2snxvYVoZyGS9iOj8KWX2zvLcDtwcCjbLp8RzQ3yFl
	3WKhj/DubsuFR+PJXm1eub0vZ3FPxHfSKgKj00UQLKbS/Pw8wqXMiR0KGyTLiMtGSq7sZhRKIKq
	U5vH0Fx02Yuoby5AzzaDpYuruqBjtwg5InfGTygTVkBcGe5xMEFPFafPJsGpCxv8ZHp7lzXhe3V
	ZCkJeZaL9aWn7ww8XKeBPnA4zsYGr+T6AVN1yra9QrLJE2pyvL7w6240+Yr9f4SEGr20ivq2do3
	RrJ5ET76kSx/V/s1hoC35rPoPcdxhhe8S2OCjr1I30p+bYo8/BBRlDto+9DbYcxZRGXE4yOO3b7
	xfb1BL4yVwhGrgbQOQfAu0=
X-Received: by 2002:a05:6a00:2492:b0:823:52b6:1633 with SMTP id d2e1a72fcca58-824b0543412mr166389b3a.40.1770839745699;
        Wed, 11 Feb 2026 11:55:45 -0800 (PST)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e7d621esm2810293b3a.32.2026.02.11.11.55.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 11:55:45 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] requirements: bump to fix vulnerabilities
Date: Wed, 11 Feb 2026 11:55:33 -0800
Message-ID: <20260211195536.10278-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 19:55:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3214

-Django>=4.2,<4.3
+Django>=4.2.28,<4.3
https://docs.djangoproject.com/en/dev/releases/4.2.28/
CVE: CVE-2025-13473
CVE: CVE-2025-14550
CVE: CVE-2026-1207
CVE: CVE-2026-1285
CVE: CVE-2026-1287
CVE: CVE-2026-1312

-django-simple-captcha==0.6.0
+django-simple-captcha==0.6.3
https://django-simple-captcha.readthedocs.io/en/latest/changes.html#version-0-6-3

-Pillow==10.4.0
+Pillow==12.1.1
https://pillow.readthedocs.io/en/stable/releasenotes/12.1.1.html
CVE: CVE-2026-25990

-sqlparse==0.5.1
+sqlparse==0.5.5
https://sqlparse.readthedocs.io/en/stable/changes.html#release-0-5-5-dec-19-2025

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 15530a6..7a3806c 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,3 +1,4 @@
+-i https://pkgs.safetycli.com/repository/self-d8782/project/layerindex-web/pypi/simple/
 amqp==5.2.0
 asgiref==3.8.1
 beautifulsoup4==4.12.3
@@ -9,7 +10,7 @@ click-plugins==1.1.1
 click-repl==0.3.0
 confusable-homoglyphs==3.3.1
 diff-match-patch==20230430
-Django>=4.2,<4.3
+Django>=4.2.28,<4.3
 django-appconf==1.0.6
 django-axes==6.5.1
 django-cors-headers==4.4.0
@@ -18,21 +19,21 @@ django-ranged-response==0.2.0
 django-registration==3.4
 django-reversion==5.1.0
 django-reversion-compare==0.17.0
-django-simple-captcha==0.6.0
+django-simple-captcha==0.6.3
 djangorestframework==3.15.2
 gitdb==4.0.11
 GitPython==3.1.43
 kombu==5.4.0
 mysqlclient==2.2.4
 packaging_legacy==23.0.post0
-Pillow==10.4.0
+Pillow==12.1.1
 prompt-toolkit==3.0.47
 python-dateutil==2.9.0.post0
 pytz==2024.1
 six==1.16.0
 smmap==5.0.1
 soupsieve==2.6
-sqlparse==0.5.1
+sqlparse==0.5.5
 typing_extensions==4.12.2
 tzdata==2024.1
 vine==5.1.0
-- 
2.50.1 (Apple Git-155)


