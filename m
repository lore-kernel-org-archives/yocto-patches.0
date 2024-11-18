Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89520D49209
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 10:14:27 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.37830.1731924858401467373
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 02:14:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Eiima/gG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 922E4E0002;
	Mon, 18 Nov 2024 10:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731924856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vvXsUCW2DMgu90GMTfy2PbPxTV9zOAVApjBkJuYJniY=;
	b=Eiima/gGZaWaywpdGEyfQxbYIylemIshWr7wbxaylCN08VbYncLRRrhTPfsJHiMUXyezy2
	OacRQLDmZrTSRjS/RWm25hec2TjargGHEvWUiUMFA0jawO+kaX4xoLqY05L0DbBXQlP375
	fBqVUgBVTH2T/V7qiUPPoAV6cic7MBj+cFmWNh8dbBhE0E5du+Y4xLyLh4bmEu5MQ3esRf
	z4a/fU/bahNby5gjxHiTroeNH6ITrSarsV+bUrUYzElCMS0JZYg3BKo8lW9OhHVqniNCYR
	ntXVBTFhmRORDYgNVu1RAkhtf6ezrAt/SVKY+Q5wjRmF5krg8vumqJ4rP5/LAg==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH v2] prepare-shared-repos: Allow to tag poky git
Date: Mon, 18 Nov 2024 11:13:53 +0100
Message-Id: <20241118101353.385834-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 10:14:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/817

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/prepare-shared-repos | 6 ++++++
 scripts/utils.py             | 8 ++++++++
 2 files changed, 14 insertions(+)

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
index 8e6463d8c62c..2902dfa9fcd5 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -280,6 +280,14 @@ def fetchgitrepo(clonedir, repo, params, stashdir, depth=None):
     subprocess.check_call(["git", "reset", "origin/" + branch, "--hard"], cwd=sharedrepo)
     subprocess.check_call(["git", "reset", revision, "--hard"], cwd=sharedrepo)
 
+def taggitrepo(clonedir, repo, params, tagremote, tagname):
+    sharedrepo = "%s/%s" % (clonedir, repo)
+    revision = params["revision"]
+    print("Creating tag...")
+    subprocess.check_call(["git", "tag", tagname, revision], cwd=sharedrepo)
+    print("Pushing tag...")
+    subprocess.check_call(["git", "push", tagremote, tagname], cwd=sharedrepo)
+
 def publishrepo(clonedir, repo, publishdir):
     sharedrepo = "%s/%s" % (clonedir, repo)
     revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=sharedrepo).decode('utf-8').strip()
-- 
2.39.5


