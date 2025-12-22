Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E5CE677EA
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:28:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83577.1766420920595867427
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:28:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ptrVSdEI;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0E2344E41D35
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D9F26606C1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45E7610AB0089;
	Mon, 22 Dec 2025 17:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766420918; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9NH2iwHMisUI9PZxEp0tkpsOC/rZICjz+rN/Bj+PN+8=;
	b=ptrVSdEITJPOvQjD+E9xn2QtjcWN6JzQupq3h18Lp5pJSPG8wiJeF7913gEtsBsagGxnRw
	Tlx4Qs7jO1PcdaSrbvgL75UzYRrHi0E1nNH1GDqqoExLM/sCoDoXeRws2yBqWPkjWPVp6P
	H+m4Tc4/a+jr0GJudiP/aXvjjpFIZjTeIfFgejygZF9mJQGiQraMq3U+9S0S6EXsgmQYys
	AT12liDhhZAYCvx80sjFKinZV/rl1aVPGrqVilI+S4Ek0QUEV5ZPTXNOJZNTc2sGAYwNuV
	yTNrBSs53FFCNJVtAA2Za+KDNlfpUef4dKbvQrq0Km2kpDoIpylka2YFc1cCdQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 22 Dec 2025 17:28:15 +0100
Subject: [PATCH yocto-autobuilder2 3/3] observer: Fix builder name
 detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-mathieu-fix-ptest-urls-v1-3-4153fdb174a8@bootlin.com>
References: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
In-Reply-To: <20251222-mathieu-fix-ptest-urls-v1-0-4153fdb174a8@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766420910; l=1701;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Q1gQLNJtVJZmfj7SsdDuReXL5Q2wk4zgRdDKgnLd0p8=;
 b=LOp/RRykxtRkGtf48SWngeZ8bfCGllGRI1uk5t2FPvl/Aq28A6+1R26+0JkHMzs4L5Hgz0n4Q
 ITNL4gv2YRDApgzv4/SgI7b5SIEk/Ck8xVp4c5AVFjt9DNXxViimfSW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2849

Builder name is needed in order to generate correct ptest result links.
Previous code tries to extract it from the first log lines, but these
lines do not go through the log observer: match somewhere else in the
log instead.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/observer.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/steps/observer.py b/steps/observer.py
index 7231d29c33ea..7187d1ad5108 100644
--- a/steps/observer.py
+++ b/steps/observer.py
@@ -42,6 +42,7 @@ class SimpleLogObserver(ShellCommand):
         self.addLogObserver('stdio', logobserver.LineConsumerLogObserver(partial(self.logConsumer, 'stdio')))
         self.yocto_io_re = re.compile(".*/([^/]*yocto.io/pub/(non-release|repro-fail[^/]*/)([^ ']|$)+).*")
         self.ptest_fails_re = re.compile(r"WARNING: (\S*)-[0-9.]*-r[0-9]* do_testimage:")
+        self.builder_re = re.compile(r"Target task (\S*) has \S* steps")
 
     def describe(self, done=False):
         return self.description
@@ -58,8 +59,10 @@ class SimpleLogObserver(ShellCommand):
             if line.startswith("ERROR:"):
                 self.errorCount += 1
                 self.errorLines.append(logname + ": " + line)
-            if line.startswith("Builder:"):
-                self.builder = line.split(':')[1].strip()
+            if not self.builder:
+                match = self.builder_re.match(line)
+                if match:
+                    self.builder = match.group(1)
             url, matched = self.yocto_io_re.subn('https://\\1', line.strip())
             if matched:
                 self.links.append(url)

-- 
2.47.3


