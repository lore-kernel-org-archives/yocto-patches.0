Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DBCC6B2F
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:55 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14775.1791987165228611580
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=eoLn96+y;
 spf=pass (domain: snapchat.com, ip: 209.85.128.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso29223945e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987163; x=1792591963; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lg0d7lopx1sRbQGDyk+rYGFiIm4+d8yXVKU006qTceM=;
        b=eoLn96+yejXYqXYagfguHK6KMjrhQIwLDNv9vUpGOLxRtCCudOXvBjydfOMdmEGOvD
         eRl07qxrYXu4+LAxqFLs2cd0EZvY5UGjaueLvwkv48trZQP7+6jd/m97/qQgUleyYT4Q
         nHMttiGb1YJbSjZdL1plOF30BbENk4bANBdB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987163; x=1792591963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lg0d7lopx1sRbQGDyk+rYGFiIm4+d8yXVKU006qTceM=;
        b=T6BQ3Dk/aW08f+Z+vH3javV7OURaVXdbbq0KJIq2OcjDL5zQ9xqIXWeCraz/dfrz3G
         DSCI3RkSMmeSYbjuxVuG41D7VPDjvZwxlNVdorxer0H7PoTr3JPRU4vSuXbPFT4zmoBW
         yungT0tj0daXe7gwKZiMcNVEHI+Z3vDDhanFSpALmzFmHsD5Uk1pz0YYITzCjlheBrMu
         +gkosdxx618DPuZV0YY8UvxSjNRGTrQJRsiSbyIj5c20lGiOOe3FD4sqWKf18bqbOjUK
         Qinrv3Ji+e/cWvMKXVFX4Mydp4TgGqYXK5JJ8ZQcqrZ9N6yzwY+HgXk7ZFKO8GITkvvF
         9olw==
X-Gm-Message-State: AFq9FYJgdMTdIghhLlJCl+XxvWy/wednOsjJ3ZC0PAbfmT5ff76mq5b1
	P2W+2dAWW8a+2KfM7X37RvKovtk6psEIvc96FBpmuaqNno3mK6K2NpgSo5UmgNE47xsW716ylgo
	lAxxgO3I=
X-Gm-Gg: AYBFou2aUq977TD4Z0dgAwliAvMe7Rbwdoj5zTeCPQvCODK6MV1nwI3ykrlG8wHCIyS
	COeX6jxengm+7XObDILCQWYuua1D8j+qYwLE327cR5WXcCHg0WePgH/pqMwPjYiA7ediM6dOphd
	UDoyT9ai8YfassTycBRw042a20VNVgFtByoyHml1vPSMIJydoOLIIAQJpPgGpsZSHtBtem37o3H
	yLV41/dH6OIHHUr5aCibvSlhrkj5qk1+QWaR+zLkPrqqlNoGElZwYR8nbl2ds1sEA0rhiKAsTiz
	hz9OY6F7kG8+Ohd9UVtyyxMrLO331Ot6c8xFrM397UWyxqMwIzvvZ1C1B022dQNhKAWDKEDyEq7
	lRxIKcfFBdkiyCAq9noDWWUwfm+FQV1n45DMCyvXtJtWK8DWKRM+TU7kYE3lzvT2wlUfVJ1qaAN
	IJ5qmVBc6OV/JF165kcZKTVXEkkUmmNwKj4HhYH52efrTwcdTMeSaF4+2MsiDXdeaGuYCRJFtnc
	zXloBBg9RyBeRegkGZrrDRwJHz4Xbd5kvGlJBGKSQ==
X-Received: by 2002:a05:600c:3e05:b0:4a0:2391:6540 with SMTP id 5b1f17b1804b1-4a18e4cdbd0mr297988205e9.25.1791987161769;
        Wed, 14 Oct 2026 07:12:41 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:41 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 16/21] darwin-common: don't treat buildpaths QA as an error for the SDK
Date: Wed, 14 Oct 2026 16:10:37 +0200
Message-ID: <20261014141209.488034-16-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5022

From: Etienne Cordonnier <ecordonnier@snap.com>

OSX_TOOLCHAIN_OPTIONS adds absolute -L paths below TMPDIR to the
compiler command lines, which then end up in headers (gmp.h's
__GMP_CC), libraries and binaries across most nativesdk and
cross-canadian packages. Handling this per recipe doesn't scale.

Tested: nativesdk-gmp and nativesdk-ninja do_package_qa.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/darwin-common.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
index 632c6b0..1e3f03b 100644
--- a/conf/machine-sdk/darwin-common.inc
+++ b/conf/machine-sdk/darwin-common.inc
@@ -86,3 +86,8 @@ fakeroot create_macos_img() {
    bzip2 "${sdk_img}"
    ls -lh "${sdk_img}.bz2"
 }
+
+# OSX_TOOLCHAIN_OPTIONS puts absolute -L paths into the sysroot under TMPDIR on
+# every nativesdk/cross-canadian compiler command line, and those end up in
+# headers (e.g. gmp.h's __GMP_CC), libraries and binaries.
+ERROR_QA:remove = "buildpaths"
-- 
2.43.0


