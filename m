Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39506.1793007947343481613
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 02:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=jswvoV/R;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 80AF41A12AA
	for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 09:45:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4BC9560740;
	Mon, 26 Oct 2026 09:45:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C80510328E76;
	Mon, 26 Oct 2026 10:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793007944; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1JU3cK78K3JtdjJYvQdrXVn6EJwDTN0sXM26vvdGTps=;
	b=jswvoV/RCR6GJFi8jT5/siSb0eVidpFDSpiqlv2pQUIULs+gT2iOoLjvVM12L0Yn5y2RbY
	jVp4vswdFcwKkGoA7IuNh2iM23RTCYVp2Hx6HZu+R1ouhiQ3ql0bGtmerVjKoO/tSrmpA2
	4cR41ZEgS9lYslprIYat5Gbb178dwKR+eM/IK/UJ9QO6Xk+p1t6cmmjBEfjWQ4dzBQ7LhQ
	MEdS30BzBToglfdnBsSLG/Y5Y0QFgYCnAbqWIBh/4bMrCtXt2Xko7ZqpmNY1kN1SaFJ8aa
	XYM2C7BamMcym8oaBV3+9nHKGf2xl8c1VeFXPyAdtdiS+q0RkIIz0gLLDSC72g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 26 Oct 2026 10:45:35 +0100
Subject: [PATCH yocto-autobuilder-helper] scripts: abint: Fix python syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-mathieu-abint-fix-v1-1-8b31db077ef9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD4h32oC/x2MSwrCQBAFrxJ6bYMZ1KBXERfzeToNcSbMJyghd
 7dxUYsqeG+jiiKodBs2KlilSk4q42EgH216gSWokzmay6jw27Yo6GydpMZP+fB1MsbhBB/OE+l
 uKdD8/7zTN/uW2faWXZc5oHDEvKDQY99//2xHJ30AAAA=
X-Change-ID: 20261026-mathieu-abint-fix-9722be4ecd57
To: yocto-patches@lists.yoctoproject.org
Cc: Ross Burton <ross.burton@arm.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793007943; l=908;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=yNh5olulDm8OTdQpPru2sDkYv+7/1tdLfVgE98mHjn8=;
 b=VRrzrWXSCDXCYhf0DaTTUGwJcOo/WFj4Evifh1iQ4m8wRKAdcQ267o7eQ7So1TsZhjjlFEwJj
 ZoZHK2j4XloByUd8VkrJlSGkmGj0A1AksblzU8nIauvSZB/D2/Fbq2/
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 09:45:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5156

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/abint/abint.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/abint/abint.py b/scripts/abint/abint.py
index 951ea59eaea6..9d4af3a4d8d7 100755
--- a/scripts/abint/abint.py
+++ b/scripts/abint/abint.py
@@ -91,7 +91,7 @@ def get_data():
         for bug in bugs
     ]
 
-    logging.info(f"Found {len(bugs)} AB-INT bugs: {", ".join(str(bug.id) for bug in bugs)}")
+    logging.info(f"Found {len(bugs)} AB-INT bugs: {', '.join(str(bug.id) for bug in bugs)}")
 
     logging.info("Fetching bugzilla comments...")
     comments_data = bz.get_comments([bug.id for bug in bugs])["bugs"]

---
base-commit: 831cdb1bdd83a4b26afd81d63eb749d221a5d963
change-id: 20261026-mathieu-abint-fix-9722be4ecd57

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

