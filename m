Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCDCC55174
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4592.1785497610211214301
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g1iNggnj;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e7c6ec9dbso39145985a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497609; x=1786102409; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JpzQNh219afLZHEikB/rh1rnGvH410OYsM9SU/PtGj8=;
        b=g1iNggnj88YE/fTfbszIT4zu4GHi5O6jE6YscHIFNT230hgrul1lLVJoygDrQe4SVD
         PWJFN1ZjsHpnP4CSf37MT3Qn4ciijyF75bVFnZHTvd7snHQn14dVVX6iIKd7o54dqGCp
         WRAL6lLqib15dPn1dfSaIs1jFRjSjMgikZkpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497609; x=1786102409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JpzQNh219afLZHEikB/rh1rnGvH410OYsM9SU/PtGj8=;
        b=Bux6UmnPD0029wpjgzq9ilhL7G7h4A8pU33Nb2YsE1L9O3+sW+xSMyuQ+ZRWifQLj6
         K4uDddEJd8CMG+Tmw5yWFo9LVayEWKf2O+lF9sBQDkSS9aQQh4u+Xa0W+ZDaL+enm9lM
         2jc4VuqaQMhiE0yx2HuV4u5R+AXuZibbGtu6ym9f4gwg6Fw4XozsIEeYlBFOYbQf4Q+7
         wHuOsfGKg7UrjlLDQ+uw+iDqBFdZV341CHEli87zqrGuGNMiWd1hYLHHoTHoqbCQ9yye
         TKuM+2lKj95GO9zpkhT3ejlaytbcyKr0A2lIrn+Iw6kHVGwemp4DlyXMwoHOXYtAFT2y
         lvPQ==
X-Gm-Message-State: AOJu0YzH9wspA5vltQ0wdKjZXOpjXpdEpTyfXLEuqXRklSWLpPHJAQWx
	MPLp/8jvFVnoH8NMxGg2J38HOADiA1NhUlBC7K+sJ/Sdbp9GwsLP7SQ7Cy9Ogm/+sqs88cuofC3
	jtNbJ
X-Gm-Gg: AR+sD108zSkcWwg2BEpvvxzapaNRdAcyMjcdvY8xldaJmCQ/zLjlrYyho0gMpbg1Dpf
	s+iZxc8LsZhu/C1quGef3CFNlx0Gz+XG83UGc+VPb2LWKsLY3hagseH4WSoOnMp57U529i/F/iy
	LLGPXGMvMvFZmgGuPkK7rF47KZP1AYJO2f5oNWGx3byKnfr6SHJtg89aA8GFXcZQX21EWPRKCwF
	KcqJHXRT0jcmvsSp3Tbyn67+F4Abj3OoDWhPkOwzB8MNwnMARwRSMfTKy9ThYRt4Pk2QUV/38lR
	wg3w0X6/xUDid5yQNVtdJ8YU48/WV3V8zMqw3Z+9hI2ASzR/IS3kPQ8iFhwnB6sJzmi+TnYbfyJ
	2jNfuM7vylooCGnHIlxWKtFtMv1PaZbEEah07Pcbc5L9veqaYgxOdYkG8A8Tm/Ceyq9vf0jjwEu
	dLwWdiMkZ3QlBO3m8LJ+Z23HmMK6lE3vBku52lMu2dTXblGdQwe5bL7NTuomLUv3MPC1YKASBAJ
	0qJoO6WINB6zhd09if3TUZGoc9GfKF8mcZ6YIptNKPdWel4N1L6rKXlPKzMmk37JWsE6LChzzP0
	KSFcrVFZRdPdGkTMH0QnjoXCCg==
X-Received: by 2002:a05:620a:a189:20b0:92e:fd2c:6a21 with SMTP id af79cd13be357-934965b0fc2mr169391085a.27.1785497609036;
        Fri, 31 Jul 2026 04:33:29 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:28 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 15/35] cargo: set status of CVE-2023-40030
Date: Fri, 31 Jul 2026 07:32:45 -0400
Message-ID: <93193b19559efdbd55f6992cae982f0b98f7f76e.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4591

From: Peter Marko <peter.marko@siemens.com>

sbom-cve-check has problem matching version 1.72.
It works only if cvelistV5 is modified to indicate 1.72.0.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ac18fd10e777b4ef688b7075c47c616e9405d752)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo_1.94.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo_1.94.1.bb b/recipes-devtools/rust/cargo_1.94.1.bb
index a6d3f17..1c60700 100644
--- a/recipes-devtools/rust/cargo_1.94.1.bb
+++ b/recipes-devtools/rust/cargo_1.94.1.bb
@@ -84,3 +84,5 @@ RUSTLIB:append:class-nativesdk = " -L ${STAGING_DIR_HOST}/${SDKPATHNATIVE}/usr/l
 RUSTLIB_DEP:class-nativesdk = ""
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2023-40030] = "fixed-version: fixed since 1.72"
-- 
2.55.0


