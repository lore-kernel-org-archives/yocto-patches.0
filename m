Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5494.1792496784418961403
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 04:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=k+POeGIK;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 257764E41290
	for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 11:46:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D07F660393;
	Tue, 20 Oct 2026 11:46:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 701E510328934;
	Tue, 20 Oct 2026 13:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792496777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GYrB/zqexuuREitjXym2o8oOZZrpH4SJ6fX0P+ZWBbA=;
	b=k+POeGIKvZP3UqSTDQRHM1LSxdTQkae+eT7Ng/eeFk6710FQGN0cXlZLKq1MHev34OwzQE
	x5VPvbyhJfML/N72Y5BJQC7mm49FehgSeYH9sJNDI/lUjnppAtNbAuGcC5psSt044CZWx0
	GiCcNkxkbSsLQ2MKPS8idG71qthaiD5lj1N5URx94tc8rmGf5RlGL0vDpEY43B+JQdtslW
	8zTMu0IPzI0zvwha6Iw9wol7d0tEclRlm6O0VOUq0Wchuyhe8/MRVFeuPDnt3Jrw0I+BOh
	rDgOrr1rRfkRFSyeMqBaifG1rceemBoCiQzh10YBrea4C2G+pjphT0KcB6oaHw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 20 Oct 2026 13:46:07 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: Fix meta-meta-agl branch
 for wrynose
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-mathieu-agl-wrynose-v1-1-f1bc4f908055@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAH5U12oC/x3MTQqDMBBA4avIrDsQpyVIr1K6iMmoAzZT8tNWx
 Ls3uPwW7+2QOQlnuHc7JP5IFo0N/aUDv7g4M0poBjJke0MGX64swhXdvOI3bVEz48Q3a8NA4Tp
 6aOU78SS/8/qATX1RdLXoWGUNnAiex/EHyPd6h3kAAAA=
X-Change-ID: 20261020-mathieu-agl-wrynose-fe466d82d3bc
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jan-Simon Moeller <jsmoeller@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792496776; l=745;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=xippmkSlTrKmZeFYTp4bR8aKl4qSKKVkMXBV4At8Ss4=;
 b=ar6nawhGWVzQvjfbdvyBAWqKtvMD656eUC2qByW865PETxu+PZEXlFUrCPCHDiL7iNGE+sviO
 oUDcEaHBn04CnzOKLums4M0FWcz4X1h793acMu5BrC2qIwKtitd7Z/i
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5109

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schedulers.py b/schedulers.py
index 5577f5b6fbe2..2bfc36ed4439 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -94,6 +94,7 @@ branchdefaults = {
     'wrynose': {
         'branch': 'wrynose',
         'branch_bitbake': '2.18',
+        'branch_meta-agl': 'master',
         'branch_meta-arm': 'wrynose',
         'branch_meta-aws': 'wrynose',
         'branch_meta-clang': 'wrynose',

---
base-commit: 8cc2acaac17df5a15f7c58a330cf30e4a7132d7b
change-id: 20261020-mathieu-agl-wrynose-fe466d82d3bc

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

