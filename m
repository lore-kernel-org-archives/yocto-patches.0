Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FDDC5516D
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:55 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4603.1785497627158496356
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=C7ns7vxB;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5b048375so43968885a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497626; x=1786102426; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ByXF7c4MB7oT8FmWNBPuPZGrYjWCLeltF36HwX4GFug=;
        b=C7ns7vxBDpQh+Xa7FNOtK7tMJpSfjjIiqk48o8fhGvSklENiQK1aTtUEcD75jSFdSx
         5djho9PUTBwW3ElC8ygSboR4hjeX85+ii/L7umGhDiTQDLeyef3vYevv36DdZqTX3syw
         0bPDaZVdZIm9VHI2yhc4moWDmyA/QCQaWRmYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497626; x=1786102426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ByXF7c4MB7oT8FmWNBPuPZGrYjWCLeltF36HwX4GFug=;
        b=U/uvTAcaiw7Vj/SBObVMFDQ6eN/A5qBitYeYk/3Lk4s4l0VdssOMGxk0FqNzfvVQIx
         /YZYjFIPNTgE13X3CI7n4oha7+a7DboNxqhCCE6KgldyzDo88f48pswnIZXiC9iX9l96
         4/AFnW7Mt5TZ6Q97UXzGWvPSH4/wGNhAuw8eSI3avZwAj8L559Kv5FGlMAzGi1CSBxd0
         wyOK7rLAqS3z70fMGFhsWyioRtrINmcesRkuKTOavj/q1igRV51FJV7Bf8b/UNbr2jRG
         dHQQWC8LAhZ5re6s3xxtS/ED3F97LBVq+il48V938YGOrEj8VhZZt7WdZsk562NhGWwD
         maRw==
X-Gm-Message-State: AOJu0YxT+UYnyPOQkaslr33RGRqGdaNmw8XrUm/zljfeyeGiWgczpO45
	35CziivthDFH8PulH4vUEGXZNBw7yx6WxYr1jBwURkL3Rm82K+GznHha4bj7R8vITbnR044kEmV
	950fR
X-Gm-Gg: AR+sD11+l4Kf1KeSls2MX9yubE2ntofYxghJ/ei4bWsNhRU7f+pMDduPqOFbawPu5/I
	umobLcBd7GB0TEd1FU1hyY1Zg5wynXJpalT+s3I8pVuQ4Gu2sl4q5anzxQ1rakUlYKVB/cHTU1e
	f73xjwrFk0eWSXGCRFm81pWazIOpQq8BQiBalkm4O1GUU8aT2KcmK9dwJTAZpNfDFc21aL5y58D
	rVvFxQfJV6B3DDBDlDA/5vQPI/SVBM9f08X+zT9Zulb6gxX3WdhVBHSt7UbXKjnuEcuvigS/YfX
	yFNgK157cZZO8IGY0JUI4xtnxnyCASNng9zaVqVfGWZPis84TPmZTIFz86E/WtIC8SkgJvVTf+M
	3f9muVRc41LLSor0So1+5VlX+uzQTM2t2Xt5955GN3T9GtyqdwPZFPWIT/mp3YNiKxXN6LADkTr
	6pZSZGKwAPPxWLjr8jwPrDVuek6Yt0GjLj+tWZTuJPE8qCRtxP1soFrGvN3uSk0G+bawSDi0YJi
	KNUM+Fm0EQwqNQqbY5Y2ibjKQdsOxp1Tn2fXcNTaCVdkRs44M2Tg0COg+j4CjdbBHO9FEOC5N+N
	Ins0w5oztlf79K8sGeZCa1kmNA==
X-Received: by 2002:a05:620a:3726:b0:932:fce7:dc66 with SMTP id af79cd13be357-9349787a4ebmr178632485a.45.1785497625532;
        Fri, 31 Jul 2026 04:33:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 33/35] cargo_c.bbclass: pass --libdir to cargo cinstall
Date: Fri, 31 Jul 2026 07:33:03 -0400
Message-ID: <c0864a356599d1cfc58d2cbcba2e8e3d7c0e8439.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4609

From: Taruntej Kanakamalla <tarun@centricular.com>

cargo-cinstall defaults its libdir to <prefix>/lib since the class does
not pass --libdir. On configurations where ${libdir} is not
<prefix>/lib (e.g. multilib builds where baselib is lib64), the libraries
and pkg-config files get installed into <prefix>/lib, causing do_package
QA failures (installed-vs-shipped).

Pass --libdir ${libdir} explicitly so cargo-cinstall installs the files
into the correct directory.

Signed-off-by: Taruntej Kanakamalla <tarun@centricular.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ce8b2340e4a3fd146bb632898e196438505650e9)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_c.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes-recipe/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
index ef43163..e91ee1d 100644
--- a/classes-recipe/cargo_c.bbclass
+++ b/classes-recipe/cargo_c.bbclass
@@ -35,6 +35,7 @@ cargo_c_do_install() {
     "${CARGO_C_INSTALL}" cinstall ${CARGO_BUILD_FLAGS} \
         --destdir ${D} \
         --prefix ${prefix} \
+        --libdir ${libdir} \
         --library-type cdylib
 }
 
-- 
2.55.0


