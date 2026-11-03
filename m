Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6536.1793694734344158984
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 00:32:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=dpxp4HPY;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0AF5D1A1425
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Nov 2026 08:32:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC3356046C
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Nov 2026 08:32:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE7B410328267;
	Tue,  3 Nov 2026 09:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793694731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=fP9PgYViFZTWnAhU961Yf+4zUXE9/bMW6llYda0gakY=;
	b=dpxp4HPYHZkICZ1LAl9OShkE+V6YvDw6kZeutqFbS6P4neiT0Wqc+83hdI2/GMEbs8hTib
	tRGSxF0VJIWWSJpzPhGWJ2TAYGQd+t1kfkl+eNb93KTLl7s0qsKcoj5U+/1pFYPAMRKniJ
	rBuTwO+qCnGFvEKUSaj/5/ozDLwJ0/tkMcFl7ei3qk2eoElHcgZstHwNvqDJh0hknKSqq1
	KB6i557el6OGiOP/XRhVxqcTJdk6Vm4VWEptB5oSoQ5QpqrY4s52PGwKul9Gqy1vi4ifyk
	NVGcgCR2ci52D/ZrbGMoVlyK1yXSQhGD+2MVqBdCYGVmEpCUGSScjnQzivDDPg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 03 Nov 2026 09:31:59 +0100
Subject: [PATCH yocto-autobuilder2] schedulers: Use blacksail branches for
 some layers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-mathieu-blacksail-branches-v1-1-fe5e61ab4a26@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAP6b6WoC/x3MSwrCMBAA0KuUWTvQpKWoVxEXk3RiBmMi+RSl9
 O4Gl2/zdiichQtchx0yb1IkxQ51GsB6ig9GWbtBj3pRapzwRdULNzSB7LOQBDSZovVc8DwpOy/
 azRdy0IN3Zieff36Db7I1IbWaTJOwctZwP44fo4Irn4AAAAA=
X-Change-ID: 20261103-mathieu-blacksail-branches-831c462f49af
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793694730; l=1115;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=dbr4H83G2N9ET4CY8M3kRz+dc0/x6s4HJ4KWQ8WboB0=;
 b=W5gppaiM4Yg3wzuK/FIZiJYJvv4KQvZeVYFI9kl2eG7dnvGOAhuYo8YvC7qMT1zRbLkg3Hbeo
 7ww89LlyqhUD2kyoPQnNQtaQmfZVlKDAnwAOFkm8ugOIMDGSwbL7tK7
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 08:32:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5216

Some layers added the branch, use it on the autobuilder.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 2bfc36ed4439..5b5cf646fd48 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -76,7 +76,13 @@ branchdefaults = {
     'blacksail': {
         'branch': 'blacksail',
         'branch_bitbake': '2.20',
+        'branch_meta-arm': 'blacksail',
+        'branch_meta-exein': 'blacksail',
         'branch_meta-mingw': 'blacksail',
+        'branch_meta-openembedded': 'blacksail',
+        'branch_meta-riscv': 'blacksail',
+        'branch_meta-security': 'blacksail',
+        'branch_meta-virtualization': 'blacksail',
         'branch_meta-yocto': 'blacksail',
         'branch_oecore': 'blacksail',
         'branch_yocto-docs': 'blacksail',

---
base-commit: 41f0281bea933dd4603a4fe25ddb9de8a062526f
change-id: 20261103-mathieu-blacksail-branches-831c462f49af

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

