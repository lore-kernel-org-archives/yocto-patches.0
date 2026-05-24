Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47AECD5BC7
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:17 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7242.1779625694410118351
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AmpzGX8x;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-911449d9d03so1026584385a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625693; x=1780230493; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VUNwjHuJ+vi90ftzm675iFT2ITlGrExafDFX/h+Zo4=;
        b=AmpzGX8xPpA4J03PZSWBd+y9k/c+QeL5vZ35BBZGyv6jQezM8NJ1dbaULayyzuYFDP
         kzK/V4r/b54dsY7+xKYXm2kfPRSFBHIN/RfsgnODBxpFjgDSnuD1pB/xL2uFACQH2zf+
         xqg2nUhasslfAd0asqze88hSO60mlhPq3mp4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625693; x=1780230493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4VUNwjHuJ+vi90ftzm675iFT2ITlGrExafDFX/h+Zo4=;
        b=ZFaB+pddEXlTPoeXVcpis/RCLrwx4C9O086byjsbXaTBgmRbuXYHNN29SaeVpO26qa
         PHxfQc3YPOE/lKVHaHmVR31urhfOMJZUI7PBSZFYTVEMSoaS9wfeibi4k3QJz2nz6GnT
         W1Me1jRRLvnqGBYq242rGKLBO1NMrLHAnAO16nJab5UrXbih/7CrgwTY74Xm0Aq3en5H
         r6jMGsuhubSl/JMPYGAuj2xqBBMFtkKoK5jd/onir/+RxjYGBvVDhwG2fHp+VfI8/9IA
         aKrovSMyNaGGsMwmR7BPcRhbgb7wVvZzGL7+0i4aUVTjz6J0C2EMrSuSyW3An27V6jAq
         7mLQ==
X-Gm-Message-State: AOJu0Yy1Npo1FgDHsyAf9WryMn7H57nIXnTYkYL+TqvT7muOv9KrzZrk
	onzaqvHG4Qovl7NUpuhCgsh39Ey9WCfC+CC6K0dTHE7+uzYCVNPb9oaD10xoZ/d2hfMX9czoefb
	3vCel
X-Gm-Gg: Acq92OFKMJ78CLugiU9dCArpE3ugl3rXYFM8i8WfflfTdK/D0WBMPF0eIIp1mFxRc2P
	k9MS8zWYP5WFhmIej0ejrzDC8P8j/PGI31psLkFtbN+6vVp+5hz9mRfkDMFmt2F61K55iq3ODYE
	tc+5G6HtVz0KOC77Xl3qTaSFjA6beapVw3pLysZBW/3GF87aSuE1e1yinTCpxA1V+2X5BX2poN5
	pE2c8Xmn2VkyeV1ki71PuvmMYNepv2DyuN7L4P/ynRq9LiBluB0O6GjcC43/d6T+uSE6SP8Abue
	g6eeM0apCOvl1uLzssOR9C7Tl8NovjIwNknC+YtyFPTv1+r9qEg8Fij9jGYWvj5MaCnmDS5W9tN
	UKFFKiylUzd5FIdMhSfjg4OahxSSQmNLIk4WtScCvrDRKWe7xBacwNoobg9YGufcVT94MC/R+ik
	e83gZGobW8LTzA2ozLlJr3erxSpQWNxGyqIxKmf6XuxYlb1CTNTd4VpwIKBOmWhGq0CMWOPV/4V
	tge8Q7U0dXElM+jLXmP9M+pIX37RC29ww9pZFEXpt+c9czohBDE+WxhKS5itx52
X-Received: by 2002:a05:620a:2610:b0:914:cadd:ac57 with SMTP id af79cd13be357-914caddad05mr424134985a.52.1779625693426;
        Sun, 24 May 2026 05:28:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 06/13] parsec-service: assign PACKAGECONFIG in one line
Date: Sun, 24 May 2026 08:27:55 -0400
Message-ID: <66c38186baa4275acc3bc28cf0bda467b609acd4.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4025

From: Ross Burton <ross.burton@arm.com>

By :appending the TPM option we make it impossible for distros to simply
assign to PACKAGECONFIG.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-parsec/parsec-service/parsec-service_1.5.0.bb      | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index d88f1b2..c5f9978 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -16,9 +16,8 @@ SRC_URI[parsec-service-1.5.0.sha256sum] = "819f1f658a1c62fee1b4986fe33232d5dc539
 
 B = "${CARGO_VENDORING_DIRECTORY}/${BP}"
 
-PACKAGECONFIG ??= "PKCS11 MBED-CRYPTO"
 have_TPM = "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'TPM', '', d)}"
-PACKAGECONFIG:append = " ${@bb.utils.contains('BBFILE_COLLECTIONS', 'tpm-layer', '${have_TPM}', '', d)}"
+PACKAGECONFIG ??= "PKCS11 MBED-CRYPTO ${@bb.utils.contains('BBFILE_COLLECTIONS', 'tpm-layer', '${have_TPM}', '', d)}"
 
 PACKAGECONFIG[TPM] = "-F tpm-provider -F tss-esapi/generate-bindings,,tpm2-tss,tpm2-tss libtss2-tcti-device"
 PACKAGECONFIG[PKCS11] = "-F pkcs11-provider -F cryptoki/generate-bindings,"
-- 
2.53.0


