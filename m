Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E6F3095F
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 13:24:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43980.1772717042743379800
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 05:24:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Ab8Llj2N;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 148D91A2CDD
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Mar 2026 13:24:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D88A25FDEB
	for <yocto-patches@lists.yoctoproject.org>; Thu,  5 Mar 2026 13:24:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D146103698A9;
	Thu,  5 Mar 2026 14:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772717040; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=h0FdB3uLgFFz4/GYvC7AZ0SqU3dpSzaksxWFmQPD0ic=;
	b=Ab8Llj2NL9dxz4xxMeW1TNi9EQC7p43+VbYmJvddWJXIGct1azwJQbh91baRTMFuz5HNXE
	cIxCtS/b3jX3AwexnTXJCx23D7y8czpuXsN5tazXYQXR8l1+U6wjKY1cSI/HZ/7aCFYf2g
	HLzi3FMpXCiuUFHNZxjllC9sN97HA/FxMsFyNu3DBH7QcwFW9q/+3E0RBrZnsMjhyZ0C4z
	0kZgIUSg4d5lLnLck96U8sCA3tafmLCbzoF0zxmRGQW6/b5LacrNXEnIfPUDJKieZM6b+V
	KX9h9VOOmIW3PxaQa3owMNk9bYrXDtymQE58FPkdR1Q20YT1Ug308rybkawaAw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 05 Mar 2026 14:23:45 +0100
Subject: [yocto-autobuilder-helper][PATCH] scripts/release-parser.py: add
 bitbake version mappings to releases.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNyw6CMBCF4Vchs3aSClQTX4WwmJYRRittejEaw
 rtbdfktzn82SByFE1yaDSI/JYlfK46HBuxC68woUzW0qj2pTvUY2TElxkCxTtFINnRnfFAIss5
 oiNqz1pqs6qFGQuSrvH4Hw/h3KubGNn+rw9vb7JFK9qaIm2pwYRc4jrDvH6QzWkqcAAAA
X-Change-ID: 20260304-release-parser-bitbake-mapping-baa27555ac04
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=waEa1EGvYQu27ZbTFYW7ILaSVxZNsZ25LlRYgNgiBpI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpqYPvtAe8rJI9owAdPF4dasE2ZtJ5+VvczKdSU
 E+OZkuAh0mJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaamD7wAKCRDRgEFAKaOo
 Nq5aD/9VvZx+9cRj9WD9YbIWJyCphDV/D0W6rAbjWT2ZrzHg3lpP58Un444LOmspu45QYo/u5N3
 Qev5tKkIgVAv3dBq8rMZMN3f8RNE+hfQHjl2mTqZ04n64X9cIksRJSJ27/qferTdalX7hRjbLJI
 hWCyfYXtfN6mqjqp0T7t91L/gBwcgrEMc3IShqRDbqGfSFDeCND4TquKgC1E8B/Rx7hPDncAyh2
 njfAqGzhsLvMEHweTbobVoYIok37EY108szKMm4QoOvQiycWODdRn1RvczRuKoBM4MHUwZEEDes
 5yzTpaWHRdw3hUo5tJ3C1MLccVvZeecAljANqFmJoewajw+TWgjA/hptWm2OGnvqbWcnV/GS3wM
 wSH8/bVrJ/wk8I26p4RnoGy71hjpeehHqdbYrJUkImScWl2tzm3A0hpwe6KhBBReMn0RmgMMmDo
 iASu5XmW3a0KiVheOVmXDwMNhEv7sGW9k4HI5GzQBUZGTWkKWtwW4rhg+HSb2SMLZNJyIwguseL
 y3qd0altIY/8cG2IyE4Pni92qKlx1OotxbptYVJLS4gK0YFwq6LBafaTwSbpDoNEw0/Yqyn7o7W
 ceTWXKd5MSy2mEuqjpUTxToQV2W/OpLXjamqpCEiFT2/I4AWn2X827O/SSouiIfXWn+TBJQ6jeW
 ZRUH2f+MqDrmnpQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 13:24:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3337

Instead of maintaining the bitbake <-> yocto version mappings in
yocto-docs[1] and bitbake[2], let's maintain it here instead. This is
part of a work-in-progress to use the generated releases.json file in
these two repositories to generate the documentation.

[1]: https://git.yoctoproject.org/yocto-docs/tree/documentation/set_versions.py?id=d97cfeaa55ed42722998d3313c1857aa377f6881#n66
[2]: https://git.openembedded.org/bitbake/tree/doc/setversions.py?id=1d0d4a0066603461eacb92a766fec616c1e91257#n25

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Tested on this build:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/104/builds/48264

Output: https://0x0.st/PjSE.json
---
 scripts/release-parser.py   | 37 +++++++++++++++++++++++++++++++++++++
 scripts/run-dashboard-index |  2 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 15ef017..70fcac1 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -7,7 +7,10 @@ import sys
 
 from git import Repo
 
+# this is the repository where we fetch most of our tag data
 GIT_REPO = sys.argv[1]
+# the bitbake repository is used to associate bitbake versions to them
+BITBAKE_REPO = sys.argv[2]
 
 print(f"Reading tag information in {GIT_REPO}")
 
@@ -19,8 +22,38 @@ SUPPORTED_RELEASES = {
 CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
 CURRENT_ACTIVE_DEV_VERSION = "6.0"
 CURRENT_STABLE_BRANCH = "5.3"
+CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.18"
 
 repo = Repo(GIT_REPO)
+bitbake_repo = Repo(BITBAKE_REPO)
+
+def get_bitbake_mapping(yocto_tag: str) -> str:
+    """
+    Get the bitbake mapping for a yocto project tag ("yocto-X.Y").
+    If the tag does not exist in bitbake, return an empty string.
+    For any tag lower than yocto-3.1 there were no bitbake mappings, return an empty string.
+    """
+    if yocto_tag not in bitbake_repo.tags:
+        return ""
+
+    semver_tag = yocto_tag.replace("yocto-", "")
+    try:
+        semver_tag = semver.VersionInfo.parse(semver_tag)
+    except ValueError:
+        semver_tag = semver.VersionInfo.parse(semver_tag + ".0")
+
+    if semver_tag < semver.VersionInfo(major=3, minor=1, patch=0):
+        return ""
+
+    branches = bitbake_repo.git.branch(
+        "--remotes",
+        "--sort=version:refname",
+        "--contains", yocto_tag,
+        "origin/*.*").splitlines()
+    if not branches:
+        return ""
+
+    return branches[0].strip().replace("origin/", "")
 
 def get_git_tags():
     tagmap = {}
@@ -88,6 +121,8 @@ def get_git_tags():
 
         status = SUPPORTED_RELEASES.get(branch, "EOL")
 
+        bitbake_mapping = get_bitbake_mapping(tags[0].name)
+
         # Create a dictionary for the series entry
         tag_dict = {
             "series_version": re.sub(r"[^\d\.]", "", tags[0].name),
@@ -99,6 +134,7 @@ def get_git_tags():
             "status": status,
             "download": download,
             "release_notes": release_notes,
+            "bitbake_version": bitbake_mapping,
         }
         tag_list.append(tag_dict)
 
@@ -118,6 +154,7 @@ tags.append(
         "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
+        "bitbake_version": CURRENT_ACTIVE_DEV_BITBAKE_MAPPING,
     }
 )
 
diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index c3fb8fa..c7beca3 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -16,7 +16,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 dest=${DEST:-docs@docs.yoctoproject.org:dashboard/}
 
 cd $builddir
-$scriptdir/release-parser.py $builddir/yocto-docs
+$scriptdir/release-parser.py $builddir/yocto-docs $builddir/repos/bitbake
 $scriptdir/layer-parser.py
 curl --silent --output $scriptdir/dashboard/testresults.json https://git.yoctoproject.org/yocto-testresults/plain/oeselftest/reproducible/qemux86-64/testresults.json
 

---
base-commit: 6c6c7e0d8291b32cf09570f3d819df4d465a7962
change-id: 20260304-release-parser-bitbake-mapping-baa27555ac04


