Return-Path: <alexis.lothore@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934BC2BD05
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 15:57:41 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.77006.1718985456936707775
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 08:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=C2cI8IiJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexis.lothore@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 467801C0006;
	Fri, 21 Jun 2024 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718985455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uu3rvoO7MkUkoL1qDIG05FjV5u1vlcU6YdBwbjdyKHw=;
	b=C2cI8IiJOsq4MeWqrZ9Is40ycJWqCcBN5IUpePS7ENo2UcBr6O45B7VRKZwK44/Hjg51hC
	10AZzDOo2KK4VkCbpmrCoeINpwgs7ABqQQrvV8ZgELundyaiuVqJyafQ2P+dXf41baLZJe
	fRDhKiz8dka1n6F/zGe8/aeahEfr0UQXiCxBZ7YmsYg2C+sqE9RuYQrJillROxwVLUWX64
	rsVWEBU/0+3DhHTri1EGRHEdjizEm7d7YiiikUKMMTkcQuepnDElwa7xn1LhYqZGW72sWA
	oYmQOEkwstety0GJ2HG6O9k+9pAmf1/k2ss+qY6G7xaMnPdIlxw8CuRLnrS5Pg==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 3/3] scripts: send_qa_email: do not try to generate a regression report when missing base and/or target
Date: Fri, 21 Jun 2024 16:57:23 +0100
Message-ID: <20240621155723.33600-4-alexis.lothore@bootlin.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/368

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Fixes [YOCTO 15503]

When running autobuilder onm a testing or stable branch, the following
exception may occur:

Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/a-full/yocto-autobuilder-helper/scripts/send_qa_email.py", line 278, in <module>
    send_qa_email()
  File "/home/pokybuild/yocto-worker/a-full/yocto-autobuilder-helper/scripts/send_qa_email.py", line 207, in send_qa_email
    generate_regression_report(querytool, targetrepodir, regression_base, regression_target, tempdir, args.results_dir, log)
  File "/home/pokybuild/yocto-worker/a-full/yocto-autobuilder-helper/scripts/send_qa_email.py", line 93, in generate_regression_report
    regreport = subprocess.check_output([querytool, "regression-report", base, target, '-t', resultdir])
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.11/subprocess.py", line 466, in check_output
    return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.11/subprocess.py", line 548, in run
    with Popen(*popenargs, **kwargs) as process:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.11/subprocess.py", line 1026, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib64/python3.11/subprocess.py", line 1883, in _execute_child
    self.pid = _fork_exec(
               ^^^^^^^^^^^
TypeError: expected str, bytes or os.PathLike object, not NoneType

This issue is due to base and target revision being None, but subprocess
module do not tolerate arguments being None,

Prevent the script from even trying to generate a regression report if we
are missing some info about revisions to compare.

Cc: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 scripts/send_qa_email.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index e258fa131fcb..39e938284972 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -203,8 +203,11 @@ def send_qa_email():
             utils.printheader("Processing regression report")
             try:
                 regression_base, regression_target = get_regression_base_and_target(targetbranch, basebranch, args.release, targetrepodir, test_results_url, log)
-                log.info(f"Generating regression report between {regression_base} and {regression_target}")
-                generate_regression_report(querytool, targetrepodir, regression_base, regression_target, tempdir, args.results_dir, log)
+                if regression_base and regression_target:
+                    log.info(f"Generating regression report between {regression_base} and {regression_target}")
+                    generate_regression_report(querytool, targetrepodir, regression_base, regression_target, tempdir, args.results_dir, log)
+                else:
+                    log.info("Can not guess regression base and/or target, skip regression report")
             except subprocess.CalledProcessError as e:
                 error = str(e)
                 exitcode = 1
-- 
2.45.2


