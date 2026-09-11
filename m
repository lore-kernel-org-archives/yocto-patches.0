Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0FC88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 07:57:42 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34658.1789113453577011006
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 00:57:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=A4pyEkE9;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 32545C653F9
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 07:58:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68F8D601DE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 07:57:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99D9411C78AEE;
	Fri, 11 Sep 2026 09:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789113451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yeSMO4+IfpVZPUxe4aq/t4Ny2+tPVvpAnUfQ37b7RJI=;
	b=A4pyEkE9b0/5aNISqUoDqOguQGlRSUWYfdd8/iMF+Glvmv7/JqEhXWXJzTCQMAYMyW6q0w
	mJJqA5R5whlOFI/7nQw+nucqihpuRzmntF9Qw9w1fLZ+jBVxnechFJTM1QN8TQ79XPhbSo
	xykMDD2+P+nukNe6ksin++1Z0xgO6J0MMcPhSIOfniC3eYPvkGquxgmzcaVjM3G1BgC8vN
	TqCLNpGxOvvk2DwV5Xq8+bKrPbxIMiV0ck67KuA3E7v+xdc72B/O+i1Rt2U2idezhTeTN6
	YfKP2Ws9sy2tOIqRtNhYqMT48O6UibQ7MtkNt2++LpAFkfgzLfm1NN9neJiSXg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 11 Sep 2026 09:57:16 +0200
Subject: [PATCH yocto-autobuilder-helper] run-dashboard-index: Show curl
 errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-contrib-mathieu-dashboard-curl-errors-v1-1-1a443c64f0e9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFu0o2oC/x3NwQqDMAyA4VeRnBeogoJ7lbFD2sY14IykrWyI7
 76y43f5/xMym3CGe3eC8SFZdGvobx2ERNuLUWIzDG6Y3Nz3GHQrJh7fVJJwxUg5eSWLGKqtyGZ
 qGecxTHEh55aRoLV240U+/88DvhqKItWivsoa2TDxurPB87p+YDC/3pEAAAA=
X-Change-ID: 20260911-contrib-mathieu-dashboard-curl-errors-95c6dfa00f5a
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789113449; l=1371;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=p6ky7OyYbvUTrnHZhHGfpCAZ75Tv5CrAvdmgj6c43G0=;
 b=9hkpc69ecNKplBedqruM1KtR7nktWt1OQE4v5g4ZQrVu93U842RNljqvJFU7Ud2s3jeQ098h7
 2G6Z09IeDC8CGSMkr13KKHddMVeb54ZQqQV5n1hcyxbirHNpx4lF9J5
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 07:57:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4765

The curl command has been failing a few times over the last days, but is
not showing the error source. Mare it a bit more verbose.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/run-dashboard-index | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index c7beca3c58e3..3a70ccd897e7 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -18,7 +18,7 @@ dest=${DEST:-docs@docs.yoctoproject.org:dashboard/}
 cd $builddir
 $scriptdir/release-parser.py $builddir/yocto-docs $builddir/repos/bitbake
 $scriptdir/layer-parser.py
-curl --silent --output $scriptdir/dashboard/testresults.json https://git.yoctoproject.org/yocto-testresults/plain/oeselftest/reproducible/qemux86-64/testresults.json
+curl --silent --show-error --output $scriptdir/dashboard/testresults.json https://git.yoctoproject.org/yocto-testresults/plain/oeselftest/reproducible/qemux86-64/testresults.json
 
 rsync -irlp --checksum --ignore-times releases.json ${dest}
 rsync -irlp --checksum --ignore-times parsed-layers.json ${dest}

---
base-commit: 4e83aa5617eb01342b90eee1dcf1003dfbdee06e
change-id: 20260911-contrib-mathieu-dashboard-curl-errors-95c6dfa00f5a

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


