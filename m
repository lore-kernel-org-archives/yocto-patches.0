Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD1CC5B553
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:13 +0000 (UTC)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web10.12286.1748486529237524603
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UdKXqhTx;
 spf=pass (domain: konsulko.com, ip: 209.85.210.194, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so264684b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486528; x=1749091328; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utCPNlzLT4Q12C7+tfjYgTlC35optYMAW7DR7KcQh2I=;
        b=UdKXqhTxvJsMn+TE5bFic0IctZ7BJt+17nzDVXA3tn3Ce94qU/ZIeckrgEQ3W99+jD
         C6fsAjnV3BJxxVAUhswJt2D8p/A9biM4GfKUWcO9B5zez5AsWCr4sPOVr+UMpoSA1jTV
         h2f+GkeYtS3iWvQwiMtsvI0TwXGoTyCOtF9FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486528; x=1749091328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utCPNlzLT4Q12C7+tfjYgTlC35optYMAW7DR7KcQh2I=;
        b=pGHxc83e/Ik52ILjtqFTsnp/fnwVxwHmxM0+avN6kyXpLj+SpN1ii9anGQC+L24bug
         WUi+fWM/ZveU5pBwk/GAppolWYcrk0/WlNlS9GXncg7i8p6eauHOvET0LLUZTjZnHSJK
         G5dC4HQSdY3DNchhl9B3ufQYXzVpQ5AyKfYnqdpp+CqvZSdiwHo9yI6moDh80N3cfDH9
         DdScRwZOmvegQ5J3a+1GvrN2aHVUf4BBx0dB5MOKyov2O+zYJ0VNeOdy445Xfp++TwuE
         pCYd+NYEtpbpdK+PaYEjD67rI8c9Rjlbbu5W51yAOjCD2i2zbrgCmjOZnRL55FgRdU9X
         ShBw==
X-Gm-Message-State: AOJu0YybgdkyX1Q/1K5jgU8vgmxkfZ5YKegkS67Yab06fQobwGQXeDxJ
	1rjw3zknau1xXwGo47Rr41OAkfc2Rhr81R8B+SCQdbNRNYlOMXuIsOyJ2wPHZJ9z50FG13yC2TB
	0gqVBIT/iEr8L
X-Gm-Gg: ASbGnctxQvjHrn2cwp9iYAf5RevNFKh08z0FfY/321hm1/h5IYOKMcSLA28kFxGxThn
	zgwRvWyOSkFIkDM3Oddv9WDcU7XZs8+R1yvbG9BGRCYfHa004sdnCHBTFfTVzC3EnwIphEt7uN+
	tNQgxbk4DIWuSiLc4VZAo08A1kk7QVTSiJo+z+uNqMNECsdeUXBNJE4MFs7iWsMwfm9zEueWmAd
	RQnwY8bdfdR03jbLLSFNtoCRFcOMrrbk7FnwIdl0ahYbs++/XXo5TjIgL5IAngJWOPJLMVHeDKW
	WbWJBDj/D4Pf6TKjrgjpYC6Sb3BQ5obn0qpq7w4v7gc4fu5QsZDTlPmykXw4UkiJsMMd2R80F4V
	7dz6c+4hRrYOQZaA=
X-Google-Smtp-Source: AGHT+IH85q7QdIQRj8gG66oe3Iogtanm5vbIDvJ5rzj4OkKoBwgilNx9Q/M+S6AyP0u+5SGW9HThNA==
X-Received: by 2002:a05:6a00:1412:b0:740:b3d9:c889 with SMTP id d2e1a72fcca58-745fe0c9063mr25631062b3a.22.1748486528154;
        Wed, 28 May 2025 19:42:08 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd4398sm312396b3a.134.2025.05.28.19.42.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:07 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 06/11] u-boot: Add patch to use SWIG_AppendOutput
Date: Wed, 28 May 2025 19:41:33 -0700
Message-ID: <223fd058a1575187b7063603b04d9e3f9e9fd6c5.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1590

From: Markus Volk <f_l_k@t-online.de>

Swig has changed language specific AppendOutput functions. The helper
macro SWIG_AppendOutput remains unchanged. Use that instead
of SWIG_Python_AppendOutput, which would require an extra parameter
since swig 4.3.0.

(From OE-Core rev: 4eae7888e91c7c864bf490dee38716267be6202e)

Signed-off-by: Markus Volk <f_l_k@t-online.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 ...bfdt-libfdt.i_shipped-Use-SWIG_Appen.patch | 60 +++++++++++++++++++
 recipes-bsp/u-boot/u-boot-common.inc          |  1 +
 2 files changed, 61 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch

diff --git a/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch b/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
new file mode 100644
index 0000000..9cd2cee
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch
@@ -0,0 +1,60 @@
+From e093607e9a08e9c29b7bbaa6aeb137036db798a6 Mon Sep 17 00:00:00 2001
+From: Markus Volk <f_l_k@t-online.de>
+Date: Wed, 30 Oct 2024 05:46:00 +0100
+Subject: [PATCH] scripts/dtc/pylibfdt/libfdt.i_shipped: Use SWIG_AppendOutput
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+Swig has changed language specific AppendOutput functions. The helper
+macro SWIG_AppendOutput remains unchanged. Use that instead
+of SWIG_Python_AppendOutput, which would require an extra parameter
+since swig 4.3.0.
+
+/home/flk/poky/build-test/tmp/work/qemux86_64-poky-linux/u-boot/2024.10/git/arch/x86/cpu/u-boot-64.lds
+| scripts/dtc/pylibfdt/libfdt_wrap.c: In function ‘_wrap_fdt_next_node’:
+| scripts/dtc/pylibfdt/libfdt_wrap.c:5581:17: error: too few arguments to function ‘SWIG_Python_AppendOutput’
+|  5581 |     resultobj = SWIG_Python_AppendOutput(resultobj, val);
+|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
+
+Upstream-Status: Submitted
+
+Signed-off-by: Markus Volk <f_l_k@t-online.de>
+---
+ scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
+index 56cc5d48f4..e4659489a9 100644
+--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
++++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
+@@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
+ 			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
+ 		buff = PyByteArray_FromStringAndSize(
+ 			(const char *)($1 + 1), fdt32_to_cpu($1->len));
+-		resultobj = SWIG_Python_AppendOutput(resultobj, buff);
++		resultobj = SWIG_AppendOutput(resultobj, buff);
+ 	}
+ }
+ 
+@@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
+ 
+ %typemap(argout) int *depth {
+         PyObject *val = Py_BuildValue("i", *arg$argnum);
+-        resultobj = SWIG_Python_AppendOutput(resultobj, val);
++        resultobj = SWIG_AppendOutput(resultobj, val);
+ }
+ 
+ %apply int *depth { int *depth };
+@@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
+            if (PyTuple_GET_SIZE(resultobj) == 0)
+               resultobj = val;
+            else
+-              resultobj = SWIG_Python_AppendOutput(resultobj, val);
++              resultobj = SWIG_AppendOutput(resultobj, val);
+         }
+ }
+ 
+-- 
+2.47.0
+
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index 113f215..fe3afb3 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -15,6 +15,7 @@ PE = "1"
 SRCREV = "f919c3a889f0ec7d63a48b5d0ed064386b0980bd"
 
 SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
+SRC_URI += "file://0001-scripts-dtc-pylibfdt-libfdt.i_shipped-Use-SWIG_Appen.patch"
 
 S = "${WORKDIR}/git"
 B = "${WORKDIR}/build"
-- 
2.43.0


