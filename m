Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A9DC982D7
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26512.1789595928147081965
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=V97NZNwh;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cc46c8so12487085a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595927; x=1790200727; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YpuASZxVpQBRb99NvzrvxGm9ABXKbYJDMu75tzSQ2Lo=;
        b=V97NZNwhispXMVaoptg9iRg/AB1bL6c90vmXzVxoGo3aV9f1zFPpATiJE2Ex19VX38
         XSTSnYEEymhNXnnMnFVwI8oJuHoe+pV6DFcmz1eRFd0bI020s3KpsdhEkuA5pK9MFo5y
         FWT4O6As9yt72kmnk2C3nx8DJbdZfPLEzV94U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595927; x=1790200727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YpuASZxVpQBRb99NvzrvxGm9ABXKbYJDMu75tzSQ2Lo=;
        b=P1Wi16yP5MinkNHtA0NWIeHyifM35ANeB6jf59gLdflybU3ioaA6AwmO7X+jUqqoEP
         DKM2RDeHhDEARg3rxt+1qcUQvjAnA3+am6azweGJYu2uOkP2VgfgTh6wWVd0hDTNzilL
         tooI2+JZpwEy23lK0uqNlqe5EfSjwTqjgVCc1qJOwHp80MXaMRYrIg9Mb83iNqnYTgAy
         nCGaUOvE0jpmiJfAiSivzlJvJQT5TcR45j5Iu5bf1gmCC4TXTyp4pTQ/DdOMkHKGYqXN
         LYPXD05rJUSWEJ0rXT23Xfu3TbOUgHvyOCgmaKoUeI1R1RV/uUNoPswDhhlNSd7vHJst
         OOAg==
X-Gm-Message-State: AFuF++ljyaoNo6C1kvKO1z5/CyHjKteexQa+FZGT/FF/bQOP+Qot3EAn
	BdfHTQJapWTqYVsy2cDx0CJjffRFESAyx3GQpOA4UJ5ZtQ7isumLDzy7e6l5Eg1rogp9FpHIfD/
	JMO49
X-Gm-Gg: AYBFou3VQ4xem6U6y7tuTu7eRHVo4hr9bkxuuXPSMiVwh1t8oJpn0pv9OGVSY0H7/9K
	WVJIMKzc9szWHQ6js45PQvr8MSfxbYJDpXhXnDhIZPWqn4L+JQSTzCGvkMQnGZa8vlEherx8EM8
	4tUaa/6yElhVXbjZAr6FPyyAsJeVJl1eaVk/cu3MpEZ/QTc6DY6ENw08AQu/lum07nZsHn3Vopr
	iC7gKbe5HHRiwigw/sbNymnOTfRdcNm9sBVMVbH+vI9njb77pq9RzWgM8y7Aaew22KbXVB45feb
	p4sPOd6EEP3tZQInQq/qKW1OFf7OQnDYK59qCTBH3OyuYnXlEqgx6d4IIYiQtxoOpSBGyOOcx7f
	qboZKd4VoDGs4Jpb2+QqzM6DLsp8t1958+5ctbtZRZagz14w2oAJDklOpHHv3VaoR3iBuYmdFhU
	P8gQ+OkUQxnSw9xyYktySIuByY5eMLe3dXsYoD/dMFHEnlhOaexv/9PKAzJ4Dh66I6/mEEKHZut
	8LEIagXDpN+ScIhveN5qqX/GQuX19KyXOg61JEYRa5NBKup2yVme7cq89pp9k0CwQCH4lwCmEXh
	V+idVc5Oa7lIkuGhmTKJBSSCSMDJ9Dt1F1k=
X-Received: by 2002:a05:620a:2618:b0:936:dc4c:3bf4 with SMTP id af79cd13be357-93bb7881a08mr773630785a.28.1789595927031;
        Wed, 16 Sep 2026 14:58:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 10/19] tpm2-tools: Upgrade 5.7 -> 5.8
Date: Wed, 16 Sep 2026 17:58:10 -0400
Message-ID: <66cb831bbb320ac4af0a356cd5b850c9492889fd.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4866

From: Khem Raj <raj.khem@gmail.com>

Release notes:
https://github.com/tpm2-software/tpm2-tools/blob/5.8/docs/CHANGELOG.md

Fixes GHSA-v7w4-4gc9-qcgv, GHSA-gwfg-w3jr-xh66 and GHSA-qp88-8f4j-wv7q,
including a heap buffer overflow in tpm2_getekcertificate.

Also brings OpenSSL 4.0 compatible macros, so the tools build and link
cleanly against openssl 4.x (verified against 4.0.2 with no deprecation
warnings; tpm2 links libcrypto.so.4).

Add autoconf-archive-native to DEPENDS: the 5.8 release tarball no longer
bundles the autoconf-archive ax_*.m4 macros under m4/ the way 5.7 did, so
the autoreconf done by autotools.bbclass leaves AX_CHECK_COMPILE_FLAG,
AX_CHECK_LINK_FLAG, AX_CHECK_PREPROC_FLAG, AX_ADD_FORTIFY_SOURCE,
AX_CODE_COVERAGE and AX_IS_RELEASE undefined. m4 then strips a quoting
level off their unexpanded arguments and the bare AC_MSG_ERROR leaks into
configure, failing autoconf's m4_pattern_forbid check with:

  configure.ac:40: error: undefined or overquoted macro: AC_MSG_ERROR

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (83%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
similarity index 83%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
index 7c5d156..4edd283 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
@@ -5,11 +5,11 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl"
+DEPENDS = "tpm2-tss openssl curl autoconf-archive-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
+SRC_URI[sha256sum] = "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156a1fd92edf84bef73"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.55.0


