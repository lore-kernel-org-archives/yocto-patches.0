Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809ACCAC59C
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:51 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.31618.1757938908519942781
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 05:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=cVpZix74;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC48AC8F1D2
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41CE66063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98BCA102F2A7D;
	Mon, 15 Sep 2025 14:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938906; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vzywlSxOyUSoOpTP64DfouGBX6jbUMtCaAZbhonQiKE=;
	b=cVpZix74CMk95n4noU3MU2PXDsT9hWjIxpDtk4gBn9v2zTpTP3o/C6GqK2KByZ4ZCdNYt/
	pMbARwKqRgJZfP7T1cRCh8NpJq0reoXEFyPsM4YHeNuTzxNP47Eg4fYmnoILiht9U1H/98
	bc8MhN/ELPxQEIjuIcjdHVzevG3Ifx1K2dG709RdjIowy5biMTj8a3ZewX9n0+Z8wqdOnU
	N+wxnclAeL/mltWktZVndgY4baDKPjjI5qrOS9XTAEo50AVkosORqwxwBQ5rbknbn6PxDS
	Y7EdFr0VDAvHSAiO3waP3V0bwzYeFQz8ZbUmrBZzU8c8BkJn79CiFQ4F/dSF7Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/3] scripts/run-docs-build:
 improvements for the bitbake menu
Date: Mon, 15 Sep 2025 14:19:46 +0200
Message-Id: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIEyGgC/yXMQQ6CMBAF0KuQWTuJNBCIVyEupuUro4SSTiEaw
 t1FXb7N28iQFEaXYqOEVU3jdKA8FRQGme5g7Q+TO7uqdK7hWczYa/byBEvIuoITRojBuIb4UNZ
 N21aBjmJOuOnr13fXv23xD4T8Pbt3DDmyLDn6RcceiQeMM9KV9v0Di4oqHpoAAAA=
X-Change-ID: 20241227-pass-bitbake-active-releases-5eabc157884c
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=p+lV09SI6TL7eFzRCbjh2wZM1HLPchYDlhk8qV1l6Qs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATZ+/7lyTO6YkhRJ9+MK92Zi0OFxWWFci2Uy
 fFLN+d3LeGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgE2QAKCRDRgEFAKaOo
 NvRtEAC0jN28a+mDSDHXAFvnd3mdNrM1ilLNfS3Z9OJZ/ca3N1PhU/m2fvGzcvP0ZOu1ytmFwQI
 9crosAU9+K/mhwA3X8ZUqLKiwcqzds2Gx1pv4v4g9K7hlQsFBAfy+JlkTl0LNry5keQ01GCtExU
 OiYCEVaQlCwkY5b0Au+2+QGglusP+dxdLNRRuJmPoVp+jSWrnVAPeBL8ONhnIm9buiyl1UYg0XR
 iCrfE7j7fgikDVcD6DpzyvDlIjzfl1FxE0l+X9hKPyBdj7RBbDLmbA37cpPH7+yeFYx5ucRF4gv
 kaG/xYeh50b20s5clBAFHnEwUrhtolZmMVeZtowK5zYswUoHQyqWe88uNP+Z3uaEe5VySG68tWs
 aWWa/UVGlgu5zxTn7JpIOxQIdRgTQgHu9Hua0kv+51gWTKzmz2LksZhVkr7Q33MPfnxBTkV35Nj
 TzTyngUVzGENNmbEiM7JN+XBV9xx5XQRHG28PtxfbyL92jcPekniagvKQmJmWC286t4wU95BkmT
 s0ugkZiM6fGzpgw/5uF19Ly8pEI7wM1mGDejW+U3B8GO0ZAxfFo4ElfmWzMvljnUcAJqQwu3Z7+
 MBeLER1X/1D/mcjBUdEouWmCD/U8sfkEjK67I5PNCIOV+pc6fDXn9+1voBVkv15PQqqxcSu39ea
 a9DozFlwqaW4j2A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2187

This series comprises some improvements to the scripts/run-docs-build
script:

- The first patch is general cleanups and improvements.
- The second patch passes the current active releases to BitBake, so
  that the Bitbake menu shows the currently supported releases (in sync
  with yocto releases).
- The third patch passes the current version to Bitbake, so that this
  information is used in the switchers.js script and also shown on the
  sidebar.

IMPORTANT: must be merged with following series/patches:
- "set_versions.py: add bitbake-active-releases special argument" on
  the docs list
- "doc: fix the switchers menu" on the bitbake-devel list

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (3):
      scripts/run-docs-build: cleanups and improvements
      scripts/run-docs-build: pass active releases to bitbake
      scripts/run-docs-build: pass version to bitbake docs build

 scripts/run-docs-build | 94 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 35 deletions(-)
---
base-commit: fa3e15fba7fa96da520343c2ad312cefa6fc9c87
change-id: 20241227-pass-bitbake-active-releases-5eabc157884c

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


