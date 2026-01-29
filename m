Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE3D6B093
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 16:37:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19125.1769704636537866826
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 08:37:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6E68153B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 08:37:07 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E1E43F632
	for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 08:37:13 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH yocto-autobuilder-helper kirkstone] scripts: rebase before pushing patch and CVE metrics
Date: Thu, 29 Jan 2026 16:36:32 +0000
Message-ID: <20260129163632.1660116-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 16:37:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3143

There's a chance that run-cvecheck and run-patchmetrics fail to push
because the remote repository has changed. Try to resolve this by pulling
and rebasing immediately before the push, and failing if we can't rebase.

Backport of 60e2011 from master.

[ YOCTO #15686 ]

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/run-cvecheck     | 4 ++++
 scripts/run-patchmetrics | 5 +++++
 2 files changed, 9 insertions(+)

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
index 391ac45a..5fe3d8f3 100755
--- a/scripts/run-patchmetrics
+++ b/scripts/run-patchmetrics
@@ -24,6 +24,11 @@ if [ ! -e $PARENTDIR/yocto-metrics ]; then
 fi
 $OURDIR/patchmetrics-update --repo $PARENTDIR --patchscript $PARENTDIR/s=
cripts/contrib/patchreview.py --metadata $TARGETDIR --json $PARENTDIR/yoc=
to-metrics/patch-status.json
 git -C $PARENTDIR/yocto-metrics commit -asm "Autobuilder adding new patc=
h stats"
+
+if ! git -C $PARENTDIR/yocto-metrics pull --rebase; then
+    echo "Aborting push, metrics repo has updated and cannot rebase clea=
nly"
+    exit 1
+fi
 git -C $PARENTDIR/yocto-metrics push
=20
 if [ ! -d $RESULTSDIR ]; then
--=20
2.43.0


