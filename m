Return-Path: <florent.allard@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23248C3ABC3
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 16:05:06 +0000 (UTC)
Received: from fallard-pc.mtl.sfl (fallard-pc.mtl.sfl [208.88.110.46])
 by mx.groups.io with SMTP id smtpd.web10.54089.1747065903016859764
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 May 2025 09:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=none, err=permanent DNS error (domain: fallard-pc.mtl.sfl, ip: 208.88.110.46, mailfrom: fallard@fallard-pc.mtl.sfl)
Received: by fallard-pc.mtl.sfl (Postfix, from userid 1000)
	id 1721B14C012; Mon, 12 May 2025 12:05:02 -0400 (EDT)
From: Florent Allard <florent.allard@savoirfairelinux.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Florent Allard <florent.allard@savoirfairelinux.com>
Subject: [psplash][PATCH 1/2] configure.ac: standardize default-enabled options
Date: Mon, 12 May 2025 12:04:59 -0400
Message-ID: <20250512160500.244466-2-florent.allard@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512160500.244466-1-florent.allard@savoirfairelinux.com>
References: <20250512160500.244466-1-florent.allard@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 May 2025 16:05:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1547

This commit makes the features progress-bar and startup-msg enabled by
default, and enabled when respectively `--enable-progress-bar` or
`--enable-startup-msg` is passed.

To do so, the default variable name `enable_feature` is used, as well as
the default variable values `yes` and `no`.

This is linked to this issue on buildroot
https://gitlab.com/buildroot.org/buildroot/-/issues/112

The documentation for this feature of autoconf is available here:
https://autotools.info/autoconf/arguments.html

Signed-off-by: Florent Allard <florent.allard@savoirfairelinux.com>
---
 configure.ac | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2a7da91..4543d1d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,17 +31,17 @@ AC_SUBST([FONT_NAME])
=20
 AC_ARG_ENABLE([startup-msg],
     AS_HELP_STRING([--disable-startup-msg], [Disable text banner output =
on startup]),
-    [disable_startup_msg=3Dtrue],
-    [disable_startup_msg=3Dfalse])
-AS_IF([test x$disable_startup_msg =3D xtrue], [
+    [enable_startup_msg=3D$enableval],
+    [enable_startup_msg=3Dyes])
+AS_IF([test "x$enable_startup_msg" =3D "xno"], [
     EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_STARTUP_MSG"
 ])
=20
 AC_ARG_ENABLE([progress-bar],
     AS_HELP_STRING([--disable-progress-bar], [Disable progress bar]),
-    [disable_progress_bar=3Dtrue],
-    [disable_progress_bar=3Dfalse])
-AS_IF([test x$disable_progress_bar =3D xtrue], [
+    [enable_progress_bar=3D$enableval],
+    [enable_progress_bar=3Dyes])
+AS_IF([test "x$enable_progress_bar" =3D "xno"], [
     EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_PROGRESS_BAR"
 ])
=20

