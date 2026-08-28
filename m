Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D55C61DD9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4378.1787917133298267761
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 04:38:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=X779eQIF;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB8104E413D5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EB7960537
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEBAB11C781C7;
	Fri, 28 Aug 2026 13:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787917126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hH6mJ4xrGcETo8V7LqWzHYNDAwVtMMM6nCDLoVybpDU=;
	b=X779eQIF2ltgHV54b/4gXQSfdlopHFFJMJnw80A4sMzvbxM4cJagjHrr3KWtMqj7o6mKdg
	X8R3mhl96jqSjn/ikGRy2y3pj4RmqV9+aV8zOIBvPKaEmJQeKBpDR3whWp3jVlUYHwlX28
	xdsgxb6b80IXq9+8CRUuraW77zWtDicl90aziTsDiXvERvv4ZKjwU5FsgXq4DjGtLmsIXx
	u0wiPyVmNsc2gPE5M89J8l1d2g2uPHRF0eIKbC/k0OhMw+LEbdxKtbrxmyJdjunM2myEe+
	BO2G5HxILj3oBRgIOrsZxqkpBxhzmKrWYgoWEWvN9TH/RFs5lXryO5jivDw8/A==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/4] scripts/run-docs-build
 cleanups
Date: Fri, 28 Aug 2026 13:38:33 +0200
Message-Id: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJKcSgVyEsSjvKKGlJp0UN4
 e5WXL7F/xsIRSaBa7VBpJWFgy+oTxXYyfg7Ibti0EqfVadbjNmjC1ZwzDw7TC8yT0Fyrhtr2zb
 q0kBpl0g3fh/ffvhb8vggm36z/hNsCmhyCseFIk40LxQH2Pcva42iwZMAAAA=
X-Change-ID: 20260824-run-docs-build-tweaks-edd8b1c43093
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=695;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ZR3Ms3164h4ARlg2mY0h4TpdRYroCZrzXmnCkC+KJKM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqkXNDGaBHjGdS/LtJUclttZlDuaegnItYA4K2+
 u+OuBY5KgeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapFzQwAKCRDRgEFAKaOo
 Nub1D/9yif21bSjENtccKeKT1I9klUeKUx5vM6dmCgWaLaiyYB0y6HELLk9cgRdbbL/PWpSM5ro
 r0RlUGb7pkHTxeexg+NAoIHMsFskBxF8l68AlQ6BryE8Dc8d9LtUmbis3snSFA2FFMXzJfJfTvh
 qAlVxgLRi+hW0miViSu4DtMaEKUqwM778hEVmMqSHfDcxo/EwBNjTwhw4wdyHVi+mv9VvuwHxh9
 1oB0DztIte7j1eVI1j84NXAcE5IexCuCG0+DWy/NHVJ96/tVqMGMx2zyGFL77XyFB3u1bRiT5AB
 m/HPu9xyOX7fxQfBw9lZ+JRA+K8Va/50qiYr/MQZRs8etUE+CqKtzuoKe3pr2CRRZP2ds2Jo0ti
 vwfJVoBlqiERICCtcA2opkR5jB50sTmjQhahjd5OBq60cp85UPb8zPPFAgk3gLS+e6t/Iee+1Bm
 H5WplnLrZCytv+jsqhC2KUgqeT3pwZrDwm8QlAe/BuQzYJVaTOC9qoRKHmmNBo5hdlpyf8V56XH
 5Tj/MKCw+kOoQYcdEIn/ZXMUiX/ijFu/LfI9ccVhRLJz1B/wjSyCu+hthovv/z79afhyUW2u0E2
 041PzkoqYtQW4b4LtLArWj9ThnotYPryzdk+dHXM2X/5QN7arrQ7MMUmeuDuBrLSo2DIgI3+4PS
 a+u1vRuHtgK/Opg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4714

No functional changes, only cosmetics and shellcheck fixing.

Test build with this branch OK:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/34/builds/588

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      scripts/run-docs-build: fix a typo
      scripts/run-docs-build: fix indentation
      scripts/run-docs-build: fix shellcheck issues
      scripts/run-docs-build: use a bashism

 scripts/run-docs-build | 121 +++++++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 59 deletions(-)
---
base-commit: ff7149fe675bff1f57f4f46c0efc5dd5029ce001
change-id: 20260824-run-docs-build-tweaks-edd8b1c43093


