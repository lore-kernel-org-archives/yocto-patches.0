Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC26D0E6E9
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 13:51:29 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17443.1764078682798197935
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Nov 2025 05:51:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cQuZPYx9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so32002475e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Nov 2025 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764078681; x=1764683481; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPx3NjY/nwa113zvpsq+PlZ8N1z6H/xfsZAhXIlAHMc=;
        b=cQuZPYx9Nu4E+rmXH35Jtk8KZ83tgOO5FbsgsPkvVX96e91artID2ukF7kEOjlhtZ/
         2tkegyxHyU7apiwyAVHbH4bnGXm0JNqD2M0e0JjwFchqkGR2FHgBTigah/kurzYFZWSV
         HoSdUr/kU24PZk3+k2COy4B5t0trP7LNfvHhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078681; x=1764683481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPx3NjY/nwa113zvpsq+PlZ8N1z6H/xfsZAhXIlAHMc=;
        b=kbMq3+CayBVZjRxOnImxPJ4m7E43wTFp/46NRt+J5sJ/z3eY13Y2ib06DjebBiAq5A
         ddiC5CLnYQipLm1h7bvIVGJYJEDALZ9xNIIJi5ssOEi5HEWIpquceELQrwtHNavKHJ6k
         w1hFpHoKDIyihbK+Kk/mXCi+t4JhsjK3OZuloVHmaBWzVR67EtAgNjGhfOZy8VaM/UcN
         y69j1X6XLYdi5cB7y8aQSJ37PGZnv/+W1x8oECg9szh+kfTBbfBUIeV9saR9oZZEMTrQ
         Ho8ufU+d318Bl6UlPx2JVu2FTbMkGffYAD7gkiO03s0CFQyQkGKip34bVFgK9dZUULL9
         uIfg==
X-Gm-Message-State: AOJu0YwvYONJJLMNL7BwfRJ4kednGRjJN4bhaUma2GJjMQPwYK2f57HE
	fintREWKywbbtK1KIJ2W29rO7WGrasQJGn8bLrcUa7N4EnZPx7+8znPCE0+Qrpdiaa1Rt/jO2LE
	5UVFd
X-Gm-Gg: ASbGncuZ64f7AZsZqfGDfz8JwIsU3LThQaPX4qIURYAq2DKDklVwNWpajM4L/GglKFm
	ASccQxXt285PF6MQY8lFZrKtZlVfkUV/6x4jH8ZkPlB+EbEGz7HGR6UqVmdis6WahG86Q3B22WG
	/P3JGdPEI9+OrUgM+0sfRHNp21ZrfbxRpuxwELP2qKM9KdqHamEZ0fnNJUmTkFwfhoNIp9tt6gk
	mPc2kajUto4b7K5sItBUPoGdhiNSrPCkn1o9fwl4r62hbzgH6+y+/fhDC39bClv3dIeBBKCh9lA
	9yyFyiN9AkdU2Di10scuy675ncVawS4osA8CHuApfuUHUQYi0JOsM8esRqZR9Ea/3rC1sbr6Mkj
	eDO00xM5dMgeXcxtBjgcZBl8ecMpR0qTj2A1lKo6l5Q+lf8c/DgRjn3+pt1XZBzBCGb1ZDQWXcA
	oNhR3CogDPOz8qA2+Sklr20q0ux+VGOVAz9rhvAtI=
X-Google-Smtp-Source: AGHT+IELGKQ2fBiJ141NHDakmFkgx8MM5QJxBI5kIT3bT7UeYVTmu+TKmrJsOCVQmTG/b3bzGxGllg==
X-Received: by 2002:a05:600c:4f87:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47904acae93mr23444215e9.2.1764078680454;
        Tue, 25 Nov 2025 05:51:20 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c8cd:1015:2ce5:f243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df3d5sm252128985e9.2.2025.11.25.05.51.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:51:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Avoid config fragments for machine/distro for selftest for now
Date: Tue, 25 Nov 2025 13:51:19 +0000
Message-ID: <20251125135119.407479-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Nov 2025 13:51:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2709

oe-selftest relies on being able to set the MACHINE/DISTRO from configuration
or the environment. Therefore disable the fragments for this test for now until
we can find a better solution.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json          | 54 ++++++++++++++++++++++++++++++++++++--------
 scripts/setup-config |  3 +++
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/config.json b/config.json
index f65563b..84adeb2 100644
--- a/config.json
+++ b/config.json
@@ -249,10 +249,12 @@
             ]
         },
         "selftest" : {
-            "MACHINE" : "qemux86-64",
+            "MACHINE" : "unset",
+            "DISTRO" : "unset",
             "PACKAGE_CLASSES" : "package_rpm",
             "extravars" : [
                 "RPM_GPG_SIGN_CHUNK = '1'",
+                "DISTRO = 'poky'",
                 "IMAGE_INSTALL:append = ' ssh-pregen-hostkeys'"
             ],
             "step1" : {
@@ -1150,27 +1152,61 @@
             ]
         },
         "oe-selftest" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-ubuntu" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-debian" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-fedora" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-opensuse" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-centos" : {
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemux86-64'"
+                ]
+            }
         },
         "oe-selftest-armhost" : {
-            "MACHINE": "qemuarm64",
             "SDKMACHINE": "aarch64",
-            "TEMPLATE" : "selftest"
+            "TEMPLATE" : "selftest",
+            "step2" : {
+                "extravars" : [
+                    "MACHINE = 'qemuarm64'"
+                ]
+            }
         },
         "reproducible" : {
             "TEMPLATE" : "reproducible"
diff --git a/scripts/setup-config b/scripts/setup-config
index c311d95..c06dabf 100755
--- a/scripts/setup-config
+++ b/scripts/setup-config
@@ -65,6 +65,9 @@ machine = utils.getconfigvar("MACHINE", ourconfig, args.target, stepnum)
 distro = utils.getconfigvar("DISTRO", ourconfig, args.target, stepnum)
 
 def enable_fragment(fragment):
+    if fragment.endswith("/unset"):
+        return
+
     cmd = ". ./init-build-env; bitbake-config-build enable-fragment %s" % fragment
     cmdpath = args.builddir
 

