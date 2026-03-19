Return-Path: <youenn.lejeune@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4D2107527C
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 08:53:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6520.1773910384780444037
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Mar 2026 01:53:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=UDPzajkL;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: youenn.lejeune@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 83AA63D80F4D;
	Thu, 19 Mar 2026 04:53:03 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id eTBLQthvLv_9; Thu, 19 Mar 2026 04:53:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9EC843D81764;
	Thu, 19 Mar 2026 04:53:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9EC843D81764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1773910382; bh=R6rx5UA72XKg+GAX7QSjZT+YhKU8R3Yh/hCHYEHtjgA=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=UDPzajkL+8nfQGmm+wSP1F0ClEHM7woNnpHnNbxzDDQVFIbrBcN2UJsMckjmZHyDE
	 keeekUbv5C/xP9yzFzJLRNItG3Zkts6sBM+rSiSqCq3klrf9CB93v6P/oUDNMFh4HL
	 ALa2GIcVHiZssnTo+8Ny27/q5ftcvbZgZWQmLl3aupjAPLKGpItBAkTa6X5dn23Y1P
	 9SZV3jhAnQ8034y7JdrjIHYTpYrwfD0dgTZiJxLi8LJxQwQktYtMjF9JP62dYRcTkO
	 42n92yxgbnBLqyTYzu/1DfnBLYsSc87994oGdvc0aTRCDJDmLLq2YSNyn0+hGf0ZJS
	 n8ZlHJj/fQ4fA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pbw2VuYa0poh; Thu, 19 Mar 2026 04:53:02 -0400 (EDT)
Received: from krampouz.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DDAEA3D80F4D;
	Thu, 19 Mar 2026 04:53:01 -0400 (EDT)
From: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>,
	Anuj Mittal <anuj.mittal@oss.qualcomm.com>,
	Erwann Roussy <erwann.roussy@savoirfairelinux.com>
Subject: [meta-dpdk][scarthgap][PATCH] dpdk: removed obsolete CVE_CHECK_IGNORE
Date: Thu, 19 Mar 2026 09:52:38 +0100
Message-ID: <20260319085238.339541-1-youenn.lejeune@savoirfairelinux.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 08:53:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3520

The CPEs have been enriched in the NVD datavase. They now contain
proper version information, making those CVE_CHECK_IGNORE useless.

CC: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Reviewed-by: Erwann Roussy <erwann.roussy@savoirfairelinux.com>
Signed-off-by: Youenn Le Jeune <youenn.lejeune@savoirfairelinux.com>
---
 recipes-extended/dpdk/dpdk-module_22.11.7.bb | 9 ---------
 recipes-extended/dpdk/dpdk_22.11.11.bb       | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/recipes-extended/dpdk/dpdk-module_22.11.7.bb b/recipes-exten=
ded/dpdk/dpdk-module_22.11.7.bb
index e8973b1..cd9bbd6 100644
--- a/recipes-extended/dpdk/dpdk-module_22.11.7.bb
+++ b/recipes-extended/dpdk/dpdk-module_22.11.7.bb
@@ -47,12 +47,3 @@ do_install() {
                O=3D${STAGING_KERNEL_BUILDDIR} \
                ${MODULES_INSTALL_TARGET}
 }
-
-# CVE-2021-3839 has been fixed by commit 4c40d30d2b in 21.11.1
-# NVD database is incomplete
-# CVE-2022-0669 has been fixed by commit 6cb68162e4 in 21.11.1
-# NVD database is incomplete
-CVE_CHECK_IGNORE +=3D "\
-    CVE-2021-3839 \
-    CVE-2022-0669 \
-"
diff --git a/recipes-extended/dpdk/dpdk_22.11.11.bb b/recipes-extended/dp=
dk/dpdk_22.11.11.bb
index f2db074..d6fc4dc 100644
--- a/recipes-extended/dpdk/dpdk_22.11.11.bb
+++ b/recipes-extended/dpdk/dpdk_22.11.11.bb
@@ -9,15 +9,6 @@ BRANCH =3D "22.11"
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
-
 # kernel module is provide by dpdk-module recipe, so disable here
 EXTRA_OEMESON =3D " -Denable_kmods=3Dfalse \
                 -Dexamples=3Dall \
--=20
2.53.0


