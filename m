Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA3CD4857
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 22:42:03 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10682.1762987315002927020
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 14:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dwOFl1p4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47774d3536dso1499525e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762987313; x=1763592113; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMhJFwwB+IexKWzIBCSLokrLsZt9U2RQPzZWFfsYWUM=;
        b=dwOFl1p4z7p12OgP/i0AwA83jS53rGgVpdq0ui8M+4eb9HWG63UHDqKA6ORfKt2Snz
         3qcwouV8pgaY/nTTU+rd8+CNfWPkP1moE+ovNXga3mlJlwvyrqHTytLTPESLjKq24Ls1
         95LaA5nUWWH7lKgXvYWi8eyL0Hi7cCaShaZFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987313; x=1763592113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMhJFwwB+IexKWzIBCSLokrLsZt9U2RQPzZWFfsYWUM=;
        b=XQuTOGnGsGtc1E1KQYVB6V/idLBUKSekBvtkrhqs5KS06yLc3rvDhZlbM2EmOijUC7
         SrtX//5oBB8ljQwcEOf373BINWGlyJF7xLH93I1qwRonkFxZ9PyIbvJKRittnrz1PsBU
         eoOo+SCe8V/vfhweYwjdMuTNKv9mykhbGPQ5s6hbPAD2vWQlAgLwjqKY7fvpavqt9F9T
         nLeht8pR7Adld0zYyNL5LqQXLkC1glrD1KW/GcFAVPElp8u2aal7oBVv5t0cxLGKFuLE
         90nygilcEmJb95aw/SBEUA1d8ZHwtcXiwT3j8+nwEBzLHaP+y0IT74Gw2npEc6XR9IZS
         mHoQ==
X-Gm-Message-State: AOJu0Yz7TvgABVgHbCZsWxUXcllub16xvQT+SlswfmfQi4NIL8TTdxMN
	JPIOxep+XVd7qenEtqL2XGysH7BwzUlgi34NTia5Vpz89qjXxEWzHjV+pGxOO0WsSPoMRDd0ZnE
	47Ltn
X-Gm-Gg: ASbGnct9dY2rTQIgYtmso4O2GQw+9Dxw+QVOOub3Es0kaqw9R+Ab+FXYGtiNlHzc+qv
	QlBis+ym3evW+gpgRKQZQYKBBlH/2PrCxETeR65gAQp3FXo9wHSc6jgRctHtZLrAatUENMlD8Qz
	Y9f+1ckXmlVe/+HP31UiAKAyHrBpwFzezT/clxrlv4zI5T4KsO/bSUg2aKU/37U55Qg+A1g9ZsQ
	DCvc7x3e0YKWWcen5tZKuOUnIPYMRUkZlJ9vH+NN2LPfDR/HDw95w18/o+JuOfP/I5+9PDAZtBT
	NqHjMyAA0hashFCsrb3YFEjV4PxYj3DNbx/UM+1wUSRXdvaItVZyAHywVs4T4mwSxMf82y0hNTD
	8qn6TTs0IkpW9qqMKtGIUPmx2y5c1UYuG/DOcEbtqaGsnsXzcW14fMsyynumv4YHkmRE10aSdXe
	VOMxuFR7aN7HbHqAwiFs8klFHTGtXl
X-Google-Smtp-Source: AGHT+IF6sP/mSMbgZf4T6JfxDWBINxoKHHQdExhfYUUP8iMxdIR0uHHSsmSfMdk5TkVqMJfYpVp+4g==
X-Received: by 2002:a05:600c:1e29:b0:477:5639:ff66 with SMTP id 5b1f17b1804b1-4778bd07ac2mr7969115e9.13.1762987312830;
        Wed, 12 Nov 2025 14:41:52 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8876:d08f:2a0c:d6ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcf051dsm5566475e9.3.2025.11.12.14.41.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:41:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/send_qa_email: Update poky -> oecore for testresults
Date: Wed, 12 Nov 2025 22:41:51 +0000
Message-ID: <20251112224151.3093656-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 22:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2501

Ideally we'd track bitbake + oecore + meta-yocto + yocto-docs. Since we to
be able to look up a single revision, lets just store against OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 7ab9f3c..d8c060f 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -133,8 +133,8 @@ def send_qa_email():
 
     utils.filterrepojson(repos)
 
-    resulttool = os.path.dirname(args.repojson) + "/build/scripts/resulttool"
-    querytool = os.path.dirname(args.repojson) + "/build/scripts/yocto_testresults_query.py"
+    resulttool = os.path.dirname(args.repojson) + "/build/layers/openembedded-core/scripts/resulttool"
+    querytool = os.path.dirname(args.repojson) + "/build/layers/openembedded-core/scripts/yocto_testresults_query.py"
 
     buildtoolsdir = os.path.dirname(args.repojson) + "/build/buildtools"
     if os.path.exists(buildtoolsdir):
@@ -148,13 +148,13 @@ def send_qa_email():
     else:
         test_results_url = TEST_RESULTS_REPOSITORY_URL
 
-    if 'poky' in repos and os.path.exists(resulttool) and os.path.exists(querytool) and args.results_dir:
+    if 'oecore' in repos and os.path.exists(resulttool) and os.path.exists(querytool) and args.results_dir:
         utils.printheader("Processing test report")
         # Need the finalised revisions (not 'HEAD')
-        targetrepodir = "%s/poky" % (repodir)
+        targetrepodir = "%s/oecore" % (repodir)
         revision = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=targetrepodir).decode('utf-8').strip()
-        branch = repos['poky']['branch']
-        repo = repos['poky']['url']
+        branch = repos['oecore']['branch']
+        repo = repos['oecore']['url']
 
         targetbranch, basebranch = utils.getcomparisonbranch(ourconfig, repo, branch)
         report = subprocess.check_output([resulttool, "report", args.results_dir])

