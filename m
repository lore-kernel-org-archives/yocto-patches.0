Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A7C88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:30 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48565.1789157725389756420
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Jsk7blDb;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9105d241693so4274646d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157724; x=1789762524; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mednid1BXYN1aP3O42N9MgApBaXxEXZJJVMxKMxfNjc=;
        b=Jsk7blDbzYi76EL8sB8+kIg3VQj6qmz/4nYeKzzRn03H1PJPcWL6ivZAhQYDLyo/X5
         Fgt+QTNqknhTleBmN5KIbJVxxj/WA4UoaACEVDUPHxi0Up4O+oHvjkOG1MGesPJLS00y
         xMKcME8Nn10KHIjf/7/IzTaRWFJEySm+/SSaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157724; x=1789762524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mednid1BXYN1aP3O42N9MgApBaXxEXZJJVMxKMxfNjc=;
        b=pQPlwKPSBejwoZmiHBJeFT9begN/pNCxQa7n4IyacbgVa1E0ZpkAX0fJW9XDi9vdQ+
         l+dKAzkVPTKy7iHPWZ2MySjlzaCfKjIn8w4L2bg/hXX9vnF3j2Y7OVQ+unlsIYYOmEtJ
         tueoHEDKrrsmYmvuHXLG3FeDSRGxay4B4IEcSrk+UMgSTua3e5FIwSVeACHAgsqP1Qfr
         UBKwJkQpr81LEdHmdJbIbGoY103jIs3khLSwzU/KvP4Pp7Whd1YXyDfuco4N/oZW0zIE
         b0jdiG3eT6WZHX7wTdawq4QAaDusD6hHa81yYUevrkEXBU6e/cnw2ibbXrmy655rYBim
         Ltqg==
X-Gm-Message-State: AFuF++l0CgCqP0z4IGPl4DRR604S3JVzsu+rZRldjuU7zGZRJBGDCkpw
	2/8biMMZlfnc4ukBpSZL7ePWzgPS0UjRtrUV02gyAiGeHcPYtZDjiGz1iqgScmMQ8D8bAW3yOgy
	Q8sCl
X-Gm-Gg: AYBFou3yZtUgTHoqcgkYcACN7eIOY7huBQ6jzkYXXnxPZ7FvIesUpHEM8JL4VK0RoLs
	6QPzWCVZwCEAhpK5lqfCFloS3Pr1PE9Fk1D0HDtsBAOjmZNQN59KiZcynaFIt0eDrdli47wB9ia
	KcQHqXnH9r0PleAfmm81OBPxFBunjP90qx30qNH6YE3rOFrSGp2GZoebzD89a10mScZtcADBNQp
	scXJGjfTtFdSzEfk+h/IBgXmCU1OStEPRi6cy6Y+IECggGwTlLenG2bslF2EzctQtdfu7hhQoA3
	aZKpJZRjWMd5ms9Ep69MeaPD09XlbsdSVzgODJ4TXtRjuUm6MqXzZs5GM0SyGC+KpEWOLa/PxaI
	80dBk2IoDAe+dKxpxj6IrbDtlJZMVrnsFF1YSJsJ19rfAP9+bqaOJia244uT4DcMrMfdrhUc8uH
	byTezBIZ+4zerpTSLrPhizvStqe9DeYTQqtvDSy87Rb32MANOoHoz151yKRpR9Q3ujfWiNuiEFm
	MrgFTkB3gQkQwuedWSJCowoeYV8BNCBeYc9Uh7wYNBZW++hjYRba4P12gn2Hs7hteU8EgLnLKHr
	VcDK30pj9veD1xS7X6HE+u+InWwwYWg8VNo=
X-Received: by 2002:a05:6214:419b:b0:912:d20:9b1c with SMTP id 6a1803df08f44-91211fa9bcemr88045916d6.0.1789157724087;
        Fri, 11 Sep 2026 13:15:24 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:23 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 03/11] classes/ptest-cargo: add explanatory comment
Date: Fri, 11 Sep 2026 16:15:07 -0400
Message-ID: <4ec6c97276ef2f91e3f2b0a41dd43c7be0e93dd5.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4806

From: Ross Burton <ross.burton@arm.com>

Add a comment to avoid someone else in the future wasting their time by
having the the idea of stripping the cargo hash from the test binary
filenames.

Some packages, notably librsvg, build multiple tests with the same base
name that are differentiated by the hash:

  primitives-3fd9d71b0a55e20a
  reference-00d9b406d910a645
  render_crash-c88a2b880ba97e09
  rsvg_convert-b43bd2236753f43d
  rsvg_convert-eef250e6c0174413
  rsvg_convert-f70976dd6cda88b0
  rsvg-eec8e799568381a3

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c40a156f543789dc570c5cbbe0ea8c1b48e5af32)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index f4c881c..2e008b3 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -95,6 +95,8 @@ python do_install_ptest_cargo() {
 
     test_paths = []
     for test_bin in test_bins:
+        # Note that we can't strip the hash from the filename as some packages
+        # (eg librsvg) have multiple binaries with the same prefix.
         shutil.copy2(test_bin, ptest_dir)
         test_paths.append(os.path.join(ptest_path, os.path.basename(test_bin)))
 
-- 
2.55.0


