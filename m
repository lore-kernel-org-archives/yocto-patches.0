Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C75EC5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4471.1785497611040007552
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DwopjdwD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e6c4a867cso59405085a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497610; x=1786102410; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oD1XMAE1IXlNFCMMjiHolnCMh335NR6Uz/eXYbKhzY=;
        b=DwopjdwDxazf5Cl+DTDq+mPVNg8Y2kTyALIlaoT/uR6UY6uMRaA6z018UgmbjndWT6
         iYZ8XXK53lX4cGLqgkLkcDEF4JfdQXkAc01AD8Qf1YweJI6yY6LH3dFN9p2Y3Tyw41bN
         A/7WQgVJukcUNpBNwE8xNnZGLHhL43eEKZMtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497610; x=1786102410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5oD1XMAE1IXlNFCMMjiHolnCMh335NR6Uz/eXYbKhzY=;
        b=qYK+fygfT3HHTi6w3bjqu835PAYECKBBJb4VbHHTfUi1Lx/601p1x/VKXbrMcw3PF5
         bsB3g75cZy11FzLTApvjVc3nW0yiylRr3dpnqFMXWkFtB2EiuuCQG7c9WkNIvcumA82f
         3w22NeTZuYyRLuXibYYCAQaSctXdlybQ2Jc6pkXGXMAwn9YuIcghT1FnE8qyCCVXP1Eg
         Er//n28mNzJersBApReLocJRNiqm/fdIYBQbe78vK8iyE5+O9b3bQFFULWR5UAN1HD/P
         9XQjaoUkVhQASQ8URZFH6VchNvA6+qdhDs6icJaK5BSPSV14Knc/1L8WFW02wrR6HQ1W
         8VWg==
X-Gm-Message-State: AOJu0Yz08MpZeRrNcqP3W2AgFlNXu7AwQLBwPBo7BkflHFRiUJwh54U9
	OwD9LY+qkXis6AlSVcClj81m65DhRPhgAT6+FbD444kl0yLLqsPx2vo/Pksm2L//I+a0JW7fgmO
	NJSph
X-Gm-Gg: AR+sD12mCye6eko5LUW6OLx2+IX7f9cGwXnYos1G7O+Hr7Bbe23KkPgw9EM7Vo5NQ2E
	PyJn9+MmYwm84fnbUfBxIPqnMvyVYnNqsDrURQRnDK0KfSDBr2Ukry3uUv6jf0xWl6wHglwapmp
	2I9jwnYcsTJ0S6RgvWXUPYkjnKoydQ/pUT4lLZMKAK6VeDBm7LuF87DZhniL5dHgfmLpfXNrZkP
	jLaKDrYMCS8vD6g1EqZcr3lBSL6mwap+XRXWRDLrHUSMbJUTQnWHJX6qR1fmuwCpsZH1KBtoQXt
	WfGX25PFJuspffgs6DihWUJ33OLmU5xQOh4hN3HG/7yeiE+kZLiZmCtkKDduPI7lyYc0W+Vo865
	jF0j/uxnT44tGYMeqFPgLCyGk72BIMYpSOuX8ZWgldAbtuYIVuVtF4PiltuCCAwb1/Ez3PR2LuG
	OtZaEgBqFi+Cs0/t+JcRaaJPuPDyH7+UCLICxtOtKOlZcd3JCDCrBdtvj9kb5P4nEXZsdSE2juP
	gT8I36Sju1JV057aOJBMDm0wIiPW6hOTo3UKeXjQOGFO+tf0k0/08dhr4qv1c8NDE/1Af49vHqU
	93UsROzZL0BHc0j8nEsgRxJoxyGJbWU8e3b5
X-Received: by 2002:a05:620a:2406:10b0:92e:76a1:96d3 with SMTP id af79cd13be357-934965cfcdcmr163259285a.34.1785497609735;
        Fri, 31 Jul 2026 04:33:29 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.29
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:29 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 16/35] cargo: set CVE_PRODUCT
Date: Fri, 31 Jul 2026 07:32:46 -0400
Message-ID: <8f0c82ab82b38bb500170943e01a5ec309f76657.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4592

From: Peter Marko <peter.marko@siemens.com>

This removes mediawiki:cargo CVEs from CVE metrics.
* CVE-2026-39837, CVE-2026-39839, CVE-2026-39840, CVE-2026-39841

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a5cb71e7df95925a5c342c341e699e244b1b84f6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo_1.94.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/cargo_1.94.1.bb b/recipes-devtools/rust/cargo_1.94.1.bb
index 1c60700..64944ff 100644
--- a/recipes-devtools/rust/cargo_1.94.1.bb
+++ b/recipes-devtools/rust/cargo_1.94.1.bb
@@ -17,6 +17,8 @@ require rust-snapshot.inc
 S = "${RUSTSRC}/src/tools/cargo"
 CARGO_VENDORING_DIRECTORY = "${RUSTSRC}/vendor"
 
+CVE_PRODUCT = "rust-lang:cargo"
+
 inherit cargo pkgconfig
 
 DEBUG_PREFIX_MAP += "-fdebug-prefix-map=${RUSTSRC}/vendor=${TARGET_DBGSRC_DIR}"
-- 
2.55.0


