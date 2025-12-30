Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D4EE4991
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 17:47:54 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69019.1767116864499852657
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Dec 2025 09:47:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vDA9XHlY;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 500DC1A2542
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:47:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 192AF6072C
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:47:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77FCF113B062B;
	Tue, 30 Dec 2025 18:47:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767116861; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7dtPz8Y6yzMel9bhCu5i70k/J13sTkfJynXKYcg48Zo=;
	b=vDA9XHlYtPJJNmzLDr95uy8c7oXFDaD1XK+n9eD+DPH0Vzdv6bk//XPbQHn6YGP/12Tasr
	AjBTxHvGB4/0JglyGVY5ae0RTwjpOAO9xd5rq4QRfJXqBV6isk4iUiNVTaL7k+Sds7M4ea
	FbzJWObzpfJizaIPhVLpTbQCm/jZaY/mqBV9DMIG3O4BjQn6ToLqFTiy+zDv308fJR4qpj
	4zt8ikD5Os/npyeTlSBHEZ31RN0RE9u0CdSBZGbS4Uk696838kncNqOxST/HYABY463L10
	rcGtdylt+JDCzEdbYl8TZg1xbqwQsnajKrujBd+zEbQnO7oXnMdYLCbzxwQ9rw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 30 Dec 2025 18:47:07 +0100
Subject: [PATCH yocto-autobuilder-helper] send_qa_email: Only copy logs
 when we are pushing tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-mathieu-fix-15696-v1-1-a364776c47b5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABoQVGkC/x2MQQrDIBAAvxL23AW1aNN+peRgzKYupDGsWlpC/
 h7pcRhmdsgkTBke3Q5CH86c1gb60kGIfn0R8tQYjDJWm6vCty+RqeLMX9TW3R3e+t7PloxywUL
 rNqEm/88n/FIoCX0taay8TCQYadlIYDiOEyeGqAl9AAAA
X-Change-ID: 20251230-mathieu-fix-15696-788af5e206c5
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767116859; l=1781;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=nr1RAyOOV/P6YLX6CSIX4FwlBMcdJEGsKkTypiDk83I=;
 b=ZrGdt3BZtOFln3BlX+pjFgzZX6a/t4SIUFEXcs8fVXxTMCHZq4Mf64CbArNKqX7KoiYl10ijA
 VKudmF9KqegCDECjRktOsDg1k1EJpcZZV+XMPco8042JRULkVcC7aNO
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:47:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2885

Resulttool creates tags in yocto-testresults and copies logs in an NFS
shared folder whose name is based on this tag. If we are never going to
push this tag, we should not copy the logs, in order to maintain some
coherency.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/send_qa_email.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 23114a47da11..2755df9f30f7 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -203,7 +203,15 @@ def send_qa_email():
             utils.printheader("Storing results")
 
             if not args.dry_run:
-                subprocess.check_call([resulttool, "store", "--revision", revision, "-l", args.results_dir + "/../../testresult-logarchives" , args.results_dir, tempdir])
+                cmd = [resulttool, "store", "--revision", revision, args.results_dir, tempdir]
+
+                # Ask resulttool to store logs in log archive folder. We should
+                # only do this when tags are pushed, as tags and log folder have
+                # to match.
+                if basebranch or targetbranch:
+                    cmd.extend(["-l", args.results_dir + "/../../testresult-logarchives"])
+
+                subprocess.check_call(cmd)
                 if basebranch:
                     subprocess.check_call(["git", "push", "--all", "--force"], cwd=tempdir)
                     subprocess.check_call(["git", "push", "--tags", "--force"], cwd=tempdir)

---
base-commit: 6f793956c9b43f7a74f5a22c86a93b744b21ada9
change-id: 20251230-mathieu-fix-15696-788af5e206c5

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


