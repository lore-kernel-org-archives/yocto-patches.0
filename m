Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4490F3380E
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 08:11:28 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71000.1773735084197228692
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 01:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=b4XEqcb1;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 01076C55054
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 08:11:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EE04B5FC9A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 08:11:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A36A8104504E6;
	Tue, 17 Mar 2026 09:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773735081; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=neAIogLjm989O+fDe7kWAZG1qwcqrcZOvl7STV2RxvI=;
	b=b4XEqcb1OAqQDkm0/TGYCdeUfEoO/ffwv1A2JevlQRH9UDlP1rr6ZrdM/5Rfl87B2Feotz
	mvK/C4iTvw/1NOz22CgQ3+0GLTRuQocs4eLCkCCIn69Y4Edjw7TG32Wh9BVSM4YRg6e7cy
	suJNg8msXbOUbUyxjnufXGNGYaMDr0edGz/i1bVAvAB5RRWEJEhoINlbTEj+uZA6aMD8cE
	ssRqd/p2MsyAabWvA6tivv51Fgy94d+mVTUuAqRs4HYXrue2I1tmhwSbgX5I3d58CnHuch
	B6lxAgq1vGwBvrS2CtpdtAsl36z7vZXuEnCV1ES3byBuQ/oKj4Vm7CAuQ6144w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 09:11:12 +0100
Subject: [yocto-autobuilder-helper][PATCH v2] scripts/release-parser.py:
 add bitbake version mappings to releases.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-release-parser-bitbake-mapping-v2-1-1368b57dbf40@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6CMBBFr0K6dkwpoMaV9yAspmWEUaRNW4jGc
 HcLxrXLt/jvv7cI5JmCOGdv4WnmwHZMoHaZMD2OHQG3iYWS6iALWYKngTAQOPRpCpqjxjvBA53
 jsQONqI5VVaGRpUgS5+nKz+2gbr4cJn0jE1dr/bImWsApWj3x0CZhT4Mj36zbnkO0/rW1zflq+
 GVU/zLmHHK4SlWQLLQuT+VFWxsHHvfGPkSzLMsHDZFfh/oAAAA=
X-Change-ID: 20260304-release-parser-bitbake-mapping-baa27555ac04
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4678;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9hYtu1mcolK9l21T9aEyNzWgGHmfSPwfNCsPSdsGplg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuQynyj8Yu03llplcwug1EiUyEBRmbk3RpSi0K
 TjdF66nkjqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkMpwAKCRDRgEFAKaOo
 NorUEACjkrehD54iuR3+Of1Bqe88Kbav1Md+c+vSWRBpNTEpPzFHNNbPWCYeZjNHPrjJBr76w89
 U81CSAQXGEfcZFP5E9UwvjOsM9SHSvHtR9ZcX6hJYCVledqgid2Dy50lCbbFY+rE9TNLDafmaOw
 Mx1suE23rw0rK4etcBzZTYs272Ta89jtkZXVmjgPHwiY2ARkiQePL0sxFHFtNjI0CgVsMV6Reoi
 2naa83Bqkgq9Rw/zs/f7yZzcXb2nlvMFVwXZH1VV5feNV6XDc3Jmqi60TpS98rleFV2RIy4A9GY
 G5MjDuP/MxLYPzm/MaDh9ZQ2TRE4kxOvtn53Elx/MVBQN2lcMQmk+nDGrlNifHa2z/BJkgEr5Gd
 W9oICTNQ/p1AQMN/k87bvtaSTzIBIw7tKX40wd955+RUPd4EKDIPzUxPciMk3dzHJLd+f/OCfvx
 Sl+cUSOpX+pNsVa488FHQwUorAH0bFghssoiXZ5b40G/8OFkDLm5scBJzY5M/n4y2NVJ/psZEdv
 gkG/oTOLau94n4BfWOXqlRdXq6MbhM8mlpvssEx+5rqf1YlEbi64oAPntp5U1lxB1NDlSMSOK2O
 4ZiuhFbMkI9YdSR/tXHAMOXwxKJe1NsTGk626Fz8B79DjC7x0XEjp4I3JV6dTU2jKAq8WvljfFn
 sOlS1kZNEaqUINw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 08:11:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3482

Instead of maintaining the bitbake <-> yocto version mappings in
yocto-docs[1] and bitbake[2], let's maintain it here instead. This is
part of a work-in-progress to use the generated releases.json file in
these two repositories to generate the documentation.

[1]: https://git.yoctoproject.org/yocto-docs/tree/documentation/set_versions.py?id=d97cfeaa55ed42722998d3313c1857aa377f6881#n66
[2]: https://git.openembedded.org/bitbake/tree/doc/setversions.py?id=1d0d4a0066603461eacb92a766fec616c1e91257#n25

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Tested on this build:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/104/builds/49344

Output: https://0x0.st/P9zd.json
---
Changes in v2:
- Rebased on master
- Link to v1: https://patch.msgid.link/20260305-release-parser-bitbake-mapping-v1-1-f023e03bb484@bootlin.com
---
 scripts/release-parser.py   | 39 ++++++++++++++++++++++++++++++++++++++-
 scripts/run-dashboard-index |  2 +-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 4bac558..a38824f 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -7,7 +7,10 @@ import sys
 
 from git import Repo
 
+# this is the repository where we fetch most of our tag data
 GIT_REPO = sys.argv[1]
+# the bitbake repository is used to associate bitbake versions to them
+BITBAKE_REPO = sys.argv[2]
 
 print(f"Reading tag information in {GIT_REPO}")
 
@@ -20,10 +23,40 @@ SUPPORTED_RELEASES = {
 CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
 CURRENT_ACTIVE_DEV_VERSION = "6.0"
 CURRENT_ACTIVE_DEV_MAINTAINER = "Richard Purdie <richard.purdie@linuxfoundation.org>"
+CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.18"
 CURRENT_STABLE_BRANCH = "5.3"
 CURRENT_STABLE_MAINTAINER = "Yoann Congal <yoann.congal@smile.fr>"
 
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
@@ -92,6 +125,8 @@ def get_git_tags():
         status = SUPPORTED_RELEASES.get(branch, "EOL")
         maintainer = CURRENT_STABLE_MAINTAINER if branch in SUPPORTED_RELEASES else "N/A"
 
+        bitbake_mapping = get_bitbake_mapping(tags[0].name)
+
         # Create a dictionary for the series entry
         tag_dict = {
             "series_version": re.sub(r"[^\d\.]", "", tags[0].name),
@@ -103,7 +138,8 @@ def get_git_tags():
             "status": status,
             "download": download,
             "release_notes": release_notes,
-            "maintainer": maintainer
+            "maintainer": maintainer,
+            "bitbake_version": bitbake_mapping,
         }
         tag_list.append(tag_dict)
 
@@ -124,6 +160,7 @@ tags.append(
         "status": "Active Development",
         "download": "",
         "maintainer": CURRENT_ACTIVE_DEV_MAINTAINER,
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
base-commit: 1e27bfd901292297c8471e287d62226f4555a2e1
change-id: 20260304-release-parser-bitbake-mapping-baa27555ac04


