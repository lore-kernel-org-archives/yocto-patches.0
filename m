Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C3C3600C
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 10:17:38 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.18767.1742984256201422353
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 03:17:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hmKn/+lk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso430493f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742984254; x=1743589054; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqsN1CuF75ilmiCdrkXRr2Q6NUfn9FypVa4xXYbZ5Q=;
        b=hmKn/+lkdMOG/G1DF7ZCtGIhgEXbqmXgrPFV7zXBIYcZmq8+T/WKZzBFKlQezbDT28
         MNUz+W1GPYHBXUEfd2o5UMXWjZ7VpsIj4KstTehPnJ32Da2RbRO2azMNk0oOCflOnHxi
         4+5wIssio7F9BXKithvLTfJSSO2/JJYPUm7/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984254; x=1743589054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqsN1CuF75ilmiCdrkXRr2Q6NUfn9FypVa4xXYbZ5Q=;
        b=CuDxenKe2RDlSbemZrMfCrx3PuWS100kteq2FiLceMUjRDK/J75Xq2ekqGB1AjlBY6
         TFbo55/seA3Ekk89nQ/bofnWZhEMGBgNJJMc4+CIse30XAK1cxN/6DHw8km8L4IWyksT
         /zmiB1/tXXHq2O7thpB3zoFfAzJdIUJSyMwGv3Jrd9T4tD/RfLq1FSimDkByZSsvYavV
         5X79XI5G75CX92ATqoc/BwEZRNfNThdXrpbO3mw48Z+4g+w0gje/2eoRm9d6e3z/N0Vg
         1NDAJ6F6BvRaMmeJZh0KHf7TTFgPz/xRgulDhvI3keEqEgpfjfMx8iSqCSDu8Bn9vgOk
         fg+w==
X-Gm-Message-State: AOJu0YyoXe5gpKGOcZMotVp2DQlU2CuKI6Lvt5ISG3Ykomk3eyNAr4Ur
	axchlcWkMDo+pRy/yX0yeTTzv0au98WPy8/uR+WZ2yS0jSMP8FDf9cah7H68giC5BT23CVPVpKO
	i
X-Gm-Gg: ASbGncvz3d63t1QiHyjj+YRFM61hVMz2r3fj0VsgtAq8TVbIe/W4ttIWjjT2BU/ieZ1
	DCLDpzoxOltpDgxNKO9gW5EkN26yOlmnLYe1Z5PF+WiqXQ0KsR1mClIFRg1Ha2MPUneSMhJ1zmc
	069XVDFyAn3DQ3IrqamF3ayPMmA2rlS9puXqR+uQvWHJAHyjnCQCa31q+FHwmvbSSMkLpJ+oEI+
	MPhJ+RIicpzJhwRAqVf6ivUuwPE3YwO22hbAsy9qIwS17MyHoRGEaHiHaD1NDnGjfRJ5UA6t4FZ
	4FV0/EmPkbDevZbW6E6060FtaXi3h/1jw4qWfiKyaaHnnki6iabVlYNSbleGPH6JMtUuI8Pey3r
	c9X8VPAul
X-Google-Smtp-Source: AGHT+IFgsiTn7Hy2HYmyEp9WaTzrADFY0Om7TNLSvmQj3m0qhonygTNpcoRoFuUoXtMsR5cVqjNzJQ==
X-Received: by 2002:a05:6000:1fae:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-39acc3e1cc3mr2350618f8f.0.1742984253867;
        Wed, 26 Mar 2025 03:17:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm16679364f8f.35.2025.03.26.03.17.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:17:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Add musl ptest targets
Date: Wed, 26 Mar 2025 10:17:32 +0000
Message-ID: <20250326101732.713471-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 10:17:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1254

Add musl ptest targets for testing purposes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/config.json b/config.json
index 92cbc82..e6c3554 100644
--- a/config.json
+++ b/config.json
@@ -589,6 +589,13 @@
             "MACHINE" : "qemuarm64",
             "TEMPLATE" : "ptest-qemu-fast"
         },
+        "qemuarm64-musl-ptest" : {
+            "MACHINE" : "qemuarm64",
+            "TEMPLATE" : "ptest-qemu",
+            "extravars" : [
+                "TCLIBC = 'musl'"
+            ]
+        },
         "qemuarm64-ltp" : {
             "MACHINE" : "qemuarm64",
             "TEMPLATE" : "ltp-qemu"
@@ -774,6 +781,13 @@
             "MACHINE" : "qemux86",
             "TEMPLATE" : "ptest-qemu-fast"
         },
+        "qemux86-musl-ptest" : {
+            "MACHINE" : "qemux86",
+            "TEMPLATE" : "ptest-qemu",
+            "extravars" : [
+                "TCLIBC = 'musl'"
+            ]
+        },
         "genericarm64" : {
             "MACHINE" : "genericarm64",
             "TEMPLATE" : "arch-hw"
@@ -874,6 +888,13 @@
             "MACHINE" : "qemux86-64",
             "TEMPLATE" : "ptest-qemu-fast"
         },
+        "qemux86-64-musl-ptest" : {
+            "MACHINE" : "qemux86-64",
+            "TEMPLATE" : "ptest-qemu",
+            "extravars" : [
+                "TCLIBC = 'musl'"
+            ]
+        },
         "qemux86-64-ltp" : {
             "MACHINE" : "qemux86-64",
             "TEMPLATE" : "ltp-qemu"

