Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EE4CCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 08:20:48 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.10781.1760689239922737928
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 01:20:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=qoPJSjxx;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F19DD4E4111B
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4DF7606DB
	for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEEBE102F2330;
	Fri, 17 Oct 2025 10:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760689237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kZj2/GVgsuiz4jaqBfXR0Dp+Cj5UWAOr4TX15SleA/Y=;
	b=qoPJSjxx5ijci8JtXHM3vCWpju+kIvh8Q1NDqqoLHwEFqsWdo/UlUvueZdiNGzrU6lhNKX
	XXs6UIP3qICpZ5Isdr/tdlbkndrKXFUprgp5Fz4vRm9xgpM0L0dQTXQoiZe17XL7km+jps
	m2bPCRc9SI0bIiHcI2qRZcZue3BN13NJHpmkbBzin2K7pVmqAG+rPnQfHVzLdZ8n4O0oWN
	gTIX76FswUQkybT8ilscZ6r39sVfAsifopzL7d+MRWDZ+HTed62GSNp8XXHAJN8AmAJl5M
	2nvbFJ1/1Lx4IFK0h8b++q+d+O2By+mjWGzUt4hW50R5OD27vAZBa8WhhdDoWg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 17 Oct 2025 10:20:29 +0200
Subject: [PATCH yocto-autobuilder-helper] prepare-shared-repos: Add tag for
 separate gits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-contrib-mathieu-oe-core-tag-v1-1-9ed5059cde28@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAE388WgC/x3MQQrDIBBA0auEWXcgWkugVyldGJ3EgdQJo5aWk
 LtXunx/8Q8opEwF7sMBSm8uLLnDXAYIyeeVkGM32NHezGgmDJKr8owvXxNTQ6GelLD6FV2wzi3
 emSleoR92pYU///sDvhKqoG9V5sZbJMVE204Kz/P8AZNUTy+HAAAA
X-Change-ID: 20251017-contrib-mathieu-oe-core-tag-4c244fa417d3
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760689236; l=2609;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=shSDt55Um/Y7jWtH09oAPCdkynx+sy2mp9GivlCR0Ls=;
 b=whZ78ccDHpNeoaA38xbyH2UZ8xEVzAshc6gK4wXG0FzPMV+kgkGdugNtODoeKH7UhzyIUcirD
 7VG/aJqmrEKCd8GtebV40qmQDg2VcxizwrWf89KjwJjIPtv4ZsdQhWb
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 08:20:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2346

As poky is no longer used, add tags for openembedded-core, bitbake and
meta-yocto. We continue to use the same poky-ci-archive repo.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
PLEASE DO NOT MERGE!

Only merge this once oe-core and bitbake master branches have been
pushed on poky-ci-archive, as we need to bypass push checks to do that.
---
 scripts/prepare-shared-repos | 3 ++-
 scripts/utils.py             | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/prepare-shared-repos b/scripts/prepare-shared-repos
index a510a4fd0cf4..8ffc2c501571 100755
--- a/scripts/prepare-shared-repos
+++ b/scripts/prepare-shared-repos
@@ -17,6 +17,7 @@ import tempfile
 import utils
 
 poky_tag_remote = "git@push.yoctoproject.org:poky-ci-archive"
+tagged_repos = {"bitbake", "oecore", "meta-yocto"}
 
 parser = utils.ArgParser(description='Iterates over a set of repositories in a json file and sets up a shared directory containing them.')
 
@@ -55,7 +56,7 @@ with tempfile.TemporaryDirectory(prefix="shared-repo-temp-", dir="/home/pokybuil
             utils.fetchgitrepo(tempdir, repo, repos[repo], stashdir, depth=1)
         if args.publish_dir:
             utils.publishrepo(tempdir, repo, args.publish_dir)
-        if repo == "poky" and args.tag:
+        if repo in tagged_repos and args.tag:
             utils.taggitrepo(tempdir, repo, repos[repo], poky_tag_remote, args.tag)
 
     utils.printheader("Creating shared src tarball")
diff --git a/scripts/utils.py b/scripts/utils.py
index efc7c991181e..a4de27e71722 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -283,10 +283,11 @@ def fetchgitrepo(clonedir, repo, params, stashdir, depth=None):
 def taggitrepo(clonedir, repo, params, tagremote, tagname):
     sharedrepo = "%s/%s" % (clonedir, repo)
     revision = params["revision"]
+    tag = f"{repo}/{tagname}"
     print("Creating tag...")
-    subprocess.check_call(["git", "tag", tagname, revision], cwd=sharedrepo)
+    subprocess.check_call(["git", "tag", tag, revision], cwd=sharedrepo)
     print("Pushing tag...")
-    subprocess.check_call(["git", "push", tagremote, tagname], cwd=sharedrepo)
+    subprocess.check_call(["git", "push", tagremote, tag], cwd=sharedrepo)
 
 def publishrepo(clonedir, repo, publishdir):
     sharedrepo = "%s/%s" % (clonedir, repo)

---
base-commit: 63f4e3954ff26cfd753c3c21f094b751978dda3e
change-id: 20251017-contrib-mathieu-oe-core-tag-4c244fa417d3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


