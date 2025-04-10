Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8FC3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 13:55:41 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.34773.1744293339423535376
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 06:55:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=TPOwP53J;
 spf=pass (domain: snapchat.com, ip: 209.85.221.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso465064f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744293337; x=1744898137; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnMmNbQiOSToYXf/zcJakacNwBkw7giuTK1bCnONiwk=;
        b=TPOwP53JSAgYKhg758IUCPd7YXp/Ae4kwA44zOker9K/UwSCLJ8pyxZFnRmJjEkXv1
         YqsycYAcyEGhE4vR2HwjxG7fnuh2dyKOljbJxu2nREqI9Q/zOdwYygqabBn4rUyHyEtN
         uDeXPjypBSOb4Mk8VSXzoxGmSYHLM7FtrDDkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293337; x=1744898137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnMmNbQiOSToYXf/zcJakacNwBkw7giuTK1bCnONiwk=;
        b=P5HjjzGYnt92YwTz2a9nXcLf0hnexhpBJM8m7dbMYUippjznb/KgLiJGRPss+N7vaJ
         uJfEjvSsV9cv8ee7ChG8bVgzcjS+tOMsQcO6PPblAYrqHVHAfei9nKLJKZ/UDWGOOxUm
         U5GDDe9PzfzEWEIudzrqA41djRniipnDUIzn5sSH5dw2qJvIejOyaHwiV6Nfn6sV1219
         OeBXn8lpoSVArnm+y2Kazy3P9qCTedzfDAn57BrfBstYXg4SeaXIabMN1X3kbMY92gwo
         ViuHNs2At6y+5AqLedMlDmhGyPGH2ZBxdqmNRimuUXpu2tZBnml75WQiNxLX46qZknfR
         P3wA==
X-Gm-Message-State: AOJu0Yysk75eNmdA5oYxh6G5MKKUUxplD6iFglXbGDVdDgeocSTBd2bX
	mwgnxm8jX976sEzf/DdMjg/QPSi72Hp+9YMIQCx0796Q/L0xE9RdQnWoErRgwl+7k5JzQYdjMaZ
	+QDc=
X-Gm-Gg: ASbGncuZKWmqTfMVp9C6TRyYVEqtbyIl8AwBBZoHC3eVHO/vMFYenlEYdmRNRrI0R2i
	ofadJb3lnKojBRhaNPpNX/Bp4vECTfGriz4MfoQfdWXmWV8spV5JKPHI9H+5L/N7sLtKs3Qlqmh
	KETGknpTGJbySOwRWAEAlx+wetqVfszmB8vT16QwiV/AvavIn098qgL4+tFHUTB29hPjA8gcZk9
	FgrYNp84fFE8WPFVsIrY4bwwvNd4Aj2k7b9hz724leaH0kQFlv++K0JDLN58MJJteQa3uzUcx8m
	r+HsJJJtcvOTNUqrlqPPkcHbmjEkO3jyPBY+55bMbY8HgMGf3xNvQKAm+sLEakci7Z8V5jYMSVC
	WXMupoWxEevO4eLBConQ=
X-Google-Smtp-Source: AGHT+IFExxyamKuglNj5JlXGZVEl/X80ULLbq5jQWG3CddtJ2xHIvvZE9AFVEjmiyJI4//RcZ0uMBw==
X-Received: by 2002:a05:6000:4023:b0:391:3d97:bd33 with SMTP id ffacd0b85a97d-39d8f4696cfmr2620190f8f.13.1744293337211;
        Thu, 10 Apr 2025 06:55:37 -0700 (PDT)
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c824bsm52560715e9.24.2025.04.10.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:55:36 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] ncurses: fixes for darwin nativesdk builds
Date: Thu, 10 Apr 2025 15:55:32 +0200
Message-ID: <20250410135532.21184-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 13:55:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1356

From: Dominik Schnitzer <dominik@snap.com>

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-core/ncurses/ncurses_%.bbappend | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 recipes-core/ncurses/ncurses_%.bbappend

diff --git a/recipes-core/ncurses/ncurses_%.bbappend b/recipes-core/ncurses/ncurses_%.bbappend
new file mode 100644
index 0000000..f64df53
--- /dev/null
+++ b/recipes-core/ncurses/ncurses_%.bbappend
@@ -0,0 +1,13 @@
+EX_TERMLIB:darwin21 = "yes"
+
+base_libdir:class-nativesdk:darwin21 = "${libdir}"
+
+do_install:append:class-nativesdk:darwin21() {
+    rm -f ${D}${libdir}/*.so
+}
+
+PACKAGES:prepend:darwin21 = "${PN}-lib "
+
+FILES:${PN}-lib:darwin21 = " \
+    ${libdir}/*${SOLIBS} \
+"
-- 
2.43.0


