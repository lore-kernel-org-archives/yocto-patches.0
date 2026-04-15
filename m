Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6FF4383A
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 15:00:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21165.1776265239462545370
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 08:00:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=Rc9IICca;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A2E946EF
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 08:00:32 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FBE13F7D8
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776265237; bh=V8PtYWdKv8FQjvHpWHRmN/u9dKsTvOtBlDO3wobga18=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Rc9IICcaaGAYu858Lco0S5OH1FecjLO63hdPtFx6tFBgWx879k5bGgTJWxDcTfDXK
	 EWEIfeUOEJXt153MI0+vx41Ys9tCuSnLtYaQAaMk658ckcCphUj3RpGpFFRfkcGdET
	 E21RYCLMxXzT+SHeR/D1++Y5UApMNBpdVqxiPgm8=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/2] config: filter CVEs from core out of the meta-oe report
Date: Wed, 15 Apr 2026 16:00:32 +0100
Message-ID: <20260415150033.1413106-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415150033.1413106-1-ross.burton@arm.com>
References: <20260415150033.1413106-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 15:00:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3707

Now that cve-check has been removed the evil genius hack to hide oe-core
from the meta-oe report no longer works.

Remove it and instead pass --hide-core to run-cvecheck.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 5cc70914..2db902c4 100644
--- a/config.json
+++ b/config.json
@@ -1424,7 +1424,7 @@
                     "${BUILDDIR}/../meta-openembedded/meta-initramfs",
                     "${BUILDDIR}/../meta-openembedded/meta-webserver"
                     ],
-                "EXTRACMDS" : ["echo 'do_cve_check:layer-core =3D \"\"' =
>> conf/auto.conf ; ${SCRIPTSDIR}/run-cvecheck --metrics ./yocto-metrics-=
meta-oe --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../=
patchmetrics-meta-oe --push"]
+                "EXTRACMDS" : ["${SCRIPTSDIR}/run-cvecheck --metrics ./y=
octo-metrics-meta-oe --branch ${HELPERBRANCHNAME} --results ${HELPERRESUL=
TSDIR}/../../patchmetrics-meta-oe --hide-core --push"]
             },
             "step6": {
                 "shortname": "AB-INT report",
--=20
2.43.0


