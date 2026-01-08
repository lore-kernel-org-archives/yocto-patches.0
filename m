Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B7FD1D465
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 14:46:12 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7901.1767883564364000137
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Jan 2026 06:46:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=xS3M7G2b;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0D367C1ECA0
	for <yocto-patches@lists.yoctoproject.org>; Thu,  8 Jan 2026 14:45:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 40E1D606B6
	for <yocto-patches@lists.yoctoproject.org>; Thu,  8 Jan 2026 14:46:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 896CE103C889B;
	Thu,  8 Jan 2026 15:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767883561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Pa6ktzco4ta4/rvm+gyXhZ2e8t1q/po28V5Qi0NW6i4=;
	b=xS3M7G2bGaN3pZPVIPCACw0qVbfvA+/dqXY26Ym+AO/IJ+tXXl2f6mE/J3JWTVRjBw9hyK
	IoIU+sdVwpGFvsLuzBbQHoGVKxAJOCNsSAB1qCG0Pr+8JJS9oJn/3wR9DtASWk/qYyKkhh
	RmnRdZ1QYNcQcmhbJzEhPAKgQ9E2qrXhclAV8L5zJuc0HvzfWtqOG29FhccoA3YmOhvuTB
	Y3gktd9uKIkTEDD54kK0HroiReum0Z/0OVMgKgia7v+mjnI1E08csyXd5xI/40lDSgXUkc
	pM1I8qvG2pAYoLGSpSwAy5+AkJSBZwn5b3WivvwV25x7PzYsns8HY+WKNUxYbQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 08 Jan 2026 15:46:00 +0100
Subject: [PATCH yocto-autobuilder-helper v2] send_qa_email: Only copy logs
 when we are pushing tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-mathieu-fix-15696-v2-1-11e36594faef@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACfDX2kC/32NTQqDMBBGryKz7hQTTbRd9R7FRYxjHVAjSZSKe
 PcGD9Dl4/t5BwTyTAGe2QGeNg7s5gTyloEdzPwh5C4xyFwqIYscJxMHphV7/qJQ+qGxqmvTK5K
 5tgrSbvGUwuvzDbuz0aFZo2tXHjvyONC4kIcmNQcO0fn9km/i6v/xbAIFmkKXVaVtWbXq1ToXR
 57v1k3QnOf5AxqMyazOAAAA
X-Change-ID: 20251230-mathieu-fix-15696-788af5e206c5
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767883561; l=1986;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Cii1DXlWDPERYorWyaKykTWVILSQsNU+JlqpD1shaJs=;
 b=HMTVj8T4uW7kwp7ibv+LK7xmFx5NzKpBCjm/H0aHoLW/YIn3yWFsYGYKklpxySOfOWClRfjbj
 jNwTMsdJb/1CL/bPhiHJ/oEWE7/A20eDfc7wsnE9AQ+V9QDdrU27eOU
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Jan 2026 14:46:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2914

Resulttool creates tags in yocto-testresults and copies logs in an NFS
shared folder whose name is based on this tag. If we are never going to
push this tag, we should not copy the logs, in order to maintain some
coherency.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Add -p parameter to explicitly ask for tags pushing.
- Link to v1: https://lore.kernel.org/r/20251230-mathieu-fix-15696-v1-1-a364776c47b5@bootlin.com
---
 scripts/send_qa_email.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 23114a47da11..91f175c64987 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -203,7 +203,15 @@ def send_qa_email():
             utils.printheader("Storing results")
 
             if not args.dry_run:
-                subprocess.check_call([resulttool, "store", "--revision", revision, "-l", args.results_dir + "/../../testresult-logarchives" , args.results_dir, tempdir])
+                cmd = [resulttool, "store", "--revision", revision, args.results_dir, tempdir]
+
+                # Ask resulttool to store logs in log archive folder. We should
+                # also ask to push the tags before copying these logs, as tags
+                # and log folder names have to match.
+                if basebranch or targetbranch:
+                    cmd.extend(["-l", args.results_dir + "/../../testresult-logarchives", "-p"])
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


