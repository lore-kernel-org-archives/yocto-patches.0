Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ECDC5B549
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 13:24:39 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.51753.1748352269801485623
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 May 2025 06:24:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ZmJL/Ncw;
 spf=pass (domain: snapchat.com, ip: 209.85.221.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4c9df6f92so2790566f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 May 2025 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1748352268; x=1748957068; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG0boyf7Hue7eafwqq6dxkLmbvsL4YDw5Aams1MCTS8=;
        b=ZmJL/Ncw6pDrlP/fplK0x86phNDP48oZjJMtL5Z23/ww314cqljNE9ijm0UWBG9FHs
         QjmZEFZyeyUBcJgR3THa46lNkCXlshws/83WywBMt4UKLg413XzbAHqQIayNHpMx+YtO
         otKWcREh0yZNTqHIqpyha97RYzJhlOjWGtjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352268; x=1748957068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gG0boyf7Hue7eafwqq6dxkLmbvsL4YDw5Aams1MCTS8=;
        b=hVC6iodNpHEl6xqxXkO1W/Pvco5TFt5mqgevbIRYjqVqoWhTpfXon2SyMe1GfL72g8
         dPDspo8NfQJ3TLLYa8uzgDiIQb0AnMAP0jGZQl8Cxuu7fPcgXMcKxJT+ZgSV32RMK0nk
         4JTv+8OXUDzQT//6eciHZqyD5GOqh8pirw3+NIyPGhCB4L9rzbaSTZGtZHn1nUpwhFD9
         Oddhmf5ZNFsTfZ1Gg4mTmAiLI4nHdVuPRqHxrgSlNQAIewzRa1vPORTB30PgycQESkxv
         tYIPdw+4FsWP5aZNuYxa0v2WbjZGBGjeGaQVMzsHzq3+uUt+f4TTfWqN8arqEsLRD8JS
         kYxw==
X-Gm-Message-State: AOJu0YwpF+aE47DOEjILtgEj+ZFtkQGrpf5BHOnMx47mC9Hp2f68CGTV
	O7JzLr6NHZN+EBQjtlGBiOuGWMedD2dhoXKpz5q286jzWzahzQ6c6niRrcmVCm6QvY492nHfYM+
	PUoS0WY8=
X-Gm-Gg: ASbGnctKTd1U7b/vuEIKD3uChxYTqXYjSd6iHK2Lckx+JLXWeiQ5x1qt14iULOrK7+G
	YvjCKLP/Stog305HN93FZjxUJt+SeL2+/LzIWTfLTC3KmINcihWL3gSsKT58o2IJt2hCByK4KDw
	ByRz2Bj3upAcaShp+yHGuLDOfJgHfljREmyEKo6cdE9Qv1OX/GeK6xw7fiIu9r5SyQKPQdxbZh+
	AgGActEYkwG5Erk5wbuWQLFRFzsyp3FLc6d8pzt0MZHQ76lZyqDqIh8gyy3xVTGbdwRERguwQIT
	AEyuVRcDLhQsdWtyLfWt0OO5VYYJHabsxspi5PlMndTX5OUF2+7jbYERjShlGev/
X-Google-Smtp-Source: AGHT+IGx3jv3+Oxgdx3rzLetInsAooPtF0sqeGY4J1ethECxOd/ejSLLegYz5j4wleFugpJwh0WE8g==
X-Received: by 2002:a05:6000:2503:b0:3a4:d048:124d with SMTP id ffacd0b85a97d-3a4d04812ddmr10605117f8f.26.1748352267983;
        Tue, 27 May 2025 06:24:27 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d437f961sm7843506f8f.17.2025.05.27.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:24:27 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dominik Schnitzer <dominik@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 1/2] gcc: rely on loader_path instead of rpath
Date: Tue, 27 May 2025 15:24:14 +0200
Message-ID: <20250527132415.2160472-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 May 2025 13:24:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1580

From: Dominik Schnitzer <dominik@snap.com>

"--disable-darwin-at-rpath" causes the "loader_path" to be used instead of the "rpath" for finding libraries.
This allows to use the SDK without calling the relocate script which is changing the rpath values (LC_RPATH on MacOS).

Also add "Signed-off-by" line to aarch64-Darwin patch.

Before:
```
$ llvm-objdump -p ./sysroots/x86_64-pokysdk-darwin21/usr/bin/clang-18 | grep -A2 -i libstdc++
         name @loader_path/../lib/libstdc++.6.dylib (offset 24)
```

After:
```
$ llvm-objdump -p ./sysroots/x86_64-pokysdk-darwin21/usr/bin/clang-18 | grep -A2 libstdc++
         name @rpath/libstdc++.6.dylib (offset 24)
```

Signed-off-by: Dominik Schnitzer <dominik@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../gcc/files/0101-aarch64-Darwin-support-gcc-13-3-darwin.patch  | 1 +
 recipes-devtools/gcc/gcc-runtime_%.bbappend                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-devtools/gcc/files/0101-aarch64-Darwin-support-gcc-13-3-darwin.patch b/recipes-devtools/gcc/files/0101-aarch64-Darwin-support-gcc-13-3-darwin.patch
index 4599f52..23d36b3 100644
--- a/recipes-devtools/gcc/files/0101-aarch64-Darwin-support-gcc-13-3-darwin.patch
+++ b/recipes-devtools/gcc/files/0101-aarch64-Darwin-support-gcc-13-3-darwin.patch
@@ -6,6 +6,7 @@ Upstream-Status: Pending
 aarch64 Darwin support for GCC 13.3 from:
 https://github.com/iains/gcc-13-branch/
 
+Signed-off-by: Iain Sandoe <iains@gcc.gnu.org>
 Signed-off-by: Dominik Schnitzer <dominik@snap.com>
 ---
 
diff --git a/recipes-devtools/gcc/gcc-runtime_%.bbappend b/recipes-devtools/gcc/gcc-runtime_%.bbappend
index 7f61e92..ce9dd1f 100644
--- a/recipes-devtools/gcc/gcc-runtime_%.bbappend
+++ b/recipes-devtools/gcc/gcc-runtime_%.bbappend
@@ -1,5 +1,6 @@
 EXTRA_OECONF:remove:darwin21 = "--enable-clocale=gnu"
 EXTRA_OECONF:remove:darwin21 = "--enable-clocale=generic"
+EXTRA_OECONF:append:darwin21 = " --disable-darwin-at-rpath"
 
 RUNTIMETARGET:remove:darwin21 = "libmpx"
 
-- 
2.43.0


