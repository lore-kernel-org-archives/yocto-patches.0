Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD4C282DE
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 16:44:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.17935.1741193089560981556
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 08:44:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802B3FEC
	for <yocto-patches@lists.yoctoproject.org>; Wed,  5 Mar 2025 08:45:02 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB0923F5A1
	for <yocto-patches@lists.yoctoproject.org>; Wed,  5 Mar 2025 08:44:48 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/2] scripts/run-dashboard-index: add ability to override the destination for testing
Date: Wed,  5 Mar 2025 16:44:43 +0000
Message-ID: <20250305164443.3080640-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305164443.3080640-1-ross.burton@arm.com>
References: <20250305164443.3080640-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 16:44:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1158

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/run-dashboard-index | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index b898c9b9..129493e1 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -2,7 +2,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-# Called with $1 as the build directory
+# Called with $1 as the build directory.
+# Set DEST in the environment to override the destination for testing pu=
rposes.
=20
 set -e
 set -u
@@ -12,10 +13,12 @@ set -x
 builddir=3D$(realpath "$1")
 scriptdir=3D"$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
=20
+dest=3D${DEST:-docs@docs.yoctoproject.org:dashboard/}
+
 cd $builddir
 $scriptdir/release-parser.py=20
 $scriptdir/layer-parser.py
=20
-rsync -irlp --checksum --ignore-times releases.json docs@docs.yoctoproje=
ct.org:dashboard/
-rsync -irlp --checksum --ignore-times parsed-layers.json docs@docs.yocto=
project.org:dashboard/
-rsync -irlp --checksum --ignore-times $scriptdir/dashboard/ docs@docs.yo=
ctoproject.org:dashboard/
+rsync -irlp --checksum --ignore-times releases.json ${dest}
+rsync -irlp --checksum --ignore-times parsed-layers.json ${dest}
+rsync -irlp --checksum --ignore-times $scriptdir/dashboard/ ${dest}
--=20
2.43.0


