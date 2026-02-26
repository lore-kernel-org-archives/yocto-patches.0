Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC30FD8FE0
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 17:18:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75237.1772126303425896923
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 09:18:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CIyymnLY;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43984d7e49bso1001593f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 09:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772126301; x=1772731101; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x6rcgMzytMTKoXffQnCWwkMkEJA4bmmWbsJruCpGa7w=;
        b=CIyymnLY6Hq9aeL0P1PhbYQadGScnnnJZoNeU/rFu/LoL6R7WfaxAjFn9i0nBYLCmJ
         tRfWA2RpsH0dtNayMkRshhPmb23tDGQrr03F9HBtZrY9tslYa7q2rehErI/8pn0g0/WW
         5/8ICzMDZXlEMcKNvs6WjdotBYw4LF9OUC18k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126301; x=1772731101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6rcgMzytMTKoXffQnCWwkMkEJA4bmmWbsJruCpGa7w=;
        b=E1ATR57Z2zv/Vbfaiy25HvHFbIAR/4lj3iErgY7JQ7dt2o4d7Q4rUADmmRQZ0b82vi
         Qg/UuPy2uAg1ZR0yLGQl2O0EnRnAfTvm6GfSv74KA41GA8CVIScwX6bAUxcWliaw2m8N
         X6wtv7m+eNn2pY/jVssEzX35vf8zIwBjM7YwcyoIadYIYVBtxeo1/45fUDVCxV8fc8EA
         avtp/gJ+TzqlJCWloCxgSV99EqU41OzPnqHBn8PHN280G79qPZsxUbJE8bcUTZneQT+c
         jJDEXgerzGB1Hq4h7MfEkrmmiIWKxIHUthobbRliKGKDimVW4dkkP8NS2W8CoNUOgzzr
         Qq7Q==
X-Gm-Message-State: AOJu0Yz/tCL/VQcJFWyQjZrifTt/d2oN7oUSGzulAl11Jvh7D6SM4I5E
	+MEzbvf9KmYdgt5QeZr2gk2qsJhsrVQAa/btSGTnDndKfuizoe93gfC7ZwNRYEF43qH9WMumWt9
	fk+JF
X-Gm-Gg: ATEYQzwpXg5jUyy75EHsR895qv1kuZ7o8tNO2vAPYX27vHm4BB30Uz8u75sBUL1c4M/
	IHdrvFDuzyQQQH9ISrLZV5JUMH63mSpxLGyPgVmDYSRv8TRJerbPFNDYeC65ONcCQ95NKSpzoWB
	h/yjRzL1JNrrBVhUT6WZeSY0bFJ39VokLmrO3ecVbyUZcRvgRsL8Kmfh7liw04QGjMS2ufq1cKT
	afENwq7VnpSQiBKqTA2HSphdx2OAkqVQ5KNW+zNFAwijmnCnsbOWaLL80YzVMsOtcpq+8lH5fhu
	/ZahoLPTrzDHZuOrfpz9eB43PmJ+Jagatsbu97VihuO76GVQkjLvrv8VpBcO9eMvV3xWUiuFrH/
	D+uEdehewVYrM6EHjLctv3sM/rzj2FqR+4BaoJh3irWyuiEFkh0U7kTQ+1D3RZt6RraLHtCEJsO
	I005uDkgj9J9Ag6wv8FSN7lXO2r0FbXimOlW7Wpea6C4KHyAtffZQt285cUaViXJ6QEzsu16MMl
	v//c3PusIC98yJX2HrgFcIGpK8R
X-Received: by 2002:a05:6000:26cb:b0:436:37e4:594d with SMTP id ffacd0b85a97d-43997ed999emr5711745f8f.6.1772126301450;
        Thu, 26 Feb 2026 09:18:21 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa002c0b752a8b25831e.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:2c0b:752a:8b25:831e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm645888f8f.36.2026.02.26.09.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:18:21 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v3] schedulers: Add stable -nut builds to the branch selector
Date: Thu, 26 Feb 2026 18:17:44 +0100
Message-ID: <20260226171743.61885-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 17:18:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3293

From: Yoann Congal <yoann.congal@smile.fr>

These build setups are frequently used for stable maintenance
work. A shortcut is appreciated.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v3: only -nut is really useful here (-next was removed from the patch)
---
 schedulers.py | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index dd692a4..38957ed 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -85,6 +85,17 @@ branchdefaults = {
         'branch_poky': 'master',
         'branch_yocto-docs': 'whinlatter',
     },
+    'whinlatter-nut': {
+        'reason': 'Stable maintenance - whinlatter-nut',
+        'branch': 'whinlatter',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.16-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/whinlatter-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/whinlatter-nut',
+    },
     'walnascar': {
         'branch': 'walnascar',
         'branch_poky': 'walnascar',
@@ -141,6 +152,19 @@ branchdefaults = {
         'branch_poky': 'scarthgap',
         'branch_yocto-docs': 'scarthgap',
     },
+    'scarthgap-nut': {
+        'reason': 'Stable maintenance - scarthgap-nut',
+        'branch': 'scarthgap',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.8-nut',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/scarthgap-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/scarthgap-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/scarthgap-nut',
+    },
     'nanbield': {
         'branch': 'nanbield',
         'branch_poky': 'nanbield',
@@ -208,6 +232,19 @@ branchdefaults = {
         'branch_poky': 'kirkstone',
         'branch_yocto-docs': 'kirkstone',
     },
+    'kirkstone-nut': {
+        'reason': 'Stable maintenance - kirkstone-nut',
+        'branch': 'kirkstone',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.0-nut',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'stable/kirkstone-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/kirkstone-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/kirkstone-nut',
+    },
     'honister': {
         'branch': 'honister',
         'branch_poky': 'honister',
@@ -504,7 +541,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "walnascar", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",

