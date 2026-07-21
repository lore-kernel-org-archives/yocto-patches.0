Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A2C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 20:16:42 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32876.1784665000571256247
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jul 2026 13:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Pf6QiC/r;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso8895842a34.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784665000; x=1785269800; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6iO8cHD7R1M8sXWFVqhzjly8fVNUJ4o4XgogQTsKcc=;
        b=Pf6QiC/rI2fTUXXNWo9pJwRgKaXA/by1JfTouiXnJ1z1mO3Pn7T+0M6/irLaD5aQmT
         N1+SWvKRr92ybEdNWJgwWf4px1TBVqClJaBmgJoStalqAUw/0BickpjsGIz6IUrAVij6
         9z2Rl+mBDfDbBG/wFX/3w6EOYzXKyc4h0lSBBJPIYSPGAdFIwdwg6t7USg4J0Gh/Q+tT
         s0LONSBkCcqrsAvxbKXj5eNj1eHV65WNzjD5mqF7xdt+yHS2KxpfM0ch5jJIavUQd/ZP
         wlt3GEueYgEp7jIlABwzuXRSxurIAhN84HxkuM7J0qWTc4N2/vS6DwG8G8kDdDq7YpZ3
         H4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784665000; x=1785269800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6iO8cHD7R1M8sXWFVqhzjly8fVNUJ4o4XgogQTsKcc=;
        b=D9H/sBCEsfPirhBMlJQMDxTkelQyaMimr3s5IBq70kllkgHkCDvlo/Ws0flgpDiujr
         luNpwLpgOhwbsTr4ZGOAdJ35iijYJUEyJ7YPVlr/VwDCXdNN57QnjpTAIsylIL2j5LxS
         mda0InBWFuT4b0I0VdkFrg27xc8VptD00bWzearK3Cz6sCJXb2m/RGSYgFze0srKyhEl
         6+ocjSqk2+YDkXuBBeYb/vLdoyJ05JZ5FWjYMzwzskjeu1PO9PjFcsLsDciQScZLYCRR
         EWBYKdGwZhkbS/0pK2XJpCVEtLQHhnX5tXLvIIDAVLmCWI8klJK8LqZw3EFvPhF7Bsxd
         JkVA==
X-Gm-Message-State: AOJu0YyZ6RY2FOAWSb0gE6UoHkW52ZGR/mKsc/pzIMcZ4Lex7uZoWjqB
	iSifxosB061h4FbNdpE8qDoHWeCMEvYJDw+X4+PBFRNl7jTtMrUfSL0VEvdMAw==
X-Gm-Gg: AfdE7cmYxOtXMpLkTLoUrWr93JU1INa6TKhEJXrulGJkiq4SsdBKTUx8Me9OyCs54em
	V0VxKpro96SePC3niNT+5mu77+XtWewmNKpRoiLizwEbYEVGxMigwnM55JxYNNy8LBdGNWXm1jk
	U40qavC9WgiRk47i3x5qRl0hrDRVvgrFZhWDAG0L7/4vyOWPNN7ztTg88dJd5SK3mtoAf05V94F
	+3Lk4QKR+wT+s8fwOrazp8Kd0Yg9XBRT3bJJpR9iRiLBXtDkR1p4sXG3NP+tEmfvN+UL4RUAEPj
	D6Sy0dcQCYRV+mw/lF/ZL50K8YlgeurfKpOKFncwjFpq+ue5XLQtS329We9talsJD9MSSohdw2q
	chAvORIDu78CTqQVjdrRPHCorRVUJ8A1kal2ZqTRZObJxDHRSQZSC56+m/qLHaGqAfa7EfTe/lA
	==
X-Received: by 2002:a05:6830:398d:b0:7ec:5899:cd6f with SMTP id 46e09a7af769-7eda097a615mr11135229a34.17.1784664999653;
        Tue, 21 Jul 2026 13:16:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::d8e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee24743ac5sm353174a34.6.2026.07.21.13.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:16:39 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] libiconv: Update LICENSE expression
Date: Tue, 21 Jul 2026 14:16:37 -0600
Message-ID: <20260721201637.1636702-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 20:16:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4530

Updates the LICENSE for libiconv to be a valid SPDX Licenses Expression

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 recipes-support/libiconv/libiconv_1.18.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-support/libiconv/libiconv_1.18.bb b/recipes-support/libiconv/libiconv_1.18.bb
index e4e6a62..52b61f3 100644
--- a/recipes-support/libiconv/libiconv_1.18.bb
+++ b/recipes-support/libiconv/libiconv_1.18.bb
@@ -6,7 +6,7 @@ SECTION = "libs"
 NOTES = "Needs to be stripped down to: ascii iso8859-1 eucjp iso-2022jp gb utf8"
 PROVIDES = "virtual/libiconv"
 PR = "r1"
-LICENSE = "GPL-3.0-only & LGPL-2.1-only"
+LICENSE = "GPL-3.0-only AND LGPL-2.1-only"
 LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
 					file://COPYING.LIB;md5=4bf661c1e3793e55c8d1051bc5e0ae21 \
                     file://libcharset/COPYING.LIB;md5=4bf661c1e3793e55c8d1051bc5e0ae21"
-- 
2.54.0


