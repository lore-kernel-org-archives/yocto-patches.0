Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E804BD637CE
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:03:02 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.21349.1731679376086801430
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 06:02:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DqRnqkHe;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61B3340005;
	Fri, 15 Nov 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731679374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f59Lf7bupeiRCK7KH0vzN8bgBEoX2HmX1UqhMLPZTsY=;
	b=DqRnqkHeiDZMqQOfImyiSaP+WHM+RiXpgI8A243+SgVlt13/GxMlLVPKLT34V3FNzO75jC
	ZNI5MptVLYgi54QmOK8wQhwz9IcaWidALMKd4PHmPCBeV67tyw+8C9b0+xYbey6tX8YM0Q
	TmHfvfDZ8lzJRDBlONeTsrJI5LmcjJaXkkcr9y3+cae3Bv4LU/zvxes9USWaulsHX0VDqg
	T4JNdqpi13MfYHpSwf4UO4ziVaxtay7tPJv5QTlPDowypWEqsuworVS38GT1bNXcV1zOZM
	ffC7UGrBLmiJCDGicqYHjU4zY4jH+92s74IH81wGMI14KXGmBe1MjOoCLqn1EQ==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH] prepare-shared-repos: Allow to tag poky git
Date: Fri, 15 Nov 2024 15:02:49 +0100
Message-Id: <20241115140249.176032-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 14:03:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/805

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/prepare-shared-repos |  6 ++++++
 scripts/utils.py             | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/scripts/prepare-shared-repos b/scripts/prepare-shared-repos
index 1b756520b701..3d10af4e6d63 100755
--- a/scripts/prepare-shared-repos
+++ b/scripts/prepare-shared-repos
@@ -16,6 +16,7 @@ import tempfile
 
 import utils
 
+poky_tag_remote = "git@push.yoctoproject.org:poky-ci-archive"
 
 parser = utils.ArgParser(description='Iterates over a set of repositories in a json file and sets up a shared directory containing them.')
 
@@ -26,6 +27,9 @@ parser.add_argument('sharedsrcdir',
 parser.add_argument('-p', '--publish-dir',
                     action='store',
                     help="Where to publish artefacts to (optional)")
+parser.add_argument('-t', '--tag',
+                    action='store',
+                    help="Git tag to create (optional)")
 
 args = parser.parse_args()
 
@@ -49,6 +53,8 @@ with tempfile.TemporaryDirectory(prefix="shared-repo-temp-", dir="/home/pokybuil
             utils.fetchgitrepo(tempdir, repo, repos[repo], stashdir, depth=1)
         if args.publish_dir:
             utils.publishrepo(tempdir, repo, args.publish_dir)
+        if repo == "poky" and args.tag:
+            utils.taggitrepo(tempdir, repo, repos[repo], poky_tag_remote, args.tag)
 
     utils.printheader("Creating shared src tarball")
     subprocess.check_call("tar -I zstd -cf " + args.sharedsrcdir.rstrip("/") + ".tar.zst ./*", shell=True, cwd=tempdir)
diff --git a/scripts/utils.py b/scripts/utils.py
index 8e6463d8c62c..122a56d3c3e4 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -280,6 +280,16 @@ def fetchgitrepo(clonedir, repo, params, stashdir, depth=None):
     subprocess.check_call(["git", "reset", "origin/" + branch, "--hard"], cwd=sharedrepo)
     subprocess.check_call(["git", "reset", revision, "--hard"], cwd=sharedrepo)
 
+def taggitrepo(clonedir, repo, params, tagremote, tagname):
+    sharedrepo = "%s/%s" % (clonedir, repo)
+    revision = params["revision"]
+    print("Creating tag...")
+    subprocess.check_call(["git", "tag", tagname, revision], cwd=sharedrepo)
+    print("Pushing tag...")
+    subprocess.check_call(["git", "remote", "add", "tag", tagremote], cwd=sharedrepo)
+    subprocess.check_call(["git", "push", "tag", tagname], cwd=sharedrepo)
+    subprocess.check_call(["git", "remote", "rm", "tag"], cwd=sharedrepo)
+
 def publishrepo(clonedir, repo, publishdir):
     sharedrepo = "%s/%s" % (clonedir, repo)
     revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=sharedrepo).decode('utf-8').strip()
-- 
2.39.5


