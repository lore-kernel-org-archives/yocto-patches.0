Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12387.1793625538571249186
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 05:18:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=p1nhCxay;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51D55C8F448
	for <yocto-patches@lists.yoctoproject.org>; Mon,  2 Nov 2026 13:20:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36D1560750
	for <yocto-patches@lists.yoctoproject.org>; Mon,  2 Nov 2026 13:18:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EE4B10328C5E;
	Mon,  2 Nov 2026 14:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793625535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=omSygveX5xtLPjpespI3yFo8uHYtVUV9F6e0oDUaufw=;
	b=p1nhCxay1YJwLCJ0kwR4ygD1cnf6nOX6mrM8t7Uc/aASpULlpX+ySKT5+mGRPeuiUwoNIo
	aY7lz7tDCnx+B+tz8TKhes9FNIXI3mqv1LMZ69N7nlCexwC8afDMoeLwM3BvQJRbIqGvS+
	UT1EQpxshgFyQDc49jgq9cqo6S8NlmnCJiBNv/YHy2rNJUclWTgWkpVU52m5SKVImz16O4
	vaqgwoyhcLLgAkIrkS2RIafWu/jJt5FnT33dRNWaeGuU5E9IA/Yk087/ysWO1yWO2quKTS
	ESo5IFcvz/QPOtweBwhYWxHD69wUaccFwO5FoUrMbL/hjdFGsfZ3s2fBUpN2pQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 02 Nov 2026 14:18:45 +0100
Subject: [PATCH yocto-autobuilder-helper scarthgap] config: fix meta-exein
 clang dependencies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-contrib-mathieu-meta-exein-clang-v1-1-e5f90ff30703@bootlin.com>
X-B4-Tracking: v=1; b=H4sIALSN6GoC/x2NQQqDMBAAvyJ77oJJbQv9SulhjatZ0CRskmIR/
 97Q4xxm5oDMKpzh2R2g/JEsMTQwlw6cp7AwytQYbG/vxvQWXQxFZcSNiheuuHEh5J0loFubgNM
 w2+E29A/rrtAySXmW/b94wTe6EpFqiWOVdWJFz2ti7bIjLX6hBO/z/AGqmk2IlgAAAA==
X-Change-ID: 20261102-contrib-mathieu-meta-exein-clang-d4f2454072c3
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793625534; l=1190;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=jKHqpJXHhBzRgRtluaU9RAVL+rYcO+Oa1bcKDN97sfo=;
 b=Vj8s04eKvHM3dCLXSvWkB/YtIunPEh9rTpyLEm8kEXjVz6zC9hEIdUR0NWFBKJm6gAqjbJrJX
 z09/2/wkGucD7EVEXBJKDGMDawxymJjMNGJ4xC48wqMLxDxCOwKN8XO
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 13:19:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5206

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/config.json b/config.json
index 86a6adac977f..e2a6e4a54756 100644
--- a/config.json
+++ b/config.json
@@ -1280,10 +1280,7 @@
             },
             "step9" : {
                 "shortname" : "Test meta-exein YP Compatibility",
-                "extravars" : [
-                    "HOSTTOOLS:remove = 'clang llvm-strip'"
-                ],
-                "EXTRACMDS" : ["export PATH=$PATH:${SCRIPTSDIR}/exein-path-intercepts; yocto-check-layer-wrapper ../meta-exein --dependency ../meta-openembedded/meta-oe --no-auto-dependency"]
+                "EXTRACMDS" : ["export PATH=$PATH:${SCRIPTSDIR}/exein-path-intercepts; yocto-check-layer-wrapper ../meta-exein --dependency ../meta-openembedded/meta-oe ../meta-clang --no-auto-dependency"]
             }
         },
         "metrics" : {

---
base-commit: e7450f82a6ea10d97d2fa75f40103fd14fd8b5d8
change-id: 20261102-contrib-mathieu-meta-exein-clang-d4f2454072c3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

