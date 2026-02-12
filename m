Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48509ECD6F0
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:40:03 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41551.1770885600630428220
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:40:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Q4SMoM1h;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 05A04C8F472
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6570606CA
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:39:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CCA82119714DC;
	Thu, 12 Feb 2026 09:39:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770885598; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IFpbIe4ZIn0Xq6wfUCcZV/xuX2n68VIs1HpDNPZINGM=;
	b=Q4SMoM1hIsvLdNI44xKMpLqABGFWAzuI+nMPtpzz8xTvadv12Um3qWYs9FwMtgV+II26Li
	cVQuYNfeFfeWRKd8hv4N9x/ZooYa1L2TnVlS+J1T+U/14QQsi7b3Xg/x2AEe8UKnl/7Kdm
	AVXkkVa4XyBkKF4oz9m4gmdlFnyJewAXnwkAtBiz3TplCuiNF4crBuC1/Fc0Y5aaZPORdo
	7EMnlxzAeMqQOnsLTUtjFlN/Q2RQ2zAFLo55QhTy5Nq2grZjlgeUDQtkrHrCgsyC0crkdw
	pFFX9bIrRY9fZZZ4NFiMVjb2mc3Gst0Fbei1Cw0n/kCd/vo5P35wNcgKrdQgIA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/2] scripts/run-docs-build:
 Adapt to new yocto-docs switchers.js
Date: Thu, 12 Feb 2026 09:39:46 +0100
Message-Id: <20260212-fix-switchers-js-ydocs-v1-0-ab1113759747@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDuQWmiwVxEXMZk0I2Ikk9iKe
 Pem7fKD9/4DhBKTwKM5INHGwnGpuF4asMEsT0J21dCq9q5a1aHnN8qLsw2UBCfB3UUrqG9e+84
 4a7SHel4T1eUv3A9/Sxknsvlb6/doc0RTchwLz44SBppXSgOc5we8btZWlAAAAA==
X-Change-ID: 20260209-fix-switchers-js-ydocs-73f7f9adca7f
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=570;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=F9m8UNC9VvzQoxkmruVd4p3bLlENxRZbwEnCKiYLhHg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjZHd/BGKumNCdQUfvrhqXjeX7vhRiZeYWJRn7
 YNaI4K2IDuJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY2R3QAKCRDRgEFAKaOo
 NgnFD/oDrmDfaUH3mNB2vqKJokElmf/HoN80o4xfFXsGELaDGvobgPJySuqqtUkFGkBuLsNjF4i
 fjS5feRsZ6ybkH+JcTvKK/9R57+g1YiKlmwbdNH7tFtUNZUfctppKDlX1shGJQkDJ/jpsjFvr5J
 dmv4mkXRzY3qJZ0znLm/k+YUMGBer4kNiDz/42Xee0gwjQy0kQ7YTybHokxTK9zBuVjFB21ijQe
 UFCUx7pRROzTiV5Vvr38lHpsLSCy7f2nGNOYoMi7GtuVdLDIIa/HHHz3L+LIoA0z/P72JeHTaFl
 n/41wr+95sWpP5HOW8LY/vTldJLBD/Ma+jSkJmWtalRi0d3tMwIRGuX8QasLK4BtzcCFjVdi4MU
 JPpmndn+8r8hgx8FEqDmTldB0SyNPmZZVjTaaqGaVfFXiZgRSSyg3qv3LoV74Mn+2fR2R5Clp9G
 ppx6MV0YLviAlX49id2A0g341/UHmzBdZFrIDZH5n8BBUBig4TBdkP/JG7eNwhErTjR8HAUIttZ
 Y7I1pcyt7MeTOAAqzigbr9UZ1JE8tsrXSHsDUYP8KUv+pix95VsPn47tiXqNU+Muir4WGe9X4KK
 6pZYYsKIJEc4oQabhkM6LsqgyVLlsIfpwjlaJOP22zLLDuZ09pr8RXTAc6XHGSrl6VawNu14p+y
 15DmSdDlwp5tbMA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:40:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3223

This needs to be merged in lockstep with [1].

[1]: https://lore.kernel.org/r/20260212-fix-switchers-js-v1-0-16d95c74c328@bootlin.com

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      scripts/run-docs-build: do not run set_versions.py manually
      scripts/run-docs-build: remove transition from built branches

 scripts/run-docs-build | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)
---
base-commit: dfa040ecf286a20afac1bd3360aca8e1158766d4
change-id: 20260209-fix-switchers-js-ydocs-73f7f9adca7f


