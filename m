Return-Path: <alexis.lothore@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2577C2BD09
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 15:57:41 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.76933.1718985455872376879
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 08:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=N/E7V6ty;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexis.lothore@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DC1C1C0003;
	Fri, 21 Jun 2024 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718985454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev9OeDLGskgXxvgrLClMsoxkzoex16MFvO0CMZ1RcKw=;
	b=N/E7V6tyENy8Ewb5wpSelMRMuud+6sCP1sSA29OSV8mWXG6FP0V6OGsZO5g++EMpjtbtV6
	Insk6wcuvGvD5GDeXfhLpIqqvAfph1ZrYpApoU/KZfkrhN1qCDaEqToNoCS9zf/iCvA5cK
	DNy4O1tiAem50R1kZVbYlkCZnf+SialFRhb+8umSqYbnoWgBU5vXsgzbP1kMCL5l+VRgcw
	BEZYbrdJi4+NDMxxZ2AHmLGRdWwceV6LB5z0gDbCU2Q+PYkUJBzv5juO7y/3wZG0ydMLmT
	ZETC57rUUMj6FlM/0ukacsYU3fp1XMAOAFOyutfz8wf6vNpFwfjIPKpL4baAYA==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 1/3] scripts: send_qa_email: fix invalid regex syntax warning
Date: Fri, 21 Jun 2024 16:57:21 +0100
Message-ID: <20240621155723.33600-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621155723.33600-1-alexis.lothore@bootlin.com>
References: <20240621155723.33600-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 15:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/366

From: Alexis Lothoré <alexis.lothore@bootlin.com>

When send_qa_email is executed with python >= 3.12, the following warnings
are emitted:

/home/alexis/src/yocto_ci/yocto-autobuilder-helper/./scripts/send_qa_email.py:22: SyntaxWarning: invalid escape sequence '\d'
  p = re.compile('\d{8}-\d+')
/home/alexis/src/yocto_ci/yocto-autobuilder-helper/./scripts/send_qa_email.py:67: SyntaxWarning: invalid escape sequence '\/'
  tested_revision = re.match('refs\/tags\/.*\/\d+-g([a-f0-9]+)\/\d', latest_test_tag).group(1)

This warning has been introduced to replace the DeprecationWarning
initially raised on such escape code in string regex. Python 3.12 changelog
([1]) states that raw string must be used in this case. Update both
send_qa_email and its tests file.

[1] https://docs.python.org/dev/whatsnew/3.12.html#other-language-changes

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 scripts/send_qa_email.py      | 4 ++--
 scripts/test_send_qa_email.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 8d9250d555d4..e258fa131fcb 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -19,7 +19,7 @@ TEST_RESULTS_REPOSITORY_URL="git@push.yoctoproject.org:yocto-testresults"
 TEST_RESULTS_DRY_RUN_REPOSITORY_URL="git://git.yoctoproject.org/yocto-testresults"
 
 def is_release_version(version):
-    p = re.compile('\d{8}-\d+')
+    p = re.compile(r'\d{8}-\d+')
     return version is not None and p.match(version) is None
 
 def get_previous_tag(targetrepodir, version):
@@ -64,7 +64,7 @@ def get_last_tested_rev_on_branch(branch, test_results_url, log):
     tags_list = subprocess.check_output(["git", "ls-remote", "--refs", "-t", test_results_url, "refs/tags/" + branch + "/*"]).decode('utf-8').strip()
     latest_test_tag=tags_list.splitlines()[-1].split()[1]
     # From test results tag, extract Poky revision
-    tested_revision = re.match('refs\/tags\/.*\/\d+-g([a-f0-9]+)\/\d', latest_test_tag).group(1)
+    tested_revision = re.match(r'refs\/tags\/.*\/\d+-g([a-f0-9]+)\/\d', latest_test_tag).group(1)
     log.info(f"Last tested revision on branch {branch} is {tested_revision}")
     return tested_revision
 
diff --git a/scripts/test_send_qa_email.py b/scripts/test_send_qa_email.py
index 415d8cbbbccd..64ae80a1852d 100755
--- a/scripts/test_send_qa_email.py
+++ b/scripts/test_send_qa_email.py
@@ -31,8 +31,8 @@ class TestVersion(unittest.TestCase):
         {"input": {"version": "4.1_M1.rc1"}, "expected": "yocto-4.0"},
         {"input": {"version": "4.1_M1.rc4"}, "expected": "yocto-4.0"},
         {"input": {"version": "4.1.rc4"}, "expected": "yocto-4.0"},
-        {"input": {"version": "yocto-5.0_M1.rc1"}, "expected": "yocto-4.3(\.\d)?"},
-        {"input": {"version": "yocto-5.0_M1.rc2"}, "expected": "yocto-4.3(\.\d)?"},
+        {"input": {"version": "yocto-5.0_M1.rc1"}, "expected": r"yocto-4.3(\.\d)?"},
+        {"input": {"version": "yocto-5.0_M1.rc2"}, "expected": r"yocto-4.3(\.\d)?"},
         {"input": {"version": "yocto-5.0_M2.rc1"}, "expected": "5.0_M1"},
     ]
 
-- 
2.45.2


