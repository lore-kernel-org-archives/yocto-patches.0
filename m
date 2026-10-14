Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D60CC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:54 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14777.1791987168826465266
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=W0esucdg;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso32403205e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987167; x=1792591967; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BguFgbvJhQu9z5QfsHL47E2+IjH37SY7kKXTlMAZMG4=;
        b=W0esucdgWr7szY6fH3dPeXNibbroPU09vrlP/dRinoGgVjJAmgapZka+L+XYtaLzx3
         aE/6mZZqISBXx7nM/h/yac6rQJaem7BkvefXQjpKnHWQEdUPswp8nlIXnpQk6bmu0V5n
         eqpwHgwaA0IP1rg9jn0JRMkttaLxeEeqEbCxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987167; x=1792591967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BguFgbvJhQu9z5QfsHL47E2+IjH37SY7kKXTlMAZMG4=;
        b=r++NNSSR7vJAXTiUEmUlFbwqqgieFWi7rKekDDFfd3k/N44o5QBnK6GEAPBUuOeof9
         +7ilH/4IftBd7P+xKhw82toVe0AtV14xt5+PnBRgUVXeaYTyl1g6/dpgCdQGy55+MJpz
         hhGlABK7aLG0rhc233FPpafrKks/fIKh6qi5ZMwUEWzUj/zcO+K4b8XmzJ1wdJhKbAVg
         s9sHO9iD446YUQdvvL/BFG063RjISjlMab6HppsO9nlX5O5X8kpzSRz8+7Opik8KAt+2
         Uw/Llk5aVs64hhVsKrpNgihl2zF98Qnk7mD+PRvypa60Nm69Obff0ReJD9nq+djzJ3K7
         udlg==
X-Gm-Message-State: AFq9FYJNCZVABYty4jOBKLNegsA9zBlme95Jq9NvJMLdVSefU7MUFStJ
	Hhfi8w2kABa7SXU5zIGmDOwkNxrlFHu9mjLhS7s8TZb+hW9wlIZ4UwZ9tYJ+Cto5fqTE5TZ2vLa
	Aj9NsU8s=
X-Gm-Gg: AYBFou1cAUC8cJx5TPNIf4btdUMLAOzdVo7QpN6yD3TJr//936AZuyLk9F99jBxH5UR
	NTjpAUOi142SYM1L3CG3Y7zJVIQbKG/Qe81ZCh48bOSiOy7avzcRDFXgxs+UozysCi0RBNT3Lqa
	Ag6dOWNlJQDbEj5DLNjcmo7fZJv0wqZqrN3ICszrhpVgYKsNycrUTiJbyPFYXC5T+ZDuB5Uzoh+
	NJ70c75RMj3a/iDAEXwughbWwdPrlwNBATbF3+J5LByaDR4OmddRuRqB8jpowscgQAEe7PhMR1n
	yo02lW7xhvuUQ/pbw+9V5jVh2kmImpb8QF0z4dWN6luSK/LH07R7CxkT75nn+kbtKEp9NB2fRZy
	6dUODxM3g9shq5GSfuvioahbjFY7l1nrakJreh97fiVw/gH9qA6DNASZMkgzuKxlj+BoTCAvNWX
	eHNSRpapyAK/2FbbHD9wg/Xt5u/s2X2oRnHdhpj1y0JvJwxElSYjQsB0P2FjUkSvnpaSAb4v58+
	xNVGnYFxTM3ffTd7oYZ96nRHYCqF9mcYn+G0Vymqw==
X-Received: by 2002:a05:600c:8b02:b0:4a1:6d2d:d8bb with SMTP id 5b1f17b1804b1-4a18e4a00dfmr337425605e9.12.1791987166891;
        Wed, 14 Oct 2026 07:12:46 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:45 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 21/21] gdb-cross-canadian: point --with-liblzma-prefix at the SDK sysroot prefix
Date: Wed, 14 Oct 2026 16:10:42 +0200
Message-ID: <20261014141209.488034-21-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5026

From: Etienne Cordonnier <ecordonnier@snap.com>

The PACKAGECONFIG's --with-liblzma-prefix=${STAGING_DIR_HOST} doesn't
find lzma.h and liblzma, which are installed below the SDK prefix in the
recipe sysroot, so configure fails with "missing liblzma". Use
STAGING_EXECPREFIXDIR, as already done for gmp/mpfr/mpc.

Tested by building gdb-cross-canadian-x86-64 for x86_64-darwin.

AI-Generated: Claude Sonnet 5.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
index 8d30ffb..ccdd43d 100644
--- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
@@ -23,3 +23,7 @@ do_compile:append:darwinsdk() {
 DEPENDS:append:darwinsdk = " nativesdk-zlib "
 
 INSANE_SKIP:append:darwinsdk = " buildpaths"
+
+# The PACKAGECONFIG's --with-liblzma-prefix=${STAGING_DIR_HOST} doesn't find
+# lzma.h/liblzma, which are installed below the SDK prefix in the sysroot.
+EXTRA_OECONF:append:darwinsdk = " --with-liblzma-prefix=${STAGING_EXECPREFIXDIR}"
-- 
2.43.0


