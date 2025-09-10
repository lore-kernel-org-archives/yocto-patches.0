Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDDCA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 08:53:09 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.12775.1757494383488579987
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Sep 2025 01:53:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=q/lDLvFs;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0B693C6B3AC
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Sep 2025 08:52:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8FD0606D4
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Sep 2025 08:53:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF50A102F28B2;
	Wed, 10 Sep 2025 10:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757494381; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=C+n8EUo8HIxl7op2bZQ0WO/E6/uxw2dxPiKpawtkBW8=;
	b=q/lDLvFszNXiJ0S3k6y+3R1Wy/j9x4kwZ15ML81E8Mi1r2XtKpwHqWZdC0jQhkQBkiCm8g
	sO5Jj+BGhD1DzWrJLHqQYhDIj7WP1xqU9kcnHaHH3tZLD6/Bo4ak7Hxpz3Mgrz3GB0FpOa
	t+T/esyrEOvz+vSsli3olQoEmXVnjQTqzllrxbGwn11q085VFnPm2wh3fjYW01szHexlda
	1UdtT1Ej8rLzaox1VsVvWUqCBlh866KYNhTMmyXF3R6GtWr2UfHAwRFUYADofVx0rZ8eCW
	jjE8TId5p7ubzvphz2J/gODsO7OMU+UaIS9x8AjCLwW86GQsNnigzuQumsRmvQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 10 Sep 2025 10:52:12 +0200
Subject: [PATCH yocto-autobuilder2] reporters: swatbot: Fix branch name
 retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-contrib-mathieu-swatbot_branches_fix-v1-1-55f1635094c7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADs8wWgC/x2NywrCMBAAf6Xs2YU0WEV/RaTksTULmpVk44PSf
 zd4nDnMrFCpMFU4DysUenFlyR3G3QAhuXwj5NgZrLGTOY0Gg2Qt7PHhNDE1rG+nXnT2xeWQqM4
 Lf/C4eJr2xhLFA/TUs1DX/80FvhJU0DUV3/geqVi4btsPgY/5fooAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757494380; l=2269;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=XBZU21i3BWNaBHKupRWilnvMg9NZJJP037lNw8RzFOc=;
 b=nX5jlmrvMIocAZ67K+r6QMs2uJuDysuwDLogYH0XMQsrzM+Ekefk2w54L0K9fFX5UBra1B2o0
 es4EarlQ/XHAtHv914jpK+TkrfuFMT5LgsxZSDbkAEG3edYdCi+tnH6
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Sep 2025 08:53:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2180

The swatbot reporter tries to get the name of the built branch, using
the "branch_poky" property of the build. Some builders, such as "docs",
do not use the poky git, so this property is missing. Currently, this
result in a non-fatal error on the buildbot controller, but the build
entry is not added to swatbot.

Import code from swattool, falling back to oecore or yocto-docs branch
name.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 reporters/swatbot.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/reporters/swatbot.py b/reporters/swatbot.py
index 5e434d5d04a4..6e3827329033 100644
--- a/reporters/swatbot.py
+++ b/reporters/swatbot.py
@@ -49,6 +49,24 @@ class SwatBotURI(object):
             return self.client.get(query, timeout=self.TIMEOUT, headers=self.headers, allow_redirects=False)
         return req
 
+    def get_build_branch(self, build):
+        """Extract branch name from build properties.
+
+        Args:
+            build: Build dictionary containing properties
+
+        Returns:
+            Branch name if found, None otherwise
+        """
+        repos = ['poky', 'oecore', 'yocto-docs']
+        for repo in repos:
+            branch = build['properties'].get(f'branch_{repo}')
+            if branch:
+                return branch[0]
+        branches = [p for p in build['properties'] if p.startswith('branch')]
+        log.err("Failed to get corresponding branch, possible values: %s", branches)
+        return None
+
     def find_build_collection(self, build):
         dbid = None
 
@@ -77,7 +95,7 @@ class SwatBotURI(object):
                     'attributes': {
                         "buildid": collection_build_id,
                         "targetname": build['builder']['name'],
-                        "branch": build['properties']['branch_poky'][0],
+                        "branch": self.get_build_branch(build)
                     }
                 }
             }

---
base-commit: 247aaef0910826113ccfc892f42f9012a45034f7
change-id: 20250910-contrib-mathieu-swatbot_branches_fix-7fbe5402eed6

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


