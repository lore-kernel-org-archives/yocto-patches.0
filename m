Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32EC88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:04 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48452.1789157635212229686
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CHJ02/RO;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-530e1b6a689so3232631cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157634; x=1789762434; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XOOl+F7T2KSWB9dvTtcEwiYt4H2VTR9aP+BALaU7Mhc=;
        b=CHJ02/ROmR6qzuBj3PunfZbgcz8TdyhHNmfuoNbIjG6INP3NCf+nEcpP0UkSp+YOTp
         3HL/u2qamvYPu6xfu/qk1Wo5P9mioK1EJkRgKsSKtf+Ta+quuXHwY3uPozua8ffqexSI
         iLyLSNU8rTVyi7Mx/JkIfiTOMT265MJHTTjnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157634; x=1789762434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XOOl+F7T2KSWB9dvTtcEwiYt4H2VTR9aP+BALaU7Mhc=;
        b=iOSpUIDKz0awNPjRdtrsiFaV2No7IhxbQuElRqZrcsUAaDnRzekTtETe0Rec2m4IgE
         MCAaqnOSs2m+MNQi4lSaVrFT7LVdMlNnKiWdowYerxY750dKTO9Th6d0IugmWXN+oH3R
         smr7IfyABxdDo1HsQ4DmvZDmb1a3tbVDbCRwZkKOpkA+xvSFqZgmrtdCzIP/ZQ18R8AE
         dszA1VdpansrYgwrxoQQSJI3+I0Gfe9/ZdBRnjA8omoi2PuVlzl6i4FqTSa9zSKXxIsC
         ymidnkrF4Hkgs22v4gnFm3gS6kOCTZbN292n1uy1MOwP4+tmNi+oc1f7OHoEBu4t+RHb
         TmWw==
X-Gm-Message-State: AFuF++mbZ/XuWqODV9Ax1BCUAOUCXHgjEmFSnm3TRZGY2huik0cunnAJ
	dkY3DAhS0PfxOirnJOfLlY4JoamtmIn2FJZmq/ts0N9HRlAQrGiQfMK4pFot7vM3Cidj9bM1tdc
	Zg9JF
X-Gm-Gg: AYBFou0DewaWe6NA0gmYz0Y3TBNGkaWqdfV8t1tQt/W8YV3Y8iF94s1+gkyp96rDMRn
	zkk3BVHq68tWlsbj+aIfhR2orUdh33fBBqpc0k/QKlQVBLeNkxj2DhbfXFrO0T/9ASOUvwvLI/q
	tHtzqL2vUok+Y51bc5NgJgWJo1V0KggFdi5MzTdbOUkucnPzhMJAUjttsj94lb/uvF52uOo2t1I
	E5AzEu7d0b/DEj0z2qns8KAM03M2iXLfEsH+EO8aBPm92MP1NEGjmKjsb3cVi751MsqkmpGnFkS
	qbo+j8SkS1yxsCkUtkKPoYTjD+2dBm7Y08iFNPFV+embt8KLDD39FQ9FS9ImaTtV7/ZtWwmWKTZ
	4/N4a5eSGCuTz/6JwPx/m5GkB/6x8Lwme6Al/eDUgWvj026ZA2ezxVqzqq+sddCmSbAslcAGgZN
	LSQMKLQK1j5lgfwpZG9JRV9IHz97WgDU2oeOBnryAB0gRVivKlh1fDvt24o4CN64V2l21cFo+8x
	+sdax05zMzbV9DR1AJY0P6iWU+YEKOQOgbwQLtRdVKrbL+63Y4SSpbb67ZkD5Q8ZObsepbZjE4Q
	jG8kaU/nhBA/gUEOcC8WLP6sDeBnRytXJ7Y=
X-Received: by 2002:a05:622a:48f:b0:530:7caa:ec94 with SMTP id d75a77b69052e-530c850ea8cmr95627221cf.19.1789157633970;
        Fri, 11 Sep 2026 13:13:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 16/37] libgit2: upgrade 1.9.4 -> 1.9.6
Date: Fri, 11 Sep 2026 16:13:02 -0400
Message-ID: <b26e925655bf927a857ce7a764c1b5e39f05d8f1.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4782

From: Wang Mingyu <wangmy@fujitsu.com>

License-Update: update COPYING to include PCRE2 copyright notice
                Remove the original PCRE copyright notice; replace it with PCRE2.

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9ed24f38e57454e554165392ee8d1b2eec1ee032)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../libgit2/{libgit2_1.9.4.bb => libgit2_1.9.6.bb}            | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-support/libgit2/{libgit2_1.9.4.bb => libgit2_1.9.6.bb} (83%)

diff --git a/recipes-support/libgit2/libgit2_1.9.4.bb b/recipes-support/libgit2/libgit2_1.9.6.bb
similarity index 83%
rename from recipes-support/libgit2/libgit2_1.9.4.bb
rename to recipes-support/libgit2/libgit2_1.9.6.bb
index f81cdaa..38a03fb 100644
--- a/recipes-support/libgit2/libgit2_1.9.4.bb
+++ b/recipes-support/libgit2/libgit2_1.9.6.bb
@@ -1,14 +1,14 @@
 SUMMARY = "the Git linkable library"
 HOMEPAGE = "http://libgit2.github.com/"
 LICENSE = "GPL-2.0-with-GCC-exception & MIT & OpenSSL & BSD-3-Clause & Zlib & ISC & LGPL-2.1-or-later & CC0-1.0 & BSD-2-Clause"
-LIC_FILES_CHKSUM = "file://COPYING;md5=8eacfdc17c8f4d219e131a073973b97d"
+LIC_FILES_CHKSUM = "file://COPYING;md5=8289345c8713c385f45ec0c6c8a0d080"
 
 DEPENDS = "curl openssl zlib libssh2 libgcrypt libpcre2"
 
 SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https \
            file://0001-cmake-mark-system-libraries-are-private-link-librari.patch"
 
-SRCREV = "f7164261c9bc0a7e0ebf767c584e5192810a8b24"
+SRCREV = "26055f5af74ab1cf636d272e8a34315496d3f06f"
 
 S = "${WORKDIR}/git"
 
-- 
2.55.0


