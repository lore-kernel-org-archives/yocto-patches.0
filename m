Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.14689.1713364542231903272
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Apr 2024 07:35:42 -0700
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ecf406551aso4664048b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Apr 2024 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1713364541; x=1713969341; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a1q2F49yvXoQGF3uhcfTSTxCQ6odXeFQ1lCxo2+FLI=;
        b=kLQrDf4yiQAbpr9+QtLq2TGDrdt/IdVI36y5u54MWTtgY5eKRMmx4MoD+9ZQ5LdE8O
         b74EmhV9EUt9V1IPlcTEElzcliaz6NElGYrTi7fPQ9ZGgeMFq5ekQ0IvOlkzeCNvdpM0
         uSeUFAirrX6MdthKgmY0B++k+pckhYIm86UXs=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] requirements.txt: bump django-ipware; kombu
Date: Wed, 17 Apr 2024 07:35:19 -0700
Message-ID: <20240417143529.106594-2-tim.orling@konsulko.com>
In-Reply-To: <20240417143529.106594-1-tim.orling@konsulko.com>
References: <20240417143529.106594-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

Bump requirements.txt after running:
pur -r requirements.txt

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 9a5d0de..8ab5e56 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -13,7 +13,7 @@ Django>=4.2,<4.3
 django-appconf==1.0.6
 django-axes==6.4.0
 django-cors-headers==4.3.1
-django-ipware==6.0.4
+django-ipware==6.0.5
 django-ranged-response==0.2.0
 django-registration==3.4
 django-reversion==5.0.12
@@ -22,7 +22,7 @@ django-simple-captcha==0.6.0
 djangorestframework==3.15.1
 gitdb==4.0.11
 GitPython==3.1.43
-kombu==5.3.6
+kombu==5.3.7
 mysqlclient==2.2.4
 packaging_legacy==23.0.post0
 Pillow==10.3.0
-- 
2.43.2

