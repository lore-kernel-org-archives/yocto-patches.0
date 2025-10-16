Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D54CCD1A1
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:21:03 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.8279.1760620856193405294
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WKUoWHer;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CADAA4E41103
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A07EE6062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08641102F2304;
	Thu, 16 Oct 2025 15:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kaseh5pwfz391x0GvjN9VZEiyFHMAwZlZXMnWcVVMZw=;
	b=WKUoWHerWzKoWK1hSjRl/9y4I5xSNKAAHCyvoB+or4eA8Km18BGx58QWwVhvQZmU4NxtR0
	6/19PaZhNcLKDyt6qTRjB1IbSfKtsxZ2K2DftaXXabDjlDBp85BshSizH4u/MvpimU4f9E
	1sLrcC3wyjGjwrlCnaehOCB3C9QHYRwY+5XQ++qqNhmCcoXiTNIBEwVXUXr8L7wzq/H1NC
	/q/LY20IgwK8Bf3kA1kJ/AR434x1mf1ZZrw4ihlrnnNFQCeRWRIdA9flGU1gU78dPCLCZm
	9BCGNfomgzrUYEvIn7bmAY2ZajpFRBoTR/ott7oT95GalEsiMAL1H8/tqVVbJQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:50 +0200
Subject: [PATCH yocto-autobuilder-helper master-next v4 1/2] getproperties:
 Also extract build properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-build_props-v4-1-1f2f6700e06b@bootlin.com>
References: <20251016-contrib-mathieu-build_props-v4-0-1f2f6700e06b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-build_props-v4-0-1f2f6700e06b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620853; l=2336;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=UO7h1dh7tAm8um/+r6J2WwafvLsq5Q7yrr8YR62Oeps=;
 b=8h7S8gQxGv19K0ARcl6g5/MSrURcqGsbj4AfP85AwCptr2InVl0I13G7v23IHjJApfFLvT7wL
 e2n7l5hc6zCBB4FQqw+fG79FdTjaGkuFYCs3X8vXz02qsiRId2LzxlM
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:21:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2321

Extract some important build configuration values, allowing to add them
to buildbot properties. This includes MACHINE, DISTRO, SDKMACHINE and
PACKAGE_CLASSES.

Properties will be assign either a single string value or a list of
strings, when different values are used across different steps.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 1148d52be5aa..2119424b2dd4 100755
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
@@ -71,5 +72,29 @@ buildid = hashlib.sha1(buildid.encode("utf-8")).hexdigest()
 
 jsonprops['yp_build_revision'] = buildid
 
-print(json.dumps(jsonprops, indent=4, sort_keys=True))
+ourconfig = utils.loadconfig()
+exported_properties = ['DISTRO', 'MACHINE', 'SDKMACHINE', 'PACKAGE_CLASSES']
+if targetname in ourconfig['overrides']:
+    target_props = {}
+    target = ourconfig['overrides'][targetname]
+    maxsteps = 1
+    # For each properties, construct of set of all values this property is
+    # assigned with.
+    # We iterate each steps, and get corresponding values from:
+    # - The step itself.
+    # - If no value was found, the build target template.
+    # - If still not value is found, the defaults value.
+    for v in target:
+        if v.startswith("step"):
+            for prop in exported_properties:
+                for propdict in (target[v], target, ourconfig['defaults']):
+                    if prop in propdict:
+                        target_props.setdefault(prop, set()).add(propdict[prop])
+                        break
+
+    # Transform property sets: as single value if the set only contains one
+    # value, as a list of values otherwise.
+    for k, v in target_props.items():
+        jsonprops[k] = list(v)[0] if len(v) == 1 else list(v)
 
+print(json.dumps(jsonprops, indent=4, sort_keys=True))

-- 
2.47.3


