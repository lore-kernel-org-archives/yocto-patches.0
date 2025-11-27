Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA667D111A8
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 17:51:43 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.452.1764265899870100104
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 09:51:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XnaH2z8s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a1c28778so11996265e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764265898; x=1764870698; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQ8f3w26T1P9fSczqgw0/k6/eNiI8OAWI0+VfCacnaE=;
        b=XnaH2z8sfHW/UJd59O2uUIFdjt0k7MRiAC+IKqSRVYxCEK+bjfe/PuE7XLvRy07BHh
         CVSy1pdi406QMSh6pYE1l2KjaqAXIpZfaQt7HNV+SibZP7P+wP2mIa562EfuA89hPgUw
         Ay/ywUdGtfNv6GfVeI4hTI42bdV59VGc+JZFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764265898; x=1764870698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQ8f3w26T1P9fSczqgw0/k6/eNiI8OAWI0+VfCacnaE=;
        b=jqq9z2jj8SLkMxs0APWj19ZrCuaG4O5tBRZftRIy5BIXCQs345tIm5gY+VNiPwFfP1
         q2uB2VudFtcsrBBY4zKe8kFF6u/aA2JxjvjYubMSZKwFsK53dTNUgfPPbumQtlW4nM9v
         szfeh47pDiZYrF74RJIxhRDWyXih7Za8UsTACc6WPzeo8J45SFVSn4yg6bFkljefuNrX
         NWeufavPvFwhCaxqdxkOfQ6IMJxkFEPqOJ6PA7UDGFAgye9GMKJkqeAD3JlLadknSeQg
         Bu5+UvN/0gAXvghTE3bJ0mQQ2hGrxXIaERXDSXY5BWvMqSGAkrAXbNmR33XEXvp2OLan
         17Lg==
X-Gm-Message-State: AOJu0Yy0AN86nimN1GOGjs9FtPSGK7xn8SiuhqmmieeHqEk1Yd7lmBxU
	GsAl5wXTIvfNmxaOPGe3ZRe09Gh8Sfh+zZsxGpfbZD3XOa1w51R0zQaIO7N1VyhPLAcquEx+1qX
	J8Gii
X-Gm-Gg: ASbGncu/ls1Dyh+HLPF3eR70SgSHbdFE6w49uTAXK0aFv2c9se4+L5nX0eY2q+YfF3+
	udVxWYbwmhJxFCjAIAgM3IsENNppVUw6Tn0qI3hqskDs6kDcvKTG41wleCp8RnyOao5ngFZSnmu
	nTWIh9AhmhG7FSQ6ERebZIuJf92UOL04m85TFgPELWxrIG0xUIpwRaqVUQJ03fPUK7cbrVUifHz
	+yNQOYbruXUhxjc4KdMwSgAzFYOCfo9PmtFnZGbE704vv8jyrBtPjyoObv12PO3rjUkijqc1zGq
	diu6sC1fZNOZlKDxEN0P2OOkK7yeAzYx6Qhe7YPN8g4OCZBZuFMcIY0stt6dxA07qka+nw1PF+q
	oJF24GlUEV5W2iJUHKAYtHpO1lG1H+z0z/cBLd4HWT7cUYP7ESflKGU/l+Ywg/cH0/s3Ls0UxQs
	IXz+VVepW8XX/jB3hcDISB16yUAx/00QtBsQufRFUr2D8aLvv1gA==
X-Google-Smtp-Source: AGHT+IETlgtSUTtSv5pz+OiYoQKZI3snS65nvYQv2AWzIJJ6rzKAKyXwlm5+HqifzyUUa+LcKcZCVw==
X-Received: by 2002:a05:600c:1c8a:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47904acadd7mr129681615e9.7.1764265897688;
        Thu, 27 Nov 2025 09:51:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:49e4:7f15:9d56:4465])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d6181sm4690023f8f.18.2025.11.27.09.51.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 09:51:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/run-config: Use correct branchname/repo after bitbake-setup changes
Date: Thu, 27 Nov 2025 17:51:36 +0000
Message-ID: <20251127175136.867214-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 17:51:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2723

The controller is currently passing in information about poky which is incorrect.
Ideally we swap this for the right information but for compatibility with older
release builds that is trickier. The plan is to ultimately use the properties
json files to transfer this in future so shortcut to that a little and hack
that into place now to fix the performance testing builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-config | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/run-config b/scripts/run-config
index 17610ea..91afd19 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -74,13 +74,18 @@ parser.add_argument('--phase',
 args = parser.parse_args()
 
 scriptsdir = os.path.dirname(os.path.realpath(__file__))
+# FIXME, we need to ultimately pass this value from buildbot on the commandline
+propertiesjson = scriptsdir + "../../build/build-properties.json"
+with open(propertiesjson) as f:
+    properties = json.load(f)['properties']
+
 os.environ["SCRIPTSDIR"] = scriptsdir
 ourconfig = utils.loadconfig()
 ourconfig["HELPERBUILDDIR"] = args.builddir
 ourconfig["HELPERTARGET"] = args.target
 ourconfig["HELPERRESULTSDIR"] = (args.results_dir or "")
-ourconfig["HELPERREPONAME"] = args.reponame
-ourconfig["HELPERBRANCHNAME"] = args.branchname
+ourconfig["HELPERREPONAME"] = properties['repo_oecore']
+ourconfig["HELPERBRANCHNAME"] = properties['branch_oecore']
 
 hp = utils.HeaderPrinter()
 
@@ -173,7 +178,7 @@ def logname(path, stepnum, stepname):
 utils.mkdir(args.builddir)
 
 revision = "unknown"
-report = utils.ErrorReport(ourconfig, args.target, args.builddir, args.branchname, revision)
+report = utils.ErrorReport(ourconfig, args.target, args.builddir, properties['branch_oecore'], revision)
 errordir = utils.errorreportdir(args.builddir)
 utils.mkdir(errordir)
 
@@ -246,7 +251,7 @@ def runcmd(cmd, *args, **kwargs):
     except subprocess.CalledProcessError:
         print("ERROR: Command %s failed" % cmd)
 
-bh_path, remoterepo, remotebranch, baseremotebranch = utils.getbuildhistoryconfig(ourconfig, args.builddir, args.target, args.reponame, args.branchname, 1)
+bh_path, remoterepo, remotebranch, baseremotebranch = utils.getbuildhistoryconfig(ourconfig, args.builddir, args.target, properties['repo_oecore'], properties['branch_oecore'], 1)
 if bh_path:
     if jcfg:
         addentry("buildhistory-init", "Initialize buildhistory", "init")
@@ -276,7 +281,7 @@ def handle_stepnum(stepnum):
         if jcfg:
             addstepentry("write-config", "Write config", shortdesc, desc, None, str(stepnum))
         elif args.stepname == "write-config":
-            runcmd([scriptsdir + "/setup-config", args.target, str(stepnum - 1), args.builddir, args.branchname, args.reponame, "-s", args.sstateprefix, "-b", args.buildappsrcrev])
+            runcmd([scriptsdir + "/setup-config", args.target, str(stepnum - 1), args.builddir, properties['branch_oecore'], properties['repo_oecore'], "-s", args.sstateprefix, "-b", args.buildappsrcrev])
             log_file_contents(args.builddir + "/conf/auto.conf", args.builddir, stepnum, args.stepname)
 
     # Execute the targets for this configuration

