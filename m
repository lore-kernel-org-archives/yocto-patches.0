Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD8BFF8855
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:44:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.153.1777995874603152705
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 08:44:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=dzXsuHIn;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8665293B
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:28 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE0873F836
	for <yocto-patches@lists.yoctoproject.org>; Tue,  5 May 2026 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777995874; bh=gyIWnNl+Y/TkBM87iKwgWboQRfyqTb8wHAk3Sw4KUzY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dzXsuHInlSeGSspxxJi5H/S7xIsUqW0JeiLeaPnk5yVcbr5g0dxoWdVQMkCohxNlC
	 h+ljeokeXwZgyrhb2byRMEPhARRrWGfk5AudvU8VOww/DpZMXYU6H3RHYJ/brUdMBB
	 AtNmQ3ey6p3i9qAPloePGm8dwGzKsu4P4sV00o18=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][meta-security][meta-parsec 2/3] parsec-service: do group membership modifications in useradd
Date: Tue,  5 May 2026 16:44:22 +0100
Message-ID: <20260505154423.535572-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505154423.535572-1-ross.burton@arm.com>
References: <20260505154423.535572-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 15:44:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3917

Instead of calling groupmems after creating the user, we can tell useradd
to do the group membership when creating the user.  There are several
reasons for this:

1) Consolidation of the calls into a single call means creation is atomic=
,
   it either worked or it did not.
2) The existing logic doesn't work if both TPM and TS were enabled.
3) GROUPMEMS_PARAM is broken in oe-core master[1] and this will not be
   fixed as groupmems has been removed from shadow[2].

Instead, construct a list of groups that parsec needs to be a member of,
and pass them to useradd.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16277
[2] shadow 388ce70 "*/: groupmems(8): Remove program"

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 .../parsec-service/parsec-service_1.5.0.bb    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5=
.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index c5f9978..0268c0e 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -72,9 +72,22 @@ do_install () {
 inherit useradd
 USERADD_PACKAGES =3D "${PN}"
 GROUPADD_PARAM:${PN} =3D "-r parsec"
-USERADD_PARAM:${PN} =3D "-r -g parsec -s /usr/sbin/nologin -d ${localsta=
tedir}/lib/parsec parsec"
-GROUPMEMS_PARAM:${PN} =3D "${@bb.utils.contains('PACKAGECONFIG_CONFARGS'=
, 'tpm-provider', '-a parsec -g tss ;', '', d)}"
-GROUPMEMS_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG_CONFARGS=
', 'trusted-service-provider', '-a parsec -g tee', '', d)}"
+USERADD_PARAM:${PN} =3D "\
+    --system \
+    --gid parsec \
+    --shell /usr/sbin/nologin \
+    --home-dir ${localstatedir}/lib/parsec \
+    ${@parsec_groups(d)} \
+    parsec"
+
+def parsec_groups(d):
+    groups =3D []
+    config =3D d.getVar("PACKAGECONFIG").split()
+    if "TPM" in config:
+        groups.append("tss")
+    if "TS" in config:
+        groups.append("teeclnt")
+    return "--groups " + ",".join(groups) if groups else ""
=20
 FILES:${PN} +=3D " \
     ${sysconfdir}/parsec/config.toml \
--=20
2.43.0


