Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26946CD8C8E
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 19:55:10 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21923.1780775704902051765
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Jun 2026 12:55:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pPPm79hn;
 spf=pass (domain: gmail.com, ip: 209.85.215.176, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85d8615b09so1851164a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780775704; x=1781380504; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkK48s8OPz+ZsypHdaN4tvVVUxmGsywaccSWw9AKz3w=;
        b=pPPm79hnbT4JURwFSTuEfg9U0FYxqmWuZlFs6mMRRsY9LmYpCCh1AEg8JThB/pW5h6
         3Ia3U7rV/29+IkguB95GX20u5I4aZCIiPlyBUwgLP71uZd+pbtArwSw0gPDxQNmVxZXR
         UV9jP4Lxq1rvA0YF4PtlwqNtAtAA/VYdUeDGK9v2syHuEAZH2wVRtU+M060Ogx29tA7R
         v0As6iaeI0gfNdjx+uEvwQQ3T22Q9tesYolu7a0UJAWSElpHq6ph128+6ywdI317XUF9
         4MfcsAl6DZQfO0LeFBZPvOW3mNd70fYcZuNdPu8glOrar0aPUkwwIsR+Nk2yAuNItG8D
         vHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780775704; x=1781380504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkK48s8OPz+ZsypHdaN4tvVVUxmGsywaccSWw9AKz3w=;
        b=K9s2UbKZpZRQKpH2i2AFItrz+bDZLX6zSJc0qpVRDihG4rq9o5ZfHpIhjL1hXvSDDe
         YOwL1Ln437/fwz6SJzRcUx7clvRdPwH1CocIciB1XjhO3MYwn2iGT/qetb0HrtGvfTTg
         dq/TWLQxHkzPYv2L8sEUfZpCjr2Nke1keKed/S+zJ+2ou/lxh2MLYM38029VD0toyUqG
         fE3gGOdvrAYtjFerhhNYBz5qYBsrQKwEFdBqVieeD1cQy8ULg991TwxUec2rE54+WEij
         6h7RjKO16fM1gy4eSe6e1eJF0ARaV5KnWDQHSY+rtVFPs/ykvUZxKOku5wuLdzBwuLet
         9GzQ==
X-Gm-Message-State: AOJu0YxT8d0/W7BVHsvMfqRUwd0QG4uisB14HUTWUxQ4lOXKO34Ooz7p
	2AB4lgh+7ooEutQnzS+gapv7ZfhsjLojWt8N5cDtPb/EEhx81I3QLS2BAp1jWA==
X-Gm-Gg: Acq92OHgXzFK/GHD+1i7ALrr+wR/OcMOHiHQtdeN0tXwWDlbLHh2aw+i2/Njq+twr7F
	XYLEvqD+lEB9qwbzYdJcAVG5zgyt3FItdIrcUAEH6GI3ZE91eCOfLzCcdSnoWcOU4Zmil0ZHSpt
	BZgK2Fc8CR6wufJJwExAzGH8b4u9Kicq5fZUsrhyMQODIabnToORXjWYcDo4AEPqOWCjMt6tkKp
	yt2La7gzaL3xsXv0utbO8SBdz+6dzrev9aPdM2XEHf6FYG3scj5E0FTLQf2QNiNh0CF8v619jGx
	sDuC1GIlGNqEHS5hWf9nsu5TkZZRlL+iXynh3ULjpPk674reVrV/z5hc6VHTZEelj0Voi5AVBBu
	ZC9ithspxNwJszUEkFBxhHDcvSVTTKmWBLQUarwS5DIpzBKEb7VAMzZXeKnogsmLZGg6TckjHcy
	/SWkb1BZhQKz45EsMklCOF6rqFYAEjes64CccIwz+ARBFvveGHayIXJTm2PQzcUMk4LBA8ia898
	CIs/4b2rGQ63QNpNOkdOKaNfuGBvvu73Q==
X-Received: by 2002:a05:6a21:6f0e:b0:3ab:18cd:7da3 with SMTP id adf61e73a8af0-3b4cccffba1mr12095537637.1.1780775704182;
        Sat, 06 Jun 2026 12:55:04 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04311bsm10943179a12.9.2026.06.06.12.55.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 12:55:01 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] Fix remaining git:// urls (replace with https://)
Date: Sat,  6 Jun 2026 12:54:49 -0700
Message-ID: <20260606195450.59191-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606195450.59191-1-tim.orling@konsulko.com>
References: <20260606195450.59191-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 19:55:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4167

Fix a few other places where git:// urls were used.

Fixes [Yocto #16272]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README                              | 6 +++---
 docker/connectivity_check.sh        | 2 +-
 docker/settings.py                  | 2 +-
 layerindex/tools/import_classic.py  | 8 ++++----
 settings.py                         | 2 +-
 templates/layerindex/editlayer.html | 4 ++--
 tests/test_update.py                | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/README b/README
index 9e1e659..96c2ddd 100644
--- a/README
+++ b/README
@@ -124,7 +124,7 @@ setup within it:
         Layer type:               Base
         Summary:                  Core metadata
         Description:              Core metadata
-        Repository URL:           git://git.openembedded.org/openembedded-core
+        Repository URL:           https://git.openembedded.org/openembedded-core
         Repository subdirectory:  meta
 
         Once you have filled in the required values, click on the
@@ -217,11 +217,11 @@ been migrated/superseded). If you want to enable this, do the following:
 2. Clone OE-Classic somewhere locally on the machine running the
    layer index:
 
-   git clone git://git.openembedded.org/openembedded
+   git clone https://git.openembedded.org/openembedded
 
 3. Clone a bitbake somewhere locally and check out the 1.12 branch:
 
-   git clone git://git.openembedded.org/bitbake -b 1.12
+   git clone https://git.openembedded.org/bitbake -b 1.12
 
 4. Run import_classic.py, specifying the path to OE-Classic and
    the bitbake you checked out:
diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh
index 59b26b8..2e46ce4 100755
--- a/docker/connectivity_check.sh
+++ b/docker/connectivity_check.sh
@@ -25,7 +25,7 @@ if ! wget -q $HTTPS_TEST_URL ; then
     exit 1
 fi
 
-GIT_TEST_REPO="git://git.yoctoproject.org/meta-layerindex-test"
+GIT_TEST_REPO="https://git.yoctoproject.org/meta-layerindex-test"
 if ! git clone -q $GIT_TEST_REPO ; then
     echo "ERROR: failed to clone $GIT_TEST_REPO"
     cleanup_tmp
diff --git a/docker/settings.py b/docker/settings.py
index fdf09de..e3ae0fd 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -250,7 +250,7 @@ LAYER_FETCH_DIR = "/opt/workdir"
 TEMP_BASE_DIR = "/tmp"
 
 # Fetch URL of the BitBake repository for the update script
-BITBAKE_REPO_URL = "git://git.openembedded.org/bitbake"
+BITBAKE_REPO_URL = "https://git.openembedded.org/bitbake"
 
 # Path within the BITBAKE_REPO_URL, usually empty
 BITBAKE_PATH = ""
diff --git a/layerindex/tools/import_classic.py b/layerindex/tools/import_classic.py
index 44f8f88..07565ac 100755
--- a/layerindex/tools/import_classic.py
+++ b/layerindex/tools/import_classic.py
@@ -116,10 +116,10 @@ def main():
         layer.layer_type = 'M'
         layer.summary = 'OE-Classic'
         layer.description = 'OpenEmbedded-Classic'
-        layer.vcs_url =  'git://git.openembedded.org/openembedded'
-        layer.vcs_web_url = 'http://cgit.openembedded.org/openembedded'
-        layer.vcs_web_tree_base_url = 'http://cgit.openembedded.org/openembedded/tree/%path%'
-        layer.vcs_web_file_base_url = 'http://cgit.openembedded.org/openembedded/tree/%path%'
+        layer.vcs_url =  'https://git.openembedded.org/openembedded'
+        layer.vcs_web_url = 'https://git.openembedded.org/openembedded'
+        layer.vcs_web_tree_base_url = 'https://git.openembedded.org/openembedded/tree/%path%'
+        layer.vcs_web_file_base_url = 'https://git.openembedded.org/openembedded/tree/%path%'
         layer.comparison = True
         layer.save()
 
diff --git a/settings.py b/settings.py
index bbc5aca..94b3dd1 100644
--- a/settings.py
+++ b/settings.py
@@ -242,7 +242,7 @@ LAYER_FETCH_DIR = ""
 TEMP_BASE_DIR = "/tmp"
 
 # Fetch URL of the BitBake repository for the update script
-BITBAKE_REPO_URL = "git://git.openembedded.org/bitbake"
+BITBAKE_REPO_URL = "https://git.openembedded.org/bitbake"
 
 # Path within the BITBAKE_REPO_URL, usually empty
 BITBAKE_PATH = ""
diff --git a/templates/layerindex/editlayer.html b/templates/layerindex/editlayer.html
index a95dab3..e14f953 100644
--- a/templates/layerindex/editlayer.html
+++ b/templates/layerindex/editlayer.html
@@ -196,7 +196,7 @@
         if( repoval[repoval.length-1] == '/' )
             repoval = repoval.slice(0, repoval.length-1)
 
-        if( repoval.startsWith('git://git.openembedded.org/') ) {
+        if( repoval.startsWith('git://git.openembedded.org/') || repoval.startsWith('https://git.openembedded.org/') ) {
             reponame = repoval.replace(/^.*\//, '')
             this.vcs_web_url = 'https://git.openembedded.org/' + reponame
             this.vcs_web_tree_base_url = 'https://git.openembedded.org/' + reponame + '/tree/%path%?h=%branch%'
@@ -204,7 +204,7 @@
             this.vcs_web_commit_url = 'https://git.openembedded.org/' + reponame + '/commit/?id=%hash%'
             this.vcs_web_type = 'cgit'
         }
-        else if( repoval.startsWith('git://git.yoctoproject.org/') ) {
+        else if( repoval.startsWith('git://git.yoctoproject.org/') || repoval.startsWith('https://git.yoctoproject.org/') ) {
             reponame = repoval.replace(/^.*\//, '')
             this.vcs_web_url = 'https://git.yoctoproject.org/' + reponame
             this.vcs_web_tree_base_url = 'https://git.yoctoproject.org/' + reponame + '/tree/%path%?h=%branch%'
diff --git a/tests/test_update.py b/tests/test_update.py
index 588b2ed..a0ac897 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -63,8 +63,8 @@ def hack_settings(backup_settings):
 
 @pytest.fixture(scope="module")
 def import_layer(hack_settings):
-    run_cmd("layerindex/tools/import_layer.py git://git.openembedded.org/openembedded-core -s meta openembedded-core")
-    run_cmd("layerindex/tools/import_layer.py git://git.yoctoproject.org/meta-layerindex-test -s meta-layerindex-test")
+    run_cmd("layerindex/tools/import_layer.py https://git.openembedded.org/openembedded-core -s meta openembedded-core")
+    run_cmd("layerindex/tools/import_layer.py https://git.yoctoproject.org/meta-layerindex-test -s meta-layerindex-test")
     run_cmd("layerindex/update.py -l meta-layerindex-test")
 
 def test_example_recipe(import_layer):
-- 
2.54.0


