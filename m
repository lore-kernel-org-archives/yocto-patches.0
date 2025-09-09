Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50494CAC58E
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.3376.1757443825269187111
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EpJlwXh4;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-80b7a6b2b47so567827685a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443824; x=1758048624; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2plOedVRbIl/GoQJL6SSMvJ5vt804tWRcgiHevfYSm0=;
        b=EpJlwXh4X6evB/izI2m/QH7Gj5fn12K9F0nLgsQAxRVxTkGK00GnUygJKxrYlGXEQk
         cxuRTsTrv8rJ/WbiHc9m5SX99S4/eHT3U8+T2s8RUODtnklp43ctdj+0JPr2uAPXtW8x
         Dyf1f/R1KJXl53stu7t/R4vLkJ30vxOj9WdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443824; x=1758048624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2plOedVRbIl/GoQJL6SSMvJ5vt804tWRcgiHevfYSm0=;
        b=j5f6oFqaREQMxk9FRZbhsFDYAQoA+y2aMoNVv6v4ZJBdNk3oX70B4xIvlGI6aCTk58
         Yv/78W/LiKtXvw7fY4a49lgmnIRWSV8WAh3be5N53L2hfnEdm6ClfSvvVZwEWB8/pwaP
         TZqKAownIMmKPnYmLVmBV7S9ABbKA1GZ7KzvrhbA/A5PrzYyhAJnnRFV+BisToNKQHza
         eQMOt/UB9vIBdcmOKVDR1kjZPTjyB6Pz/pqaP+7O5FaPOu3FBgBPyE6jdvDWxon2MDO9
         NIZU5T9D6iqTzGb04GZC5jDwyVtFM9fniUQt1zbNabZdnlNghbLaQc62pGtRjbA6wbX0
         kI7g==
X-Gm-Message-State: AOJu0YwsotliYjShASTXOTme3iFSrcquR7wM2/ZaDRQqjxODGTOCL7sU
	82Rji2OvUuqdNMIZCoiX6+av+sJsc4JVNHIXac9J+vTHBegVm7jCnuKWBww6f44Ryzox/euCJZ/
	+fvj0
X-Gm-Gg: ASbGnctzO8FjErOEFtA4IpmOOmgS34y2RO74bQL8h8CKqG642deGiCAryMQhx0cXFx/
	JvVa/ycVe1VKYplaQqeIksH9vp6RGrMz8k1cq1cizYyq1+wax+WQhthQQTcjPrpR8qrxsNblFOa
	AyrjoQr99hzkdDFTuRXAmt9zTD9IT26G8TRRmP7/I51F5OsQ5avZn4pVo/x5MynCCa0xCFWDwZ7
	ry38wp4EppiC1BGbTp4hnmeTYIGPw0IibqSIbCkY3BBVt6hdAcwvrGYVZSiNrg7lbq0lEUJoKPi
	vuLwxUYTdjj58ZhkA04PXAuEpVjofaX+dMXOoL6AOzErYdt4QiBbC0Ye/NZmq4tpHIHggbPizfP
	Mn4s9xnb8IwakWPmTQYtASaj51ry5hG227BdhQqCeV1k3TCBLHerNeH1J3dJiPiCFpvUD6kRviw
	==
X-Google-Smtp-Source: AGHT+IFFUCyi78qvBoG6ivjW5O1B8gpTCacbr3w2uS9jJWH6wHMK7FWZbFqhvLzva+8rY4+sOMTAJQ==
X-Received: by 2002:a05:620a:394f:b0:813:64ce:dd1e with SMTP id af79cd13be357-813c10f21edmr1433258085a.35.1757443824050;
        Tue, 09 Sep 2025 11:50:24 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:23 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 5/9] rust: handle softfp fpu
Date: Tue,  9 Sep 2025 14:49:53 -0400
Message-ID: <cad4a815845168721eafcb648f85f71050c6d70f.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2171

From: Peter Marko <peter.marko@siemens.com>

With TARGET_FPU set to "softfp" stdlib-rs fails with:
error: Error loading target specification: ARM targets must specify their float ABI. Run `rustc --print target-list` for a list of built-in targets

This fpu type is set for example for arm in file
meta/conf/machine/include/arm/feature-arm-vfp.inc
when TUNE_FEATURES do not contain "callconvention-hard",
e.g. when using tune
DEFAULTTUNE = "cortexa8"

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 4d50135cb902037380915966ecc97399d32e9f74)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index 9677fbf..76dbf47 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -392,7 +392,7 @@ def rust_gen_target(d, thing, wd, arch):
     if features != "":
         tspec['features'] = features
     fpu = d.getVar('TARGET_FPU')
-    if fpu == "soft":
+    if fpu in ["soft", "softfp"]:
         tspec['llvm-floatabi'] = "soft"
     elif fpu == "hard":
         tspec['llvm-floatabi'] = "hard"
-- 
2.50.1


