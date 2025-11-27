Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC4D111A8
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 23:03:05 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5241.1764284583012825695
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 15:03:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PsuTOlBU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso750027f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 15:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764284581; x=1764889381; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxrNIAXIKW9iCt6nLAs6Q45GbY2b7KhbIDeajm8HV2Q=;
        b=PsuTOlBUkzQs6RvWk0JBjHjlN0iNRhy3dr8jc6ZtnS183AaL98VA5w6CaW8Wmb6ACB
         UHJZnBARFRTNqn12rXFDSY8hYQHAfpEbrq9VdKI4JAfg2I+pa3sC+392qQ8YqYGzVEDg
         CSBrrwBk9riTjNkozE24ffGdJmItvZgl3SGZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764284581; x=1764889381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxrNIAXIKW9iCt6nLAs6Q45GbY2b7KhbIDeajm8HV2Q=;
        b=fDOay9oijhSbxNQQqtxmzAqAutaM6VoMo8s92PSg35fKl9u/0H2vgSfSBJLSFKwW8k
         GX2NqkvbjIGZLxRsBlxA1A/MYkbunsUbi/6pu09aQFAxEbU+Tn8v9SBx3kVOHSZTLv1j
         H6GWLvphMcgSx2FqlWZHlpY+wFV9pCqtHGtpGbP2WEBX7csHQw4GWaFPWlW2SpVRz/yJ
         r/x2JPPXYlRndg32IMoqBtrs2sjkDdxo592s/KGWJXcT4YXIMNR69xvuzJtzx+Xe3S9N
         MS+MMqjwZXV4dkgX+lmuyAu2Xjlr8WhqWz060q4SZqcxXqvS7oO6v7YCKOWAqjuP3IaE
         iD0A==
X-Gm-Message-State: AOJu0YwgxwUUdpIlyxbuKrf79KECK+T2LsjG4elkbtmkHC7U5UvUXtLb
	vHEGSzfbJe1EsJhSUuhC0Mjpp7Ir42Ivu92WHJD4bm8JqvAZeGsByCpkFxNKKyAI/qnwhAJ5Yjc
	sqchS
X-Gm-Gg: ASbGncsaXBSSns3G47Ez0B6LDq1zA19xGk+Tv8ZCrJZwG5mBZwdhglVkMdGWfkMmS7w
	rCrIELUzf4dHtFQrrgkIes7RcOBMCXsiHnSEsX10kuI78AjC3QZx96lxCe59WkxOZwEkJOE2PC6
	Bf2iglodHE8FvhDkPZo6TtgPP/8n/NLwPgJOpzfIWz6zLKNTOg/ZJa0SwYcg86GNpaI9AFBuvJh
	yulO/JOxBUy0jp7QzeiOp7ZVOQdGQ7+uQfvn8Ap07cEF9g0ViOoOlW5F+a1IHJAHbtXSFygJHcp
	p+QNd3sLvy3NaUhoSG7aU9/j1yivzh5trwpd08jOB9wHv2WLtQ2O3ka4AWH9xQ2DlA5laFUKQ38
	PIsLFS74NpdfiDWDTUBfh3f6Q4s+8noUG4RvoHoPgriGHgPDKTpP28FvwodGl8GFrsJb8PrCftF
	Lr4ofQjvJ1sArHLNP6YpbxR1b9ka02oHm6To0Dlg==
X-Google-Smtp-Source: AGHT+IF0YRIzFczZBb0T4ni4qs38H7dGSbYl0oQIpz5zhEwZdtDp2/pkrJCZEuB7DVevH7Zb7TLFlQ==
X-Received: by 2002:a05:6000:4012:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-42cc1d1999dmr29181032f8f.40.1764284580695;
        Thu, 27 Nov 2025 15:03:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1dc:c751:b975:a108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5168acsm5541519f8f.0.2025.11.27.15.02.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 15:03:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/setup-config: Remove all fragments before setting new ones
Date: Thu, 27 Nov 2025 23:02:59 +0000
Message-ID: <20251127230259.892390-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 23:03:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2725

We can't unset individual fragments so we need to disable all before
setting the ones we want.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/setup-config | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scripts/setup-config b/scripts/setup-config
index c06dabf..06bd595 100755
--- a/scripts/setup-config
+++ b/scripts/setup-config
@@ -64,17 +64,22 @@ for v in ["SDKMACHINE", "PACKAGE_CLASSES"]:
 machine = utils.getconfigvar("MACHINE", ourconfig, args.target, stepnum) 
 distro = utils.getconfigvar("DISTRO", ourconfig, args.target, stepnum)
 
-def enable_fragment(fragment):
-    if fragment.endswith("/unset"):
-        return
-
-    cmd = ". ./init-build-env; bitbake-config-build enable-fragment %s" % fragment
+def runcmd(cmd):
     cmdpath = args.builddir
-
     print("Running '%s' in %s\n" % (cmd, cmdpath))
     utils.flush()
     subprocess.check_call(["/bin/bash", "-c", cmd], cwd=cmdpath)
 
+def disable_all_fragments():
+    cmd = ". ./init-build-env; bitbake-config-build disable-all-fragments"
+    runcmd(cmd)
+
+def enable_fragment(fragment):
+    if fragment.endswith("/unset"):
+        return
+
+    cmd = ". ./init-build-env; bitbake-config-build enable-fragment %s" % fragment
+    runcmd(cmd)
 
 for v in ["DLDIR", "PRSERV"]:
     value = utils.getconfigvar(v, ourconfig, args.target, stepnum)
@@ -143,6 +148,7 @@ with open(sdkextraconf, "w") as f:
         print("  " + v)
         f.write(v + "\n")
 
+disable_all_fragments()
 if machine:
     enable_fragment("machine/" + machine)
 if distro:

