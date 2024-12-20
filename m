Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CAE7718D
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:32 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.152223.1734703522768924440
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PjsoX+MM;
 spf=pass (domain: linaro.org, ip: 209.85.208.177, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3002c324e7eso19618471fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703521; x=1735308321; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbHqbRbHdDOnD9FzUIBPrFO+8KXbeQWKPl/UfrKGYiw=;
        b=PjsoX+MMa0Ne2mqy7GcT8ZNA505LWCVSAStpb5jcTZqiLGRdgGlbQ8Aai+wtndBEN/
         LtAoQZ7rvMFeUWMZ40EGa82POIOxbYKvQ3ImFbR4W6pjwuCa8obZgXXmmBXG4sOWkk8i
         YvDz+awU+LKhbojVT2pzP+yBc9oQ4xGALnjewV8oI+ar1Uw0UDRCwaOAl6r4KB6oVyaT
         bUGwZSV3DkroNmi9lr6/QozYmLLBLpkyj3RTrDzXG2eNzA4urHoTujETM0CW+9hbge6i
         yBKhNXMKwbfuDZt0TcpMe9pr8n7boD8cQM2yI3CuyhaG+HYPv4fecZDGwuoMuQ5laVPs
         QE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703521; x=1735308321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbHqbRbHdDOnD9FzUIBPrFO+8KXbeQWKPl/UfrKGYiw=;
        b=TqSYoEBmEWsLe/BK0aZmULZOqsqzfTK+lqlg5FLajYR1EcaW7shKnFbtViq9blgDxy
         yz1hkwUkdAOpaa2mrP9tURlrnioJjzm+mNoBYG5uJV/eKVNY+jcrI4fOAwWqxJjipvD+
         dgMQUPaGmNPKw5ttyxSIOFlNVz1sjWOnAIAnEbqBHwoGCZHRDzvcsm0rX5HvHKQWgpNm
         eDozK1or6ERNm0RK2PDcInsM4jU79FLrWFyAs55ym2KbLPEH9hD/A8f/sunB3sKe8LEZ
         aWXoORESe0WCYq3FZxnOijl3NdDY5GyOQaM73jr2Zpe13fW2WqUru3Yf7Hrk3NT4L3Ny
         IrdA==
X-Gm-Message-State: AOJu0YxfN3HM8ZM1d/RbfydrbriAEfg8DovfOi6U1c0ToMQUIIlLeW87
	GnHHZVxN9B6kmSflSjQT/UV0yrojFKeRbsENDw0DFZhLGjjvGXElkid0jNeX5m8XNY7iotvi50E
	g/VA=
X-Gm-Gg: ASbGncvWtY4eIxRvrx+dLoeJ/kinLbNIqa8MTF0D2dSthytVCjG6bpxaPlGLz3LpKJR
	XgtqBWCZ4b6Zy1fkHVb2gQusc98ljgQmRVV1c+uYw3LwhQsdm1PWkVia1JtHRX5OjEpUteBM+8A
	HM51TITgWCwIS85vdxmNdBP0aoVIL4Q+FIt2Alyr24s8qe84CJbbSfi5lSwo84SXJabNpbAOZ5v
	bJAfVtCqj4pIqRhs5M5NI9ikOJQ8tD08RQN+r9qMNIw8guyPwkIsB/etlncupQONXDRfIe/c/XS
	tX1izGvLfFNsytJKl6jGNlHnDg==
X-Google-Smtp-Source: AGHT+IFEJCXeA5BYh2RNVyJxGnG4DWlZBouEUamHYUK9CiI2JP3061XMmC9mEFNKMdarV7j0e12DpA==
X-Received: by 2002:a2e:a9a8:0:b0:304:68e5:eabf with SMTP id 38308e7fff4ca-30468e5f351mr10598951fa.23.1734703520833;
        Fri, 20 Dec 2024 06:05:20 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:18 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 06/18] libtpm: update from 0.9.6 to 0.10.0
Date: Fri, 20 Dec 2024 16:04:29 +0200
Message-ID: <20241220140441.271395-7-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/945

Needed by newer swtpm. Improves error messages etc.

Changes:

https://github.com/stefanberger/libtpms/releases/tag/v0.10.0

version 0.10.0:

    tpm2: Support for profiles: default-v1 & custom
    tpm2: Add new API call TPMLIB_SetProfile to enable user to set a profile
    tpm2: Extende TPMLIB_GetInfo to return profiles-related info
    tpm2: Implemented crypto tests and restrictions on crypto related to
    FIPS-140-3; can be enabled with profiles
    tpm2: Enable Camellia-192 and AES-192
    tpm2: Implement TPMLIB_WasManufactured API call
    tpm2: Fixes for issues detected by static analyzers
    tpm2: Use OpenSSL-based KDFe implementation if possible
    tpm2: Update to TPM 2 spec rev 183 (many changes)
    tpm2: Better support for OpenSSL 3.x
    tpm2: Use Carmichael function for RSA priv. exponent D (>= 2048 bits)
    tpm2: Fixes for CVE-2023-1017 and CVE-2023-1018
    tpm2: Fix of SignedCompareB().
    NOTE: This fix may result in backwards compatibility issues with
    PCR policies used by TPM2_PolicyCounterTimer and TPM2_PolicyNV
    when upgrading from v0.9 to v0.10.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../libtpm/{libtpm_0.9.6.bb => libtpm_0.10.0.bb}            | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename meta-tpm/recipes-tpm/libtpm/{libtpm_0.9.6.bb => libtpm_0.10.0.bb} (82%)

diff --git a/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb b/meta-tpm/recipes-tpm/libtpm/libtpm_0.10.0.bb
similarity index 82%
rename from meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb
rename to meta-tpm/recipes-tpm/libtpm/libtpm_0.10.0.bb
index cd47155..a2c3a14 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpm_0.9.6.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpm_0.10.0.bb
@@ -2,10 +2,10 @@ SUMMARY = "LIBPM - Software TPM Library"
 LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=e73f0786a936da3814896df06ad225a9"
 
-SRCREV = "f8c2dc7e12a730dcca4220d7ac5ad86d13dfd630"
-SRC_URI = "git://github.com/stefanberger/libtpms.git;branch=stable-0.9;protocol=https"
+SRCREV = "17f253a767f6b5b7813ae33f12bc79c479576cdc"
+SRC_URI = "git://github.com/stefanberger/libtpms.git;branch=stable-0.10;protocol=https"
 
-PE = "1"
+PE = "2"
 
 S = "${WORKDIR}/git"
 inherit autotools-brokensep pkgconfig perlnative
-- 
2.43.0


