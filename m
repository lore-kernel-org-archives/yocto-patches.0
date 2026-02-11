Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D71EA3F3D
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 15:50:08 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22012.1770825003160367999
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 07:50:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ac1Gzufl;
 spf=pass (domain: smile.fr, ip: 209.85.128.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48327b8350dso48303005e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770825001; x=1771429801; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvivBjVkxt/qhUwkrw0iPlWq3i1GQkR6PUp3rXj7RJA=;
        b=ac1GzuflUBa28SdxQ5jV0bC7GaHG0sx7tVz0y/7xWrB5t1NxmASKJQ4kuLjtDYXZwD
         6r8rGy6DfUNYzp1K1swRQLCpGGWuS4vTi7axvXJuq5/B19wSvvfbrvwIoriSgUphOq3c
         D4ABkuGAOnFDR1l/q/jshbNcH7ii/qLYnyRBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770825001; x=1771429801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvivBjVkxt/qhUwkrw0iPlWq3i1GQkR6PUp3rXj7RJA=;
        b=Hy77BaWGXaIG/Fq3on81MkYR3mMAtpL4a4jNMwuHOV2Lpa/tH8QrRXnpfCeup5qDQv
         9c+e6c4xu4NDm+0f8pHdXy9GzhS9NrezAIXN1MLLCD7SNBVHN31KUzGkJBHEjRnP2ScK
         Iuct34O5eozPvtIr38v2QxUQEByXMvMIsy4sRErXYY+gDcowmo6Yk7n0G1tJGn8xS+T8
         pN+9rtcy5aDi+Jn74bzUHxYnfW7dxGr1/2dNlm1j6YHNIBffviMDHLPdpZ6pi9FOroGN
         K6FtPgr56Pen01omtNFKlPuz2vKhp+++0tBOm6SIKFuZ/d3Efp/ZPSNi1VqNJa252v7R
         Zyyg==
X-Gm-Message-State: AOJu0Yybp1ISfUGFW2kMnaSAI90eZ9LdcgeGmPp+/N+7Wkra5dCMYJoO
	qpuw+ettdm/4ao/qmjWLHWWcGfRRv3SstNfVLPrNv9E2hnHwpbKV7j1jFqbfVs2AUWxlkb44B5R
	+3krs
X-Gm-Gg: AZuq6aKObTtxUqpNF1538XyQTDAFIvIVnbblGYnGziLxeh2o1Fnd/ofXbGE9nJ9yTNX
	4mxjBP16F+PiwmI7SNRq9H4RMZsd/7Vk9Ib4FshP5UDM4CwOetnFTrrUHHjgxSCIqY267Vt0ztI
	JlV8rN3tmH540BmbpZu4t9uYcj4jyq771uBRx+ZOBv1wc8L/0pEO48X7OVqPnZaq14S/BjvrMmE
	lZRoOx42KBRi2Syn9MTMSEPjPkkryhPd+fEUiy8CMRDXpBxGAZfoIJIVAWAFASirLe8OMiwmxI9
	x6FwvwOanz4IiMz2+PhKHRPWnHsVMvmvrcHhsEoHamHivK2rKG5f//4AjEptxGOWPbzpJHb3n9y
	if4ibT0nt5LEDIp+5L/TSLaFMVOmKu531VzjgJRnnBhv/xQPdZsXxvPgrl8xrYyhlPXWmkAEH5m
	rcLNb3Vz+Ur6Z8gRsYvafJBdIS5tsHLXpLw7+7KMGgQgfUZt+tpCpw2081aVh82LmdvPWyNQWSF
	CK5vilTMCgfBseLYeJe4qzKMMU=
X-Received: by 2002:a05:600c:1d1e:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-4835b8bbf9bmr46456975e9.7.1770825000780;
        Wed, 11 Feb 2026 07:50:00 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm189642995e9.1.2026.02.11.07.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:50:00 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [yocto-autobuilder-helper][whinlatter][PATCH] send_qa_email: Only copy logs when we are pushing tags
Date: Wed, 11 Feb 2026 16:46:44 +0100
Message-ID: <20260211154643.3053476-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 15:50:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3213

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Resulttool creates tags in yocto-testresults and copies logs in an NFS
shared folder whose name is based on this tag. If we are never going to
push this tag, we should not copy the logs, in order to maintain some
coherency.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 904d5722ced282b58474e3b605ce87897994f4f7)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/send_qa_email.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index d8c060f..6384001 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -190,7 +190,15 @@ def send_qa_email():
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

