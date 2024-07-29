Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C5AC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 16:49:50 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.60573.1722271780100822177
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 09:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bmkNZthv;
 spf=pass (domain: snapchat.com, ip: 209.85.214.173, mailfrom: ecordonnier@snapchat.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc60c3ead4so20215085ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1722271779; x=1722876579; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txcsKK/ARhIGXiV2EvhSjdN+jDqnEdYrjCB583c5rXQ=;
        b=bmkNZthvq+VNmuecYFrK0Bzpk+EscRxoXzJjmd1CpdG4xj0OcuKte0FFOnhHwdIct1
         wxamrKcJdgXZKoCbxFRH8leUIcP3rOM8eKhC+xiuDV7vPPVo7eZYnV5z5CSR2ph9ZhDx
         hsi8i4iOKMtiTgqyfh1QWqcSZBBloiUiwZzXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722271779; x=1722876579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txcsKK/ARhIGXiV2EvhSjdN+jDqnEdYrjCB583c5rXQ=;
        b=ClZavS+6g6SxLdztLbo0VKj2ekoS+lHn9av8RvnfGGNKJ92qnusVDSgZ1IknZc1n4k
         UA9VcpMflxA4vGLzjhXtmViEsuc6UhmyN3q3ROJ7g7O2t+YCbl0n16ZKjL+VNM/24nwT
         5U5dnDTlw8okw03c1iUld6OqJLiuzMQoIgKtgisBOa+yB2DquUZqXL8z1EydKeAKlnAp
         beSc6W2NgOhSBp+iNMMW8s1PuEGDTizJ9S5sWvpSjcNhpDYhWzZTYaQo6aTOFKkCe138
         C+Q/Vc4OiINsr19vPJFI3PxXg3oO+gx40zZtD1OvZBsMt+LcxfetDfuHpcX+PtPBxaVV
         GnZw==
X-Gm-Message-State: AOJu0YyIHPpqv2+9EU0ipL7rQ/qOQ6TSOctF+ytq0ySDYEm4Gypyc+1c
	4jYb5Eq9gOSniP4g6CAHmf06WYdiiPIfdP94d57475fqm4nfK3o3UVpaVGNbeFYgIHV9xPMVoqt
	m4gU=
X-Google-Smtp-Source: AGHT+IEUpdcBJw/aOmpjQJga/45HlNUEoQ6nyuOSkoldelBSEvMhgk/3IeeOKLgaob4qLGM/fxm19w==
X-Received: by 2002:a17:902:c611:b0:1fb:81ec:26da with SMTP id d9443c01a7336-1ff049343a7mr51311005ad.58.1722271779044;
        Mon, 29 Jul 2024 09:49:39 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc8102sm85094365ad.280.2024.07.29.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:49:38 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 1/2] gcc: update to 13.3
Date: Mon, 29 Jul 2024 18:49:23 +0200
Message-Id: <20240729164924.145828-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 16:49:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/496

From: Etienne Cordonnier <ecordonnier@snap.com>

gcc is updated to version 13.3 in the scarthgap 5.0.2 update.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
index 687b5aa..2071fa3 100644
--- a/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
+++ b/recipes-devtools/clang/clang/0037-Fixes_for_Darwin_SDKs.patch
@@ -22,13 +22,13 @@ index f7da3f187814..0656f5cbad69 100644
 -                                                "4.2.1",
 -                                                "i686-apple-darwin10",
 -                                                arch == llvm::Triple::x86_64 ? "x86_64" : "");
-+                                                "13.2.0",
++                                                "13.3.0",
 +                                                "x86_64#SDK_VENDOR#-darwin21",
 +                                                "");
        IsBaseFound |= AddGnuCPlusPlusIncludePaths(DriverArgs, CC1Args, UsrIncludeCxx,
 -                                                "4.0.0", "i686-apple-darwin8",
 -                                                 "");
-+                                                "13.2.0", "", "");
++                                                "13.3.0", "", "");
 +      {
 +          const char *S = ::getenv("YOCTO_SDKPATH");
 +          if (S && (S[0] != '\0')) {
-- 
2.36.1.vfs.0.0


