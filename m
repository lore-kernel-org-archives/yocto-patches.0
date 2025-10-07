Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6649FCCD186
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20395.1759847834267853939
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yX1TO8d2;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EBF731A11CB
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C56DE606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2659D102F2165;
	Tue,  7 Oct 2025 16:37:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jH9Jy4h/VQfhIuba+8lObu47LbGw9piU0B3s7ze6bX8=;
	b=yX1TO8d2mGtGuMa58h6laU7ttyMR3qXgZgrZHJ+gP+yYep4Iiar3ps4rsinHQ5uX0UKWX1
	LGwzLvthgqx4xYdVfOoNC3GD7WNSY7UzgKWgny0Myma8xV2C++Wjc+6P2din1vlq8GT+qT
	j/4+ouzBE2ZBlWdEjM7uQhwO8kW5jAbH9s5WSGwsNJlnSpNhSIVuKdIt7MV+BiHdTy5BR1
	UQIleADPgGtX4bhs9r+OTHQ8mWXCdfMi2VubnjgJmwGu43sQ5dRId2UceDIDjqHUgwieVw
	XMAmrRdBxLUcjZv/F4RHmXu0zggddjPmR743smXwk7BHLp7CdRf3N0GdhKrk8g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:03 +0200
Subject: [PATCH yocto-autobuilder-helper master-next v3 2/3] getproperties:
 Also extract build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-build_props-v3-2-0263f52bd682@bootlin.com>
References: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847830; l=1931;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=uwDSSKXMvizcr8QvtvgxaWKOnTcpu394t8+57wu0cIY=;
 b=1qEdQLGbbJl/IyMCLC1TfHTUmP8SMcPhAr/3wteRrYrSzGHTTRNieqr/e7qJwHOGGqFmo4HpD
 EaS14rahGExBb1xMSndP7aEUxWaisiCJy4lTx8KTmVQKPmCrhUU0Si/
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2273

Extract some important build configuration values, allowing to add them
to buildbot properties. This includes MACHINE, DISTRO, SDKMACHINE and
PACKAGE_CLASSES.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 0d8eab22efbdba65d1ca497a6a28c361c42d5a83..ce1bc2fb45a8fce463fd2e19249833075b9d975b 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -8,8 +8,9 @@ import sys
 
 import utils
 
+# Usage: scripts/getproperties.py <builddir> [builder_name]
 builddir = sys.argv[1]
-
+targetname = sys.argv[2] if len(sys.argv) > 2 else None
 
 with open(builddir + "/../layerinfo.json") as f:
     repos = json.load(f)
@@ -71,5 +72,22 @@ buildid = hashlib.sha1(buildid.encode("utf-8")).hexdigest()
 
 jsonprops['yp_build_revision'] = buildid
 
-print(json.dumps(jsonprops, indent=4, sort_keys=True))
+ourconfig = utils.loadconfig()
+exported_properties = ['DISTRO', 'MACHINE', 'SDKMACHINE', 'PACKAGE_CLASSES']
+if targetname in ourconfig['overrides']:
+    target_props = {}
+    target = ourconfig['overrides'][targetname]
+    maxsteps = 1
+    for v in target:
+        if v.startswith("step"):
+            # Get properties values for this build step, falling back to
+            # defaults if they are not set.
+            for prop in exported_properties:
+                for propdict in (target[v], target, ourconfig['defaults']):
+                    if prop in propdict:
+                        target_props.setdefault(prop, set()).add(propdict[prop])
+                        break
+    for k, v in target_props.items():
+        jsonprops[k] = list(v)[0] if len(v) == 1 else list(v)
 
+print(json.dumps(jsonprops, indent=4, sort_keys=True))

-- 
2.47.3


