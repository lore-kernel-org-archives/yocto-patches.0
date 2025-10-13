Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E3CCD18D
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:08:10 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.46330.1760368087250830496
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 08:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GDflx3Fe;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0264AC093AF
	for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:07:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC87A6067B;
	Mon, 13 Oct 2025 15:08:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BD9E102F2272;
	Mon, 13 Oct 2025 17:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760368085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/YGJHjoaWuWGBNDqMZJOpBiTxzqXqzvFOIkiHs8QB7g=;
	b=GDflx3FeGu1rM1WbzOLQ1ewfx8JPa9SOdDti3ABCeEnmsmXNqPIF0K+uZvVhvE8YksWUZz
	a20+DSGHMARPiQljRN2+fVFNljw+dsqIs3cjbjyF/a3zNqJVUQNNRpxbm7EC13hs8hWdWt
	qUVYUht15JI5bEY3GMtzGlV0jL+yp170t4XZS0ax8HW0QI3G2+rPauKkL3Jp2jaCT1X9ZB
	Tcwl0vOQuuR2/MGwGYfS5qnOH8gc1N0TYV0JRdv6ACQOBnDGAzXJo14kLHQpoHuunX2kXp
	vxbxdv5ZjizssXplL/0gjdP2DQvU1337sFXKQhGHewHm7rCSpqdDmfxlZxnRAQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 13 Oct 2025 17:07:55 +0200
Subject: [PATCH yocto-autobuilder2 2/2] steps: observer: Add links to ptest
 logs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-contrib-mathieu-bb-log-links-v1-2-79db0af7bdce@bootlin.com>
References: <20251013-contrib-mathieu-bb-log-links-v1-0-79db0af7bdce@bootlin.com>
In-Reply-To: <20251013-contrib-mathieu-bb-log-links-v1-0-79db0af7bdce@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ross Burton <ross.burton@arm.com>, Yoann Congal <yoann.congal@smile.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368082; l=3217;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=d9PFCnNhGtCG7cUXYPhybiI6BVrtzmx8SnuKUGuxedM=;
 b=H4BxbXd9xZUeHtTray8g8jNM4boSjKrAfwUJAyQOz1AMfTGl7jA2vHExrT3ZGS/K8IP4QCkOe
 jjHW+NTSSsiDnxjzw6cZXqA+enSylGZccfyojfq3aYdhSpBxVJUNis+
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:08:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2295

Finding the ptest logs corresponding to a build can be a bit tricky: it
requires to find the correct yocto.io link, then the correct subfolder
corresponding to the builder and the correct ptest image.

Generate this link in the log parser and add it in the links log
section, so users don't have to do all of this by hand.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/observer.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/steps/observer.py b/steps/observer.py
index 555321993836..a89f0c5b1962 100644
--- a/steps/observer.py
+++ b/steps/observer.py
@@ -29,15 +29,19 @@ class SimpleLogObserver(ShellCommand):
 
     def __init__(self, maxsteps=10, *args, **kwargs):
         super().__init__(*args, **kwargs)
+        self.builder = None
         self.warningLines = []
         self.errorLines = []
         self.links = []
+        self.failed_ptests = []
+        self.testResultsLink = None
         if "description" in kwargs:
             self.description = kwargs["description"]
         else:
             self.description = "run-config"
         self.addLogObserver('stdio', logobserver.LineConsumerLogObserver(partial(self.logConsumer, 'stdio')))
         self.yocto_io_re = re.compile(".*/([^/]*yocto.io/pub/(non-release|repro-fail[^/]*/)([^ ']|$)+).*")
+        self.ptest_fails_re = re.compile(r"WARNING: (\S*)-[0-9.]*-r[0-9]* do_testimage:")
 
     def describe(self, done=False):
         return self.description
@@ -48,12 +52,19 @@ class SimpleLogObserver(ShellCommand):
             if line.startswith("WARNING:"):
                 self.warnCount += 1
                 self.warningLines.append(logname + ": " + line)
+                match = self.ptest_fails_re.match(line)
+                if match:
+                    self.failed_ptests.append(match.group(1))
             if line.startswith("ERROR:"):
                 self.errorCount += 1
                 self.errorLines.append(logname + ": " + line)
+            if line.startswith("Builder:"):
+                self.builder = line.split(':')[1].strip()
             url, matched = self.yocto_io_re.subn('https://\\1', line)
             if matched:
                 self.links.append(url)
+                if not self.testResultsLink and url.endswith("/testresults"):
+                    self.testResultsLink = url
 
     @defer.inlineCallbacks
     def finish_logs(self):
@@ -71,6 +82,12 @@ class SimpleLogObserver(ShellCommand):
             links = list(dict.fromkeys(self.links))
             htmlLinks = ['Found links:<ul>']
             htmlLinks.extend([f'<li><a href="{link}">{link}</a></li>' for link in links])
+
+            if self.testResultsLink and self.builder:
+                htmlLinks.extend(['</ul>ptest logs:<ul>'])
+                ptestLinks = [f"{self.testResultsLink}/{self.builder}/{ptest}"
+                              for ptest in self.failed_ptests]
+                htmlLinks.extend([f'<li><a href="{link}">{link}</a></li>' for link in ptestLinks])
             htmlLinks.append('</ul>')
             yield self.addHTMLLog('links', '\n'.join(htmlLinks))
 

-- 
2.47.3


