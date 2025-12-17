Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C3FD65C78
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 16:14:48 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18336.1765988080112454719
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Dec 2025 08:14:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1g4KBp28;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4CC66C1A59E
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 16:14:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D75856072F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 16:14:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F29EB102F0ADF;
	Wed, 17 Dec 2025 17:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765988073; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EmVPlFXEnOBiEGgSHEfJS1Cx+jFyBfF4jBhioolpVRk=;
	b=1g4KBp28Skz07j9JxLpTwUJ0onO1oeABZRWXp+B1NVujrhxvW7aUzChWAFnInJbUQ1AQ5/
	oH37N0PMEEVIVkp3icXv48613aqIja9lh1luDkpGG5HwYHqLuXocFNkrD45QKv+AJY+NPN
	komyfvO2TkoRrYCqRgrfm4WgF3x1eZhKo3kxSTvjKFccWVe7rYxNIhaWSZ9A8vd8Qn2F5I
	MEWxKdcV/DfX10YGhybXtcorSMozelOwIbnsp10sdoge8HZBU+xI1Uf6DjFFYpoPSMf09v
	2oUGO6VvTzzNAtpnBz2ybeMNYk48U1CE5jRbSdRFg8Hh98NdmP2UpBp0imSvKQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 17 Dec 2025 17:14:25 +0100
Subject: [yocto-autobuilder2][PATCH] config.py: add whinlatter release to
 workers_prev_releases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-add-whinlatter-to-config-v1-1-9aeb42d212bd@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAODWQmkC/yXMTQ6CMBBA4auQWTuJVInRqxAWZWYKY0hr+oMaw
 t2tuvwW722QJKokuDUbRFk1afAV7aEBmq2fBJWrwRxN15r2gpYZn7P6xeYsEXNACt7phGSZ+Nr
 R6ewc1PwRxenrt+6Hv1MZ70L5++vfgWprSw5j0YUlmgH2/QNsa/zNkAAAAA==
X-Change-ID: 20251217-add-whinlatter-to-config-cadcd95c34ff
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=esZCtgDIR/3bFsQ5rUWamOvoyuxvv4DWSo/je1tGcKQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpQtbne3HtLhBm9LhHYyO39XisBB9cf1SNMZPmy
 b0mFD2d10SJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaULW5wAKCRDRgEFAKaOo
 NlL7EACltsX0xX36k3pJufY6U1ADPz3vav5+In7McqFybtDrm+AOHL2IBGeu3HFeBDseC46f5sy
 O3iQl83V2ilicN1g2wcpTmFdkOopS8za3GT6wCUi/JUSYHH83OtKIO+Mx98TW/IfjSx7XCJUYKM
 dgPhK0lqkdjRyp2oSKqVaQn30fgbHtCfy0X5NFDWWUDdYoPLNq8tRNF/fz5x/1DR8lFn+iZ+y9m
 5qbBgH3AL3hENF2FQQBgsafjDCevu7msN9L4iN26w2Tu2t5wGcvRMfs6jAYuWQHFLDdIyaGa/lj
 UsfPt4Pqm7gc/Ba9uvh85C3PXzsLEvKleujbQhCDS7i33NhH6wmoLhUT4PJy7dwDmcc0r6GzLze
 agfEIXW5o6KBvlEC2HM+ejqhL4tokDNKhXf5WLE1lJAzB66xF+bh7qdrygN5OPAlOD6sDiv4W4K
 es2tvQvm96rUkxfV985N3xd7b7tZQb9q0fO/aEiyPbiAxL1Xq8jFPqilu/9C+Pkd4XB5s3RC54z
 xIjneAnK8Pqd5RQwK05/iOkbW69NUfDMgq010je4jDQb5bA7gvaepQ9+wGnyNHp15m5ukjGMcGP
 dn+b5nNz+11vY2QGlGmpS4LEjYyKVXK+x+7Rc2uIRkLK6dECypFPEiDUwHqMCF5+t4yNUpx84ur
 Yal7aV+koS4quSw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 16:14:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2812

The list if based on what we list as supported in the documentation:
https://git.yoctoproject.org/yocto-docs/tree/documentation/ref-manual/system-requirements.rst?id=e7b40b71dec8d4aee2e7b711e7c1083b2920f171#n55

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.py b/config.py
index 50710bc..ace6c59 100644
--- a/config.py
+++ b/config.py
@@ -187,6 +187,7 @@ all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
 # Worker filtering for older releases
 workers_prev_releases = {
+    "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),

---
base-commit: 044e5fe818870ec93baf278e9564db233eae5075
change-id: 20251217-add-whinlatter-to-config-cadcd95c34ff


