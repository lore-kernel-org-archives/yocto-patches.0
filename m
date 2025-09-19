Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C2CAC5A5
	for <webhook@archiver.kernel.org>; Fri, 19 Sep 2025 09:23:36 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.12341.1758273811551516060
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Sep 2025 02:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=yOhaXpXq;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4B2521A0F14
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 235EE606A8
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 788D6102F1C3C;
	Fri, 19 Sep 2025 11:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758273809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=uaPnsimfNpVoa9hRuAESXHebyZKgLWlOdRWIqwSjuTk=;
	b=yOhaXpXqGSyCeM476LX6Wud9xJQMmhR24xqlbHezoIscoCVQnd16f8DUsVYPSbLvj/3h8r
	DZ4ldO1b7oI/qbD990GzWpS+IGaW1Dh+t3u02x6s2hRUhzir7t7vyjalNFstZsngCbgIi5
	1OWar4iMJV0AqwFdiup1rWp8hG6dlpIU7l6ink+Ys0PrgW3FomC3pKUn2uriNi1pT2Qi31
	PrMCsnBYB5rDh6PY7/h9txLEfOy4h0XUX8Fewz6Kh04nikcTkO0tBTrD6gbYDK16jiQEUC
	4weR/FQQ3x5Cqxk3UdKtu1a7Ks5toJtmC1gf+NLgoH3GE7ILRqY1AWZh0q71yg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Sep 2025 11:23:05 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/yocto-supported-distros:
 update after changes in config.py
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-udpate-ysd-script-v1-1-e5d4eacda316@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPggzWgC/yXMQQ6CMBBA0auQWTsJJUGtVyEsSmeUMYQ2ndZIC
 He36vIt/t9BOQkr3JodEr9EJawV5tSAn936YBSqhq7t+tYai4Wiy4ybEqpPEjNejes9GUuX/gy
 1i4nv8v49h/FvLdOTff6Ohi34HNCVHKYiC3HCmZfIaYTj+ADXdiRnjwAAAA==
X-Change-ID: 20250919-udpate-ysd-script-81a5cd19d756
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=pj9Yndd79tgSnKktxjupG9QaFHMPTfTHvsqf3gOnKcg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBozSERzcINaZyM0YIFAL/m1z5PgcvQngONrIG0g
 uxMp42sxJ+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaM0hEQAKCRDRgEFAKaOo
 Ng8qEACZv8nhLVcFLm6fYvuT0/8MgfFl9tatZ3Jt3LNyd483ncyTV2WpXfVr6DiFDqidAQHno3z
 8tzoqO3QkIace6wOs8QGZGNF3DToudIVjxyIKrTTMlCBYYXPPJHFaE/VweCMkvCr+JPyOkTs58g
 ALzyPjhiBYE0K21ma1cACwRN2HJ9I221wK1eZpcBBv6v5Y5QRKFQoGWnR7Z0hVqzbPAfxO9kgao
 UdIBbrdDmk1SCmWqWkMcbmNvp7trqqHmm5ybYtqixXuBsS8wfKi37hk7sQAffZXVF0Ak7cIcax3
 0q3jeq5xCh1DipDdTrhXbkAJIkhH8K2tVAgX09qFgq3eo7W7S8AXdtn3l4ZOTfvBEnPdAHL7XcY
 BORHoQGID0/n73EkEf4mTKE56QXrsLg/vJFsyqYFp7djbIi7jiLYQKxTBklyaKh2XbNCDyKN41p
 z4Ay0j5yoo3NmUM8eZw9/wCR4iWgz2Aqq1gDeLp5kBRqrTBBA+md9WTzUrgBkdlmdaVMbjIK125
 Te4HoSAWQTH7FH4y0SU8IljzYjor+YLCAAbYhY+FF6mWQOi9g8cz1KrKFs5wuItQV7ZVTKeXmcI
 4C5iLCoAVGZD0BnODuPOX0v0ov35Yqky3cXAcGoWeck4g2l8B8iNSJFlOxS92kAOzXWYLR6EX8Q
 1LI7eQCTC2YIH0A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Sep 2025 09:23:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2220

The config.py configuration file of yocto-autobuilder2 changed, and now
"master" is listed in a worker_filters variable (same as before but
includes master).

Adapt the script to always read from that filtered list.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
For context see:
https://lore.kernel.org/r/DCW1DRNGJELA.1WL7VLD0XA7T2@bootlin.com

Should be merged along with "config.py: remove debian11 for master" on
yocto-autobuilder2.
---
 scripts/yocto-supported-distros | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index e70943d..d833327 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -185,7 +185,7 @@ def _possible_workers(all_workers: List[str],
     Return workers in match_workers that match the workers in all_workers.
     A match is a worker in all_workers that starts with a worker in
     match_workers.
-    This is because workers_prev_releases is defined like so in config.py.
+    This is because worker_filters is defined like so in config.py.
     """
 
     possible_workers = []
@@ -382,9 +382,9 @@ def main():
 
     possible_workers = []
 
-    stable_release = True
+    stable_release = release != "master"
 
-    if release != "master" and release not in config.workers_prev_releases:
+    if release not in config.worker_filters:
         print(f"Release {release} does not exist")
         if args.release_from_env:
             # Might be a custom branch or something else... safely exiting
@@ -392,12 +392,8 @@ def main():
         else:
             exit(1)
 
-    if release == "master":
-        stable_release = False
-        possible_workers = config.all_workers
-    else:
-        possible_workers = _possible_workers(config.workers_prev_releases[release],
-                                             config.all_workers)
+    possible_workers = _possible_workers(config.worker_filters[release],
+                                         config.all_workers)
 
     if args.check_worker_statuses:
         possible_workers = _filter_inactive_workers(possible_workers)
@@ -433,7 +429,7 @@ def main():
 
         old_distros = []
 
-        for distro in config.workers_prev_releases[release]:
+        for distro in config.worker_filters[release]:
             if not any(distro in w for w in config.all_workers):
                 old_distros.append(_mangle_worker(distro, "ab", args.output_format))
 

---
base-commit: fa3e15fba7fa96da520343c2ad312cefa6fc9c87
change-id: 20250919-udpate-ysd-script-81a5cd19d756

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


