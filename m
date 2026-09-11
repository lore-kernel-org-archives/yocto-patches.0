Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06DC88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:13:52 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48517.1789157629066691808
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hqPXlzPN;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52f83889a93so15764581cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157628; x=1789762428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y7gXJJFsU6O3mh1Ynggzs6R2bdyiHhD8L3EE66XCRbo=;
        b=hqPXlzPNaxhV9st5UJfvg48UHsNO1qYWoz0fwTxyYunnPFbAD6LOFjx/uycGQJcDru
         k+4n26IcqGrBlKqff2Xzg93GDDTa6dlwnDfMIwRkA0n7+R/9aJBsW+mo/mABQfK+Qr7+
         EuoSsVCUaAxIW3DGPwFLTAN2FJKvhQ2j/PHbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157628; x=1789762428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y7gXJJFsU6O3mh1Ynggzs6R2bdyiHhD8L3EE66XCRbo=;
        b=J8qGn+ST/fX3gqxwoQhdGAC4r0OpflED9ukA7BCVlW6dSV03n0NxMuG+REnJsNh++R
         jp2LRk9XfRjJbOs72ArkNjNsdrj+/JEAh2hSsfU2wkjlAHTmuX1Qbiw8nq1NPDeOXx9U
         FhEIOqI2EdHDA/xhaV3+iJcndoNRTk1sRuBQDwgZsBl3yWU8fBOW3CxZOHYwxn8ccA+E
         vwcsOXFIGNihMjy0XDJvwdQzP8lQoD6qTDhZBs6E6PpYSFlioKDc328aZikg384WLhu6
         fgggdJwP0C9S3yPygD7H3sVLXzZV72y55uTtOkEUhehaJcXHurky/nmK/WMiTrbXWi+5
         +YQg==
X-Gm-Message-State: AFuF++kgq0IdpXvlzjhY9IpHVFHLMs2EpLh3uEJX7hRiXwKJ+YXEXJC4
	qrlQqAb2j6yudSAqoxhJoAACRwBpmX6JGS2lruhem7Gh08byIYfbXBXtc9mVfY0AKEIyFEivGtR
	WQmRS
X-Gm-Gg: AYBFou0qhxd/Dsb+dfi5yGzfF7yvOVUf2Nf2BSxdiSmoV7mRmIDErqIPbEPOjDGlZab
	xLC9R1Ai3o3UtGlf275jV/X0Rt4gySGUD/fTBhhHyJx1S/BS0Pam4lHuPjZE08Pbr1bde82DNxv
	odBPBZokK2iA3cW05r/Pw5H5SGbNdXQSPjKpwVjziAhrZlrHct6Ny12mPRxchbs9Btdnz/MdiNJ
	62NhYpUY0uMTq7YCXllyHeCvy3CuFEmMQqLgYJi5OpvRK97R2A9SePLJE7VUp+f/kcgl+4OWM6E
	LDPjRA7kIEkat5lZ4jqIba8A15w8HzfmWc975zzmok37vfjPu68dLT7IsS7n4OSROPwblaO6uV6
	42rmYGh/l0XNLKUETKWuUmgtMKA7ecZj766VsrcqoXcvyg7AbNItoTyUYBVOgSt6JQdYqF1YUTY
	2Wo3YubroRQIVy9EXKexe7IKp1yxs5BAZtFcEw9twZKW/JI5BVcATez4BN2L7u49XeNeX5HeXBK
	Pb2iD5jsz6wTn3PPRv9snoWQolJMzoHAq4c64f3fqecwxGvtm869+UKj3zye0DE/48zrHqBfo+M
	BGGjSdQJ5veEH2jt9tgQfEUDdt78nszmURs=
X-Received: by 2002:a05:622a:1e10:b0:530:de20:2bdb with SMTP id d75a77b69052e-530de203e9cmr42767451cf.29.1789157627885;
        Fri, 11 Sep 2026 13:13:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/37] libgit: Add nativesdk variant
Date: Fri, 11 Sep 2026 16:12:56 -0400
Message-ID: <8d06910dc82ca5c8ee337687e2aa702a1479eb0c.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4776

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There are cargo/rust components using this rather than inbuilt copies of the code
so add this variant.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 015711096d4d685d92b952d593810ec23451e6cb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-support/libgit2/libgit2_1.9.4.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-support/libgit2/libgit2_1.9.4.bb b/recipes-support/libgit2/libgit2_1.9.4.bb
index 900e078..f81cdaa 100644
--- a/recipes-support/libgit2/libgit2_1.9.4.bb
+++ b/recipes-support/libgit2/libgit2_1.9.4.bb
@@ -20,4 +20,4 @@ EXTRA_OECMAKE = "\
     -DREGEX_BACKEND='pcre2' \
 "
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.55.0


