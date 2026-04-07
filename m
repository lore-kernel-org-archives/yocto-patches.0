Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960BE105D986
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 21:07:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.92091.1775596036094717222
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Apr 2026 14:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=IpR+lAHW;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28FE353C
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Apr 2026 14:07:09 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 245693F7D8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Apr 2026 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775596035; bh=tE6lR4GlCV6HfS1exCwLkTGVWLbpntVLSRNqz4ilq5o=;
	h=From:To:Subject:Date:From;
	b=IpR+lAHW2hq0wDSz+aWcpVg2nuWXY1vNeqjbkMN3SQ+jzyU6IGEjBYGo6D4TVR1G3
	 FmOLFaKWL6o4OXX2BEY2jcGW1en9PlvpkWYfKfYut+fNbdvzun1gDIimxVjogJCv8q
	 SNV0vBrpDaksdwptvBKlVfrCZHZk3Xfk3LGrvTTY=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [RFC PATCH][yocto-autobuilder-helper] Port CVE scanning from cve-check to sbom-cve-check
Date: Tue,  7 Apr 2026 22:07:10 +0100
Message-ID: <20260407210710.2386697-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Apr 2026 21:07:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3656

Use the new sbom-cve-check-recipe class to scan meta-world-recipe-sbom,
instead of using cve-check.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json          | 7 ++-----
 scripts/run-cvecheck | 5 +++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/config.json b/config.json
index 5e5071e6..de741132 100644
--- a/config.json
+++ b/config.json
@@ -1366,12 +1366,9 @@
         "metrics" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],
             "extravars" : [
-                "INHERIT +=3D 'cve-check'",
+                "OE_FRAGMENTS +=3D 'core/yocto/sbom-cve-check'",
+                "INHERIT +=3D 'sbom-cve-check-recipe'",
                 "BB_DISKMON_DIRS =3D ''",
-                "CVE_CHECK_FORMAT_JSON =3D '1'",
-                "CVE_CHECK_SHOW_WARNINGS =3D '0'",
-                "CVE_DB_UPDATE_INTERVAL =3D '21600'",
-                "CVE_DB_INCR_UPDATE_AGE_THRES =3D '21600'",
                 "LICENSE_FLAGS_ACCEPTED =3D 'commercial'",
                 "BB_SERVER_TIMEOUT =3D '0'"
             ],
diff --git a/scripts/run-cvecheck b/scripts/run-cvecheck
index 75754fba..43bf37f9 100755
--- a/scripts/run-cvecheck
+++ b/scripts/run-cvecheck
@@ -74,15 +74,16 @@ fi
 set +u
 source ./init-build-env build
 set -u
-bitbake world --runall cve_check -R conf/distro/include/cve-extra-exclus=
ions.inc
=20
+bitbake meta-world-recipe-sbom -R conf/distro/include/cve-extra-exclusio=
ns.inc -c sbom_cve_check_recipe
 # Do another pull to make sure we're as up to date as possible.  This is
 # preferable to committing and rebasing before pushing as it would be be=
tter to
 # waste some time repeating work than commit potentially corrupted files=
 from a
 # git merge gone wrong.
 git -C $METRICSDIR pull
=20
-CVE_REPORT=3Dtmp/log/cve/cve-summary.json
+# Use the latest report, in case the build tree has more than one
+CVE_REPORT=3D$(ls -t tmp/deploy/images/*/world-recipe-sbom.sbom-cve-chec=
k.yocto.json | head -n1)
=20
 if [ -e $CVE_REPORT ]; then
     git -C $METRICSDIR rm --ignore-unmatch cve-check/$BRANCH/*.json
--=20
2.43.0


