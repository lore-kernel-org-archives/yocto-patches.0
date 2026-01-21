Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EAC44536
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 16:34:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15798.1769013273276826452
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 08:34:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=G/bA1wPV;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso283225e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769013271; x=1769618071; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFFgf4vNuogVmBuExZWJZQkCHEzWGEMcqVZMP3dhMIY=;
        b=G/bA1wPVDokGFxQ6hTrxqMQBwEtCCIr9n3BgCunQbcv7MQ4fNDbQ8s6ZKIY2eT+llV
         yZHXZ7HKbN6e43ahBxJtkkE5z0RB+gTjv/hNcMS6eyWJ0WzHr5W4PqSc2+FfUOh5jDtw
         MiN+JAx7CHlGfPiXBCWX/JBXIPhP68lGpOM34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769013271; x=1769618071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFFgf4vNuogVmBuExZWJZQkCHEzWGEMcqVZMP3dhMIY=;
        b=bl+b279tqn2a2JMzNIIGsZuj7eqd8FgG6Sfs6vrIqBUMms47VK3/pifBqJ+EqSroVT
         j5/zxHtkBFsRRneNgnxU/sMVvCQNdh+WFsLq3X+eCU2my/ufJ0Jtjy7i/SlcDXENYdx6
         DUSWToMJ3e+PBzFWQKggOJ8LcjOCB2lo51eop74jPSnJCC3Y/CivOGlJpGMgU46H8L4e
         XlIZybqQrdjo71M1g1WpsHMXR+z+zVH3KKFKjz5ZvPBQICrBBJccgz5U748Cy93a1k+j
         Zpkyd0KZ0gaY/OISiYVKXkkjGUVvf72BL8C3XXFW+7SxBq2fBsNJaCBtOUT37mJvxK0K
         htzA==
X-Gm-Message-State: AOJu0YxMP/pphcxdUjAvftEM4YHuQtBB/SznFvPvbCI9Ezl4XJ6x/bGO
	0nGGe6ut4SJEhrI+lu9A3IV5YHRUKlShy3DXbgZV8VAfgDho+1mQeVNjfsucPpDPKPJtK38j5HQ
	JAsgL
X-Gm-Gg: AZuq6aLye9sMJ3LplpC1rw+VBOJLDbqL0UWvOz1jZORqKMPQozckVdOet+GB5rsB/vy
	fP4XukjicqgMRwDiVeNb846DvnzwhkUhzM+p4CmhZBtQj6I9d6RapWM+1bqdHUtlDBZKyW7UUSV
	7eIeVLE+6nSbHB8y2hkZUaXyerWb/Qa7Qz8/9aOPfOVnnHFyLHsq8jlEPbiS1eF2vLMdd/Q33y5
	c6Io/z/U3ac7G1W05vnZzevXDN/S1UUfd71kJ6LQhoO2uIsN062nxSgRo7zHa5yqXoJsn8rbnuJ
	mp1qfvi3TDnF43SiDI/hLI3woINRexU2MQWxDD0FCmeUOWMp90hde8ZzRq13ssvvGMKcEWnw57n
	h+cNJy21H5MObqIAz1mEMUaOsttuKMb8MXILDYpK8HdxXIIUZg9T/AmHpMb9ZQXZP02jWtMm8qk
	/T4SZie4qVQ0vMTmC6G9Dpwq3SPLJUu8r/vEvM3ERXCwARd1YsCVkJFIrKmbTZRS9VJOgv1eqsW
	ruNQwgo3pXaDkA0oWfU2SR6clEgAXXq
X-Received: by 2002:a05:600c:3ba8:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4801eac88fcmr282186275e9.16.1769013271244;
        Wed, 21 Jan 2026 08:34:31 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042b6a3e2sm26955775e9.1.2026.01.21.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:34:30 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 1/2] schedulers: sort repo branches in maintained stable branches
Date: Wed, 21 Jan 2026 17:34:08 +0100
Message-ID: <20260121163409.59824-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 16:34:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3042

From: Yoann Congal <yoann.congal@smile.fr>

This should help seeing if any branch is missing by comparing with the
"Build Properties" page of a build.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 42983a8..0018fcb 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -73,16 +73,16 @@ branchdefaults = {
     },
     'whinlatter': {
         'branch': 'whinlatter',
-        'branch_poky': 'master',
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
         'branch_meta-gplv2': 'master',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
+        'branch_meta-virtualization': 'whinlatter',
         'branch_meta-yocto': 'whinlatter',
-        'branch_yocto-docs': 'whinlatter',
         'branch_oecore': 'whinlatter',
-        'branch_meta-virtualization': 'whinlatter',
+        'branch_poky': 'master',
+        'branch_yocto-docs': 'whinlatter',
     },
     'walnascar': {
         'branch': 'walnascar',
@@ -120,22 +120,22 @@ branchdefaults = {
     },
     'scarthgap': {
         'branch': 'scarthgap',
-        'branch_poky': 'scarthgap',
         'branch_bitbake': '2.8',
-        'branch_meta-arm': 'scarthgap',
         'branch_meta-agl': 'master',
+        'branch_meta-arm': 'scarthgap',
         'branch_meta-aws': 'scarthgap',
         'branch_meta-clang': 'scarthgap',
         'branch_meta-gplv2': 'master',
         'branch_meta-intel': 'scarthgap',
         'branch_meta-mingw': 'scarthgap',
         'branch_meta-openembedded': 'scarthgap',
+        'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'scarthgap',
         'branch_meta-ti': 'scarthgap',
         'branch_meta-virtualization': 'scarthgap',
-        'branch_oecore': 'scarthgap',
         'branch_meta-webosose': 'scarthgap-webos',
-        'branch_meta-qt6': '6.8.1',
+        'branch_oecore': 'scarthgap',
+        'branch_poky': 'scarthgap',
     },
     'nanbield': {
         'branch': 'nanbield',
@@ -185,22 +185,22 @@ branchdefaults = {
     },
     'kirkstone': {
         'branch': 'kirkstone',
-        'branch_poky': 'kirkstone',
         'branch_bitbake': '2.0',
-        'branch_meta-arm': 'kirkstone',
         'branch_meta-agl': 'quillback',
+        'branch_meta-arm': 'kirkstone',
         'branch_meta-aws': 'kirkstone',
         'branch_meta-clang': 'kirkstone',
         'branch_meta-gplv2': 'kirkstone',
         'branch_meta-intel': 'kirkstone',
         'branch_meta-mingw': 'kirkstone',
         'branch_meta-openembedded': 'kirkstone',
+        'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'kirkstone',
         'branch_meta-ti': 'kirkstone',
         'branch_meta-virtualization': 'kirkstone',
-        'branch_oecore': 'kirkstone',
         'branch_meta-webosose': 'kirkstone-webos',
-        'branch_meta-qt6': '6.8.1',
+        'branch_oecore': 'kirkstone',
+        'branch_poky': 'kirkstone',
     },
     'honister': {
         'branch': 'honister',

