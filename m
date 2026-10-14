Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FDCC6B2A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:32 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14668.1791987150420807605
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=V9UVJLwu;
 spf=pass (domain: snapchat.com, ip: 209.85.221.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c45111bebso2570801f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987148; x=1792591948; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvxa7TQz62dHobAm0nrVApA/uBl/bdWPYfchBOwW+C8=;
        b=V9UVJLwuxdgpN2QGcupuyVdTqs4yO7y0ON2CJ/W4QZVMjSwkOCKxI5gT7niBcebzdE
         UeGwbWWZTV8Ba5BIHqsQnVkIjHfgM+OhDvdnQwfWVNtlbv/nGUI/joDPkH5H05RGnzYT
         M6XnDnRnMk/VZTjx+Cl/pFCCsUWuCmqSnoa+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987148; x=1792591948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvxa7TQz62dHobAm0nrVApA/uBl/bdWPYfchBOwW+C8=;
        b=DPCz3J+rSU2cOtOJNGcCEWKbSb6pQr7mgeGViMCUXBIkJfdcebGl0qcayd5TddkMnd
         VmAacRLEzLQx7yHLgYkUYbX3pZlUY1DeZ5RwNdbeo+canj/exUr73cHGwJc9xO7wtzCo
         M/cxW7jJsYb9GYPdInJ1CS1brd94fd1qGKDzoPAVsoXFVq5wXrsyQ1UpMUOJJnkJw4ow
         1ezg606xcxfPMKkHQJXpz0RCCdCD6l28AoGvKscXZXDQpmTHQ7kFsCpt2IdoyJS9EAlk
         JphaxlVdXCpccowimTp2KzpnjvzKBe3yhk0SjL3jNu9URkKwQsHXbVxfjnxZAbi7sHa1
         kgHQ==
X-Gm-Message-State: AFq9FYIH+0hQ/FCo7Wizr5SJArPPNpRzzD+IEmYBkGL6ts3LKtC8+iLp
	qcXs8J0PtuqsymZj8FOHugQ/GLh6yh+zam2R93KWMCO4aNxYYai7VNsvrijpSlMrMukq811fECU
	mSZZJ0do=
X-Gm-Gg: AYBFou1RwbP0VCb9X0gYVjdN6Cg38Jj3coWUcZZob5asOf5aiMx0pXLm+ne7rc41fvc
	0AlZm1+FS7qbSzcXFJDExdRHu/HWeDaXfbPPJBFs0pVitxQ5Whukd04jyFj9UGD58quELcuhAnW
	a9xfvOZg5rXzNwvxmOt0ZA3RsbODmHAW5HtLDN3y24+u/QpMBOTjSTVMbpGxwyQtrlAFqhAZP2K
	9WpcFUx86h0zOtwcm5bApOA6Ti3KpmPqVg+3crvDjmWwMPx/fGPLl0LwXdRjgxbySJLjJJXF8lQ
	1tKfGnGtuwzZik/2p0Rlbx3Qcvyvbv9tIIoxyGSarpEwZvhmtFJLQ4tInmPrA7br/s5uz6gw0R/
	tp+Jm6DyJKqTmiylZLVXSBzkTq7nNjze4mTShLL9yDs6UItYFA7kM6lvJqGHlelyH+g503yB8Xc
	/1ALQhY/nj3va/sbAaiDApbTzGHC8MkzKh4W2JjUnFinm32mV0S7ZtGE+7WwuuXX7MBMzTFIYUe
	JS6OAqGhQV49qH4WCLh2tqsDbmhl0qjmlmoBoH1pQ==
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr331108465e9.9.1791987148264;
        Wed, 14 Oct 2026 07:12:28 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:27 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 04/21] automake: drop obsolete Darwin bbappend
Date: Wed, 14 Oct 2026 16:10:25 +0200
Message-ID: <20261014141209.488034-4-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5008

From: Etienne Cordonnier <ecordonnier@snap.com>

OE-core dropped the equivalent 0001-Drop-ar-u-argument.patch upstream
(ar no longer takes crD there), making our own copy of the same fix
redundant.

AI-Generated: Composer 2.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../automake/0001-Remove-ar-D-argument.patch  | 30 -------------------
 recipes-devtools/automake/automake_%.bbappend |  5 ----
 2 files changed, 35 deletions(-)
 delete mode 100644 recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
 delete mode 100644 recipes-devtools/automake/automake_%.bbappend

diff --git a/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch b/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
deleted file mode 100644
index 6e27448..0000000
--- a/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From 862a7ca3269b54a595051454c6fbb3c45688d929 Mon Sep 17 00:00:00 2001
-From: Etienne Cordonnier <ecordonnier@snap.com>
-Date: Sat, 8 Jun 2024 22:39:08 +0200
-Subject: [PATCH] Remove ar 'D' argument
-
-Poky patch "automake/0001-Drop-ar-u-argument.patch" adds the argument 'D' (deterministic mode),
-however this option does not exist on MacOS.
-
-Upstream-Status: Inappropriate [OE specific]
-Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
----
- bin/automake.in | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/bin/automake.in b/bin/automake.in
-index dbcf47c..0f2b84b 100644
---- a/bin/automake.in
-+++ b/bin/automake.in
-@@ -2678,7 +2678,7 @@ sub handle_libraries ()
-     }
- 
-   define_variable ('AR', 'ar', INTERNAL);
--  define_variable ('ARFLAGS', 'crD', INTERNAL);
-+  define_variable ('ARFLAGS', 'cr', INTERNAL);
-   define_verbose_tagvar ('AR');
- 
-   foreach my $pair (@liblist)
--- 
-2.34.1
-
diff --git a/recipes-devtools/automake/automake_%.bbappend b/recipes-devtools/automake/automake_%.bbappend
deleted file mode 100644
index 4820dd9..0000000
--- a/recipes-devtools/automake/automake_%.bbappend
+++ /dev/null
@@ -1,5 +0,0 @@
-FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
-
-SRC_URI:append = " \
-    file://0001-Remove-ar-D-argument.patch \
-    "
-- 
2.43.0


