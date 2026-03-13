Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE2105F7BA
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 15:20:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18395.1773415244360094373
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Mar 2026 08:20:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=E8Bo8+KK;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 375184E4267E
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 15:20:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0A30760027
	for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 15:20:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E25CD10369C7D;
	Fri, 13 Mar 2026 16:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773415241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZREaKVM+U4AayXmMw7jRBBllHzmspgSXeQ9JvczTu+k=;
	b=E8Bo8+KK9MKhBTYY+uJiN/9GidP2oxaaTEVC+sdfbqUrKpHoqjw0ohcXR8O0jNZuaTAdkM
	NEWd3uk03ZOdRWvI2/Co4N1T84Xxl+mCNpp1+Y3LWdAvAQEB7O2NdwpAMGu/P7Hqxnx4Je
	61eLOX86ISA+V2sJf/bc9b8PGrDcwW9rD4Gypeo5n0aNrlHz3bSG3Zz0GI+UmGYzfWoZOF
	aErp+fuJsV+NgJBTuanSFe+oSv/Q4YJGkE3PntWOW5y0FGMm4oLpOXpQpVSq82t3FrRwwW
	z1xOOOqFkrWNwPRBMHn8OauL5sIbZGlmazknBbZDoQJDUYwasKULOHa0eGNaVQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 13 Mar 2026 16:20:30 +0100
Subject: [PATCH yocto-autobuilder-helper] config.json: Improve logging on
 failed bitbake extra tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-contrib-mathieu-extra-tests-logs-v1-1-4cf3a400fc83@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD4rtGkC/x3NQQqDMBBG4avIrDsQTRXaq5QuEv2rA9bIZFIs4
 t0rXX6b93bKUEGme7WT4iNZ0nKivlTUT2EZwTKcpsY1nfO15z4tphL5HWwSFMZmGtiQLfOcxsz
 ovHct4rVub3RmVsVLtv/iQd/UW+JQLMUi8wDlCfMKpedx/AA8Pwj4jAAAAA==
X-Change-ID: 20260313-contrib-mathieu-extra-tests-logs-e63305eb4159
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773415240; l=1666;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GktR7T9NmtAlwxypI/Ttcb7R70FWyjhZNtqslti3ks4=;
 b=rM57scerKQ69D1pevZ7XzR0XnP1HIvl+WNd5u4Nx+WN8XvBaFgVeyPRZAMhJ4/tkBiFL67Tdn
 liIoUeAla3OApUaiL+1P0ZJdNOQyHTjIFetpT2O414KYYnS/OpsGij2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 15:20:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3458

Use the xterm logging option to capture the whole bitbake extra tests
session, and show the log content when the tests fail.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Log output is not so pretty [1], we have a lot of control characters, as
the taskexp is using ncurses. Yet it's better than having almost no log,
as we have today [2].

[1]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3408/steps/22/logs/stdio
[2]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3388/steps/22/logs/stdio
---
 config.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 45262c6256b0..c49378c8bea9 100644
--- a/config.json
+++ b/config.json
@@ -291,7 +291,9 @@
             },
             "step5" : {
                 "shortname" : "Bitbake extra tests",
-                "EXTRACMDS" : ["DISPLAY=:1 xterm -geometry 90x30 -e ${SCRIPTSDIR}/bitbake-extra-tests; exit $(cat bbextratests-exitcode)"]
+                "EXTRACMDS" : ["DISPLAY=:1 xterm -geometry 90x30 -l -lf extra_tests.log -e ${SCRIPTSDIR}/bitbake-extra-tests; exit $(cat bbextratests-exitcode)",
+                               "if [ $(cat bbextratests-exitcode) -ne 0 ]; then echo 'Test failed, printing extra_tests.log'; tr -cd '[:print:][:space:]' < extra_tests.log; fi"
+                ]
             }
         },
         "reproducible" : {

---
base-commit: fbb31b12e73053727a0f8e34252661aff9e8398f
change-id: 20260313-contrib-mathieu-extra-tests-logs-e63305eb4159

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


