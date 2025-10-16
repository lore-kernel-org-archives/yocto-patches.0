Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31DCCCD19F
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:44 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.1665.1760649764446048903
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Pw9VzPDc;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87be45cba29so18514206d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649763; x=1761254563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzUla/dOjI1dZ+FO4aaRudQYD7nAIOnnlUac7X1NaJ8=;
        b=Pw9VzPDcNwZQgU296cTQVd3wXwhj7V5KEuRg8plc3tiJGSkbH6f1BD94D+Mu1OJFS2
         IKW6j5GI+EQK3PW1HF1L7aH8qz93wIUh+C6LOwbb1fToR+r1X1Dp/PTU1IbDB091mFby
         Oza6+qe4OUNT5Bg2/2X9DvqLZhtg0kBj/ksPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649763; x=1761254563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzUla/dOjI1dZ+FO4aaRudQYD7nAIOnnlUac7X1NaJ8=;
        b=n0oL2Ia7wnCKUpYTWYvNqmbYla6D1GQO6C/HBa/EmhDQw+vuy1vG7i+OESU8AtlegR
         ijjYVzQdb7rtdj6k+XrDQKzzDj4xry/xYh+MCTsDs812/A2XOQGwB1tV8GUnIlL2ZKxU
         1y0b6MNF8ywlRq0AgGc7eTDaMP5R2Iq13j3WxDqjMkHbRH8UVyTyI9ZPc0ThudzmJjF8
         oKhlEJCI/AUbWgogW32GNE+LiQMW1FxEyX8rZmagA/zBsUgmZ2szwqoUwY2HaWVI70qA
         ItFwMbXQAU4ykhf1f9GOuM2chckoRl/Kr2ahKqJjR104XdHbOCF9E6mfkfTmPPwY8yzV
         ys5g==
X-Gm-Message-State: AOJu0Yx1JldG62cpeRk99X81P/v87p01pMDcIIFWOnsg0p6cbxUqg5kt
	A7hVNJ42H3tQeEdsbIfqNx36bOuxrgAuGvGi5ewvKaE3Pd07f5NzDyDTVp6XphYM7oR2kUllwdS
	SIOod
X-Gm-Gg: ASbGncs/UR/oOQuZ8LbjAKUcMu5z9GQPW4lOvS4LYxVa5wJUP5p+K/05l2a5BsgKeb0
	hylqrTqd2YWnUeZacQsI21z9bCNtpET/kUOH7Wd2IzYQNmeF67dE/vIHAJ7rOPkmbUQtcY1WMAn
	er2a7qBidTcnuOnW1hgMCEnsVbNAVy6shYVFSvXAyJqChy9ZEcm5YNZwRZV74zK7NDD+PPsuYyE
	OJb6crs8IT7ghApj4IlHNaavTL1fW233J9B7Q4imz1WnCcSh95cTza6VxrewvlwCU43d5uIK2CZ
	gOosQKPM0JAPDCx2mFrCuLUlpIiiHN0z5fTCWGz9qQEp0KVClybmyIfGJf3cGWynIgjv6sY/beG
	USRSsT0jH61VkBfByxT6UeUwq/4C2Jf1OUKyn6ln6r0gZ6Dz+ylJnMvfGfw2BPDacXT2HIZIUwH
	D/wZWf2uK2/yiloZj3rFsIYFwTPnPche4XLZG3JE+PWU8M70H0tsHTTE5KVRR0Cp8=
X-Google-Smtp-Source: AGHT+IFWTFfMlsSZXgX9KFCOhUTyHuBVe5zIB12EY24EyIYF+CxPqCvcha5y90C/MZWaxnFo8mBupg==
X-Received: by 2002:a05:6214:e87:b0:87c:1f53:e14b with SMTP id 6a1803df08f44-87c2057c8b3mr28345166d6.21.1760649762993;
        Thu, 16 Oct 2025 14:22:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 12/15] libest: Remove recipe
Date: Thu, 16 Oct 2025 17:22:11 -0400
Message-ID: <c69e15b0a11869b7970cc7b89cfa3e45e583eaa1.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2336

Remove the libest recipe since it has been disabled since November
2021, and upstream has shown no activity since 2022.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/libest/libest_3.2.0.bb | 28 -------------------------
 1 file changed, 28 deletions(-)
 delete mode 100644 recipes-security/libest/libest_3.2.0.bb

diff --git a/recipes-security/libest/libest_3.2.0.bb b/recipes-security/libest/libest_3.2.0.bb
deleted file mode 100644
index e6af2c6..0000000
--- a/recipes-security/libest/libest_3.2.0.bb
+++ /dev/null
@@ -1,28 +0,0 @@
-SUMMARY = "EST is used for secure certificate  \
-enrollment and is compatible with Suite B certs (as well as RSA \
-and DSA certificates)"
-
-LICENSE = "OpenSSL"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=ecb78acde8e3b795de8ef6b61aed5885"
-
-SRCREV = "4ca02c6d7540f2b1bcea278a4fbe373daac7103b"
-SRC_URI = "git://github.com/cisco/libest;branch=main;protocol=https"
-
-DEPENDS = "openssl"
-
-#fatal error: execinfo.h: No such file or directory
-DEPENDS:append:libc-musl = " libexecinfo"
-
-inherit autotools-brokensep
-
-EXTRA_OECONF = "--disable-pthreads --with-ssl-dir=${STAGING_LIBDIR}"
-
-CFLAGS += "-fcommon"
-LDFLAGS:append:libc-musl = " -lexecinfo"
-
-PACKAGES = "${PN} ${PN}-dbg ${PN}-dev"
-
-FILES:${PN} = "${bindir}/* ${libdir}/libest-3.2.0p.so"
-
-# https://github.com/cisco/libest/issues/104
-SKIP_RECIPE[libest] ?= "Needs porting to openssl 3.x"
-- 
2.51.0


