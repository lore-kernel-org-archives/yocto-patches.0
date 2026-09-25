Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F58DC9832A
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 22:49:30 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9932.1790376558214790780
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Sep 2026 15:49:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nY+hVyoe;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49febbce9afso8841935e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Sep 2026 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790376556; x=1790981356; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rU3FLDzfF17LgqRy7oLPgyWXkb0NVz4rBSx+TIqbfv8=;
        b=nY+hVyoeJt2RlJFswFzW0mnukDrcSWbjgLDe8Zm/dYCQhMM2FuD9lls/nI1e7kLBrx
         1ufOdBSJxIS1u2+Xvf9BnOmf29bi6YfSAYjaUy3hxAfnsrP7G8Z/PNb4J8DWJ9+dIsiZ
         7r+zvfagczdSo76HM7fWpgM5JhCvOoaPr7uwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376556; x=1790981356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rU3FLDzfF17LgqRy7oLPgyWXkb0NVz4rBSx+TIqbfv8=;
        b=1KAPP5ofDjDs7jVXd4cGkmFs1y67k7B41biooAtxMmjxGUa/MrI6lGC7lV1MENIOiH
         +MDcUrKAEmPFovBcbx7Hx4s01cJSR+cIiS074gh7K8leUWoxSAdIdhM0PrAM9e3nHnDP
         bQ86TQlUli2o+g4hAZahrQfAEnQnvDGEi8RE30WHnEcUmowmLR+QwbDHH7jsaU1ilH9g
         +KyKyT8jFRYPVefQ53m1FoGTXYsbdoeIuK8BHRauBEA2Nuix7Z0N940/azESAdLre7wS
         NDyAS/ofRVOMeafG8LBBIyJBTtnSBjt8fZSE7u7lN2LGv9MkPq+nxJKBO9apM/Yqyb/m
         muAQ==
X-Gm-Message-State: AFuF++nIMqYnYjbAm6B4KZp3iNT4z9XLwmlB/jHEJUZiwsH0Rg7ksUZb
	F82ZV1BDnw+6w6Co5/T6aUAO3aluzftCeF0vOffNM8CZauO9E6MpWvphkqTiC+MFOS+lHHAAA23
	oA3DtWn8=
X-Gm-Gg: AYBFou03UKLnBzmDdP19EnQmsiRQxfQupRI+P+hjtVvxLHuok/hM9P/LOh0q1Bj6fUT
	rVq4bIVX57DPrUS4AhNwT1GaTNvLlJHCegEkkKtZ/bZ7N6+XE8xOdy8s4zNH8OhrRp8bN0iQ88H
	whsOER1pQcLDMWBMjTPzR09EeoaqZjgZk7vamy1lOUZdQgUf4K+cK5XBi1wkUnsg20UqFyvvsdF
	RsOgR1zGxulZgMG3Fm2lv1IB+jRSzkKsJy3JBikMzMMPMETBOl/wITc2PomGER84mWfkMWzXEIU
	oA/i5h1qkFd61ygdzrvi/l4YNgwHG/8ZeBmW+RnRSY3v1QpegYzyjVhcoumO2I/b7K0sGfwEHPc
	q/Waz42ZPGEaN8zyDWuesx6ceZJg8o7bzVS4dtRKw1ew0fwcTIlaAIZCQzAnokJ48dEWsaMrXh4
	KYWFYr/w2G1DALE/kEkGVHUH9ROXWaKZP2bax4IIR9qv6EVNGO7XLdD7UXAlag31N9MSNwoWJZu
	oOxHLOpPImkGLS+nLmNiJLIQMbOxSd86AgmFLmjySUROuzUPfZ2ZRL3WTTbhk8pO4U1U67NpQ==
X-Received: by 2002:a05:600c:34d4:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-49fe66d07c9mr114518105e9.12.1790376556371;
        Fri, 25 Sep 2026 15:49:16 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5df44f9sm169299015e9.11.2026.09.25.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:49:16 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: Add blacksail-nut build to the branch selector
Date: Sat, 26 Sep 2026 00:49:09 +0200
Message-ID: <20260925224909.3735018-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Sep 2026 22:49:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4956

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 64f7d5d..4b7e5cd 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -81,6 +81,16 @@ branchdefaults = {
         'branch_oecore': 'blacksail',
         'branch_yocto-docs': 'blacksail',
     },
+    'blacksail-nut': {
+        'reason': 'Stable maintenance - blacksail-nut',
+        'branch': 'blacksail',
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.20-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/blacksail-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/blacksail-nut',
+    },
     'wrynose': {
         'branch': 'wrynose',
         'branch_bitbake': '2.18',

