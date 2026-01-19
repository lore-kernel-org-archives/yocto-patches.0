Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AED29C3E
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:00:01 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38210.1768838396154440650
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 07:59:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V+fsvQ88;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so28916525e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768838394; x=1769443194; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZCXam5Qh9i/4bJTm9MN6FFtAEiXGmNyDLqwyFJPHdo=;
        b=V+fsvQ88lPQW5ZzR21Ny6ZAdF+/gsd/CdhiVa11CE1TCHZxiyWAzNol1kcOBfoK1y2
         t/tkWLl/PytAIOsokb1AFrQQkufbXDzojMXNI/cKXw077x9ioUQSctxNPzYRCNQKS5QD
         0cH+iQ7bKXW5XR4Qqg9izScCQCcTuMUesGTkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838394; x=1769443194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZCXam5Qh9i/4bJTm9MN6FFtAEiXGmNyDLqwyFJPHdo=;
        b=LKM1anpVyB880el+dDlierptL9C5kkMtWTELRHz375aCDeNeo9tbNKpQ43TFsOiqz/
         X4iRn+HSlQ0v9T4doYL85+uZHRjsmabIXfDJC/m47uZV8tAamwgIaoX/nTiH7jcnWUW/
         IIe19LzmDBieLjm687ShKInjmgF3HJKPBRjLOsZhJrlzzVpN8zo+l3+SouoaIFQ98wOM
         w46RkbKHvx/boeh9X7obe4BUyCto81KD9DF7j0vSDdF5aCD/beXRx2jc+fr1OzdFsvjV
         orediNtbFrXwlOlSQiSmj50MFmX8EXzw7MgdYIqVx6gWmNku7LwZaR7GXaFaPidamM4d
         6Z3w==
X-Gm-Message-State: AOJu0YwPrQ0/Q9OXFxzX0Ua6gvW7fVAuEBYKmpQv1UqivETi7wRnKJLd
	MR7Uxi4hfo1tyIksRbZIcNmPOGErgNWhiJVUOnkTOpnkZ1myh8f6jUxmxecg3EyUXKHEFjcvrAw
	/tMV/uVY=
X-Gm-Gg: AY/fxX5dtslWRlGrTwS411qVc83H3zayv4lkxkEWR6ezkw1FrfoJDVqKposxpqZejE7
	LeEoUfS8aMl7OnC7/AqzAMTAFRpNEwZp9uihfjvyo+HSEf3a8yklrH8ijlx5nh0bu2Npk+XK+6w
	MCVWbuC6t9Auer4718kF7LRr0ouaSjXbZA6+YKP86jZ78AQXRnSs+/Xyn5CB7YWAweDG5VFrqta
	/aev8Q26DheCzf3ujXhy/63MEe4tj1UE406jhQCKxsECVUmaRaQHN0eI8gdBab6v98t2y43Bt0P
	WvK7Cl4h+Fmk5gNE1uCn85VA6rddmfrqtBeojwm2H3ioKZAeonRwHPCCjws9NtkZTzMCp9/D/d7
	Gj9R+d00ifdmtJqMG7epeGzFhRW4StK/NEMYxsKnY5h+1aQ+9e2HrGtGd3vtOXVlpQzDkgcl7Vf
	j6qrlnd6LBacl6t4bLZs7DtjaV12e4tsggDe5QQjo=
X-Received: by 2002:a05:600c:1f12:b0:477:a36f:1a57 with SMTP id 5b1f17b1804b1-4801e2f9110mr129389545e9.3.1768838393701;
        Mon, 19 Jan 2026 07:59:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7cb0:ccc0:c4cf:d0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569997f41sm22978179f8f.38.2026.01.19.07.59.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:59:53 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/send_qa_email: Show git processing commands used in logs
Date: Mon, 19 Jan 2026 15:59:52 +0000
Message-ID: <20260119155952.3656565-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 16:00:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3012

This should aid reproduction and debugging.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 91f175c..4f2b900 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -48,7 +48,9 @@ def get_previous_tag(targetrepodir, version):
         else:
             comparetagstring = utils.get_tag_from_version(compareversion, comparemilestone)
             previous_major = compareversion[0] - 1
-            tags_list = subprocess.check_output(["git", "ls-remote", "--refs", "-t", "origin", f"refs/tags/yocto-{previous_major}*"], cwd=targetrepodir).decode('utf-8').strip()
+            cmd = ["git", "ls-remote", "--refs", "-t", "origin", f"refs/tags/yocto-{previous_major}*"]
+            log.info("Running %s" % " ".join(cmd))
+            tags_list = subprocess.check_output(cmd, cwd=targetrepodir).decode('utf-8').strip()
             # Get last tag from list, pick only the tag part, and remove the
             # "refs/tags/" part
             return tags_list.splitlines()[-1].split()[1].split('/')[-1]
@@ -62,7 +64,9 @@ def get_previous_tag(targetrepodir, version):
 def get_last_tested_rev_on_branch(branch, test_results_url, log):
     # Fetch latest test results revision on corresponding branch in test
     # results repository
-    tags_list = subprocess.check_output(["git", "ls-remote", "--refs", "-t", test_results_url, "refs/tags/" + branch + "/*"]).decode('utf-8').strip()
+    cmd = ["git", "ls-remote", "--refs", "-t", test_results_url, "refs/tags/" + branch + "/*"]
+    log.info("Running %s" % " ".join(cmd))
+    tags_list = subprocess.check_output(cmd).decode('utf-8').strip()
     for line in reversed(tags_list.splitlines()):
         skip = False
         for exclude in send_qa_email_data.POKY_TESTRESULTS:
@@ -183,7 +187,9 @@ def send_qa_email():
             elif targetbranch:
                 cloneopts = ["--branch", targetbranch]
             try:
-                subprocess.check_call(["git", "clone", test_results_url, tempdir, "--depth", "1"] + cloneopts)
+                cmd = ["git", "clone", test_results_url, tempdir, "--depth", "1"] + cloneopts
+                log.info("Running %s" % " ".join(cmd))
+                subprocess.check_call(cmd)
             except subprocess.CalledProcessError:
                 log.info("No comparision branch found, falling back to master")
                 subprocess.check_call(["git", "clone", test_results_url, tempdir, "--depth", "1"])
@@ -211,7 +217,9 @@ def send_qa_email():
                 if basebranch or targetbranch:
                     cmd.extend(["-l", args.results_dir + "/../../testresult-logarchives", "-p"])
 
+                log.info("Running %s" % " ".join(cmd))
                 subprocess.check_call(cmd)
+
                 if basebranch:
                     subprocess.check_call(["git", "push", "--all", "--force"], cwd=tempdir)
                     subprocess.check_call(["git", "push", "--tags", "--force"], cwd=tempdir)

