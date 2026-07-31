Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0D5C55176
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4476.1785497617395386738
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZcuoxG6u;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e65e18969so45428685a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497616; x=1786102416; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VI+8wSQbMHqaRkqRfsNBsJiqV2BRGI/BB6ImBwRN2cs=;
        b=ZcuoxG6uzOq8MqjVadxOVwGyGd16uSQbDiOKRyIgci7NpZZCw4fllaJPn0wL1Sbyfp
         NIHytQDzzQiTe/21fHeyYMWYNvq3JLErr/1QeWKXItXZqVn2OqX3RTpjN2PTmz9yeX4e
         DXZ4VxIkCVW7Dchqqi2u3c9ntIlhpj1n+U1Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497616; x=1786102416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VI+8wSQbMHqaRkqRfsNBsJiqV2BRGI/BB6ImBwRN2cs=;
        b=ChWgiFu1AQkjLbNXDe8j5IlOfKs/c2V5RF6cKS7cfgyEZaccm5hvCw9hi/JIOq/VEQ
         pzDYXUgeGhHizdAWkQlo5yFfz4BagUERAQFlK0aoE/JuVVhi7MQ8XrO/ukb38IcaQSPv
         dMUdak9XP/vWoIY5S736Kjm5mf898oMfeIs5/otbyOt8i8j+6GtG+6439H6BtWLmkMkH
         V7VpUUQXsm7zqwjJiJc0Zov6eyVLqoqaHsyQFQda8To/v6MSkSs7dOwtPuXe7xsVTGv/
         gu7DE9bkFqaZ0uk08i5Wu8RbtIjghdF2pkFYGm6Q4Ci0G5YImzxo/gKl0uJ/fooIDXJw
         U97A==
X-Gm-Message-State: AOJu0Yw9gjCvtExujJJMyhYxFMstz00vmScYTYXZrahkBzDOeTURWFkt
	EKrxpThytoOPLPpzH1ryEZSpdbrASUtMbfHsPnaoMG9X5vVSWtkCdMQMoeGhG9jGGna87sG6sdN
	TfLSs
X-Gm-Gg: AR+sD13paxM3/Gq4+REw9MDJnP1w5WdA7/LaDbFYxhP6TQOr9wpgKQdaZV2QeRiRHVv
	GMdrfpKzh98mz4SowsG5uhto2NQwUMpw6h58Gz9LOZR0otBaY71xGOZ+F3oXyn3kTb40ib64FqP
	+fPDRy/WXLwpOC+FF+puLfE3kghOld4zAgnLkQErTMuUwbLp3SUWAb1+aZxReerSkJV1ulCFCpM
	4VQ08pXHyV5bc2JD6w7w64NaERmDRmJso1WqqLddnAhdRBbNfyK94JS1HXVN3ZR9zJHyVbc4UXE
	/6plVcKmrZAz55EjtszhjZzhxPZDjU7YS2OI3+DLB0/1WytvIBOl6nD65RO5WENZQrl7qRwAQvD
	aHQhufF1cTyUIfFsw4iKkfABNjkMX3Qk615sDZCCpCXMUc49AezPigQemfA9PGVIF3PtCWoVyE+
	MsWdZjRLZSS85bt4VzzCZaHGDvuRmBEef4ZYClbZsrsAuNjKykCUbu0khrkdukDrSbmTI7cLjWu
	/1boRXtMKHzYmi3BZmt3y3I7f0ywpkThjvEAkp5fpHml5aG4cWDzBx/qXt6w9oTT9RgxozPIOL3
	hLpNL1L8RvcytGT+rVUUk7FjNQ==
X-Received: by 2002:a05:620a:3945:b0:92e:5949:3567 with SMTP id af79cd13be357-934974571edmr205815085a.14.1785497616049;
        Fri, 31 Jul 2026 04:33:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:35 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 24/35] librsvg: add PACKAGECONFIGs for avif and gdkpixbuf
Date: Fri, 31 Jul 2026 07:32:54 -0400
Message-ID: <df6ede8888c01a6f63e2a1048dec9a1ca34e08ae.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4600

From: Ross Burton <ross.burton@arm.com>

The existing gdkpixbuf PACKAGECONFIG is actually for the gdk-pixbuf SVG
loader.  Rename this to gdkpixbuf-loader and add another PACKAGECONFIG
that controls whether gdk-pixbuf support is enabled, and enable this by
default to preserve behaviour.

Add a new PACKAGECONFIG to enable support for embedded AVIF[1] files.
This is disabled out of the box as it depends on dav1d, part of meta-oe.

[1] https://en.wikipedia.org/wiki/AVIF

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9797142b3f80ac93966e16896e92c4ca3bce8101)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index cf8b1b6..19ceb69 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -10,7 +10,7 @@ LICENSE = "LGPL-2.1-or-later"
 LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c"
 
 SECTION = "x11/utils"
-DEPENDS = "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-native cargo-native cargo-c-native"
+DEPENDS = "cairo glib-2.0 libxml2 pango python3-docutils-native cargo-native cargo-c-native"
 RDEPENDS:${PN}-ptest += "rsvg"
 BBCLASSEXTEND = "native nativesdk"
 
@@ -56,11 +56,14 @@ LDFLAGS += " -L${B}/rsvg"
 # needed on ubuntu 20.04/debian 11 to avoid 'undefined reference to `dlsym'' errors
 BUILD_LDFLAGS += " -ldl"
 
-PACKAGECONFIG ??= "gdkpixbuf \
+PACKAGECONFIG ??= "gdkpixbuf gdkpixbuf-loader \
                    ${@bb.utils.contains('PTEST_ENABLED', '1', 'apitest', '', d)} \
                    ${@bb.utils.contains('GI_DATA_ENABLED', 'True', 'vala', '', d)}"
-# The gdk-pixbuf loader
-PACKAGECONFIG[gdkpixbuf] = "-Dpixbuf-loader=enabled,-Dpixbuf-loader=disabled,gdk-pixbuf-native"
+
+PACKAGECONFIG[avif] = "-Davif=enabled,-Davif=disabled,dav1d"
+PACKAGECONFIG[gdkpixbuf] = "-Dpixbuf=enabled,-Dpixbuf=disabled,gdk-pixbuf"
+# The gdk-pixbuf loader (depends on gdkpixbuf)
+PACKAGECONFIG[gdkpixbuf-loader] = "-Dpixbuf-loader=enabled,-Dpixbuf-loader=disabled,gdk-pixbuf-native"
 PACKAGECONFIG[vala] = "-Dvala=enabled,-Dvala=disabled"
 PACKAGECONFIG[apitest] = "-Dtests=true,-Dtests=false"
 
-- 
2.55.0


