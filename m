Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71139C88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:17 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48467.1789157648407574905
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=jyfT7MY+;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309d6188e1so3525391cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157647; x=1789762447; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=upu2+/fyG65ioOA7A8uT5y1PzaXcvehlBAQPTViuc+Q=;
        b=jyfT7MY+Y9hCpAFnvAOxbOg/hYKICK6bGVuQzlTnA+lqxX0BImdJx980Pes3Q2+KyW
         zHpA5aJKY3MxYmeoiVjsG8DxG4LWO69JLDLeR075IUMqrYqC0KJswalfWpIwA9G7m4ii
         c7HkBguUK3FxlHlfB4YNG2VPsMvahCtNlT5jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157647; x=1789762447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=upu2+/fyG65ioOA7A8uT5y1PzaXcvehlBAQPTViuc+Q=;
        b=FURJ8PTMv0cm0CTAOBCzjTDX27Qy7u885Iz7ziqlu8iAwYZ9/ib3BlgWG+NLSqKMZ1
         nWTLrT9nwSCcAQqXVX4n2L++QFrvx3C9abT0nhPbl9xrBQYYtST5dCE6QxVDqITtn8uh
         vM9Rd5KJZEiINb0mPDMxOBtBGiQ79AhyZFC3D93imCsah7yFpoVAwjBHiLfSYM88c3Dz
         712kg7oZ928tFvj7rZp3Nt9dxfKhYhAOPrQ5vB8VzvrMWnjSRUZo23RgZ75guIgIE19A
         NeiXTkORtUJUaJ1I3ADLWvMZfSDrQV0w00LrrBV3/3kXSOR6Dn6+hdFzHu169+i2RUEK
         aB+g==
X-Gm-Message-State: AFuF++lSJOogRuPDgJBMN0Ol8EMjUI1LqME80GJC5ex6X7OSQ81nDE/C
	cZCz4kbfBgUGhf3i0TlTa56chqkYWM6ShPQG08OV5J4OIHCD81/XcO63OQ3UWZ+NkV9OSyGYYg5
	9lMvj
X-Gm-Gg: AYBFou3m3diAiHG2IejpmW5TWsBUROj1eWU9T60mntmhvdwgSZffMRtNwLcqptXidXg
	OEcH/emXNJjihaQjFtXkWyQG4aMPgFajVMIy0MUHjpty+IY08zKiYA8rDPvDkpCMXIlymCHljO2
	RYQ1tkKs7TBJ2vtjCPRdw3OBHxsEKSJ5ElxKpAmyEQdqpLXwiAh01AWRQuJHdS2hQTQq8VKilLe
	E/FMGz342EfjFeKstdmcN1EFSBblbSKWBBQdc480BBMSTs9da1V/vHHDMYXf4r8ZCppgUWu7W2u
	Z+qfW/h93O2Z7s0zkozBDAuFm9Q5K/qSilVh18K/UPiUUKOTdMKoH1o2JeTHeeLmJMMVpwBfgUM
	d9HezLMgZYrSi+VrfUtl1CPNMKF2LiX7YGltxp73gKe6rg8yGsCrsFVXIYmwAyi+1hNDt9WxjpY
	RKLhTEUhhXvyrbtilI4PtmupmwylvjvbrZCBKDE8ANmq1BsQqPT46NNh8MgJ0Cv+9hMiTPUlaIq
	a1YRJbw4GsFbHSE5g08eXccqQ8d7WDdZXJewUcJGspAV+eAxnHAd/DA88MyBX8DkK/xuyRO9CPZ
	NQ3MRSba4DyAh15DragY67nAAi51JdNlc9bOIJtUZcIFkA==
X-Received: by 2002:a05:622a:90b:b0:530:b2e3:86c6 with SMTP id d75a77b69052e-530c87afc8cmr105213951cf.56.1789157647134;
        Fri, 11 Sep 2026 13:14:07 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 31/37] libgit2: upgrade 1.9.6 -> 1.9.7
Date: Fri, 11 Sep 2026 16:13:17 -0400
Message-ID: <b08db522ea723e24d1394efde1231021a5342d9a.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4797

From: Richard Purdie <richard.purdie@linuxfoundation.org>

v1.9.7
------

This is an security release with one change.

* Escape remote repository paths in libssh2

  In v1.9.2, we started escaping repository paths in the OpenSSH-based
  exec ssh transport. Bring the same escaping to the libssh2 transport
  to avoid any potential command injection.

In addition, changes have been ported from the main branch to update
CI builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b66353353a0e1a26f8060931b3d571134a27768b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...cmake-mark-system-libraries-are-private-link-librari.patch | 4 +---
 .../libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb}            | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)
 rename recipes-support/libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb} (92%)

diff --git a/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
index 267770a..93f1f3a 100644
--- a/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
+++ b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
@@ -1,4 +1,4 @@
-From 5670d3eed82f0d64766158809bf3d0c7c631b0ea Mon Sep 17 00:00:00 2001
+From 41048806aec8a4b71f3ccf11fdedbec88080a675 Mon Sep 17 00:00:00 2001
 From: Ross Burton <ross.burton@arm.com>
 Date: Thu, 23 Jul 2026 17:35:23 +0100
 Subject: [PATCH] cmake: mark system libraries are private link libraries
@@ -38,5 +38,3 @@ index 8045ddef9..fafdb09ec 100644
  target_include_directories(libgit2package SYSTEM PRIVATE ${LIBGIT2_INCLUDES})
  target_include_directories(libgit2package INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
  
--- 
-2.43.0
diff --git a/recipes-support/libgit2/libgit2_1.9.6.bb b/recipes-support/libgit2/libgit2_1.9.7.bb
similarity index 92%
rename from recipes-support/libgit2/libgit2_1.9.6.bb
rename to recipes-support/libgit2/libgit2_1.9.7.bb
index 67322cb..7561bae 100644
--- a/recipes-support/libgit2/libgit2_1.9.6.bb
+++ b/recipes-support/libgit2/libgit2_1.9.7.bb
@@ -8,7 +8,7 @@ DEPENDS = "curl openssl zlib libssh2 libgcrypt libpcre2"
 SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https \
            file://0001-cmake-mark-system-libraries-are-private-link-librari.patch"
 
-SRCREV = "26055f5af74ab1cf636d272e8a34315496d3f06f"
+SRCREV = "49e408b3208bc3093757a1c2db938d3590f3f412"
 
 S = "${WORKDIR}/git"
 
-- 
2.55.0


