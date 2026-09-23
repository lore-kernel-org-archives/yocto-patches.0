Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751FC9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 15:42:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.836.1790178120761935853
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 08:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DGcIyeX9;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6F1941A0FE4
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 15:41:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D43060580
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 15:41:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB4561032924F;
	Wed, 23 Sep 2026 17:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790178117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=zTxfwguziyDwgWMKGVmTtcYd0HRYoIlQeVhW4aazpHQ=;
	b=DGcIyeX9LgvQCEsjt5qHpCOXY40ckAEVcTT1oglez0fFCSB5GN9bX8/GK8ZjcwGbiH8a/l
	/D6sMOqWrqD9kMRP+Uqd/yNwkVLxK9NamhUlw0Cu/9LTnfetHKV4mBSMd8ExfQo5VsZ6KD
	TdVUhdaoDAFbRyUX2yL6sNhvkDJ4zbZqlU3g0b0Mk62V+kmiPxVJ7qNVWYBc/8cg36lzMb
	s9xTpBp4xBb9ups803RWpyksFGUai4xLV+NowCHsJLjjHToPlAqUhU0KtsuL2MzdcC7ZcA
	fEF5fgAvoj7eo7GISWo4MbwcXlw+Rd8xMF9xV4qIAqh1WfkBinhOiZJGoQh6fQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 23 Sep 2026 17:41:47 +0200
Subject: [yocto-autobuilder-helper][dunfell][PATCH] config.json: fix
 cvecheck iputils warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-fix-cvecheck-warning-fdunfell-v1-1-bd0c0b400f84@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3Myw6CMBBA0V8hs3aSUtAEf4WwKGUKo01L+kAN4
 d+tj+Vd3LNDpMAU4VrtEGjjyN6VqE8V6EW5mZCn0iCFvIhONmj4iXojvZC+40MFx25GM2VnyFp
 sRWdk243npq6hGGugMnz9fvh1zOONdPqg/cvr5FHl5MfMdqKAC9mVwtD/wQGO4w0PDoYepAAAA
 A==
X-Change-ID: 20260923-fix-cvecheck-warning-fdunfell-409f249b5311
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=GzbFSfc37dUBW9LI1tccAO/KDQ3shcHDLHZ2w7xQEqs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqs/M+JWTet/3THxetpHhI3hbPWS7M/Uz7gE+nL
 VDxtba4BgqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCarPzPgAKCRDRgEFAKaOo
 NgWgD/9fZwvXPMQUfHXBTUFWqHgCpSQn49Ym8Qgv+beymoDq+KDdBswoWDWkqGEOgG3iHTHF8SU
 8eNigRe9TvF4+Goa5X/8TOOH77TgGbK87uuriincmymlLRiuna7GJ72Lu5NCfPecb3l3YgZz+WZ
 4jkBlN0e2cc0xWwMzNwkOefbBi2pj96MGVFIBhYPycYsC1optZUeNIDfVDy3Hmf1EqmomPUAgPy
 y8AVmMEHMhpmtJFKTKdwAf+8BGU0asOcI4tUNyiDVr5hdUzseb2ltNjdv4JTcz+2M/9guIcepuV
 tIeMpZZT0vyRs2F68ZwdBGyCGO89BRxydWxJRJLjNNClR1KIPobIH43r/l3X1adiT55MLQLRRga
 9tZNkYFX5pji2kvIUo+sZAtjOGr42Kgjid9eRx4DK8BvOOKlUcgqAFAb5A5LOWmFT+9ljQZEW32
 4RXiW9ofGGyzKb6lFyjHN5j5LPhUddfmaiRWT8eWv/YPmmFkl3+vhkGQam3y7Z8ypTTT07WOKcm
 5oJuMX54CtppXYp2PEMhKZKN2090NBB1iBq/fVjaiFErZvOq60TiPVSrDime0Hoag6Jys7BySzr
 WfkDCFv7Vbao3GUsxZDuD1SYSQat0A8vOuu5gdtsPFxiCl+hL7jYZ6SGS9FRUKrV88YLHrEYJJA
 PvzuG8WLejKB0PA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 15:42:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4942

On Yocto Dunfell, an EOL version of Yocto, we consistently have the
following warning showed during the metrics job:

  WARNING: iputils-s20190709-r0 do_cve_check: iputils: Failed to compare
  s20190709 < 20250602 for CVE-2025-47268

This is because upstream stopped adding the leading "s" to their
version. Since we can't patch Yocto dunfell anymore, as a workaround set
the version of iputils so that the comparison passes. This makes the
cvecheck class show the following warning instead, which is expected:

  WARNING: iputils-20190709-r0 do_cve_check: Found unpatched CVE
  (CVE-2025-47268), for more information check
  /build/tmp/work/aarch64-poky-linux/iputils/20190709-r0/temp/cve.log

Which isn't shown on the Autobuilder thanks to CVE_CHECK_SHOW_WARNINGS =
'0'.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Test build (not pushed to metrics repo):
https://autobuilder.yoctoproject.org/valkyrie/#/builders/103/builds/4111
---
 config.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.json b/config.json
index 94250e9..69674e9 100644
--- a/config.json
+++ b/config.json
@@ -853,6 +853,9 @@
             },
             "step2" : {
                 "shortname" : "CVE checks for meta",
+                "extravars" : [
+                    "PV:pn-iputils = '20190709'"
+                ],
                 "EXTRACMDS" : ["${SCRIPTSDIR}/run-cvecheck --metrics ../yocto-metrics --branch ${HELPERBRANCHNAME} --results ${HELPERRESULTSDIR}/../../patchmetrics --push"]
             },
             "step3" : {

---
base-commit: 59108a784c3d37f96f408d18993a3039a2e017bb
change-id: 20260923-fix-cvecheck-warning-fdunfell-409f249b5311


