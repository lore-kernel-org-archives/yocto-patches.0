Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76E5C88E61
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:52 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48450.1789157632132306447
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XtioyBgj;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5306c3ed04eso16927201cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157631; x=1789762431; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P1gKlvUgUcCSKLFv+RUn0GYFsbuyNbZ/ktL/F6ETV3s=;
        b=XtioyBgjrSZFtFWJDlNBz4spDGiSuE7To1aMQNa21wkMzdYKL0QSENR1SqLkaAufbL
         Bc90So9xUw578HPpcLBUVl5HaDgFb4x0VC379aJKRsP0QTHZJBQTbQczOQdV88Si3SRs
         AljGAtF6YaMWY01FOtEECczvnZo8xcZ2cbsX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157631; x=1789762431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P1gKlvUgUcCSKLFv+RUn0GYFsbuyNbZ/ktL/F6ETV3s=;
        b=BhO+FVfnQLygMBymHxE7I7KXJjY1h6FriRi7J7yY7hsc1nKPeeRvRqyw3HpO3IUBWw
         Rw3Upnt91PO1OsciDDm9/+H6IsDtlSgPB4XEZwuirmPJHANiU2xYkQJHvULUx/qy9aKG
         pDPTy1WzWzxOCRco2gxPDQ05ZR3TPtRLUU+Ccosisha2Vn4WtD/G0eUsUE5ex3Sg1Pk0
         RE8yHxz5gFqdXGium4rGrsgIEERF5r5MBoC1ObkT48EWAVeS6os/SkdjASM6Wxfj2pkd
         6YBhShaleUn8tzrzTbIRLHqR4/Ts0CMhwXnv2Owkp2/7tFp2DrfykeEgUDA8UaYp8Jfv
         pfWQ==
X-Gm-Message-State: AFuF++kpovOX5VNl9n0NmwPjxeYUlQ/OjSmpO0JqWBYCa67eGqCbTQW0
	2giZ51UszR8G2SnXySx/FFnIJNUwpVnBRQAJE8suH9KMsnKjUC1cQCvwZivCAJo7uileT+Y/JpK
	uUUbP
X-Gm-Gg: AYBFou1Z4PgmrSRamPy2zd17kQzhWuoUfw4iGXrjl5yhXXBYf8d18n2dU8u++v4MUI2
	9JYyZ+CgnDssVNdmBBOQhUpuCcYXlCUYChWhHRN81L61c80BC9hAaPBOUfP9nNA9qHGgMDGJRrC
	jr8OLBnu5RrxliyCdXhN9spLkJ6WFnz2aebeEtONWn+32qud3orysSA03/+a+i4DkQRu0aBNieY
	1kaEJN63/wTBhGqRCA0DqwuF12bM3MBryFZkdSvHsnawbeQ6+D9MoWvpRLHCXKuNJrJ827QjhCE
	7a80hEsDk3PfLKuaNxtMTao3nb1u5q5VrtXAA1n3GcN64s7joiRURqjJUKeXGcMzcZE4oT7zpi2
	zDuv7B2bgNgJPKppjvj1ytYqS2VFLBHJCGLxdh+p3aLDUtB8Vi5E51a3FdUT7+9Qfio8klirrvY
	ttwsWwvBek6Xs0x8sb7y+zOioyoeXoO9vSP1vrvgr93bLxZ07/07I9Jo+RWYkHHrEzKeiGbwSN7
	EBgd9/Io0tr4U0ySZiUji53MAR/MLVU0leMDMyxGWfqn06dVpk5nOWVQI9f74tbXObkqW9XGJNS
	EjBWbVzZEkSemEJOCFLL9xSA6oVKoqjQNdw=
X-Received: by 2002:a05:622a:180a:b0:52f:f472:bad1 with SMTP id d75a77b69052e-530c8688254mr89548031cf.33.1789157630921;
        Fri, 11 Sep 2026 13:13:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 13/37] cargo: add missing build dependencies
Date: Fri, 11 Sep 2026 16:12:59 -0400
Message-ID: <8b4c62d88ebbefab9bcc4f32b460947d726d8b68.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4779

From: Ross Burton <ross.burton@arm.com>

Now that we're disabling more vendoring, add missing build dependencies
for libssh2 and sqlite3.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 85b7ca631be63a85121108ca8e0281fe218cc57b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/cargo_1.96.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/cargo_1.96.1.bb b/recipes-devtools/rust/cargo_1.96.1.bb
index 99cac69..b576586 100644
--- a/recipes-devtools/rust/cargo_1.96.1.bb
+++ b/recipes-devtools/rust/cargo_1.96.1.bb
@@ -3,7 +3,7 @@ HOMEPAGE = "https://crates.io"
 LICENSE = "MIT | Apache-2.0"
 SECTION = "devel"
 
-DEPENDS = "openssl zlib curl ca-certificates libssh2"
+DEPENDS = "openssl zlib curl ca-certificates libgit2 libssh2 sqlite3"
 
 LIC_FILES_CHKSUM = " \
     file://LICENSE-MIT;md5=b377b220f43d747efdec40d69fcaa69d \
-- 
2.55.0


