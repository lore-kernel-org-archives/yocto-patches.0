Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49715C531CC
	for <webhook@archiver.kernel.org>; Sun, 26 Jul 2026 06:55:59 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6496.1785048950336855934
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 Jul 2026 23:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=daMos8ms;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954df200ddso10903665e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 25 Jul 2026 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1785048948; x=1785653748; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRVT+Kor2B3b23G9PgokexLCLDTLK2lBqO8tNjZm0lw=;
        b=daMos8mszE2PMnwQPAmMJfVaEDEOpfeY8X2fA4UoGIqZxpTStsoq79vTMo2gxn7yVH
         OVUvxMpADRntCW+/De+ExC/UJ+mTVJuth4cY7jKGLnPaA1HKIE7QmGIdaFLdrCFS+9kp
         tvoA3Fdh4HsbDAMaT9xZjza8uzIqP+uwEcvAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048948; x=1785653748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bRVT+Kor2B3b23G9PgokexLCLDTLK2lBqO8tNjZm0lw=;
        b=VGZGf5qCkxiQlVTKOB1VhS5dbIDHbQZ+3oMk1B3F2/7BTiLHwv4bhUcKwIOrjro9Tk
         t5iuloOUNp7wZx2aGEieO63RFmkudRjooPVpJF2iFUDUdu5KbPYT8ujk8ItYfABTD4k4
         x1ftygEjxvZmMC5QA9neej11yMJxbi5GdUcDy0unkkFIbPn+q1w+trtw9XfDojrUWBp5
         eXKMSmJPZrFR9vrA00kns6Fv6oz5rJYg0D4/8EQHJwdgGfnF+eOkFcATt3OmXn41U2Sd
         TCnbzLY8EhhY5vwi6Fzya57nm8Je9Eeu58FMflDXBG8PfFPq8e1X6vXLASBDuFQX8Oo/
         VjNw==
X-Gm-Message-State: AOJu0YyiFC7La9gRAGOJA/peNZJnrYGBM90l7wsSpMFfb4+glxSAZ7C/
	KFBHIBhfadcZgQBv0s3jxBXSHDE88mRZiXcCLkIPcObbBzGpUn7IxwMRNbBDP9Xi84JtNvzxdfL
	EcF0mMmg=
X-Gm-Gg: AR+sD11ixwBSn1PRGnqSdBUnGypKBWnXEl7Abhk/jnu7p+RTcPZiReQZp8Xr3k/tiy4
	y75kZJssXphqMcXBiiCriUAEP50D5/4Jpt/EPiPAEPQrxIzBleHDhPPJ2OAIDB7IXEF4s6fI7Tg
	M5IRlCGllDzkMeGeZ04kI47S8CJqI8Uu2jUWN3zHN7FcUzZgPPlysqQn3lk6HWiR+A/lui5RMJf
	tTT54GUX9+AXBxFqWJAQoTeVPWHkyptOptPQoT7Z/mlL37Ikb/7af5wOA4Ie1P+mMCez/+HlAEv
	YCpBSKG1D9C2pPeKs8TFWORsuZbNoXJmjIOnP4pE/vleJYGwvJwHkJNfL1p9MYtoqfMkiYC3QWG
	EwJxlRhOec/Z44GKDpFa+4aitM2pabCgviydyFVsnWpx6u712NUAzdQR5RkAesk0Ka6WZu9vAId
	DOgs40AFifFZrVoCUO221/pdZDUhflprgk/L4pPDpOjqcGDT+iMoWBaRFO4WdC+FzUKW5R7FJOk
	AehDQ==
X-Received: by 2002:a05:600c:4583:b0:495:6022:5a14 with SMTP id 5b1f17b1804b1-496b5731d4emr55066695e9.34.1785048948365;
        Sat, 25 Jul 2026 23:55:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f9c4fe4c5sm17915117f8f.12.2026.07.25.23.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 23:55:48 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: setup wrynose branch for meta-intel
Date: Sun, 26 Jul 2026 08:54:39 +0200
Message-ID: <20260726065438.3170266-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 26 Jul 2026 06:55:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4538

From: Yoann Congal <yoann.congal@smile.fr>

Current builds use master by default and that failed:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/41/builds/4034
  [...]/itt_3.28.0.bb: QA Issue: itt: LICENSE value "BSD-3-Clause AND GPL-2.0-only" has an invalid format [...]

Switching meta-intel to wrynose does fix that:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/41/builds/4037

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schedulers.py b/schedulers.py
index bb16dab..47c35b9 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -80,6 +80,7 @@ branchdefaults = {
         'branch_meta-aws': 'wrynose',
         'branch_meta-clang': 'wrynose',
         'branch_meta-exein': 'wrynose',
+        'branch_meta-intel': 'wrynose',
         'branch_meta-mingw': 'wrynose',
         'branch_meta-openembedded': 'wrynose',
         'branch_meta-qcom': 'wrynose',

