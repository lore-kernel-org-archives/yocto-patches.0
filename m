Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ABF43834
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 15:00:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21195.1776265238331162008
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 08:00:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=IEbhqb7L;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 879F83123
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 08:00:31 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7D7F3F7D8
	for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776265237; bh=VifsG16o10ORM2ETAyn5M5wkCtzVirw9fzvcjGNKCwU=;
	h=From:To:Subject:Date:From;
	b=IEbhqb7L56Me4GNnr5x6vksBQLcsN/RmTsN5d7NPLVJ6g3NORfhuOkhljKgEV3lpY
	 qmuFVTAXMsSAgeWi+urIlIhwtCRVXh632RneQmyyq7ARcvK9No/QTXyceXnX+8v9YT
	 z52ZIwUFDh3a6gJMEsHvUjYQubKGf1RAyoJ6ensU=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 1/2] scripts/run-cvecheck: add option to filter out "core" recipes from the report
Date: Wed, 15 Apr 2026 16:00:31 +0100
Message-ID: <20260415150033.1413106-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 15:00:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3706

Add an option to filter out "core" recipes from the CVE report, so that
the same tooling can be used to scan other layers without the report also
containing issues from core.

For the purposes of this we consider "core", "selftest", and "yocto"
(oe-core, meta-selftest, meta-poky) to be core layers.

This uses jq to filter the generated JSON before it is committed to the
metrics repository.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/run-cvecheck | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index 43bf37f9..eaae7db4 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -5,7 +5,7 @@
=20
 set -eu
=20
-ARGS=3D$(getopt -o '' --long 'metrics:,branch:,results:,push' -n 'run-cv=
echeck' -- "$@")
+ARGS=3D$(getopt -o '' --long 'metrics:,branch:,results:,push,hide-core' =
-n 'run-cvecheck' -- "$@")
 if [ $? -ne 0 ]; then
     echo 'Cannot parse arguments...' >&2
     exit 1
@@ -23,6 +23,8 @@ RESULTSDIR=3D""
 BRANCH=3D""
 # Whether to push the metrics
 PUSH=3D0
+# Whether to remove recipes in oe-core from the report
+HIDE_CORE=3D0
=20
 while true; do
     case "$1" in
@@ -46,6 +48,11 @@ while true; do
             shift
             continue
         ;;
+        '--hide-core')
+            HIDE_CORE=3D1
+            shift
+            continue
+        ;;
         '--')
             shift
             break
@@ -86,6 +93,13 @@ git -C $METRICSDIR pull
 CVE_REPORT=3D$(ls -t tmp/deploy/images/*/world-recipe-sbom.sbom-cve-chec=
k.yocto.json | head -n1)
=20
 if [ -e $CVE_REPORT ]; then
+
+    # Filter out core layers, if requested
+    if [ $HIDE_CORE -eq 1 ]; then
+        jq '.package |=3D map(select(.layer | IN("core", "selftest", "yo=
cto") | not))' $CVE_REPORT > $CVE_REPORT.tmp
+        mv $CVE_REPORT.tmp $CVE_REPORT
+    fi
+
     git -C $METRICSDIR rm --ignore-unmatch cve-check/$BRANCH/*.json
     mkdir -p $METRICSDIR/cve-check/$BRANCH/
     cp $CVE_REPORT $METRICSDIR/cve-check/$BRANCH/$TIMESTAMP.json
--=20
2.43.0


