Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CFAC282E3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:03:42 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.10016.1741169016256022207
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=n2Lj5mYN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB32644282;
	Wed,  5 Mar 2025 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741169014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pxlkmqyq7njCPgZNnVNK0OI2qMfub7yWv4tJFg6LGlc=;
	b=n2Lj5mYN/6LBYKMwTE/NsHmUc1e2NnKc2xpoUdrh2sChNKy3AcRMfNHcF+MFfxkGmfNws9
	CYEGHtV3qBy1kOY3GNOkZkvMKGqU3qanFyuOxmpwlE6ci9iJVzqIs3GzBbT8NFkR4SxNU8
	j5NvEBmUnKYQ+JNH5oRkdQAWwXkAp4vbGKfsX88L7KPAXydEF8Gzp7iFsPyK7JDoOyHHuh
	nX6bOThjwC0D0m9JJX1CRIP0J/aBde5RhHriHVpAF8DvhlSDIr259dJY7hrufWtm8IHk7J
	BTJAySu1qBbqE9SGaNE4Ic7AAFqQ6refEBbDCBDabsDgQ2Qjz190s9nCq8DT+g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 05 Mar 2025 11:03:06 +0100
Subject: [yocto-autobuilder-helper PATCH 2/2]
 scripts/yocto-supported-distros: ignore missing on AB for stable branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-yocto-supported-distros-fixes-v1-2-308df26dd6d9@bootlin.com>
References: <20250305-yocto-supported-distros-fixes-v1-0-308df26dd6d9@bootlin.com>
In-Reply-To: <20250305-yocto-supported-distros-fixes-v1-0-308df26dd6d9@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=57bgeS0rilkGRDKsKArolGco4lH2ZhfWvMoJl9Snor4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnyCF2An1wMqXgbDLvAxEc5BJ6hK/6j70DNrvJx
 8hFmM1BCjOJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ8ghdgAKCRDRgEFAKaOo
 NjyCD/980QkxDCCxWf6eRcXuZLq83QgxkX/NHEeQu7BEkqf4rt5Aw/wOoXTL7Ch/HzNmP6SkiT2
 4ENhJDK8YjxplhPj3zC32pDHvECQQFH9z+zu4P8sWmxfrqf2L+E/zShHyZAuG1LXZVyuOMqj9ZM
 BP7HRTQg9/zJdoYW805sRVrnP5k2mrQzN8wBuMIOVAh67BV4yM5lBn8v8go5nOtdc0PHD15QhBN
 KIlttJvNlZna0f6HYFpm/C9dq7hN8OL71HVaiKZgJHM7B77pJJoshaGh2YhHmr6GuOmU24wnRWU
 jiM2azB0VmuEYumqJRUqWIkCdAB3XB9WxcfCjxkUQW3q5DGe3fg+2uQw2hgJx3Da9iycQnpYFfy
 UaLlx+JE5oryP4wsQRqZam7tLTrhihUFMB58TTopuGa9q+xHvTFIayU18UKceOZqjbK9H8x360h
 SYLB99Rkfo3OzMCkaYPzuzMDTAYwPVl9FqqUzOpFiM06C9IgIIsSsr2gHkQGvPLXTbDjIaZ+z3+
 st4pGAFbKaTK3iNO8AawM62wNcXjeAVaOMwXB7v0wsOWERS5xJ+ZJronsmUMENppOk1//g/Hl2w
 wG9XQfYvDijxZyoMVIOq2aZ6QQwlO02QyQ9JNCqaclSbHt3FdBdS53ipfIL3ld6fu+4QMn5HFwD
 Gf78HHyq5GuHW6w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhst
 hhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:03:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1143

Add a stable_release boolean argument to _compare(). If True just
ignore missing workers on the AB, because we want to keep the full list
of tested releases in poky.conf for stable branches.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/yocto-supported-distros | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index 533e3d48bddee9c685d4e94add14c66d2406621c..112d967149e3542462db3fe8ccd3d7a66dacca57 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -199,7 +199,7 @@ def _mangle_worker(worker: str) -> str:
     return ""
 
 
-def _compare(ab_workers: set, poky_workers: set):
+def _compare(ab_workers: set, poky_workers: set, stable_release: bool):
     ok = True
 
     print("Configured on the autobuilder:")
@@ -218,9 +218,13 @@ def _compare(ab_workers: set, poky_workers: set):
 
     ab_missing = poky_workers.difference(sorted(list(ab_workers)))
     if ab_missing:
-        _print_worker_list_warning(sorted(list(ab_missing)), "Missing on the autobuilder but listed in poky.conf")
+        if stable_release:
+            print("Missing entries on the autobuilder while listed in poky.conf, "
+                  "but comparing for a stable release so ignoring")
+        else:
+            _print_worker_list_warning(sorted(list(ab_missing)), "Missing on the autobuilder but listed in poky.conf")
+            ok = False
         print()
-        ok = False
 
     return ok
 
@@ -256,6 +260,8 @@ def main():
 
     possible_workers = {}
 
+    stable_release = True
+
     for release in releases:
 
         if release != "master" and release not in config.workers_prev_releases:
@@ -267,6 +273,7 @@ def main():
                 exit(1)
 
         if release == "master":
+            stable_release = False
             possible_workers.update({release: config.all_workers})
             continue
 
@@ -291,7 +298,7 @@ def main():
             if mangled_w:
                 ab_workers.add(mangled_w)
 
-        if not _compare(ab_workers, poky_workers):
+        if not _compare(ab_workers, poky_workers, stable_release):
             print("Mismatches were found")
         else:
             print("All good!")

-- 
2.47.0


