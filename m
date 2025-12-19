Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B421D767CB
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:36:18 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14175.1766140572635120061
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 02:36:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=a9VtdG73;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 210B94E41CB6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E5B106071D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3650102F0C7D;
	Fri, 19 Dec 2025 11:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766140569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=P2IA325s7V+SIBj0yIaB9X/Ja23cwL6xFUeycyA1fNE=;
	b=a9VtdG73NhNUZGqwskqSz7U6LLnQRLdaYXHlAnuHZAtOwnqMJuUB0jId2ZMY0O1pKgTU/k
	YInpSlMMYtDPwF6K4HCgKx6FkrAgmamhgEv5yIdFOpZzpWNlH9FP+P3Oa3pdmw6k/6mKYo
	JFmWghqVN3v1P3YBAHoHaKsQnRRgyr02ivTsKfnzmA5SeT9IkJ2A3uvypA/HLW+gOW783r
	qIzPAmHnNcCgnnLRQ5cdAamM5aDxhwxi3C1BwZSVjBaIh3m3Tm22y767lBjoHM70AiBEK5
	Nbk4fInWL5P7Q4+p9Iz33sYLpXRR3Mit/zJgTgwE1CoVcUef8FEpP3jYYR92yA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Dec 2025 11:35:39 +0100
Subject: [yocto-autobuilder-helper][PATCH 3/3] scripts/release-parser.py:
 define globals for stable/active versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-releases-parser-updates-v1-3-6830e6a67db0@bootlin.com>
References: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
In-Reply-To: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=EAOc4amIk17ZyyARF5janHZIac7pLY/sfUSGIFJjR7k=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRSqK1kTjViviJki9AMIvzr5RtwIXcE+Ca63bq
 ffZsAHW7riJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUUqigAKCRDRgEFAKaOo
 Nh9HEADCawgdaTYJe57SCt0iwDE+IRB+OT6F9JIZzXaHGS5UnFOYAoBkh+Muz3LcLW3dCsid0XR
 bQdQsthjem+M+EJt0kfl04+8/9/XKTPZGxz1ScBo9hlyLcJVcQkKPU8k71MuWVE8vDHIAJnr0j5
 EWfsblk3SbrYsoGyeCAoBv0Ml/ZIS1Fi6cgLUT34z0qWGn7Rf4lf+G3EqSOkGmIgbmLDTX8zjY+
 5AJ8Tz40/y8akSYjVYKsIP8/8IbG8ZVdvXvIryFzeFQRaWE0TLXFFcO9UtmQOwXbWdODDgqqWlv
 YAEw+bKnY6q/0+kO71rKbM1gNAWmY5FC2slAX8yHjSmJDgwGQNC+5qNi9+RlsTc3Th+dHq2b7M1
 mjJYokdALryY5jHd5t4gKiZS8hqC+B7DO6+itDuhtjbUDZPjDfp4VEWN+9hj+6uET2IX1NctyT2
 G1Ls/1IvAZURz+FRKnUlFcqcgLIhSeIsXIk9thmmXDHnBO/RmzuHFgkwDgxYgPIQ8IirUpy+ESP
 w8w5MSXbJYcd3VtrTNRiGq5opWVq9of5ckFwrU/pFWJLtMuq50ZO9gVr7n+zwMYzh8r8VsngjHQ
 z6afQFSZwLPrp4C09sof14oTDx6rgAlbm+acYHiyqxNOZo683NqxS7vlnuXrVAycq77PWD0Try6
 zFlGlm/an8FqV3A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2831

To avoid forgetting a spot where the we need to update this information,
define it at the top of the file and use it in the code below.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 61ff935..5993b30 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -10,6 +10,9 @@ from collections import defaultdict
 import datetime
 import semver
 
+CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
+CURRENT_ACTIVE_DEV_VERSION = "6.0"
+CURRENT_STABLE_BRANCH = "5.3"
 GIT_REPO = "~/git/mirror/yocto-docs"
 
 repo = Repo(GIT_REPO)
@@ -83,7 +86,7 @@ def get_git_tags():
             status = "LTS until Apr. 2026"
         if branch == "yocto-5.0":
             status = "LTS until Apr. 2028"
-        if branch == "yocto-5.3":
+        if branch == f"yocto-{CURRENT_STABLE_BRANCH}":
             status = "Stable Release until April 2026"
 
         # Create a dictionary for the series entry
@@ -108,12 +111,12 @@ tags = sorted(get_git_tags(), key=lambda x: x["original_release_date"], reverse=
 
 tags.append(
     {
-        "series_version": "6.0",
+        "series_version": CURRENT_ACTIVE_DEV_VERSION,
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Wrynose",
+        "release_codename": CURRENT_ACTIVE_DEV_CODENAME,
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("6.0"), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

-- 
2.51.0


