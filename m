Return-Path: <florent.allard@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F4DC3ABD8
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:05:06 +0000 (UTC)
Received: from fallard-pc.mtl.sfl (fallard-pc.mtl.sfl [208.88.110.46])
 by mx.groups.io with SMTP id smtpd.web11.54365.1747065903087185876
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 May 2025 09:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=none, err=permanent DNS error (domain: fallard-pc.mtl.sfl, ip: 208.88.110.46, mailfrom: fallard@fallard-pc.mtl.sfl)
Received: by fallard-pc.mtl.sfl (Postfix, from userid 1000)
	id 1AF2F14C02E; Mon, 12 May 2025 12:05:02 -0400 (EDT)
From: Florent Allard <florent.allard@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Florent Allard <florent.allard@savoirfairelinux.com>
Subject: [psplash][PATCH 2/2] configure.ac: fix autoconf code for img_fullscreen
Date: Mon, 12 May 2025 12:05:00 -0400
Message-ID: <20250512160500.244466-3-florent.allard@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512160500.244466-1-florent.allard@savoirfairelinux.com>
References: <20250512160500.244466-1-florent.allard@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 May 2025 16:05:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1548

This commit makes the autoconf code for img_fullscreen more standard, by
using the default variable name "enable_img_fullscreen", and also use
the default `yes` and `no` variable values.

The documentation for this feature of autoconf is available here:
https://autotools.info/autoconf/arguments.html

Signed-off-by: Florent Allard <florent.allard@savoirfairelinux.com>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4543d1d..110ce32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,9 +47,9 @@ AS_IF([test "x$enable_progress_bar" =3D "xno"], [
=20
 AC_ARG_ENABLE([img-fullscreen],
     AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in =
fullscreen mode)]),
-    [img_fullscreen=3Dtrue],
-    [img_fullscreen=3Dfalse])
-AS_IF([test x$img_fullscreen =3D xtrue], [
+    [enable_img_fullscreen=3D$enableval],
+    [enable_img_fullscreen=3Dno])
+AS_IF([test "x$enable_img_fullscreen" =3D "xyes"], [
     EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_IMG_FULLSCREEN=3D1"
 ])
=20

