Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A84C021B5
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 13:15:06 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.web10.15377.1739366100479411178
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Feb 2025 05:15:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=avK5dbdk;
 spf=pass (domain: snapchat.com, ip: 209.85.218.43, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso1331949466b.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1739366099; x=1739970899; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LH+o8//hws0+62lTexIHyOnLTS+vCMVVdVELlzXliNw=;
        b=avK5dbdkQ2j0rgjxUEk2vU7HNRY7ke9w5wX9TcZ3najtgTNmnsy7eDvn/tdwnBxeQQ
         ETAerGxCEGeAhMZbvTB+S4qZSp8lPwMrubydSfEd3E2vSD4E7zEGL/t8xxKpFlIgVc7N
         VPyqcBvcBjyUvnGvg3BCCXoyOVycSiGJRrtXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366099; x=1739970899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LH+o8//hws0+62lTexIHyOnLTS+vCMVVdVELlzXliNw=;
        b=eSPpK1hxJa+TvTrTKDDXXX8wPTrPBoTHldUmzksHj6HX3XjC9GIuPwByeUWI41PlEC
         b9R2y+sokXZOO3ZHxzgJMq2PxK4xX/V1WZRsOkSLKvMqkFWDMTeR8xdKiKWdREY4PbH0
         nZ1tSn+G8dg1Qw1F+GWVJzCx1BbK89jmCcNGEiDJUGUpE7BbiFl4UMcb0XmCZdekmKxR
         eEQfmNl3CCLRVogMtCwTFi2SjLc05mw6CQqvLaGSU2NHORySpVfjixzezrDcALHoEwbX
         03m/IHengzhP1yXcdJj7+3VlX1KI4bl6NNFABvfpSLam/SK4m7H7J9doI5nAxoZWhg5w
         miGg==
X-Gm-Message-State: AOJu0YykWgmgj9G+/QsCLqNANClq1c5elh9v0LGl3W7SUJjv3428fDsz
	LI5f7+oGatqXGavycsq/DvViHA5t0EE20b8yt35DzzxvQ9ee4/3GZkNrGlKmZOD7ymWBh8wZhiL
	9
X-Gm-Gg: ASbGncsQQw6XpFba/K3VV/KMLsLG6eXshpB1wtZRyCO19VmTx9QPisfHS2tl0n2s67U
	SBBEcVQWq7W4l4V637ToN1aBcL7cnOeUTaVvNJ/DJ+SOLySEyByMuuWg7Gphph8AzJvfD+Xg8J/
	9fU9gXDY6AM7CPh+D8P1BjzOgzMABVkDowON9wmzZTKQKNr2fVqVufYvd9//hlUe7kkjR/ji8ub
	8pcgHvxMcHLjig6+s5n5sTi8QdZ0eMydMa9r2zjX/Rwk0/huTlAeUi5VbLZe4UXTtfmr//WJSrr
	HU+dLBV3fsPwLK0MgN+HTblaJrLZ
X-Google-Smtp-Source: AGHT+IErRuiqLuqN2IucYakTYMJEfEwz0ewShPuX5sb4yjlaSrjZF5WfV4cuCTCve2YAcG0rKuwq5Q==
X-Received: by 2002:a17:907:1909:b0:ab3:85f2:ff67 with SMTP id a640c23a62f3a-ab7f339c7f8mr332611366b.16.1739366098547;
        Wed, 12 Feb 2025 05:14:58 -0800 (PST)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4e96185sm715320966b.86.2025.02.12.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 05:14:58 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] binutils: remove nativesdk-perl dependency
Date: Wed, 12 Feb 2025 14:14:55 +0100
Message-ID: <20250212131455.4094351-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Feb 2025 13:15:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1079

From: Etienne Cordonnier <ecordonnier@snap.com>

This was added in scarthgap 5.0.6 ( https://github.com/yoctoproject/poky/commit/e1958af36c9bb27f683b82a13e91f17f4cb64858 ).
Add this workaround until there is a proper fix.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/binutils/binutils_%.bbappend | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/recipes-devtools/binutils/binutils_%.bbappend b/recipes-devtools/binutils/binutils_%.bbappend
index 03e4ceb..e0868e9 100644
--- a/recipes-devtools/binutils/binutils_%.bbappend
+++ b/recipes-devtools/binutils/binutils_%.bbappend
@@ -15,3 +15,10 @@ INSANE_SKIP:nativesdk-binutils = "debug-files"
 
 # nativesdk-binutils's libctf doesn't compile. disable it
 PACKAGECONFIG[libctf] = "--enable-libctf=yes,--enable-libctf=no"
+
+# perl tries to call readelf, which does not exist on darwin (it would need
+# to call objdump instead but the detection logic does not work for some reason)
+RDEPENDS:gprofng:class-nativesdk:remove = " nativesdk-perl-module-bignum \
+                                     nativesdk-perl-module-bigint \
+                                     nativesdk-perl-module-math-bigint \
+"
-- 
2.43.0


