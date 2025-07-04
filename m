Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FDC83F0C
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web10.1067.1751649114584268993
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Hfdhe5SK;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a44b0ed780so13368501cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649113; x=1752253913; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrbDCebYBXx1OkEJTFVzKAx9LL7cbCFsZrF1YY4ZQpI=;
        b=Hfdhe5SKdLdfvFFWcYCWhpJnbRPIcTrDLfjvgGVEv7ItoSL4YXYuC4MdsOq3mB8eNk
         6LutCWWInsc0toIq9BYQ4hXu65nvQS3UumYYi6LdFyxcarcrVD6YsGUEnlA17wy9nMEX
         6GV7DeSHCFzJQbkapa84+T7Q/WQp5bDOqPnL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649113; x=1752253913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrbDCebYBXx1OkEJTFVzKAx9LL7cbCFsZrF1YY4ZQpI=;
        b=npVOByUKl9NGhcv17ZNGKLFOu9QvlHceotkOyZgI93pBInEAyQQ5cIZWnLQXG37GCm
         vYWj5EwwA36Dl907gPIk9TQXGMRcDqu9MX8suRXKL82KlsafRd9zav79z3OdywMOKY0S
         X1UX9iL8mIQ8nR9n4pKgcfVrygmr7UroV9VEmjP//twnNGoeeSdV+g04wobo+l4qLk4e
         krCLBHC5WjDg9L7y9hYuKnd5jW8lfAWEwheQjgLfG13JJ52aP4vEm2FcjN/1aOxo+BXc
         ZweHvQWuIRiWimjE20sIpcPRUVlJUwx6EDGqcEkhHJKp5z1IoWggl0qmIObobyVC6bt8
         ZxXg==
X-Gm-Message-State: AOJu0YwSQc+6RZHI3yLdSbmAcRlZde6yaqJWa2brZR9cx650YGJkMxyw
	CR1uIX9c/Y7cHTuSWs55Th3jazcYt0eMM+taQ00NwdwxXazsSciSPVp4KzSF2ksZCOkuRQanplx
	hnagO
X-Gm-Gg: ASbGncuNbx0FVvRcyjzRE183g44qM8jZLFawCIWVGcaQK97gW4LHPQRVAHY5XY7ADh3
	Ddi9Xb7swsu6c61tv+bkqhNIDeXSTb/KdpP+sqAPhXKjAtEXzkYNd6PRQxBhctNFw1q+1pQwsM+
	C5HVLxVc4itftrG3/KQ+fIlpWBy5iLh35Xk30b6nzUHSuVMelH/5sOyQVS8Hq8DqeqPxL/rIZkT
	6OS+bcw/Md+9llZRykoUyAdDFjYvwgfPaPnrv5M0zyiQxktbOONr4GtH1A9bdx7cndOajmn5EOr
	jaUtDpjQmQJm8X4IhU0XT5iRUQDa1wwlB7L08v8j26WBRiLRQrFESfYfUXxUxhDYEYW3XXdAud/
	OHCCepK4wbxpE/aiG19EJnJuWJj8tERMfSCttH5rDIx44qlA9
X-Google-Smtp-Source: AGHT+IHXbW7pWFXtVZzRSDA2+dVBYyN9UGLyhRQlIDqUk2+arUC/dV/5nYjteLbvY7TG4S2QzKhYbw==
X-Received: by 2002:a05:622a:118e:b0:4a7:6586:8d9 with SMTP id d75a77b69052e-4a996460a98mr45954231cf.12.1751649113162;
        Fri, 04 Jul 2025 10:11:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Anton Antonov <anton.antonov@arm.com>,
	Anton Antonov <Anton.Antonov@arm.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 05/12] parsec-service: update PACKAGECONFIG options as lists of cargo build features
Date: Fri,  4 Jul 2025 13:11:09 -0400
Message-ID: <b1f1c7a304de33916040928ea7182c03580efb28.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1757

From: Anton Antonov <anton.antonov@arm.com>

After commit 7a2b9acef2 "cargo: pass PACKAGECONFIG_CONFARGS to cargo build"
we don't need to include Parsec cargo build features into CARGO_BUILD_FLAGS.
Let's update PACKAGECONFIG options as lists of features.

A small fix in readme.md as well.

Signed-off-by: Anton Antonov <Anton.Antonov@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-parsec/README.md                             |  4 ++--
 .../parsec-service/parsec-service_1.4.1.bb        | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index 9dea718..a5472ae 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -112,7 +112,7 @@ You might need to change permissions or add the account into `kvm` unix group.
 
 - Add into your `local.conf`:
 ```
-INHERIT += "testimage"
+IMAGE_CLASSES += "testimage"
 TEST_SUITES = "ping ssh parsec"
 ```
 - Build your image
@@ -129,7 +129,7 @@ bitbake <your-image> -c testimage
 - Add into your `local.conf`:
 ```
 DISTRO_FEATURES += " tpm2"
-INHERIT += "testimage"
+IMAGE_CLASSES += "testimage"
 TEST_SUITES = "ping ssh parsec"
 ```
 - Build security-parsec-image image
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
index 49467cd..baa02fb 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -21,15 +21,12 @@ PACKAGECONFIG ??= "PKCS11 MBED-CRYPTO"
 have_TPM = "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'TPM', '', d)}"
 PACKAGECONFIG:append = " ${@bb.utils.contains('BBFILE_COLLECTIONS', 'tpm-layer', '${have_TPM}', '', d)}"
 
-PACKAGECONFIG[ALL] = "all-providers cryptoki/generate-bindings tss-esapi/generate-bindings,,tpm2-tss libts,tpm2-tss libtss2-tcti-device libts"
-PACKAGECONFIG[TPM] = "tpm-provider tss-esapi/generate-bindings,,tpm2-tss,tpm2-tss libtss2-tcti-device"
-PACKAGECONFIG[PKCS11] = "pkcs11-provider cryptoki/generate-bindings,"
-PACKAGECONFIG[MBED-CRYPTO] = "mbed-crypto-provider,"
-PACKAGECONFIG[CRYPTOAUTHLIB] = "cryptoauthlib-provider,"
-PACKAGECONFIG[TS] = "trusted-service-provider,,libts,libts"
-
-PARSEC_FEATURES = "${@d.getVar('PACKAGECONFIG_CONFARGS').strip().replace(' ', ',')}"
-CARGO_BUILD_FLAGS += " --features ${PARSEC_FEATURES}"
+PACKAGECONFIG[ALL] = "-F all-providers -F cryptoki/generate-bindings -F tss-esapi/generate-bindings,,tpm2-tss libts,tpm2-tss libtss2-tcti-device libts"
+PACKAGECONFIG[TPM] = "-F tpm-provider -F tss-esapi/generate-bindings,,tpm2-tss,tpm2-tss libtss2-tcti-device"
+PACKAGECONFIG[PKCS11] = "-F pkcs11-provider -F cryptoki/generate-bindings,"
+PACKAGECONFIG[MBED-CRYPTO] = "-F mbed-crypto-provider,"
+PACKAGECONFIG[CRYPTOAUTHLIB] = "-F cryptoauthlib-provider,"
+PACKAGECONFIG[TS] = "-F trusted-service-provider,,libts,libts"
 
 export BINDGEN_EXTRA_CLANG_ARGS
 target = "${@d.getVar('TARGET_SYS').replace('-', ' ')}"
-- 
2.50.0


