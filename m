Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC84C88E60
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:06 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48529.1789157640733650887
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XClu914y;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5309d6188e1so3524061cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157640; x=1789762440; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mfZxLKYhGIKSTlnOIi39WaATxJPD2nbnvDxG9lcw940=;
        b=XClu914ycLBB28xBhvY2cSEhYFMsXKxgO95212l5UH5pg5IorxnZYvNlgqdOWNpUjD
         zYMgcJjNkvufN9F6zJ6TmfJRgqMZdE1VJR4B55LZiZa9oiwidozOoJrMxGJ36n9FNLL0
         5d4vJ/N00aisWMi2nkO9RJLXkB3yXrk0erPUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157640; x=1789762440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mfZxLKYhGIKSTlnOIi39WaATxJPD2nbnvDxG9lcw940=;
        b=ot6vhGFWiy1kwY/OJRcYFRXyhUPEe4o9xFaQFnCPwgwkFUr+Qunbx3l8nD7ZrQjDqL
         gfaFDx0+Hdy5yCCnsRA6bbc4pZwt2q9vfIEEWLSHFFVXHpzD777G3lA/9QS/k+wr74cJ
         WB9BxK91rLLph7g9RjPODI+Vt0jAetymfK4ZxUtYMHGW49iYfjbOMo1uX0b+4hApoDPB
         sL7sjv9mYT+AJIxAUnkUqZAWORguK12RNhw/HlaDmUYXVPiPzDFpXqMWszmmlO10BtnU
         8wGJHmEaYAO2DXbmXTyS630rqV/A6PMGqJlwud0RuYw9V9pxLxhTDuWFK2lZnIr1NwmL
         0wwg==
X-Gm-Message-State: AFuF++nPtm5nV96DKwVX38mukGUSKILqRRL9nKsOQgugMAz0LqXVwBth
	LiPz5Zo99ruC+zE1wLbuQBynkTB+tO/NdLwlq4fB94yGbA4uEhCpsr44SvkDRBt6sj8hE8+NepO
	zp6HO
X-Gm-Gg: AYBFou2FPA2ws4tbohtXMgyJuZKtCOXkYKQJFwpp6lgq5fBqqJZPQqr7qSUV1TGgK4W
	zw53d6npr1lieEj2+Mfp3rm8tigSbyo4Yug3GGuotA8F1OgtzvFHOjcgoWDF1f3kVVREBptQlnk
	WyZJDmRegPQW2ELtcHv0WPjs4OD+fHj/WmE6hsujTUzP5VfTpNLpYaIxYXhTO4tAF35/VmyTiYp
	nNO+KIYomP7moILmkPYJHvzlO9s8jp8EvDiT+JlwUpU9+0UIeR1mlipSbH/vtmNbDwH6j9g9vG9
	I9I/b5VXt7p2udfRYYLdvL72eiQveMNK4ufXWj4qT+56KSBBVIlZDnjvhNQzYZCKkhV+UYLvQ0Y
	5BQbhnP9kaK6lr4c47FknilwK80XHBrv9vFgVUQ9geYemmve+8RP49RmOv6Yl5FT2Fg3qrQMv5M
	j0OyREV4Cc+PqEbXAP2lrLdzRCOI/b9ENUOgBqMGUGzX6FtF4kZ2SvThTuXHwoQ1b0k6hdOcYA3
	Dafu1V+X1To2SBYuVMm6ulZW1/NIwzt3nJEM7f9HTg1gxVVKgSn1+bC4iq8TI1/BHMGNvfHsHX7
	Lk84ZZ16SFUDp1rrwwaL5PnlJGFCGw3e+s0=
X-Received: by 2002:a05:622a:a0f:b0:516:d60f:6438 with SMTP id d75a77b69052e-530c824865emr125100901cf.0.1789157639530;
        Fri, 11 Sep 2026 13:13:59 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 22/37] classes/cargo_c: inherit cargo_common
Date: Fri, 11 Sep 2026 16:13:08 -0400
Message-ID: <3de5bbab52eef8a0373a437f963124d821e757e1.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4788

From: Ross Burton <ross.burton@arm.com>

This class is an alternative to cargo.bbclass, and now the dependencies
have moved to cargo_common.bbclass it can inherit that class directly.

As cargo.bbclass sets B, we can set it in cargo_c.bbclass.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8130050e1191027c458191619b84627bb468d7f1)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_c.bbclass | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
index e91ee1d..18574b7 100644
--- a/classes-recipe/cargo_c.bbclass
+++ b/classes-recipe/cargo_c.bbclass
@@ -9,7 +9,7 @@
 ## This class is used by any recipes that want to compile a C ABI compatible
 ## library with header and pkg config file
 
-inherit cargo pkgconfig
+inherit cargo_common pkgconfig
 
 # the binaries we will use
 CARGO_C_BUILD = "cargo-cbuild"
@@ -18,6 +18,8 @@ CARGO_C_INSTALL = "cargo-cinstall"
 # We need cargo-c to compile for the target
 BASEDEPENDS:append = " cargo-c-native"
 
+B = "${WORKDIR}/build"
+
 do_compile[progress] = "outof:\s+(\d+)/(\d+)"
 cargo_c_do_compile() {
     oe_cargo_fix_env
-- 
2.55.0


