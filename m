Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590AC87FCB
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 20:59:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7048.1754341153853171513
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 Aug 2025 13:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626F92574;
	Mon,  4 Aug 2025 13:59:05 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFD393F673;
	Mon,  4 Aug 2025 13:59:12 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH 2/2] dbus: remove activation workaround
Date: Mon,  4 Aug 2025 21:59:06 +0100
Message-ID: <20250804205906.301610-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804205906.301610-1-ross.burton@arm.com>
References: <20250804205906.301610-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 Aug 2025 20:59:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1885

Since "dbus: add message-bus PACKAGECONFIG" the message bus isn't built
in nativesdk builds, so this workaround is no longer needed.

This also means that dbus-launch and dbus-run-session are not built, so
remove them from the FILES.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 recipes-core/dbus/dbus_%.bbappend | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/recipes-core/dbus/dbus_%.bbappend b/recipes-core/dbus/dbus_%=
.bbappend
index f95e960..6dedd12 100644
--- a/recipes-core/dbus/dbus_%.bbappend
+++ b/recipes-core/dbus/dbus_%.bbappend
@@ -1,12 +1,3 @@
-# There seems to be a mingw build issue where if either of these are spe=
cified,
-# the mingw build fails in do_compile. Work around it for now.
-EXTRA_OEMESON:remove:mingw32 =3D "-Dtraditional_activation=3Dtrue -Dtrad=
itional_activation=3Dfalse"
-
-FILES:${PN}:append:mingw32 =3D "\
-    ${bindir}/dbus-launch.exe \
-    ${bindir}/dbus-run-session.exe \
-"
-
 FILES:${PN}-tools:append:mingw32 =3D "\
     ${bindir}/dbus-send.exe \
     ${bindir}/dbus-monitor.exe \
--=20
2.43.0


