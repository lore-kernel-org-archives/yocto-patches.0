Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79DC44524
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 16:02:41 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.946.1784563357364327331
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 09:02:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gFVLlqCh;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so3060570a34.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563356; x=1785168156; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=evuqXNXDbOUNerizgkFLvurK/AacWw480izJnaeIcBs=;
        b=gFVLlqChnVzuU+YMC22hu5WDptdjgrwVtkwaE4cqU1xTSvP+h4aFOAxQxt619x6N1x
         Os3w6MO/Z0BRlxkr8AaBmFK3Q3SWTspPcGAv0jFRYTJczXUNRGJnbMAt4YSNNqYygwVp
         2gJM9uY90rfV55f2WTYTGZCpFkO9Sew4/QcwGsn+fwep+9fKZj3CBDeu248mRZ+erDyG
         iNnG5vlByiUW4KysryKl7wKhosKTllZqaxyw0YaZXJUQf50fVRTES1vpLi8IPKBIx0rS
         TmejubeEYJ5AHcguj6FqJnSeWGf5lkEM5tdhFpPONldgYz9MhL6OueqafG6EItZW7H7p
         NHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563356; x=1785168156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evuqXNXDbOUNerizgkFLvurK/AacWw480izJnaeIcBs=;
        b=oQdHD0276nMHhOme59yiH7+6GI38VZQ1z02xuogukqplLQNsuT4JbkJl+KNQnSaCXI
         +APcjkSMMsax0QhCc+GbnOgaGE8waiJIbNl3TbxFZASZ8t5fzyrflYtHIWplQit1wsf5
         /xyfxCKzXlJ4ROAPjp/D44YzOBRPEfBBO31IKct8GLZhy2RBIWSpve3H8FoddnvKjnu1
         yDqmBt8o2Bx6V88g+MsO+jZgWOWv85V6ybst6mGkNY2D472gld7yN3eTykY5Qz0VqvG/
         goNsU39FqsBEUF4FFLNciMtqxf5OijZ60GSdNB1PCQuOgEO39H19KyHMeczXz6cZBm+g
         h7aQ==
X-Gm-Message-State: AOJu0YzLHTNhpZba3MO62b8ZHWBscC2YC5JaEGQCQz92JPx536BgX0gN
	cXv8rU+89siVQtonJMGZgYS3KPcyYlk5dUtKNR9uO3OWhonD4Bt9n3PRvJqA2w==
X-Gm-Gg: AfdE7cma1bul2XTpba02HxSVhFshwvzTi5WstYQaM+My0oEgp1PakqHftGuW8k0ZlJM
	GylTm+/7SnZomPGeImFeyqUBdHtmq3ctwFqICZOeRkUzivxwLPgeaNjVepHB8tK5FB1hu4/C8D9
	Hx4KqxC20hxDjrSf0VoPCB4bowHfecBxFgMM9sME+nUvvgBwH0QKfkyG86WDlbfA1qDXnHB2Rao
	Cr1COQsocYzZ4pm9zOgkUH+DdcCbQhQFULK6i2V58PQAO6iFrRjFXXwgep7Z7TJiQh+MHoUvmmi
	7Y/7IFAf8yOM2AUII1D50LUqLIZRe5mZ5l3gilXZAK3zge0ssglAXxJXcAare/H2Ko7chxw/7lR
	K6HROaKEhKpGXbS1e3CzmKh71OCoGybs+OjyZLohTz9WGOARzACtWfuxDV/Uiys8wAyU0pB/Qob
	k=
X-Received: by 2002:a05:6830:8382:b0:7e9:e598:8fea with SMTP id 46e09a7af769-7eda08eb8b3mr7210559a34.19.1784563356306;
        Mon, 20 Jul 2026 09:02:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::a8bd])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad91b479sm8221002a34.4.2026.07.20.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:02:36 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rong Fu <rong.fu.cn@windriver.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][wrynose][PATCH] mingw32-common.inc: disable meson exe wrapper for mingw targets
Date: Mon, 20 Jul 2026 10:02:25 -0600
Message-ID: <20260720160225.535024-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 16:02:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4522

From: Rong Fu <rong.fu.cn@windriver.com>

The meson bbclass uses qemu as an exe_wrapper to run cross-compiled
binaries for sanity checks. However, qemu-i386 cannot execute Windows
PE format executables (.exe), causing meson setup to fail with:

  Executables created by c compiler i686-w64-mingw32-gcc are not runnable.

This affects all meson-based nativesdk recipes when SDKMACHINE is set
to a mingw target (e.g. i686-mingw32), such as nativesdk-dtc.

Disable EXEWRAPPER_ENABLED for mingw32 to skip the qemu exe wrapper
since it is not functional for Windows targets.

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 conf/machine-sdk/include/mingw32-common.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index bf3f14e..6014c51 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -57,6 +57,9 @@ DISABLE_STATIC:mingw32 = ""
 # disable security flags
 GCCPIE:mingw32 = ""
 
+# qemu cannot run Windows PE executables, disable meson exe wrapper
+EXEWRAPPER_ENABLED:mingw32 = "False"
+
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
 
-- 
2.54.0


