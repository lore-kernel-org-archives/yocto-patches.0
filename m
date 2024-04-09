Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.153274.1712706981842039375
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 16:56:21 -0700
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2232e30f4so54640655ad.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Apr 2024 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712706981; x=1713311781; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arf35/MAE1hkVxPH7Z4tfW1N9yORBfjpxNeF0NI2hCU=;
        b=qar/Pv3ZUyCCCR2TaQCs/25grsxfb37suJgz3MYvxYudc5bXy3NNFT+nyUVlYKR5JU
         U8tGoQk72Exi0LCukZolozqWfO14UYubf6l998SJ8ZtepYwP72463RRXcEVPnl3qErZD
         1SbzgKnCV0Gz4cTayuJ1I+KcbbwKr5anueZZM=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] requirements.txt: update all to latest
Date: Tue,  9 Apr 2024 16:55:44 -0700
Message-ID: <20240409235602.3362257-2-tim.orling@konsulko.com>
In-Reply-To: <20240409235602.3362257-1-tim.orling@konsulko.com>
References: <20240409235602.3362257-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

After running "pur -r requirements.txt"

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index 93e4e53..6090ea8 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,39 +1,39 @@
 amqp==5.2.0
-asgiref==3.7.2
-beautifulsoup4==4.12.2
+asgiref==3.8.1
+beautifulsoup4==4.12.3
 billiard==4.2.0
 celery==5.3.6
 click==8.1.7
-click-didyoumean==0.3.0
+click-didyoumean==0.3.1
 click-plugins==1.1.1
 click-repl==0.3.0
-confusable-homoglyphs==3.2.0
+confusable-homoglyphs==3.3.1
 diff-match-patch==20230430
 Django>=4.2,<4.3
 django-appconf==1.0.6
-django-axes==6.3.0
+django-axes==6.4.0
 django-cors-headers==4.3.1
-django-ipware==6.0.3
+django-ipware==6.0.4
 django-ranged-response==0.2.0
 django-registration==3.4
-django-reversion==5.0.10
-django-reversion-compare==0.16.2
+django-reversion==5.0.12
+django-reversion-compare==0.17.0
 django-simple-captcha==0.6.0
-djangorestframework==3.14.0
+djangorestframework==3.15.1
 gitdb==4.0.11
-GitPython==3.1.41
-kombu==5.3.4
-mysqlclient==2.2.1
+GitPython==3.1.43
+kombu==5.3.6
+mysqlclient==2.2.4
 packaging_legacy==23.0.post0
 Pillow==10.3.0
 prompt-toolkit==3.0.43
-python-dateutil==2.8.2
-pytz==2023.3.post1
+python-dateutil==2.9.0.post0
+pytz==2024.1
 six==1.16.0
 smmap==5.0.1
 soupsieve==2.5
 sqlparse==0.4.4
-typing_extensions==4.9.0
-tzdata==2023.4
+typing_extensions==4.11.0
+tzdata==2024.1
 vine==5.1.0
 wcwidth==0.2.13
-- 
2.43.2

