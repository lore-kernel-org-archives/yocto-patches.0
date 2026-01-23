Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A189D72361
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64023.1769158812299450008
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=P7jX9PB7;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6BD5CC21ABC
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EBD46070A;
	Fri, 23 Jan 2026 09:00:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 701CC119A879B;
	Fri, 23 Jan 2026 10:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/QKBfSbu3QhppnpcHbughp3k4MdsEb2DA82D2ha1zU0=;
	b=P7jX9PB715Hetda49pmUyC7dcr+FYlKw6fMtKt+W5KpcE105ZWQeq0Kgug1QBc2yl7x3B7
	RsOoiprfWmuY8eIPts8xq7xkNKDT2us+iw2CN9yz1wTFU+dvZ7pFrz00EtcOVsK6d6u5eF
	+NcDrCEpydAuBxldjPp2jQeKJpyT1C0nRUXpq9QR4SttCXaLq+IFK18x7QvZYNXHBaddyk
	yQCvJn+nIyXFweTRWSZSqNpcF2DvsEquH9FunH83pN/SgSOBpVdklxVIXyHaIIviHc+/et
	wW/E1fbMQBYZCY3nwXEEuaqmvGxf7Vx8m/33WPmvEP+ZlXDZd8rGMsbiJUbIcg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:45 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 2/9]
 scripts/release-parser.py: update for Wrynose/Whinlatter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-2-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aXsQVV0dKDwh2hCyFd84PNoswrLjb3s0vXeOQ3IK+Zo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziVC1FGnsPnhsWWR8erCVUirEk99URPfoTLn
 7Vj5fvaBPmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 NsJBD/0Zp41P4we/tAxQ69MQC/Mj9KvAUItAf/7GWg0+UMa21M7FdjDGQR9yK87ulrPjms1xD4o
 jZcPsfbo4Ivhn90yxBIUWQ6UiB7aetjWCR2shC+27DoMQTV+4v8fTZJxYhWEpdP/m8aTGMoY+w9
 EEuZpqNQf3xPJKcUE5Oz1m74sjHPItwxjuLnuUdbB/+Dq5ZL/O9yn3O2kHH66c+XgYVUTM+YGOH
 gYITrAvFsQG8lutFq9oz+PTVrIqQsJc2JgQtVaeaM/8WIJsP5BxlxGyM/xFHpg8va6PM9XHBIoh
 iMQO/M6GgMVenufj2UaBdiobR4rBnG9Yz63NVqD8FbhzbJuUVQgpcJ914BNdOQMva9T5SxcfYq9
 45Frp28UuqXnqNuQHfaCCKdwl7QhKyDBHfXy1ZSv4+PDtXxG5jFFpfBQ4/T+kMrPGVZtqdxNHs5
 WQHlDJuQw6lh3KmEjPltcQbRpdih/8YQL1Upl+7vqzfc4kfSydd2GTlX+NdRqXlJu1pFRIU4ROz
 r3PpWx9in8kc5EZk2HY5AtUGnDz5QjN/XLiQNk8MRYQtMc0JGaquxSbD/JJMAn9C7H3GrY0/bfI
 ancnFNPk4ysBNtoWqytxqg6QDVKdscrkuXmzvUlLzX7dOFbL50oW+RZIBRqLplTQs5QRQhBv2rs
 2jGJzE6tY0mif+A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3058

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


