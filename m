Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E2AC5B543
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:23 +0000 (UTC)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web11.12380.1748486535828827846
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DeoBcuSP;
 spf=pass (domain: konsulko.com, ip: 209.85.210.194, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso444512b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486534; x=1749091334; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G27VnDS9f032XVtef3svsE7ylQYmg5L4KPgji7my7s8=;
        b=DeoBcuSPTxg3rSbCVCjUUC6JdT42/s8UBGe/nRgrt1J5tvL2Zl50d2FaNjidq5rr3d
         h+F0UiETlm8GjD1sP5WH6CUIfYkqbVR4XWOzSFTwd6OJC50PN/BvsTlXx37CYE32Wba6
         WL/vY7gmmIWMv6/hv48GjdqC1tOANaK5otiYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486534; x=1749091334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G27VnDS9f032XVtef3svsE7ylQYmg5L4KPgji7my7s8=;
        b=S+iK3La9Pe+VqHEVrLMgXY0xyDhZC2lwyrfHOMBIKud2mvpUPa7yRt8c2MkNulqj3C
         YMHA8R3Ar1qLPuMvqYBZIi8Icay1uCbPcsrfXgb4Ednt0lauSB6cOCy48VbiNHdOkn39
         k3IlcZgb8e9/RVbjHFiXLn2blbz/lIxDz59t6Z40dLre3kSvwmfryuw9ZXUvGokm2Edt
         9izvjaQvgWB/TPpzwLw8/kB06oS0oP+WdRyOiBQ1Fh2ZwmP8w6xiZ7Tug/9+k1qedOJi
         YM4aoO8CqQpM/utwAdtw/4LB44i1jGR4rkmEoLdPdOGHmFtj7woT3T6xvjdvdJgEVpLB
         uwHA==
X-Gm-Message-State: AOJu0YyTgM7Mc8sFViXB/JSWAvIE30zJmsZQP+wmDUQzRd7/ghj9A8vW
	al6F/CT/YiDFeSHuKhQ3xJXjVnGKSRBZlunIAbVYIdjr1Dy6FzNcsV734/7/vEalfoWdfAGPEr8
	UuR/vMz+X18VV
X-Gm-Gg: ASbGncuvJ0wo0Z7i8YAv/C71d4FBgJQY6XMGU0EiSeVlqBeqHu0hi90/0lnLAbSF+ZZ
	efuj8iifotYSgMUuNOWbMu5KDDckbJUSp8byTEj+mbEhWA5R1IaftPTdjg5R9Yh6VrmB7l9Fc5C
	EL+VQpA51af7oPgZ3poqd00NkTQkK3B5RsSf3YbXfp9/DqOuL1itnBHT2Y2CF3wV9EUiL68Ig1m
	91x/AUnPgaTnlP5ANqs3G9+Tc5LR7SYwlmeyFsY3q9Q/2blC3o8UADT9ANGiMACzfztSju3qTqD
	5bTVCMynRgzVv472tr48RIzYYMA0Ou7jV67npLiaHdbCGF2y0gk+YJ68ZpxztIbc/1LC3ShXZhQ
	SvIZC0XrIg82L/9E=
X-Google-Smtp-Source: AGHT+IGhSC5GehuVXIGdMdwAr1CZik+6aB0vNI0q4PLoQbo/YyGKg1s9YtjNks+UbCSznTn8Fc+FPQ==
X-Received: by 2002:a05:6a00:3996:b0:740:9331:78f0 with SMTP id d2e1a72fcca58-745fe0700c1mr23783225b3a.22.1748486534526;
        Wed, 28 May 2025 19:42:14 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd4208sm309040b3a.140.2025.05.28.19.42.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:13 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 09/11] u-boot: upgrade 2024.10 -> 2025.01
Date: Wed, 28 May 2025 19:41:36 -0700
Message-ID: <e9a44729f325a75bb11d45b106a06155aa1c3c36.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1593

From: Fabio Estevam <festevam@denx.de>

Upgrade to U-Boot 2025.01.

Remove the patch as it has been upstreamed.

(From OE-Core rev: e16a24f04b56ca3fec6509a3286e2e3bb5c21c1e)

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 ...bfdt-libfdt.i_shipped-Use-SWIG_Appen.patch | 60 -------------------
 recipes-bsp/u-boot/u-boot-common.inc          |  3 +-
 ...ols_2024.10.bb => u-boot-tools_2025.01.bb} |  0
 .../{u-boot_2024.10.bb => u-boot_2025.01.bb}  |  0
 4 files changed, 1 insertion(+), 62 deletions(-)
 delete mode 100644 recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
 rename recipes-bsp/u-boot/{u-boot-tools_2024.10.bb => u-boot-tools_2025.01.bb} (100%)
 rename recipes-bsp/u-boot/{u-boot_2024.10.bb => u-boot_2025.01.bb} (100%)

diff --git a/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch b/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
deleted file mode 100644
index 2eeef99..0000000
--- a/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
+++ /dev/null
@@ -1,60 +0,0 @@
-From e093607e9a08e9c29b7bbaa6aeb137036db798a6 Mon Sep 17 00:00:00 2001
-From: Markus Volk <f_l_k@t-online.de>
-Date: Wed, 30 Oct 2024 05:46:00 +0100
-Subject: [PATCH] scripts/dtc/pylibfdt/libfdt.i_shipped: Use SWIG_AppendOutput
-MIME-Version: 1.0
-Content-Type: text/plain; charset=UTF-8
-Content-Transfer-Encoding: 8bit
-
-Swig has changed language specific AppendOutput functions. The helper
-macro SWIG_AppendOutput remains unchanged. Use that instead
-of SWIG_Python_AppendOutput, which would require an extra parameter
-since swig 4.3.0.
-
-/home/flk/poky/build-test/tmp/work/qemux86_64-poky-linux/u-boot/2024.10/git/arch/x86/cpu/u-boot-64.lds
-| scripts/dtc/pylibfdt/libfdt_wrap.c: In function ‘_wrap_fdt_next_node’:
-| scripts/dtc/pylibfdt/libfdt_wrap.c:5581:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
-|  5581 |     resultobj = SWIG_Python_AppendOutput(resultobj, val);
-|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
-
-Upstream-Status: Backport [https://github.com/u-boot/u-boot/commit/a63456b9191fae2fe49f4b121e025792022e3950]
-
-Signed-off-by: Markus Volk <f_l_k@t-online.de>
----
- scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
- 1 file changed, 3 insertions(+), 3 deletions(-)
-
-diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
-index 56cc5d48f4..e4659489a9 100644
---- a/scripts/dtc/pylibfdt/libfdt.i_shipped
-+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
-@@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
- 			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
- 		buff = PyByteArray_FromStringAndSize(
- 			(const char *)($1 + 1), fdt32_to_cpu($1->len));
--		resultobj = SWIG_Python_AppendOutput(resultobj, buff);
-+		resultobj = SWIG_AppendOutput(resultobj, buff);
- 	}
- }
- 
-@@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
- 
- %typemap(argout) int *depth {
-         PyObject *val = Py_BuildValue("i", *arg$argnum);
--        resultobj = SWIG_Python_AppendOutput(resultobj, val);
-+        resultobj = SWIG_AppendOutput(resultobj, val);
- }
- 
- %apply int *depth { int *depth };
-@@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
-            if (PyTuple_GET_SIZE(resultobj) == 0)
-               resultobj = val;
-            else
--              resultobj = SWIG_Python_AppendOutput(resultobj, val);
-+              resultobj = SWIG_AppendOutput(resultobj, val);
-         }
- }
- 
--- 
-2.47.0
-
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index fe3afb3..fc86024 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -12,10 +12,9 @@ PE = "1"
 
 # We use the revision in order to avoid having to fetch it from the
 # repo during parse
-SRCREV = "f919c3a889f0ec7d63a48b5d0ed064386b0980bd"
+SRCREV = "6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
-SRC_URI += "file://0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch"
 
 S = "${WORKDIR}/git"
 B = "${WORKDIR}/build"
diff --git a/recipes-bsp/u-boot/u-boot-tools_2024.10.bb b/recipes-bsp/u-boot/u-boot-tools_2025.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot-tools_2024.10.bb
rename to recipes-bsp/u-boot/u-boot-tools_2025.01.bb
diff --git a/recipes-bsp/u-boot/u-boot_2024.10.bb b/recipes-bsp/u-boot/u-boot_2025.01.bb
similarity index 100%
rename from recipes-bsp/u-boot/u-boot_2024.10.bb
rename to recipes-bsp/u-boot/u-boot_2025.01.bb
-- 
2.43.0


