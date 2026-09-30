Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD972CA5FB1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 10:52:27 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10574.1790765542906591960
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Sep 2026 03:52:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SlenRsZ5;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so21845755e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790765541; x=1791370341; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCdtbeYA3qbU87KNW95wVfJgBT7LxPIbu7/wZSzGjzM=;
        b=SlenRsZ5CR+8nilnPGrPbM6ogA1nyPBIZdCjBGMHztwPKDIVna54JgrqKV9WYKoT7T
         +V5dE5TLoS1SlEE5CAm2YMS4wfCo9/ov7MEDNKx6IHTGp9/n88UjEr5UgOzBSkTV/WbZ
         9Bd/GcwX0yoYWkv+qYgs2rohVWwfv1SZMldLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765541; x=1791370341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qCdtbeYA3qbU87KNW95wVfJgBT7LxPIbu7/wZSzGjzM=;
        b=yHB9UQ4GoWLrjjVrn4WjNhs8jaXYYIUH3WLgac0MDH+JXN90A21urfJ1X+GHBG4IuW
         mPoyTXVOofsE1oJPbpgav3LKHuvrvZfpg/HVhECWjhlDuGOH+8KkBNjRaURz0eVRYsTK
         WfITkoMkJaKZmG+1J+/9P8mXUC1Z9nO9rYg5GVrxP08hSNGEnEgqItzXJpt7t9YmvfdJ
         IiiupQYbPi7kniDQvn/mv8npZB57WHiNot76LJXressSCzxemMoW7EnhJ4EHD9mJrrB8
         +gWx3w+UDv3Z8Dc5zUVQpVN17wl1xI+u5vgURyik1Nhd064+0PL9WvHE8yBcKHd7OEV0
         0lBQ==
X-Gm-Message-State: AFuF++mVlR0tULRvmsZnt20o/+ctEO/tRIMK1sY7pCeyTSbkEHKCQlkB
	mbV/SvsiD104cgBESkpq0Yhpk3vuYrOWQot9RI2eh9uUOjiFfBjL61waaHIFo5TCCOlNqlWdb1I
	4j5mNMvc=
X-Gm-Gg: AYBFou14bQlImea4DKgq8E08nqZXJ6tJ+Gh9Kue+XnCHVUYdcCoBhItoYg7Dd5lN2+9
	SO+fJKXsIN6+/9j3bgem9LtC88MidqirC6ImKEQOcsGAEiJZh3doegeI1v1e0xyXIS3IZiJq+Te
	NgPM1Aqi0Ggr6sp3BDpYGFd3CnErYK1Q+aqhngDKqcW9CWcAZBg+OdQOut2OwFYE/GW4NkRhO1o
	KxJN7to7fHmMNlQhJ4wnaMIvQBe2C6rttY2eb4XpyQ8QqOr8fz6AuOV4Pl1E0dIAySSht7rEuGr
	rY8jdgDahnXR2URxsqbJJYThox9gIDbRKgc5oT1NIinIJfJO9HDTBr6qQgOlIuNsY3Rag9vAyyC
	lZW0oJIjFHrP8Otu/Y8ng2+4qO1TIMRvIyVQNHSyWgVwEsb/D3ibgDPt0hFT518KbwJuC6guo7K
	vJCnEUFiZyW3c7RwZlghk+s1hW7Y1s29kP3fO205XXyFKVMFc55Jap8KHSd+XWNb+HrEZjbZUe3
	/2xqqtQSeqRjYEsVeaAujpT6Q==
X-Received: by 2002:a05:600c:4691:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-4a01b126e5dmr14462335e9.31.1790765540552;
        Wed, 30 Sep 2026 03:52:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:349:f135:e106:4c82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01cb8af89sm2078785e9.1.2026.09.30.03.52.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:52:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json/scripts: Add a specific list of repos to ignore and reference everywhere
Date: Wed, 30 Sep 2026 11:52:19 +0100
Message-ID: <20260930105219.544597-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Sep 2026 10:52:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4970

There are a set of repos we need to ignore in builds, poky, meta-gplv2 and
more. Put these in a specific list in the config and update the shared functions
to remove them in all places rather than the current inconsistency.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json                  |  1 +
 scripts/getproperties.py     |  3 ++-
 scripts/prepare-shared-repos |  6 +++---
 scripts/send_qa_email.py     |  5 +----
 scripts/shared-repo-unpack   |  2 +-
 scripts/utils.py             | 10 +++++-----
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/config.json b/config.json
index 17c241e..b96a4bd 100644
--- a/config.json
+++ b/config.json
@@ -16,6 +16,7 @@
 
     "REPO_STASH_DIR" : "${BASE_HOMEDIR}/git/mirror",
     "TRASH_DIR" : "${BASE_HOMEDIR}/git/trash",
+    "IGNORE_REPOS" : ["poky", "meta-gplv2", "mixin-wrynose-linux-firmware"],
 
     "QAMAIL_TO" : "yocto@lists.yoctoproject.org",
     "QAMAIL_CC" : "qa-build-notification@lists.yoctoproject.org",
diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 90339e8..0bafa57 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -15,7 +15,8 @@ targetname = sys.argv[2] if len(sys.argv) > 2 else None
 with open(builddir + "/../layerinfo.json") as f:
     repos = json.load(f)
 
-utils.filterrepojson(repos)
+ourconfig = utils.loadconfig()
+utils.filterrepojson(ourconfig, repos)
 
 def get_revision(repopath):
     return subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repopath).decode('utf-8').strip()
diff --git a/scripts/prepare-shared-repos b/scripts/prepare-shared-repos
index 8ffc2c5..a676669 100755
--- a/scripts/prepare-shared-repos
+++ b/scripts/prepare-shared-repos
@@ -39,14 +39,14 @@ ourconfig = utils.loadconfig()
 with open(args.repojson) as f:
     repos = json.load(f)
 
-utils.filterrepojson(repos)
+utils.filterrepojson(ourconfig, repos)
 
 stashdir = utils.getconfig("REPO_STASH_DIR", ourconfig)
+ignore_repos = utils.getconfig("IGNORE_REPOS", ourconfig)
 
 with tempfile.TemporaryDirectory(prefix="shared-repo-temp-", dir="/home/pokybuild/tmp") as tempdir:
     for repo in sorted(repos.keys()):
-        # gplv2 is no longer built/tested in master
-        if repo == "meta-gplv2":
+        if repo in ignore_repos:
             continue
         utils.printheader("Initially fetching repo %s" % repo)
         # shallow clones disabled as it doesn't work correctly with revision numbers in the result repo leading to release build failures.
diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 07fc1e7..6ce9c46 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -148,7 +148,7 @@ def send_qa_email():
     with open(args.repojson) as f:
         repos = json.load(f)
 
-    utils.filterrepojson(repos)
+    utils.filterrepojson(ourconfig, repos)
 
     oecorerepodir = os.path.dirname(args.repojson) + "/build/layers/openembedded-core"
     resulttool = oecorerepodir + "/scripts/resulttool"
@@ -260,9 +260,6 @@ def send_qa_email():
     layersdir = os.path.dirname(args.repojson) + "/build/layers/"
     buildhashes = ""
     for repo in sorted(repos.keys()):
-        # gplv2 is no longer built/tested in master
-        if repo == "meta-gplv2":
-            continue
         layerdir = layersdir + repo + "/"
         if repo == "oecore":
             layerdir = layersdir + "openembedded-core/"
diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index d1089cc..53a89ff 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -52,7 +52,7 @@ bbsetup_json = args.repojson.replace("layerinfo.json", "bbsetup-overrides.json")
 with open(layerjson) as f:
     repos = json.load(f)
 
-utils.filterrepojson(repos, args.target)
+utils.filterrepojson(ourconfig, repos, args.target)
 
 targetsubdir = args.abworkdir + "/repos"
 needrepos_baseddirs = [r.split('/')[0] for r in needrepos]
diff --git a/scripts/utils.py b/scripts/utils.py
index ab33734..fee8f67 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -314,11 +314,11 @@ def publishrepo(clonedir, repo, publishdir):
     subprocess.check_call("rsync -av " + archive_name + "* " + publishdir, shell=True, cwd=sharedrepo)
 
 # The repo json needs to be filtered for builds with bitbake-setup
-def filterrepojson(data, target=None):
-    if "poky" in data:
-        del data["poky"]
-    if "meta-gplv2" in data:
-        del data["meta-gplv2"]
+def filterrepojson(ourconfig, data, target=None):
+    ignore_repos = utils.getconfig("IGNORE_REPOS", ourconfig)
+    for repo in ignore_repos:
+        if repo in data:
+            del data[repo]
     return
 
 def mkdir(path):

