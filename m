Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F14EA4FA5
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 11:03:34 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33031.1771844611799397062
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 03:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2FbEiaif;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 73973C143C4
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 576485FD43
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51E2010368F40;
	Mon, 23 Feb 2026 12:03:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771844608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QeIZomYelOBlHzg7tthrOgvi05YQufL02y7/JMJdXsQ=;
	b=2FbEiaifAzVnzh3xheZ6yT961qWLl4tRsSLkY5WyV8WVU/jAgEKtSw48eDkZTOeBnu3Rk/
	J0x+SncZL9t5xcfeU6WnS78+9gp0IC3xWScLWxehmsIp/THbSITbN9wG08sr+juWQRbpoW
	4+JHZnky+yHH6yiGKdx7966jfTZ4gI8PWOE4ekv3cAIV5s2InLPKmR4GQKP2RrP/xChNyJ
	szfK/CJQcXAbqY63gFswVDjmmEF+oM9EHTERt4vmJrfB9zpMyL2GDHWRdyl1NsmC3NNCpt
	dR4p2uQQm0dWV0WgFFpTftU6Zi+DkC9a8K9EnuDJYcsYQP0FWCjFlzUCFymfxQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/4] Adaptation for the new
 yocto-docs switcher menu
Date: Mon, 23 Feb 2026 12:03:19 +0100
Message-Id: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=717;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=sL2lfxVQ1FhDn1tSGKPpRCOYUdPxgJT7QTKYHokkiic=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpnDP+W51V81Ri9KmXGy9O+52ymKDPQHMD52Xm1
 tkdLsp8QFaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZwz/gAKCRDRgEFAKaOo
 NoDKD/9Bdf5KWU0h/dtGEraxP4VS+AbX7Hm+u4iHomsfShe0jmGNoo30SN5EsLgaMvOMkNPnAda
 h9OpKspuRv8pAby9joTYdekPkIJqX6vdkoYxzlU1tBIvLH86zBpwxAxN7q99/rEO5UVgf8TLQho
 Qe5X1XsZmCQYmrsP00RqTRKoCOZcQgCopb05EF2FLunvI5peMGsy73JwPt805laQmuIZAiYrMLd
 sNFjkg+2XlMK9UGO6v4HJwhjWiNKKIGqMk/pmrwc1DG/KezerBKaIfv4yvLGkG0a3T9gDI9eHlk
 1RvA0XIYovSOXUMv+GclY46KZNT15aclJUD+3kpihT6k1icPK5a7z8SgdeW8Ps292r2FG/87728
 zH5iaGOXLmOHw3ys4oEEthI8EawGngF+WjI6oxIXMGi9ZvbBcDhnvJT8PtixXkFaQAvhndrlcOR
 Qo8IuySqrsSRd3hT/S4xr3lohG8m9Ls/HPHS+yuLtPN8FGDV2CHljzO9ptaf3VDzK8ZOwLpj9W5
 1dHigSfhCAax5FquVir3Qi3gQXJOL7dcHhW8EM6lmXv/uLwFJ3MZehOrQPkFiwJnikQUoiBGuhG
 Y217eUJbht5kcMriOC9jXprdPkenfjXEeYGfCIPpfNQuGXMuIMbKVkZzuhR/5L1ZPrY3LnY/SDl
 jtUgsSIPCbTD9sA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3263

WARNING: should be merged in lockstep with [1]!

[1]: https://lore.kernel.org/r/20260223-fix-switchers-js-v2-0-296523996600@bootlin.com

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      scripts/run-docs-build: do not run set_versions.py manually
      scripts/run-docs-build: remove transition from built branches
      scripts/run-docs-build: use git apply to apply patches
      scripts/run-docs-build: backport the footer.html file to all releases

 scripts/run-docs-build | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)
---
base-commit: 51e1ab8dffc637bfe4bebd939d85a10d9e21bf85
change-id: 20260209-fix-switchers-js-ydocs-73f7f9adca7f


