Return-Path: <alejandro@enedino.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFAAC3DA5D
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 19:12:27 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web10.26174.1721416345414186877
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Jul 2024 12:12:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=softfail (domain: enedino.org, ip: 13.77.154.182, mailfrom: alejandro@enedino.org)
Received: from DL-ARCH01.lan (unknown [37.19.200.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6F13720B7165;
	Fri, 19 Jul 2024 12:12:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F13720B7165
From: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.org>
Subject: [PATCH] policycoreutils: fix packaging for sestatus binary
Date: Fri, 19 Jul 2024 13:16:16 -0600
Message-ID: <20240719191616.2795633-1-alejandro@enedino.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Jul 2024 19:12:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/444

sestatus is provided as ${base_sbindir}/sestatus which is currently packa=
ged into
PN-sestatus, however, this is only a symlink to the binary located in
${bindir}/sestatus.

This causes that when runtime dependencies are calculated, bitbake proper=
ly detects
a dependency from policycoreutils-sestatus to the main policycoreutils pa=
ckage.

Hence the policycoreutils-sestatus package has no usability by itself, th=
is has
several implications, but one of them means that it recursively pulls all
runtime dependencies, making policycoreutils-sestatus require everything =
that the
main policycoreutils package RDEPENDS on, including python3.

By correctly splitting these packages, an image that RDEPENDS only on
policycoreutils-sestatus decreases its size by about ~13MB.

Signed-off-by: Alejandro Enedino Hernandez Samaniego <alejandro@enedino.o=
rg>
---
 recipes-security/selinux/policycoreutils_3.7.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/selinux/policycoreutils_3.7.bb b/recipes-se=
curity/selinux/policycoreutils_3.7.bb
index 2871de0..9e59c4b 100644
--- a/recipes-security/selinux/policycoreutils_3.7.bb
+++ b/recipes-security/selinux/policycoreutils_3.7.bb
@@ -92,6 +92,7 @@ FILES:${PN}-secon =3D "${bindir}/secon"
 FILES:${PN}-semodule =3D "${base_sbindir}/semodule"
 FILES:${PN}-hll =3D "${prefix}/libexec/selinux/hll/*"
 FILES:${PN}-sestatus =3D "\
+    ${bindir}/sestatus \
     ${base_sbindir}/sestatus \
     ${sysconfdir}/sestatus.conf \
 "
--=20
2.45.2


