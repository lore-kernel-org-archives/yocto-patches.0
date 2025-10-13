Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2795BCCD183
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:08:10 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.46260.1760368087178473342
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 08:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vJ85Lytx;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5FA4E4E41072
	for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:08:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 36D9C6067B;
	Mon, 13 Oct 2025 15:08:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F8E7102F2268;
	Mon, 13 Oct 2025 17:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760368084; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=58iS6EB026D2vU3TcWI5Fd+Dp2Avus4jm+is/gm+uso=;
	b=vJ85Lytxfnv2hd5DAy1GNKPEgSvWsZvTOxuHReeRC0CCGMkvEWDquytRYWSBgG/VeJX09s
	j/t2k2J3OHmCJThZXpMf912dJKRoDS0DoZYkCmNjvMr0nQH/I9vayi+aVmPhgfoWhXmqQI
	aWbRNqNU6e4M62fdJRYTlRqZUeB3axT2HD8eu0HO7Sxtp7e4qqyOGuxt6ezhnbYH6sdICS
	p7X8F6XvG4ZMsBLZbmNFbWZojhnEygKYH+J+BEdfEnadOkBtN4ddN4Bt4WW5zHXOGiQbko
	NBiw29grE5B4nB9G+GnSZGFmcjffqZgQzWYDTq45PCVVTbi3Pd25vVpKhqhw6A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 13 Oct 2025 17:07:54 +0200
Subject: [PATCH yocto-autobuilder2 1/2] steps: observer: Extract yocto.io
 links form logs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-contrib-mathieu-bb-log-links-v1-1-79db0af7bdce@bootlin.com>
References: <20251013-contrib-mathieu-bb-log-links-v1-0-79db0af7bdce@bootlin.com>
In-Reply-To: <20251013-contrib-mathieu-bb-log-links-v1-0-79db0af7bdce@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ross Burton <ross.burton@arm.com>, Yoann Congal <yoann.congal@smile.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368082; l=2371;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=pf7NToPZItFVNEbjxWDizCJA/SqdOqHC1H5bVzFG0z0=;
 b=sd5yEU5jmr/DKPlmPZtPLQtmVBfMBYTXRMonpksSUaOXUX1UHyIuGorp95wfIdgxC3ar16ToN
 kidzZ0mhA5xB1gZlKaZ0I4EhV07oL8s31l8jdL1C4o59RLkaLJ3B+yG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:08:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2294

Add a new log section on build steps, with yocto.io links found on
stdio.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/observer.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/steps/observer.py b/steps/observer.py
index a1260690e770..555321993836 100644
--- a/steps/observer.py
+++ b/steps/observer.py
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import re
+
 from twisted.internet import defer
 from twisted.python import log
 
@@ -29,11 +31,13 @@ class SimpleLogObserver(ShellCommand):
         super().__init__(*args, **kwargs)
         self.warningLines = []
         self.errorLines = []
+        self.links = []
         if "description" in kwargs:
             self.description = kwargs["description"]
         else:
             self.description = "run-config"
         self.addLogObserver('stdio', logobserver.LineConsumerLogObserver(partial(self.logConsumer, 'stdio')))
+        self.yocto_io_re = re.compile(".*/([^/]*yocto.io/pub/(non-release|repro-fail[^/]*/)([^ ']|$)+).*")
 
     def describe(self, done=False):
         return self.description
@@ -47,6 +51,9 @@ class SimpleLogObserver(ShellCommand):
             if line.startswith("ERROR:"):
                 self.errorCount += 1
                 self.errorLines.append(logname + ": " + line)
+            url, matched = self.yocto_io_re.subn('https://\\1', line)
+            if matched:
+                self.links.append(url)
 
     @defer.inlineCallbacks
     def finish_logs(self):
@@ -59,6 +66,13 @@ class SimpleLogObserver(ShellCommand):
             yield self.addCompleteLog('warnings', '\n'.join(self.warningLines) + '\n')
         if self.errorLines:
             yield self.addCompleteLog('errors', '\n'.join(self.errorLines) + '\n')
+        if self.links:
+            # Remove duplicates but preserve order
+            links = list(dict.fromkeys(self.links))
+            htmlLinks = ['Found links:<ul>']
+            htmlLinks.extend([f'<li><a href="{link}">{link}</a></li>' for link in links])
+            htmlLinks.append('</ul>')
+            yield self.addHTMLLog('links', '\n'.join(htmlLinks))
 
         warnings_stat = self.getStatistic('warnings', 0)
         self.setStatistic('warnings', warnings_stat + self.warnCount)

-- 
2.47.3


