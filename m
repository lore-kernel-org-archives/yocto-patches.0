Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F8D2F7CD
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 09:50:30 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2159.1764928226540664430
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 01:50:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CLDL7XYf;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4B6F7C19649
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Dec 2025 09:50:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BB97260731
	for <yocto-patches@lists.yoctoproject.org>; Fri,  5 Dec 2025 09:50:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB44710B6071D;
	Fri,  5 Dec 2025 10:50:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764928224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1r7QQMHSzwAbcb1fWaZR3FpnZtFIR0O5UDU+F1TFuK4=;
	b=CLDL7XYfIvqZqmSF6YSB57ImGK3L4Itmlz/0WyM1A0xfTtKyNLcs24xkWM2Rau3NpkArTM
	suTKJzHGaxl8+yE4RySCDek4lgDe5oaQLDcOHi5Pp3HHfHFr+SPZysc4fqUL+XMfTI0Of8
	0z4YvlktZDG//RW8/BCl9sETQxoTEyYF2ltEkcGntn8CNDFny/h3Faso8tRNiIuIzAkqS0
	TThqdQsjLu0Ug6HEQHKnNdG8/guDJI/yJ5JfJDCY6vJ5ToVKLVAsxtYYMoIcivSR6e94os
	JUPpqL5UIGjHkfg3gsHmesymAKA+9SrcJ+yhgYiwssMyzxE9MzweU+EUFxSrtA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 05 Dec 2025 10:50:19 +0100
Subject: [PATCH yocto-autobuilder2] observer: Fix failed ptest links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-mathieu-ptest-link-fixes-v1-1-1fc026d5043c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANqqMmkC/x3LQQrCMBBG4auUWTvQBOPCq4iLNP1jB2tSkokop
 Xc3uPx4vJ0qiqDSddip4C1Vcuowp4HC4tMDLHM32dE6Y0fHL6+LoPGmqMqrpCdH+aCyi9MlwoS
 zN6C+bwX/0O8bfXPQzL5pnpqsM4ql+3H8AGZL225+AAAA
X-Change-ID: 20251205-mathieu-ptest-link-fixes-5fb6fe1c4a1e
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928223; l=1205;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=eo1KdHxyygroE/ZGqrJSDSnLhs0fSkTYboYWx2ya4Ug=;
 b=faU+vV9SOARPdoEKJChRDDxyKbeyRpIUlMf7s6I8afU/Pk3HECosG+1fi5pbCVLha6ZGM0fk5
 06paDtjI2jcB6Wg+LeDvT37OzBTKqWcDmqmUyiGnUC4tBcWpQca62Ph
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 09:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2739

The new log observer added a few weeks ago fails to correctly show links
to failed ptest logs. It looks like some unexpected newline character is
messing with the parsing.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 steps/observer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/steps/observer.py b/steps/observer.py
index a89f0c5b1962..7231d29c33ea 100644
--- a/steps/observer.py
+++ b/steps/observer.py
@@ -60,7 +60,7 @@ class SimpleLogObserver(ShellCommand):
                 self.errorLines.append(logname + ": " + line)
             if line.startswith("Builder:"):
                 self.builder = line.split(':')[1].strip()
-            url, matched = self.yocto_io_re.subn('https://\\1', line)
+            url, matched = self.yocto_io_re.subn('https://\\1', line.strip())
             if matched:
                 self.links.append(url)
                 if not self.testResultsLink and url.endswith("/testresults"):

---
base-commit: e8c4db23afb334de278f3c5c7800c33fe32f7438
change-id: 20251205-mathieu-ptest-link-fixes-5fb6fe1c4a1e

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


