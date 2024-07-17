Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC1C41513
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 01:06:01 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.5282.1721178357126090232
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Jul 2024 18:05:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UlspCvwl;
 spf=pass (domain: konsulko.com, ip: 209.85.214.182, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc2a194750so28422595ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Jul 2024 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1721178356; x=1721783156; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3okU2sb8dDU/1nsRE8ZPSWXZ4J548zjMN2TBuMyz/z0=;
        b=UlspCvwlQq8wZ76qtGjNE1TOKgZleHASGDpJIrZuJ479dSzQZVjF2dCSl138lLi2KW
         6iGTmzKZYXiM7k0M05oN2/u8tqAU299M4LJtcVFxOtrk1y1hahXuuRwitRcTJO59NBer
         bq+xLrFtids6Fd5SpxM7kLx5BYyYbclRai92Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721178356; x=1721783156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3okU2sb8dDU/1nsRE8ZPSWXZ4J548zjMN2TBuMyz/z0=;
        b=Dzd/e/fcQoF7kW4R5TZ1TBpHmRiW308KP4U6ZAOJMwGcUy5OaUV2yG3eiXdBk5XORM
         /2mom03CBhlKauJ/0KUXPBSO2/inSiuKhlRlpvZW2C1PSuZvXps+bqxq3IdY+tR4t67p
         R1C/sDug1pOX9W/wnyvtcofrUVKr8rELthdEip7Tm19uup7oiqyclchRGbAcVphbAIAj
         6ST0uSve4PdRYPzgCmQ3tHt80C53cnxrD92eGDNareKZmC1Xdf/kU1VYTTYeXKBDoVgI
         ZCZp2ublFzAjWOihKqVWyZMAlCPuykiyAGY8Ckemk/9CYsdaQkBW7AzmZaeTfI1tgDz1
         tG2g==
X-Gm-Message-State: AOJu0Yyf3ER9IgrcZdgJqTrPUOYXqTAcnyawCs9q+hGjWTUyNf/nZcPE
	552frkXQFIpYUnt/uKLfD8r7W30yVsRymPwVTrmmLMsvE24MzTKRp1LpJfL6tMmvUYLOfjhivgk
	Y2KY=
X-Google-Smtp-Source: AGHT+IFERrl4LbkiWcRlKb71p4e7ZGb8hvXP4klk+fOiSfp4kmriYOj0fZ5E22iWb79RX51cjUhq6w==
X-Received: by 2002:a17:903:2308:b0:1fb:4f91:6728 with SMTP id d9443c01a7336-1fc4e6b5ff1mr926355ad.42.1721178356070;
        Tue, 16 Jul 2024 18:05:56 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc530bcsm64610165ad.278.2024.07.16.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 18:05:55 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] requirements.txt: bump celery,django-axes,...
Date: Tue, 16 Jul 2024 18:05:07 -0700
Message-ID: <20240717010514.3386182-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717010514.3386182-2-tim.orling@konsulko.com>
References: <20240717010514.3386182-2-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 01:06:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/434

From: Tim Orling <tim.orling@konsulko.com>

Bump requirements.txt after running:
pur -r requirements.txt

+celery==5.4.0
+django-axes==6.5.1
+django-cors-headers==4.4.0
+django-ipware==7.0.1
+Pillow==10.4.0
+prompt-toolkit==3.0.47
+sqlparse==0.5.1
+typing_extensions==4.12.2

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index e4610e5..07f0f67 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -2,7 +2,7 @@ amqp==5.2.0
 asgiref==3.8.1
 beautifulsoup4==4.12.3
 billiard==4.2.0
-celery==5.3.6
+celery==5.4.0
 click==8.1.7
 click-didyoumean==0.3.1
 click-plugins==1.1.1
@@ -11,9 +11,9 @@ confusable-homoglyphs==3.3.1
 diff-match-patch==20230430
 Django>=4.2,<4.3
 django-appconf==1.0.6
-django-axes==6.4.0
-django-cors-headers==4.3.1
-django-ipware==6.0.5
+django-axes==6.5.1
+django-cors-headers==4.4.0
+django-ipware==7.0.1
 django-ranged-response==0.2.0
 django-registration==3.4
 django-reversion==5.0.12
@@ -25,15 +25,15 @@ GitPython==3.1.43
 kombu==5.3.7
 mysqlclient==2.2.4
 packaging_legacy==23.0.post0
-Pillow==10.3.0
-prompt-toolkit==3.0.43
+Pillow==10.4.0
+prompt-toolkit==3.0.47
 python-dateutil==2.9.0.post0
 pytz==2024.1
 six==1.16.0
 smmap==5.0.1
 soupsieve==2.5
-sqlparse==0.5.0
-typing_extensions==4.11.0
+sqlparse==0.5.1
+typing_extensions==4.12.2
 tzdata==2024.1
 vine==5.1.0
 wcwidth==0.2.13
-- 
2.45.2


