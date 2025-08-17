Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD1CA0EF2
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.60909.1755464896934951898
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ifoReMog;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b1098d1bbaso52914651cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464896; x=1756069696; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqjKc6tzKpzZeL/nq+vk7am4T1M6SbQXx0jZrDuC4Dk=;
        b=ifoReMogOxUl7CkyFGp9ffZoF82morTl7rZCGaSlPsqQgl4oupndnmU2A0R6iKUtYV
         pgOpLPvlehU7MytskoO8tgcsR9OkvHiD0RTSpglb6MLH8RlK7LBbd1DrRL2DNfqEZ9oR
         EeFgAWV1CNfQe4OkkZMZn/cDvgD6Swl2cc6Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464896; x=1756069696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqjKc6tzKpzZeL/nq+vk7am4T1M6SbQXx0jZrDuC4Dk=;
        b=w/M4K9CUTEWuBNt79empjrIUVK0pULe6igjkavcKSXQvkB1vuvZ9hMIp8BiNOcduOx
         qRsgreIsWMLtuOnjWFRz5ZMEPKfTI8+z1/yqTyEavQexLvC+Xc9nR6R9q0lqxBA7pNPu
         icqqTxCrmiw3cJ+sx2FeiBFamxc/C+icAaoiNkbvuGqwmkSN/bkgIB0iSrJDNkhh1+nI
         xVDn9Q2ti10VtiEZonWIiEmO53DfutVxWYEHVhldQng4WwPgFm5kOzJduSW8uTRIeNz3
         ZQYqknVcmdqctGBb5jI5/c71aCGadq1LKZ+eFG8FLuz81pB6yvaJyrj/U52B/64eysEu
         nfsw==
X-Gm-Message-State: AOJu0YwJsOK7zJDJLQjTHp3ifEx/Oyaz5Y3026bwzriisVCdQLSDmcKf
	p0Bjxlnq8rFhaLNpQb3Tv2GQ8TBspT8CxefplwsSNmDeZq+WY/e1775xyH8QEeg7sBvBrl8lvoX
	MbLn+
X-Gm-Gg: ASbGnctgghRPmvRMi6KTKDxp9hv0bfZm5Jh8UGGPeTA3T8qloTN7b5R9ttKygAagQVN
	UeX1zXcT1305O4RXi4cSlPVisecgCSPH6IeamGkgGPuwvctS7nC/traHI3ZlKng1TxMlonOtbLy
	z/cyoEKCeSrUN37QZTUv4T2zW71+KGzOj2hakSPEebqr/7Ha5ZsSZhpGROZn5uB3qRICDCfJ8MS
	B+8OQeAiakuj8utI4ZbD+NJcRIdoxWIaELcJp2A5+bBxF+SD8ZKY0AvNmxCtPNHgjYKU9YGY15V
	u8e5/0wfc0c3So3XejZOU1PF1Ig1IdiZXDR9IW1xnTKYC9O8L0lBsk0OZRVgWekknc2D6y6iW4G
	30xms4HgaiZlkqUrMA4ylmp3cnTNl4vLvTXqC/or+vtf6ClNw/BU0DQf1z3Ei16/z3IJzTVXVlg
	==
X-Google-Smtp-Source: AGHT+IGkbEAndNScZYt90YhDe1oSnHSXux+cblJaeCvqGUHycTJKE0zSM1Pe2Ra+A4qhaC+4Z0ew0g==
X-Received: by 2002:ac8:5a10:0:b0:4af:233c:4c07 with SMTP id d75a77b69052e-4b11d14c156mr161493501cf.5.1755464895697;
        Sun, 17 Aug 2025 14:08:15 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:15 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 6/7] parsec-service: update PACKAGECONFIG options as lists of cargo build features
Date: Sun, 17 Aug 2025 17:07:58 -0400
Message-ID: <0b63683ef297356ea16f3a1a632b69e08c1d00e4.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2029

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
index 785c932..90decaf 100644
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
2.39.5


