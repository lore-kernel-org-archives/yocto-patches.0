Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BAEE83EED
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15338.1770192528862921440
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=k7rel0MN;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A3524E423F3
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A7B860745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89531119A88EE;
	Wed,  4 Feb 2026 09:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/QKBfSbu3QhppnpcHbughp3k4MdsEb2DA82D2ha1zU0=;
	b=k7rel0MNILCJSO1k/0aeuKC/tBbC62X9CenhlaYNfPtOPV9Q8bhrPtPnPE1rIjf5Vy1igW
	bm9Yh+ymiy3a2fFIVTwRFjs3Avpnjfvkoaqqsjo16AOH/NgEN6s1Fr41koo+35mkWF1Ido
	cCsC40QOC5QdZD1jMK4iSQ2max3lCUvuZCMpv3qmazhu3DbCMkIsT3PSL6NdV+YYb/+tZ0
	E15g+Qs2NyZc/4JMLNjtiGkwFa7t8C6hptSSZUEA60iXBoboJQF4t6yfiJQ4N668XB2GcP
	Jrm9rZL2fLoeZ80H56AUfHM1tpXvK6/quYp/m80vEgtcT8lnDW4qEjkN1UmQbA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:22 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 2/7]
 scripts/release-parser.py: update for Wrynose/Whinlatter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-2-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aXsQVV0dKDwh2hCyFd84PNoswrLjb3s0vXeOQ3IK+Zo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6LZYQ6lPHiEZGIYFWfqDh9d3DLkWIdXaYv3
 h0NIXBv4c6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+iwAKCRDRgEFAKaOo
 Nle4D/47jJlP54CirrBkFaE32Idxum7KruIZ53bb6LrksPoCQLXaIrOw6w9xZH969mqYsvusoMc
 aLwGBjMp9tnUNSBmKjEh2q7TC//OO3e6iA16Te8s6VKu4wiiJlzmAAT7WERss7t9vDyQzld6LBK
 1eIpj6J+1TilasIe2L8SorRbgG5Z0vue5y+1WUEc1usUn/V1TJDb+QCXPLUMxWccrO+kqMJrraG
 lq3xN1DYzBD8iktJpHzwuZiP1Z5gDZzbTZu5gQdJa1fZ/IM+n2TRRWfTVXpcZ3zj0mS3jmzKHgU
 ig8sc6pTbIgvHJN2D3AjdLARUb7WCvUgFt5+tfkqRBf2K8i4IOtIQKHtXXrF5cRN057/bvlh8az
 ZoLlnEGIdtrAil+QTCFnuRBZB8oQqDUlhdVd5q7ECbIf1pznYr4q0T55fhgFXzGIQSGOliFzq71
 dqyTNMxJyOk3/WJgHTjJDimfTDrXNknQYGYSTA4ap7b80oMwB58XPfZs6mRVlswKTVGKQiHps4i
 gM29SJNWwagAeF44ojF3AIiIcEgd49SDdy4PwSw7Wm/kigiktnDcB3LzdhBlVt7ftaY03VKhmCA
 CKsUv+kLBiiW/dXbGgHq3MwpVXyers4oU2Dlw8Ol3XM90IXPAHfBNt083VVhjo4PHHbL+VTl+pK
 a1MnGiKp774DF3w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3181

Use a new global SUPPORTED_RELEASES dict so we maintain the supported
branch in a fixed location.

Update the script to show Wrynose as the current Active Development, and
Whinlatter as the stable branch. Since will put Walnascar as EOL too.

[YOCTO #16138]

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index ef25289..e882569 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -12,6 +12,12 @@ import semver
 
 GIT_REPO = "~/git/mirror/yocto-docs"
 
+SUPPORTED_RELEASES = {
+     "yocto-4.0": "LTS until Apr. 2026",
+     "yocto-5.0": "LTS until Apr. 2028",
+     "yocto-5.3": "Stable Release until Apr. 2026",
+}
+
 repo = Repo(GIT_REPO)
 
 def get_git_tags():
@@ -78,13 +84,8 @@ def get_git_tags():
         else:
             download = ""
             release_notes = ""
-        status = "EOL"
-        if branch == "yocto-4.0":
-            status = "LTS until Apr. 2026"
-        if branch == "yocto-5.0":
-            status = "LTS until Apr. 2028"
-        if branch == "yocto-5.2":
-            status = "Stable Release until Nov 2025"
+
+        status = SUPPORTED_RELEASES.get(branch, "EOL")
 
         # Create a dictionary for the series entry
         tag_dict = {
@@ -108,12 +109,12 @@ tags = sorted(get_git_tags(), key=lambda x: x["original_release_date"], reverse=
 
 tags.append(
     {
-        "series_version": "5.3",
+        "series_version": "6.0",
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Whinlatter",
+        "release_codename": "Wrynose",
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("5.3"), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("6.0"), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

-- 
2.52.0


