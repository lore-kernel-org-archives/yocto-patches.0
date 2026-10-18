Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F847CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:49:46 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7856.1792288180028040309
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YAsJqg/d;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9ae391a05so5466075ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288179; x=1792892979; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9jMNuVtV9zDuiq4gkcU2zPWq/glICDYDKT0aOQCg34=;
        b=YAsJqg/d/CZ//BiwgNjdBm4sTyyGIZdr21TU9OnWypXozM/+DLqarDMf34I61+8ogV
         qNLkRLBaigyGY6MI13l30pQ8ulEdfeD0IcuNKkpJn3vch2EycY7INKcR0cFa3zdnZ5KC
         wn2SqlqcSL6X8HTn8DWTmcs5f+u9zK8nGDZYmlV5grIWW/hu9OCzamKSEv2lOoOjWFz1
         8OyzWfF+ccndPeC+us2OfrqClzlJlcO5fFusoDuMu0aI041BVu4OEyGR2FWz893DGs0R
         FWATGo5WUtwisjPt6CAL5a6CRIqIYkuCQM7mzaijt3upZnzhqC9nJdA33xeQJDxRTohJ
         UFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288179; x=1792892979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9jMNuVtV9zDuiq4gkcU2zPWq/glICDYDKT0aOQCg34=;
        b=hLhq4yD469aVproEsOPXdnXmg0PUlEmor2Z+AXAfoctekOHyJ7YJDHsnWr8ilNPGHj
         g/NiICIJ/DeW9dYuoK6bhKnmUoKnhV6Mr04FRi2Baei1CjeTCPxGnUrnyBONIr481ipF
         mIJhvUivymF2wWOH/Q+1b019KsRVSzj8LT4qrs7Bb79pnPmEmmeYbkoMtZsUWz1ODocZ
         tb2Bn6MqgFL3TIGlAZ2txNueUnJfFa7q2G/xw3x5S3nMVGGu+mDdXaoLyeyL6PpDrLKf
         Dbw3mYEKS3UZJEwBsFtF6quwI8acaWXetGoq26PuUbv1DhLxkT07Hl2g0hOFsb0A5kCH
         oH1Q==
X-Gm-Message-State: AFq9FYK5oLv56NjIb+VlFuml+OHgg2sAvrLMPnq8737vWtkvKMFfnBBK
	vig3bZqso5w6/L3Ne0e6cmWnbtICrlTPlgUBZi9kL7EnVDBGPmt6/tUgrvjmkg==
X-Gm-Gg: AYBFou0yeU6uTy6ZcYzUygOGbHtHxNjzdtQGoQsWVD3yXCIWIqVPvQJvz60CWAKss/b
	Mwnmde8Ybfh1XLqdO5bzVIR1Dc7iq+cijYSNj73sTOLD9CJA9z5zFDojtt818PeUHNjzwQ0mRew
	0tSX1Oev3yvJQtXQPGBGBBdaSR9Ta8W87n92NX+ZpwGiC2ayoteZq88QUK8umn0VR/b8KciQnyl
	Hlznk9jkbqYARSsR70PBY7YT6n98JUocSG8DbRqfWCTDbhYFVagHsEWqQVWStj6opp1oUWWmpRt
	Azi1HWb5SthATN/7o1YrzZ22LuIiaemLF/Czks0TNX+kdJRnsF6ltFBxfvt/cATYJ/1lScwJBkb
	oCFUb5KiY2BIL6It+CAoS9y5t85fuftt3d6HV9yq9htJrynYWNWJtXccBSEDHBopgBstWzdDdUk
	6yWVIU081Og4DoYEqjkxM5a0Ao2H22FZgZIe/+hvljAh5s/WvBTLpnZ1Oxglelfog3XsPnz1/9q
	6L7HxXWhtef81kBHqyaPYqX8tnOSULyNLTvkS+SzA==
X-Received: by 2002:a17:903:240e:b0:2e9:5313:8f7b with SMTP id d9443c01a7336-2e97752b4c4mr49830775ad.9.1792288179290;
        Sat, 17 Oct 2026 18:49:39 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm25005515ad.60.2026.10.17.18.49.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:49:38 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/3] Upgrade to Django 5.2.
Date: Sat, 17 Oct 2026 18:47:43 -0700
Message-ID: <20261018014924.73070-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014924.73070-1-tim.orling@konsulko.com>
References: <20261018014924.73070-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:49:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5051

Django 4.2.30 has 7 known vulnerabilities, fixed in 5.2.18. Pin the
other requirements to the installed versions. Drop USE_L10N, removed in
5.0, and AUTH_PROFILE_MODULE, unused since 1.7. No migrations needed.

[YOCTO #16458]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 project/settings.py        |  6 ------
 project/settings.py.docker |  6 ------
 requirements.txt           | 10 +++++-----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/project/settings.py b/project/settings.py
index 1ec6891..bc63c49 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -87,10 +87,6 @@ SITE_ID = 1
 # to load the internationalization machinery.
 USE_I18N = True
 
-# If you set this to False, Django will not format dates, numbers and
-# calendars according to the current locale.
-USE_L10N = True
-
 # If you set this to False, Django will not use timezone-aware datetimes.
 USE_TZ = True
 
@@ -218,8 +214,6 @@ TEMPLATE_CONTEXT_PROCESSORS = (
   'Post.views.common_context',
 )
 
-AUTH_PROFILE_MODULE = 'registration.RegistrationProfile'
-
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
 ACCOUNT_ACTIVATION_DAYS = 2
diff --git a/project/settings.py.docker b/project/settings.py.docker
index 9f98715..680b485 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -81,10 +81,6 @@ SITE_ID = 1
 # to load the internationalization machinery.
 USE_I18N = True
 
-# If you set this to False, Django will not format dates, numbers and
-# calendars according to the current locale.
-USE_L10N = True
-
 # If you set this to False, Django will not use timezone-aware datetimes.
 USE_TZ = True
 
@@ -212,8 +208,6 @@ TEMPLATE_CONTEXT_PROCESSORS = (
   'Post.views.common_context',
 )
 
-AUTH_PROFILE_MODULE = 'registration.RegistrationProfile'
-
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
 ACCOUNT_ACTIVATION_DAYS = 2
diff --git a/requirements.txt b/requirements.txt
index 920d9d0..f5022da 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,5 +1,5 @@
-Django<4.3
-python-Levenshtein
-bleach
-mysqlclient
-django-registration
+Django>=5.2.18,<5.3
+python-Levenshtein==0.27.4
+bleach==6.4.0
+mysqlclient==2.3.0
+django-registration==5.2.1
-- 
2.56.0


