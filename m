Return-Path: <anton.antonov@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A011CD3423
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 16:18:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18316.1777652315306473909
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 May 2026 09:18:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=WwZQMiML;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: anton.antonov@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EBD11691;
	Fri,  1 May 2026 09:18:29 -0700 (PDT)
Received: from acsubuntu.. (unknown [10.57.22.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 419A73F7B4;
	Fri,  1 May 2026 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777652314; bh=miCQyvTAymjBoZKpO9BTEKyPVFpokW7UASYytkiiA0I=;
	h=From:To:Cc:Subject:Date:From;
	b=WwZQMiML4fc+Ba3UuMKt9kNb6Ziq+GKtApFh00zMSeCEk02iO/nJcfPX1c1174lW8
	 HkPsYkkeKZxkkkEE8Xep0yOFipGYHz0QPpthO8/KJI1+pHQV65RyLabGAQxe76K4qp
	 z1qW8WZqLQPSz/qJbwrzZMQ1FuC/pyqB2q56d8TA=
From: Anton Antonov <Anton.Antonov@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH] Do not run Parsec CI jobs on 32bit platforms.
Date: Fri,  1 May 2026 16:18:07 +0000
Message-ID: <20260501161825.1207983-1-Anton.Antonov@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 May 2026 16:18:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3897

Signed-off-by: Anton Antonov <Anton.Antonov@arm.com>
---
 .gitlab-ci.yml         | 12 ------------
 kas/qemuarm-parsec.yml |  6 ------
 kas/qemux86-parsec.yml |  6 ------
 3 files changed, 24 deletions(-)
 delete mode 100644 kas/qemuarm-parsec.yml
 delete mode 100644 kas/qemux86-parsec.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 701a65a..2156598 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -67,12 +67,6 @@ qemux86-musl:
   script:
   - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | =
tee $CI_PROJECT_DIR/log/qemux86_musl_security_image.txt
=20
-qemux86-parsec:
-  extends: .parsec
-  needs: ['qemux86']
-  script:
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 |=
 tee $CI_PROJECT_DIR/log/qemux86_parsec_security_image.txt
-
 qemux86-test:
   extends: .test
   needs: ['qemux86']
@@ -99,12 +93,6 @@ qemuarm:
   script:
   - kas build --target security-build-image kas/$CI_JOB_NAME.yml 2>&1 | =
tee $CI_PROJECT_DIR/log/qemuarm_security_image.txt
=20
-qemuarm-parsec:
-  extends: .parsec
-  needs: ['qemuarm']
-  script:
-  - kas build --target security-parsec-image kas/$CI_JOB_NAME.yml 2>&1 |=
 tee $CI_PROJECT_DIR/log/qemuarm_parsec_security_image.txt
-
 qemuarm64:
   extends: .base
   script:
diff --git a/kas/qemuarm-parsec.yml b/kas/qemuarm-parsec.yml
deleted file mode 100644
index cef2818..0000000
--- a/kas/qemuarm-parsec.yml
+++ /dev/null
@@ -1,6 +0,0 @@
-header:
-  version: 8
-  includes:
-    - kas-security-parsec.yml
-
-machine: qemuarm
diff --git a/kas/qemux86-parsec.yml b/kas/qemux86-parsec.yml
deleted file mode 100644
index 370947d..0000000
--- a/kas/qemux86-parsec.yml
+++ /dev/null
@@ -1,6 +0,0 @@
-header:
-  version: 8
-  includes:
-    - kas-security-parsec.yml
-
-machine: qemux86
--=20
2.43.0


