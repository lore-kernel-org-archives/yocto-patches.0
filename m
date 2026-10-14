Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D0ACC6B2A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:54 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14679.1791987166214122596
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=XXHtsaPg;
 spf=pass (domain: snapchat.com, ip: 209.85.128.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a02718da81so33617445e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987164; x=1792591964; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HwdAaloJgBiSFFmUMxoBXih6f7FjuB8LOLZxkUiaiEM=;
        b=XXHtsaPg7PxEem5OcS/pxQa8EufNipsnBsa7l+BsOAvCkeVLHPJI4OjkJl56X4j6x/
         +0TEj/+mNxgZRk3DdkaAhzJ7VgpVib+gv8zD9HXM0vvtOtXj67fZU/NVAMMv252b7ud6
         smTPQwcvHuTC5p2Tvp2103gZqi/SXpBaSY33c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987164; x=1792591964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HwdAaloJgBiSFFmUMxoBXih6f7FjuB8LOLZxkUiaiEM=;
        b=mzBC7Z4XdFL5qYIfOOxK2vor+qszb7f2qZwYHXvxSqXKN36RK+pG7XFBjYjj8GMn3l
         3isp2uzLx30mSH0WGdmaOwTFqio6zxuCcEPIj+UeN+XYiQOYzEWlnBdugkc1veU9hvDz
         vSZ5oSeNa2Ncv5qKM0KnXqcsnI47Pu0q0943EF6FEcWMJ8xz1Jtu+ISPeqt8k2kJsqvb
         zsr3rffk02qcAJkZNT8igXA594MlGxmnHI9l4VlcQCfXJ/Tjf8cIbP/8MuX+B6a6qbAM
         842Zm8kCTtXAftrSkonTCPfImyYQITRgoY3M+do3BgamK5uvDVR/QpPiV9WwzrnOnHsU
         rBOA==
X-Gm-Message-State: AFq9FYL01DT/cCjn5LqIqWdNsqHIBfspd5OE1M7yuez93oWQxtTMqmSN
	ISyKDOYQ6tY9hYMHb6DSvxwjznJBqNEmvneaPu/tFatmw9EN1Oc4UZVtTodfWvkrb4l1o8SxQ88
	XRhTJchQ=
X-Gm-Gg: AYBFou2RdhUDhRJCAZXxQnKwUGqBy/XVzrNBAaE8zSWK+LeDwGl4kvKu7DB0jIOxhF3
	TebqYT1PUxpDAy+Bp9xPBbY6UJZojb19X05c6goHFKa3xqDB/H+cTEgVvJ6DoOUEr8iwVlLKfVN
	ftPKo7DQbfLA5T/LcFlBr9ybinH2VNM8xjC26rTNElrmJLhD3IuGqcSWhZqh92xGvbvIcR5envw
	0AoTI2T1qLZrAWpjXiVF/UsV/3iKlPxnODTQp0rXtLX4D1QXZYS48vxNIWt+pl/8KxIeqAb5SiK
	uot7/BuHCBZU3BuynSoCmfJdG9gbEYdrQRDiEAsjR/KbOy9FnFKr6ZKZOYxTmjdeW+wH0dRAsfi
	+um/PTsCmB4CB8UfC1+rCA/EBVH6vFi6QjTNp9gBD+CX6bEtNOdwMISlgj32110/zc7yuXaQ5Sz
	Dif4OXMFlGo6qGTTjByrPJzKmvddVBCMKHTXRRpfwza6ERHu+EX7/0TnAqLnI+8ajikOJE7djmq
	LLMLX6Uq0HLuhGOA5mI543Kzjbj28CM2XdUdWJzwmT8Ewoyf3yi
X-Received: by 2002:a05:600c:46cc:b0:4a0:8b1:f5c with SMTP id 5b1f17b1804b1-4a18e4b583fmr317436515e9.22.1791987164347;
        Wed, 14 Oct 2026 07:12:44 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:43 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 19/21] libedit: don't include glibc's stdc-predef.h on Darwin nativesdk
Date: Wed, 14 Oct 2026 16:10:40 +0200
Message-ID: <20261014141209.488034-19-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5024

From: Etienne Cordonnier <ecordonnier@snap.com>

chartype.h includes <stdc-predef.h> unconditionally, which doesn't exist
in the macOS SDK or the Darwin GCC toolchain, so do_compile fails.
Skip the include on __APPLE__.

Tested by building nativesdk-libedit for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...don-t-include-stdc-predef.h-on-Apple.patch | 21 +++++++++++++++++++
 recipes-devtools/libedit/libedit_%.bbappend   |  5 +++++
 2 files changed, 26 insertions(+)
 create mode 100644 recipes-devtools/libedit/files/0001-chartype.h-don-t-include-stdc-predef.h-on-Apple.patch
 create mode 100644 recipes-devtools/libedit/libedit_%.bbappend

diff --git a/recipes-devtools/libedit/files/0001-chartype.h-don-t-include-stdc-predef.h-on-Apple.patch b/recipes-devtools/libedit/files/0001-chartype.h-don-t-include-stdc-predef.h-on-Apple.patch
new file mode 100644
index 0000000..62317a2
--- /dev/null
+++ b/recipes-devtools/libedit/files/0001-chartype.h-don-t-include-stdc-predef.h-on-Apple.patch
@@ -0,0 +1,21 @@
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Subject: [PATCH] chartype.h: don't include stdc-predef.h on Apple
+
+stdc-predef.h is a glibc header which doesn't exist in the macOS SDK
+or the Darwin GCC toolchain.
+
+Upstream-Status: Pending
+Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
+---
+--- a/src/chartype.h
++++ b/src/chartype.h
+@@ -29,7 +29,9 @@
+ #ifndef _h_chartype_f
+ #define _h_chartype_f
+ 
++#ifndef __APPLE__
+ #include <stdc-predef.h>
++#endif
+ /* Ideally we should also test the value of the define to see if it
+  * supports non-BMP code points without requiring UTF-16, but nothing
+  * seems to actually advertise this properly, despite Unicode 3.1 having
diff --git a/recipes-devtools/libedit/libedit_%.bbappend b/recipes-devtools/libedit/libedit_%.bbappend
new file mode 100644
index 0000000..75e63a8
--- /dev/null
+++ b/recipes-devtools/libedit/libedit_%.bbappend
@@ -0,0 +1,5 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+SRC_URI:append:darwin21 = " \
+    file://0001-chartype.h-don-t-include-stdc-predef.h-on-Apple.patch \
+"
-- 
2.43.0


