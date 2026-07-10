Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085FC43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 14:52:34 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.760.1783695152027202602
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jul 2026 07:52:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=evGwZZlX;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5DFBA4E40D41
	for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:52:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D72B60342
	for <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:52:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B8C311BD1521;
	Fri, 10 Jul 2026 16:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783695149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=KhffR7ZurTIl4M60+Kx/yuU8t2kpQqDyCMqyUWMuvYA=;
	b=evGwZZlX16g7Sgece/DRfU0PoSCEkRY54tDJLepxfO5CSaUR+o548oCsc+x7qd3GVHYu0A
	DFwAzQrqXe0Izj6hgQUdbYlPSf8GpOl+qjIudVacHVhOlSHP5o0I4Q09i150kUN/p0yBfz
	ns7SaWOT/LjvXbMSFH/ZQBWXjMAVlpBvQ11Z13EpLM9ycOOf379LW7+5k0rYwzKmv1+2Go
	XlJqms8sLYSX2DGKIK8sCU+lyHVJqRQYXZWz8X9N2U1PeMeQUT0/3yR4yVWWPcSxslDZNt
	RBFmWwil+cpQnZ2in9Nu2S65xQskgKUIrsvfdJl9kdsk6bAzS9IzN6deXJmjhA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 10 Jul 2026 16:52:05 +0200
Subject: [PATCH yocto-autobuilder2 v2] config.py: Add
 wrynose/linux-firmware branch of meta-lts-mixin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-mathieu-meta-lts-mixin-v2-1-6321bcaf2e12@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABQHUWoC/4WNQQ6CMBBFr0Jm7RhabEVX3sOwKGWQSSg1bSEQw
 t1tuIDLl7z/3w6RAlOEZ7FDoIUj+ymDvBRgBzN9CLnLDLKUutSyQmfSwDSjo2RwTBEdrzyh0ko
 8jH3UlbhDHn8D9byex2/YvE0ezZx8O/PYUZDQZGfgmHzYzvYiTvNfZhEosLRKyfbW607Wr9b7N
 PJ0td5BcxzHD85rWGLSAAAA
X-Change-ID: 20260623-mathieu-meta-lts-mixin-56519ac98317
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783695148; l=1203;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=28oUdI+R2kn5B+mLBHXy9l95efpsdSbkWGWrJXsOV38=;
 b=kfUXPfq9P7ReVq7GDBLzmv0coYmQ1/c7ddElvLS2vE6WBOzK5MmHo/KnIHcBto1EmnnzPazLO
 tS+Ux1oyP91AvlPXANo7kz8ezCeR5QOf4o3tzuibtBs7GDeuF+3+Zv/
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 14:52:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4467

meta-qcom wrynose branch has a dependency on meta-lts-mixin: we will
need to clone it during some builds.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Reflect branch name in folder name, as we might need to use several
  branches at the same time.
- Link to v1: https://lore.kernel.org/r/20260623-mathieu-meta-lts-mixin-v1-1-0c552b4f6d28@bootlin.com
---
 config.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.py b/config.py
index 63e8b5627ae2..32e3869a1e4f 100644
--- a/config.py
+++ b/config.py
@@ -70,6 +70,7 @@ repos = {
     "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "master"],
     "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master"],
     "meta-riscv": ["https://github.com/riscv/meta-riscv.git", "master"],
+    "mixin-wrynose-linux-firmware": ["ssh://git@push.yoctoproject.org/meta-lts-mixins", "wrynose/linux-firmware"],
 }
 
 trigger_builders_wait_shared = [

---
base-commit: 007f5ad32b586f52a4fe53e3069b7ff7f0461372
change-id: 20260623-mathieu-meta-lts-mixin-56519ac98317

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


