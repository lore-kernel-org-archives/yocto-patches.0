Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EDC10F1A
	for <webhook@archiver.kernel.org>; Tue,  7 May 2024 14:38:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.13411.1715092696806264070
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 May 2024 07:38:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DA061063
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 May 2024 07:38:42 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1085A3F6A8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 May 2024 07:38:15 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][master scarthgap] publish-artefacts: remove generic-arm64
Date: Tue,  7 May 2024 14:38:11 +0000
Message-Id: <20240507143811.3228447-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 May 2024 14:38:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/87

This was removed from meta-arm as it has been obsoleted by genericarm64.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/publish-artefacts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index 3b4e3704..e4c6661f 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -201,11 +201,6 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/genericx86
         cp -R --no-dereference --preserve=3Dlinks $TMPDIR/deploy/images/=
genericx86/*genericx86* $DEST/machines/genericx86-alt
         ;;
-    "meta-arm")
-        mkdir -p $DEST/machines/meta-arm/generic-arm64
-        sha256sums $TMPDIR/deploy/images/generic-arm64
-        cp -R --no-dereference --preserve=3Dlinks $TMPDIR/deploy/images/=
generic-arm64/*generic-arm64* $DEST/machines/meta-arm/generic-arm64
-        ;;
     "poky-tiny")
         mkdir -p $DEST/machines/qemu/qemu-tiny
         sha256sums $TMPDIR/deploy/images/qemux86
--=20
2.34.1


