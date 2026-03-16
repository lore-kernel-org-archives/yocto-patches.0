Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B44AF4645F
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 12:17:43 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49021.1773662921298960062
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 05:08:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=sFqdskJw;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: youenn.lejeune@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 822113D816AD
	for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 08:08:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GL6D0X_czjYv; Mon, 16 Mar 2026 08:08:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CBF473D81729;
	Mon, 16 Mar 2026 08:08:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CBF473D81729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1773662919; bh=lDP9GH9H1fRHTWA/YkbSKXq9NzGciHhp+265nFRSoQ0=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=sFqdskJwyLzHioJMUQcfSBdwwpIoI90gIoXdpkX04wX2Y32TbpFoBDMrxGPkiRMZX
	 amwgQcmsfOV+mM4l3+6FuQ+M0YC3G2thO9QblQ8mBwwdjt98FO9sptRcIwatuXplgB
	 BoTpIOB3tpCeouMGmrwk7zV2WDI0zdJS5N/WC0Sh+rQNlyXR3C+cvZN3I5pIyfvCKo
	 TpvYmxD5242H8phtsrqUZsz8XUyO/ft1t0ooHLw70dFOOuPiu2BtoXB2kUNRUjLy5w
	 SS3wsFDcLYZrKKSF3N1pjOC9KUN2huaQjhJdtqQ9L+YDkSpGSnZUBdFDzVBIwGHigq
	 Of7D99bk1zHcA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8KklFbhckH7p; Mon, 16 Mar 2026 08:08:39 -0400 (EDT)
Received: from krampouz.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 405E93D816AD;
	Mon, 16 Mar 2026 08:08:39 -0400 (EDT)
From: "Youenn Le Jeune" <youenn.lejeune@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>,
	Erwann Roussy <erwann.roussy@savoirfairelinux.com>
Subject: [PATCH] dpdk: replace CVE_CHECK_IGNORE with CVE_STATUS
Date: Mon, 16 Mar 2026 13:08:27 +0100
Message-ID: <20260316120827.65760-1-youenn.lejeune@savoirfairelinux.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 12:17:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3473

CVE_CHECK_IGNORE is obsolete since Yocto 4.3 and has been
replaced by CVE_STATUS.

Reviewed-by: Erwann Roussy <erwann.roussy@savoirfairelinux.com>
Signed-off-by: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>
---
 recipes-extended/dpdk/dpdk_22.11.11.bb | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/recipes-extended/dpdk/dpdk_22.11.11.bb b/recipes-extended/dp=
dk/dpdk_22.11.11.bb
index f2db074..8d5d248 100644
--- a/recipes-extended/dpdk/dpdk_22.11.11.bb
+++ b/recipes-extended/dpdk/dpdk_22.11.11.bb
@@ -9,14 +9,8 @@ BRANCH =3D "22.11"
 SRCREV =3D "ff0626010952913655a6df4c4e12fc386bea7fe4"
 S =3D "${WORKDIR}/git"
=20
-# CVE-2021-3839 has been fixed by commit 4c40d30d2b in 21.11.1
-# NVD database is incomplete
-# CVE-2022-0669 has been fixed by commit 6cb68162e4 in 21.11.1
-# NVD database is incomplete
-CVE_CHECK_IGNORE +=3D "\
-    CVE-2021-3839 \
-    CVE-2022-0669 \
-"
+CVE_STATUS[CVE-2021-3839] =3D "fixed-version: Fixed by commit 4c40d30d2b=
 in 21.11.1, NVD database is incomplete"
+CVE_STATUS[CVE-2022-0669] =3D "fixed-version: Fixed by commit 6cb68162e4=
 in 21.11.1, NVD database is incomplete"
=20
 # kernel module is provide by dpdk-module recipe, so disable here
 EXTRA_OEMESON =3D " -Denable_kmods=3Dfalse \
--=20
2.53.0


