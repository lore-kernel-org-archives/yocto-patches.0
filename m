Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833D0CDB46F
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 14:46:50 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23152.1782226003456507823
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 07:46:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=07hmP4r0;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 322D74E40773
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:46:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01BA8601C2
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:46:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5069F106C8382;
	Tue, 23 Jun 2026 16:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782226000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HQovQlpUF2tTgHgJ2fmxsFrIt1Q6l3+mOrHfgCVpsGc=;
	b=07hmP4r04+7zrHveme6eGn2F/mUItq70VI1QiJ/RUza47ndm5xHOasUzJ4V+kS4M0ISgiB
	cWh1MdLDBbQ22P15U+n7gelkMe7cO1+AvUWKdBsI2E5yrTV2EkHXKu0K9uLx2GO4RDzu4F
	eZIbdT1Gy4Lqd6EL5Xf65S2cEXkBTTAtCFPLJBAyj7r+HkTh3si6pXA52Azp/6c50s3w6P
	R0heJDO8VgmgfF733bG2FDek9cGoJM5BdcWpFu8amu96Co9DbXmXC5QPXDRI5ByaKrTwj6
	eeMH6U16U1P2F7puspeCl0LP6CSJe2W/HbZkdlvN2tQaUsppDbLh2UDBifWVtQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 23 Jun 2026 16:46:35 +0200
Subject: [PATCH yocto-autobuilder2] config.py: Add meta-lts-mixin layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEqcOmoC/x3MQQrCMBBA0auUWTvQpDRaryIuxnS0A00iyUQqp
 Xc3uHyL/3conIULXLsdMn+kSIoN5tSBXyi+GGVuBttb1zs7YCBdhCsGVsJVCwbZJOLoRjORny6
 DOUOL35mfsv3HN/gmrwmpanpUWWfOFu7H8QNR3fN4fAAAAA==
X-Change-ID: 20260623-mathieu-meta-lts-mixin-56519ac98317
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782225999; l=949;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=I8RCj+elcXfIiQaE4EiSXD7fkiAuKBNXi2AIFBDwl5I=;
 b=pd7ykSEficzJ5H0TKouP4j6MrJpFvghhS7KFVL9uhRlRrviyqZPDT/0+abKl0djUsQ89b6d1p
 TIRmDTlrtqMBEC7FA+XOKFHGhljWzoYJEzREhGU16u5tI0gDjSbonNb
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 14:46:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4283

meta-qcom wrynose branch has a dependency on meta-lts-mixin: we will
need to clone it during some builds.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.py b/config.py
index 63e8b5627ae2..438753395da1 100644
--- a/config.py
+++ b/config.py
@@ -70,6 +70,7 @@ repos = {
     "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "master"],
     "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master"],
     "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
+    "meta-lts-mixins": ["ssh://git@push.yoctoproject.org/meta-lts-mixins", "master"],
 }
 
 trigger_builders_wait_shared = [

---
base-commit: 007f5ad32b586f52a4fe53e3069b7ff7f0461372
change-id: 20260623-mathieu-meta-lts-mixin-56519ac98317

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


