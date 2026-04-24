Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1370EFED3E6
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 15:32:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25584.1777044739962684002
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 08:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=eZnxVj/H;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B44621A33E8
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 15:32:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B3AE604EB
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 15:32:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0251B107202C5;
	Fri, 24 Apr 2026 17:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777044737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=uz+drG6Y6FD/8IKUNkIkTyP7BJMsitblzIhuFMeoRIc=;
	b=eZnxVj/HvsbSOmwhL1jslYFPc4eQkZiSNU6KzKGJUJChiNXxnaF/HQuc4hLInsy2OwTpzv
	9SFlzcw6ZIEnNA57rkeSNHMrt3f0WrftY7KjFFiP1maXMLesT+CoF4VP3Oxm1qyzpJvD3E
	ts6SxYeOCMj0B0CPj0gB3FFIWtE69sh9ioggXsX/fiQ0naxC7bWJ85M6QSU4fmqh/T3dNB
	21VHAN6g3LEkTABUl8Dg9socJbnluuFJsn2PLebuA1PL44PMS5r+v+RWV/ak2lbq9ct8pB
	ykfH6AONN5w+crSHzc9iYbH5qyhZsz7RRI80Sdlh2MN2kmiCci2vhXxvXY/4uQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 24 Apr 2026 17:32:12 +0200
Subject: [yocto-autobuilder-helper][PATCH] config.json: metrics: silence
 warnings from sbom-cve-check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-silence-sbom-cve-check-warnings-v1-1-8f320dcdf586@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBBG4auYWTsJNAjGqxAW7fALo9iSFlBDu
 Luoy2/z3koJUZHoclgpYtGkwe/IjweS3voOrO1uMpkps8IUnHSAF3By4cGygKWH3Plpo1ffJT6
 dqxImt1nlDO2VMeKqr9+hbv5Os7tBpm+2fgeZAtt5Cm7WoUXkHsOI2NC2fQAudpJTnQAAAA==
X-Change-ID: 20260424-silence-sbom-cve-check-warnings-5876e21a07b2
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=yl3YjmNaOrKA00g1+kn+/jKESdPky44KZKLmWxmzN40=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp64z/iopkkHxHTYh9hi+IHSsKsrovDYUgLlTO8
 gHJujMpa5uJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaeuM/wAKCRDRgEFAKaOo
 Nq7pD/99J6eO8K9ugG0KSZl8MJ+fRTYN/m98wa1RpAQGzF/JjBkoCLbukTR0+cxMtkNHOc0PHXG
 wyovk93pKo+f+wMOaKMCnx1MDInLl1osFKlzqtppsy9yFINyPSqL+k0dBinapGutdZHENW3lLIF
 wokPDYr+48NEHs3YGHhTKDx4cFeuuMi+Q+5pA61uIaqTqulZzIpDDa1uMJhufdcrK3CySpdRQMj
 Q4102jk2Pp04FGWw1XwN5fP5qTHSp1jCJZF/HGVV+iRSnOH7ysKcOmUBuLUoZYAlNiWNPcJ290C
 X9L9j/BrBJyO/PsVtbTJEavLLPVXFB+Ulcll4wb2vrMMf6VHdH0yALKV3P1FXLQPklpo010UtRu
 1OZGp8paVrjZdrvxREfMN/g/T+S71cS8oKMMH4+FOPeCSEniZPfq+ScswF3eIDjK/I13kVAbbsS
 CYgsSrSh0k9X+e2KHXVF1doIui0kzwWC7oEvK6ApfrXMzUegkygxDMYhNWMev7wmKSYFh3qmqCp
 /SstAIaUOChMe7qerHKxc+bBwapmkg3SXNBno/msRzXt0UAnuJNPZBgWqcrvar5k7xxcSL5G4p3
 svnGC16Rh+dUx5+0Keuq6dcxTPccOmcvt7bhg/yAwvl1YeX0L7RdipDWOOQbPoUDDtVv4QtFK7H
 KxQjGQPBMF7s0eg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 15:32:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3804

This used to be that way with the cve-check class but that variable for
sbom-cve-check was added just recently [1].

[1]: https://git.openembedded.org/openembedded-core/commit/?id=5a5162406ffed68fa82476f81c0709c2a05e735f

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index bc0c031..beb03d5 100644
--- a/config.json
+++ b/config.json
@@ -1388,6 +1388,7 @@
             "extravars" : [
                 "OE_FRAGMENTS += 'core/yocto/sbom-cve-check'",
                 "INHERIT += 'sbom-cve-check-recipe'",
+                "SBOM_CVE_CHECK_SHOW_WARNINGS = '0'",
                 "BB_DISKMON_DIRS = ''",
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"

---
base-commit: 251dbadeb48a21c825c952a140b42523e5463229
change-id: 20260424-silence-sbom-cve-check-warnings-5876e21a07b2


