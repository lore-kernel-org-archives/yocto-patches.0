Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337DC55179
	for <webhook@archiver.kernel.org>; Mon,  3 Aug 2026 14:11:58 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43928.1785766308738989282
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 03 Aug 2026 07:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Vp/Izrzt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so11802865e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 03 Aug 2026 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785766307; x=1786371107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/4h/UqmjsDXNw/LZ376lF2Dxq6IKpPpRtjNCTGQpPs=;
        b=Vp/IzrztiY07Clbti/h73X6H3SmSMDjIMNzzfOWTv5OP+SNz519Bdxj0VpZBqi1RT3
         4UVUJd+hx7NgrPsZdlUhdQPGxYQmEf4jSHnw/hXXeZRnbTAMUwJBo/cF5s3CVpvjN1Ij
         OdPZ1TvwWl8JMY1gheGOGRPy4+/My70qDNDGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766307; x=1786371107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1/4h/UqmjsDXNw/LZ376lF2Dxq6IKpPpRtjNCTGQpPs=;
        b=BWjiSvGmNClxC5BEvK3yedil11kKA3V425Dvi0juay7SMJXQCEfrtvD4y7RvZ2LUDD
         07KMPauCV8uZXEe8M3fr9hZsGFcpB/HsNUlzsM1sClA/AA+bsJwRm/Q2FZITNBCW1xi9
         h9ItnCWDERtMaKylORGNSPaZDz5xWB7S10VAS3pf3rWcZ+ghIF/Sq6rMqsn49PBCvQ7m
         4IHpom9UoSe+i0yanQRng6DBO0pSRg7HHE3wY8Pkt7hb5jpuX9QaOl4RCCDVeu7yHfpK
         yhNeyicCiwQmQiOMi4uAY6CyyLYsXwdocqqRPzSfHCYhMhQmCN0yIwnXzrkfSPIputFA
         RQYg==
X-Gm-Message-State: AOJu0Yz9Fzq4T6dgy75jtarHbXZrVvUbBLtpSq2HF3Jf9FIQhlSLNxqo
	J5mOwvV4siAw42Lyb38RihDNCaJCVyf2iWsCl7Yd8I1aSYqTsTBaSkA1N0qGJ327uz+zQmtx8CE
	bpirrZmE=
X-Gm-Gg: AR+sD13j8V06lSi73tiFEbe6ynWPD7BBsYWZeZoVhRjd3q9Fm9gePwne0MLSVmf3xRO
	1lZ5/GvNogCF4bUoTECO3ZWpwYSONrfn02TU4sggooZ6tUwl/nN6FYlzLgcK+J56ouvWsxP25GG
	v6HCrtlR6rxrQ8OLUOEEYqjLNnu/oTxRlqu/1PgDZCCAIc2J56mevEmKM3H/p8aHjhfBLVoC9HG
	ICdu2A3FZCRLqldwTE3knVRDjw1bEfABMCpMM8OvqCEWr96N794ysaIM1oonqB/8A6JIYVtP8FV
	UwB0JWrthb/ovGU55FEfTGk13Oy1Izpj31g1gOe8s5T3c5go7Lmz2CJlVbvPKazbvppI2MbYOX2
	sXIf6kE7ZiG9lXeR3Lp8zNXK2cYmY2uSh/+O8KnnCoCCHCxdG67dm6f/5G2sIcJcsl8jOXLTYJ+
	JhI6ifG3yYJxs9PmD06DCmCFVhUaW9ztLFmisV8tqm+2dIYyRDhpRdu4b6m+I2ChG4QO9UeXhzg
	hppzG2fZr8wqlXmWA==
X-Received: by 2002:a05:600c:19cf:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-4982b1fe255mr59151295e9.18.1785766306757;
        Mon, 03 Aug 2026 07:11:46 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b5c:9c24:b513:8797])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm36140695f8f.14.2026.08.03.07.11.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:11:46 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] send_qa_email: Use bitbake-setup oecore directory rather than repos
Date: Mon,  3 Aug 2026 15:11:45 +0100
Message-ID: <20260803141145.1560411-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Aug 2026 14:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4618

bitbake-setup's layers and repos can be out of sync with each other since they
run in series. Prefer the layers directory if present since that is what the
build will have used.

[YOCTO #16216]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index e3de4b5..e02d47c 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -150,8 +150,9 @@ def send_qa_email():
 
     utils.filterrepojson(repos)
 
-    resulttool = os.path.dirname(args.repojson) + "/build/layers/openembedded-core/scripts/resulttool"
-    querytool = os.path.dirname(args.repojson) + "/build/layers/openembedded-core/scripts/yocto_testresults_query.py"
+    oecorerepodir = os.path.dirname(args.repojson) + "/build/layers/openembedded-core"
+    resulttool = oecorerepodir + "/scripts/resulttool"
+    querytool = oecorerepodir + "/scripts/yocto_testresults_query.py"
 
     buildtoolsdir = os.path.dirname(args.repojson) + "/build/buildtools"
     if os.path.exists(buildtoolsdir):
@@ -168,8 +169,7 @@ def send_qa_email():
     if 'oecore' in repos and os.path.exists(resulttool) and os.path.exists(querytool) and args.results_dir:
         utils.printheader("Processing test report")
         # Need the finalised revisions (not 'HEAD')
-        targetrepodir = "%s/oecore" % (repodir)
-        revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=targetrepodir).decode('utf-8').strip()
+        revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=oecorerepodir).decode('utf-8').strip()
         branch = repos['oecore']['branch']
         repo = repos['oecore']['url']
 
@@ -233,10 +233,10 @@ def send_qa_email():
 
             utils.printheader("Processing regression report")
             try:
-                regression_base, regression_target = get_regression_base_and_target(targetbranch, basebranch, args.release, targetrepodir, test_results_url, log)
+                regression_base, regression_target = get_regression_base_and_target(targetbranch, basebranch, args.release, oecorerepodir, test_results_url, log)
                 if regression_base and regression_target:
                     log.info(f"Generating regression report between {regression_base} and {regression_target}")
-                    generate_regression_report(querytool, targetrepodir, regression_base, regression_target, tempdir, args.results_dir, log)
+                    generate_regression_report(querytool, oecorerepodir, regression_base, regression_target, tempdir, args.results_dir, log)
                 else:
                     log.info("Can not guess regression base and/or target, skip regression report")
             except subprocess.CalledProcessError as e:
@@ -257,13 +257,22 @@ def send_qa_email():
 
     utils.printheader("Generating QA email")
 
+    layersdir = os.path.dirname(args.repojson) + "/build/layers/"
     buildhashes = ""
     for repo in sorted(repos.keys()):
         # gplv2 is no longer built/tested in master
         if repo == "meta-gplv2":
             continue
+        layerdir = layersdir + repo "/"
+        if repo == "oecore":
+            layerdir = layersdir + "openembedded-core/"
+        # Try to use bitbake-setup layers, fall back to repos/
+        if os.path.exists(layerdir):
+            targetrepodir = layerdir
+        else:
+            targetrepodir = "%s/%s" % (repodir, repo)
+
         # Need the finalised revisions (not 'HEAD')
-        targetrepodir = "%s/%s" % (repodir, repo)
         revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=targetrepodir).decode('utf-8').strip()
         buildhashes += "%s: %s\n" % (repo, revision)
 

