Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FCC4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:33:52 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.26383.1714509222766728463
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Apr 2024 13:33:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=p3sCrY8b;
 spf=pass (domain: konsulko.com, ip: 209.85.214.169, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c3aa8938so40684595ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714509222; x=1715114022; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JP6quc/ZZN8CKB4Ygp4ohwED5zkh9q8QunV/3s9V7mQ=;
        b=p3sCrY8bqaIU/LpheCMRBrlzH19jNgf08LaXuc/7mfRXJlZKCJW6AR+GwxkPKJzpoG
         GgH5u58YsVyWURJbC69Xd+P/7fv6pIQKg597sfsK1wKQ33vsix3lC9Vw8bnSoj0SEm44
         ufWUmoOC+Tz+//ySw+5GEtwh+CCPx7Ft4cF/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509222; x=1715114022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JP6quc/ZZN8CKB4Ygp4ohwED5zkh9q8QunV/3s9V7mQ=;
        b=vUqWuRVGckVP+pHCgYMqzD0GXPUsH+C88LAl32vFXALmUy8gr8OiZitY8egNFBiuZW
         3Xoly2tIOq5F6RJeNdlIuK05p55OjLsF4ippl2Nr5n4usIOxyFnIMUQOLFALFHcK2+nn
         bbyk+ydVQBrvefNnJjIFib0OJjdaYNb50+g8J9iOSmWj11vqoUT1hxC+13U3vYpjegz4
         9W7P3lzdWzVMr6JFtLfAQ9e9hSdW2gBFWg3wLfqeuk/0xk/SIfPLf/Hej2KEUje3CikP
         eh8BLTU7bxM4qUURdkyWAQGs65yGT7I4JA7X5I4WD6y5Iw5QIWx5dlxGStJcppOgien9
         hIbw==
X-Gm-Message-State: AOJu0YxrSpQe/hDfgow0dTQBl9m9q5DXhFj1PHoe/4U6ssPsGQXPymxW
	HVnjpntxhU3Amyi5dROnr+rpV0D8WZTIXB9pTJPZsH0dc3e68btawX8txPWPcGNznMQgeIYCvLI
	zvSg=
X-Google-Smtp-Source: AGHT+IGMi30IX04+xrgtsgCR+jQ3hWwIFYS/GSJo7+tvwcfXt7GcQZIF+3BJigfgEcrIT8z/m6vS3w==
X-Received: by 2002:a17:903:4292:b0:1e2:c554:a93c with SMTP id ju18-20020a170903429200b001e2c554a93cmr513939plb.29.1714509219825;
        Tue, 30 Apr 2024 13:33:39 -0700 (PDT)
Received: from localhost ([2601:1c0:ca00:bd60:e8c5:20ec:b8be:259c])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001e511acfd0esm22820052plg.140.2024.04.30.13.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:33:39 -0700 (PDT)
From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [meta-security][PATCH 1/4] tpm2-pkcs11: BBCLASSEXTEND native and nativesdk
Date: Tue, 30 Apr 2024 13:33:32 -0700
Message-ID: <20240430203335.110707-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 20:33:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/75

swtpm-native requires tpm2-pkcs11-tools-native for gnutls PACKAGECONFIG

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb
index 9dea957..59add84 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.0.bb
@@ -45,3 +45,5 @@ INSANE_SKIP:${PN}   += "dev-so"
 
 RDEPENDS:${PN} = "p11-kit tpm2-tools "
 RDEPENDS:${PN}-tools = "python3-pyyaml python3-cryptography python3-pyasn1-modules"
+
+BBCLASSEXTEND = "native nativesdk"
-- 
2.43.2


