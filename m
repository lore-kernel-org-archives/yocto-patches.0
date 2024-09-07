Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3004EB64CE
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 18:21:19 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.13508.1725733271716994181
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Sep 2024 11:21:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d6anKUH6;
 spf=pass (domain: konsulko.com, ip: 209.85.210.175, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1795204b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1725733270; x=1726338070; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UdOfkMkzlRE9ev3VH5yBCFrgrfvv/6wrpp6UOOlR3o=;
        b=d6anKUH6/XVlaNU74bDgQu0EKFWn5Bb/HTb9V/yVlWpebEKJEWf+4ya2Z01nWd8qXE
         pIpGRyriGS+rIm7roaeYwOk8Qf/wwfeug00MEGUHxOPuPZONTbBSMZuYloZdnI1E3jFp
         DnDIfr6wwVZmtDVL41G5gA/Z3sXd5G9MO5lxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725733270; x=1726338070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UdOfkMkzlRE9ev3VH5yBCFrgrfvv/6wrpp6UOOlR3o=;
        b=mFEIhB7AeBy7LH5J/w7e/w1GhpTxpS3TretzKgjUdTiVK8dIg+HNd3lbL2GVcu+Iuf
         vQISb3hpu/FFNmVreSLi/Z7lMDWuWtw6a38NkvbUVhEsu21N+alhJOGxH5W4H8aChveK
         59Jh5nrAq14lJRlAi2FFIYcie6/wAl6PTyyAEmnmiokgudMYHV1qEJAi1tiZCZKU3JKV
         h0dbhbKlogUFLbPfuspgHsM1jgx4mlvKniHxziTlh+GSTJdGR5VTPmEB7IRR6kIBFFeA
         rjajyfqZwEuVqJDABp+o0mIhOOpx+2TQdtwIssJDK+AqMkSInWo6sQmtxw8HEQ/bGO/n
         JimQ==
X-Gm-Message-State: AOJu0YywPspIMU0kHdYAWB7QgvS6Cu+MQmiLqnT4bGiEAqWrGEi9zWzP
	qb2ATG7dTrxl2smcKlPxL1GLIVO+/wF/A1TbDvn+29+ZBsVSr9DZirjyiVd5ZIca+iY9dAGWPGc
	x3a4=
X-Google-Smtp-Source: AGHT+IGti1GjTlEtYYN7GqT8wpyrzaOsYQfj1B9oMMf8RzR/ksf8u/3Azyf2VbqXX5Vu3hf1oWlZFg==
X-Received: by 2002:a05:6a20:6db0:b0:1cf:3338:a475 with SMTP id adf61e73a8af0-1cf3338a4d3mr1415199637.9.1725733270066;
        Sat, 07 Sep 2024 11:21:10 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823736318sm1076534a12.12.2024.09.07.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:21:09 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] requirements.txt: bump django-reversion, kombu,...
Date: Sat,  7 Sep 2024 11:20:54 -0700
Message-ID: <20240907182054.49037-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 18:21:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/621

From: Tim Orling <tim.orling@konsulko.com>

Bump requirements.txt after running:
pur -r requirements.txt

-django-reversion==5.0.12
+django-reversion==5.1.0
-kombu==5.3.7
+kombu==5.4.0
-soupsieve==2.5
+soupsieve==2.6

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 07f0f67..15530a6 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -16,13 +16,13 @@ django-cors-headers==4.4.0
 django-ipware==7.0.1
 django-ranged-response==0.2.0
 django-registration==3.4
-django-reversion==5.0.12
+django-reversion==5.1.0
 django-reversion-compare==0.17.0
 django-simple-captcha==0.6.0
 djangorestframework==3.15.2
 gitdb==4.0.11
 GitPython==3.1.43
-kombu==5.3.7
+kombu==5.4.0
 mysqlclient==2.2.4
 packaging_legacy==23.0.post0
 Pillow==10.4.0
@@ -31,7 +31,7 @@ python-dateutil==2.9.0.post0
 pytz==2024.1
 six==1.16.0
 smmap==5.0.1
-soupsieve==2.5
+soupsieve==2.6
 sqlparse==0.5.1
 typing_extensions==4.12.2
 tzdata==2024.1
-- 
2.46.0


