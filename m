Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84EC624C6
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 09:36:12 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3998.1788255364555550572
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Sep 2026 02:36:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fLDYmf/a;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 427D81A1930
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Sep 2026 09:36:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 16F9F6053C
	for <yocto-patches@lists.yoctoproject.org>; Tue,  1 Sep 2026 09:36:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1FCC11C78AAE;
	Tue,  1 Sep 2026 11:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788255357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VLN9lH6qAbJQisFku20Ithcm82g6q0SFykXhPvnJ8Io=;
	b=fLDYmf/a5xV0hSY15cxnu2KFu4gqCYUXioKNXNqQyx4xZd+3GKlri8pKJV9slw3KC84z9t
	yFWqVVx50pVynNj/xxWhQU5/IthSn8S8bubAnK3Iu6ona7YJ9BVIGCHTeQ8s8iyhU6nB+d
	IgE830AYbypBx7JV6E/DpSj6Iff1RgEQvHs9oDJ75dgqxf0X6cutX+jahDFae0p2hWEjLg
	n9pTPKkzaiJgesfZv2fgCYurlma92sJA7iEhOeUq6063P0u+xuievvgMAoaJlB5BbhTXMY
	kDjY0SMhqAS35GdEuqpmyc/Fl8gzM2vjZv3BBnZFgNgaYa0JvBIAfD42dYhqDw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 01 Sep 2026 11:35:38 +0200
Subject: [PATCH yocto-autobuilder-helper] scripts/getproperties: Allow
 mixin-wrynose-linux-firmware to be missing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-contrib-mathieu-mixin-fix-master-v1-1-e78f631a3d84@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGmclmoC/x2NwQqDMBBEf0X23IVENLX9leIhxrVZ0EQ2SbGI/
 97Q45t5zJyQSJgSPJsThD6cOIYK+taA8za8CXmuDK1qjXoojS6GLDzhZrNnKrjxwQEXPmqSMgl
 2w2B6o3vqljvUmV2otv+LF3yjyxFtyXEqvM5V97TuJDBe1w9WCc4SjAAAAA==
X-Change-ID: 20260901-contrib-mathieu-mixin-fix-master-48865615e4f7
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788255356; l=1275;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=BsxskYV0fCjLQFrBuZinRZcBAWUrHjp8ObZCrpW02VU=;
 b=Xv9WGjZboh3a15IjuiHoOg5JbWIvZlDcJsuGHytzQ0sp/xmm6X8R6cD0StXE1s+y/g3NU+EMD
 ZFG1NaRxhJoBKaVcd+co7xMf34NiWuTjQOtLDnPW6Z/QFlghhieAnNq
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Sep 2026 09:36:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4723

Repository is added in layerinfo.json, as it is needed for the wrynose
branch. It will not be used on other branches, as it is not in
NEEDREPOS, but also needs to be ignored here.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 39930c55d8ac..90339e84ec85 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -56,7 +56,7 @@ for repo in sorted(repos.keys()):
     if not os.path.exists(layerpath):
         # layer may not be used by the build and hence not moved into final position
         layerpath = builddir + '/repos/' + repo
-    if not os.path.exists(layerpath) and repo in ['meta-security']:
+    if not os.path.exists(layerpath) and repo in ['meta-security', 'mixin-wrynose-linux-firmware']:
         # Repos is specified on the controller but not used in the helper config
         continue
     getrevs(jsonprops, layerpath, repo)

---
base-commit: ff7149fe675bff1f57f4f46c0efc5dd5029ce001
change-id: 20260901-contrib-mathieu-mixin-fix-master-48865615e4f7

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


