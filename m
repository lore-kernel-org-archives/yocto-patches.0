Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C371C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 11:18:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.5362.1720783080496359708
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Jul 2024 04:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1818B1007
	for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Jul 2024 04:18:25 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7784E3F762
	for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Jul 2024 04:17:59 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] scripts: rebase before pushing patch and CVE metrics
Date: Fri, 12 Jul 2024 12:17:51 +0100
Message-Id: <20240712111751.3696492-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Jul 2024 11:18:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/426

There's a chance that run-cvecheck and run-patchmetrics fail to push
because the remote repository has changed. Try to resolve this by pulling
and rebasing immediately before the push, and failing if we can't rebase.

[ YOCTO #15529 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/run-cvecheck     | 4 ++++
 scripts/run-patchmetrics | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index d22dc825..c6b00660 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -90,6 +90,10 @@ if [ -e tmp/log/cve/cve-summary.json ]; then
     git -C $METRICSDIR add cve-check/$BRANCH/$TIMESTAMP.json
     git -C $METRICSDIR commit -asm "Autobuilder adding new CVE data for =
branch $BRANCH" || true
     if [ "$PUSH" =3D "1" ]; then
+        if ! git -C $METRICSDIR pull --rebase; then
+            echo "Aborting push, metrics repo has updated and cannot reb=
ase cleanly"
+            exit 1
+        fi
         git -C $METRICSDIR push
     fi
     $OURDIR/cve-report.py tmp/log/cve/cve-summary.json > $RESULTSDIR/cve=
-status-$BRANCH.txt
diff --git a/scripts/run-patchmetrics b/scripts/run-patchmetrics
index fc2e23b3..3842f1a9 100755
--- a/scripts/run-patchmetrics
+++ b/scripts/run-patchmetrics
@@ -105,6 +105,10 @@ set +x
 git -C $METRICSDIR commit -asm "Autobuilder adding new patch stats" || t=
rue
=20
 if [ "$PUSH" =3D "1" ]; then
+    if ! git -C $METRICSDIR pull --rebase; then
+        echo "Aborting push, metrics repo has updated and cannot rebase =
cleanly"
+        exit 1
+    fi
     git -C $METRICSDIR push
 fi
=20
--=20
2.34.1


