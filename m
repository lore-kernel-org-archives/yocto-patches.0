Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977BC88E5E
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:50 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48442.1789157624097668168
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=s8r31G6N;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd6so3637041cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157623; x=1789762423; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zsUnW74YwNSuv91S7h67X5uN5AUeqZeNf/QJQdiXwKU=;
        b=s8r31G6N6fgK056aJcJ6/PGqhYpif7EAHfWrgvydojqf0y1SdzBFkT+fKQTXEaoD2x
         zfiWCVjA43ugQVCntfisgvBAewjAteQ5Y8RwGAbCnOemVbVVVysGaK+DTqB2GbBRJPYr
         i/2lg6r36DKs3QDCH5uE6SDoLhbCqOHaZUYI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157623; x=1789762423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zsUnW74YwNSuv91S7h67X5uN5AUeqZeNf/QJQdiXwKU=;
        b=qx/5m9yjP4rCPpUtQk29/E2sTmhGrH1IgKAUOaLupC1DsvewxQRcJNE2xhSY3QcJcs
         dCzlaqgld2WWwMuvi9mFaLUCG/XHUHoVfVrs969juWns9Z5B/Iz19zcov/AFyJKv0txF
         P1+kUU7GvFM+G6h8WticzCg9+P/H1lhLWIFbqR9m6i8ISPUyVVZqxvXAHGmrHmrFyZTk
         IXTB6LuxAmx6j1ilxzuCEs1LXkNPzxsdeuzhHVJ8gSMIT/axo6hvpuhLiDpWt3sGSSur
         qDUkl43B5t+VqO2XKvcDdjXNHpV9BQLqv7a08cb4lgmqYywc+aOD4t+thppoys6Frhvy
         UqDw==
X-Gm-Message-State: AFuF++l8Tu/pPYSqQJttCvQLXwtdCMisMcsTyz/G6xnyqdJOx4vcSpf2
	AmzV7Jb6P8OG6PlAj5Ko2hlDsleImw2rpdHgsP/6LuM1m0zjb4b6yhbe9b1e9hy70dmS0TCCfTv
	d4FtX
X-Gm-Gg: AYBFou3cBueeRBaGNZ5PVxXgDcTI1yn2cD9cNTkAJTDQbYM/WwtdIlKocX1dWTVXy5r
	FzY8Ci+IW3wlVRJp8ZYDBVX4wSBKXLXyk+U9U10xD44cRQGuHOdxd+M0rQMU+alDBCqFdiwZ/Jh
	EUmOtoNc4Q0pDpbz/9kotB1ptKN4SF5Ue9DYrgEg0n/JnCT7MWRu3SQteco7pu2SF0ICrIx+Rf1
	jXK3+o0R5UnbXKbkXGp7t1214rfPPpcYMwc3x7VpFw75ZXhPqFfs39YD1r9tcdusBrZa8Pi3RVv
	LTI8T3pxVSwKK07IaW73DOr6X6ViUKakt5NfyMVg2Q8XLZheVX2/zF8A/DIYAbxh/5CFI/0ZB9W
	Ehjgf74F6/kf/XnSVDOEdPIMrntZzqYhyZu/8muytMhbjpsusH+sgESndojC+Sc+itEsDUeVZDi
	7FYmAuE/GJxR17lAzwgqMGml8TUH0y6QTobP6q+Xd8aemlh1CNGRt69Ack0y1MB++g6UpcODlEP
	O8QL9Q9bNocGAtXqkIWu2GJPp7xA7G2PUqvK4UO89mxHCl0gxQJVdYW+8b3Ks9DZh9gAmlj1LTo
	04g7CXHzm08Pe+PFlsSz9qnsKvqpHGf0/9E=
X-Received: by 2002:a05:622a:c08:b0:530:e36d:1855 with SMTP id d75a77b69052e-530e36d205cmr22547311cf.42.1789157622928;
        Fri, 11 Sep 2026 13:13:42 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 05/37] libgit2: backport libgit2 1.9.4
Date: Fri, 11 Sep 2026 16:12:51 -0400
Message-ID: <652b2340e8b7a7bcf241ad7053d1dd3735fe8bdc.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4769

libgit2 was not included in the original set of backported packages,
but cargo-c does depend on it, and 1.9.x will be required going
forward.  Backport the 1.9.4 recipe as of openembedded-core master
branch commit d4de7d0256 to serve as the starting point for future
backport efforts.  No other significant packages depend upon libgit2,
so side effects should be minimal.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-support/libgit2/libgit2_1.9.4.bb | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 recipes-support/libgit2/libgit2_1.9.4.bb

diff --git a/recipes-support/libgit2/libgit2_1.9.4.bb b/recipes-support/libgit2/libgit2_1.9.4.bb
new file mode 100644
index 0000000..dbd60aa
--- /dev/null
+++ b/recipes-support/libgit2/libgit2_1.9.4.bb
@@ -0,0 +1,25 @@
+SUMMARY = "the Git linkable library"
+HOMEPAGE = "http://libgit2.github.com/"
+LICENSE = "GPL-2.0-with-GCC-exception & MIT & OpenSSL & BSD-3-Clause & Zlib & ISC & LGPL-2.1-or-later & CC0-1.0 & BSD-2-Clause"
+LIC_FILES_CHKSUM = "file://COPYING;md5=8eacfdc17c8f4d219e131a073973b97d"
+
+DEPENDS = "curl openssl zlib libssh2 libgcrypt libpcre2"
+
+SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https"
+SRCREV = "f7164261c9bc0a7e0ebf767c584e5192810a8b24"
+
+S = "${WORKDIR}/git"
+
+inherit cmake
+
+EXTRA_OECMAKE = "\
+    -DBUILD_TESTS=OFF \
+    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
+    -DREGEX_BACKEND='pcre2' \
+"
+
+BBCLASSEXTEND = "native"
+
+do_install:append() {
+    sed -i -e 's,${RECIPE_SYSROOT},,g' ${D}${libdir}/cmake/libgit2/libgit2Targets.cmake
+}
-- 
2.55.0


