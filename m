Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ED7CD5BCE
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:05 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7101.1779624961347614924
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UG1W1GNE;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso97702606d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624960; x=1780229760; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VUNwjHuJ+vi90ftzm675iFT2ITlGrExafDFX/h+Zo4=;
        b=UG1W1GNEii3hH06YITPsCDWH30KA+cAF3rr5tkb8D2BOCh9Ki4zp2FSO4K9dFaD76L
         TPTQCyo2uVQVWnmv1mjrt19dtWAKgHuViFDih984sJRA3ej9KTAt6N0UxOloP9nTug7W
         1ue+bi+K7+lVI/ImIKttllNwxk5373VVh+6Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624960; x=1780229760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4VUNwjHuJ+vi90ftzm675iFT2ITlGrExafDFX/h+Zo4=;
        b=JgKegcrI6wwHT56inTN0xyPKJss1Gsy/48Y5vVH7gkWMLyMgZaIYC7pMlBMFScs0jQ
         N+zSXb+RoGXVZTfb3C2WktMwOuzJk6tiEyWDgL5Z8YYAp6U6bjGPnPS1QhD4lZ+bCtN+
         6wRK5cEbI1e1VZRVeT0FIf0iHhdbKJo6SfQQDVbNE5M5pTEi6HHXG+gY17P8+bJAqP2e
         jK9PS30g9nptIUbla/ywV4RwiSWG0F0PWD3rezo+j659+SG4m6+BsAP/EI9S3hD64p5k
         N5rrl7V20z4UtOfUg5RcnKFKcivowZ1J//0DNzg7vuWLDnM7tIt4oZxLU7/kTjTswLhP
         fYVw==
X-Gm-Message-State: AOJu0Yxh8Gwyd3JO+dC5eDxK0wJdzErFyKkWp4tpkz7UZaiYPLmo2wTz
	Ik3vN0AX7RDaQwyrnSzgIpmJivw3cVLxfB4Ev/46LfdKeIft6pDC2rTrJ7n+a5b2tNcJUmiUkH5
	UjpAF
X-Gm-Gg: Acq92OHAbI6xS7oStNenK10ukodAfp3+Mg1/2cBVUQyx6UbnmpQTHFrpeoe+Qk1bRtH
	FQDfoT59wKgEB/x9IVhyRlrlM6eFy9vkZhEUfLOdDsuaxdLLmdDaXUQi75L7Y5T5pBJitSrh9iL
	G+vjoTRa0GYui/d6jUnzjHYCrgmY6yUvE7fn3fJO6pNaM9LchbiHatYNfEUZ1tgSJeAMW8vicC1
	a/iUbbPnHiiV/Xtt70LUYyros0V3xMct67GWhgyjgk0feUBmt4iXPiRdT4R5zsH4DMmTfIVM8e1
	IBmZC6LhNVBVoT6PorcmkbwkOglUicJrmx6Zyb5RXiMY7UpHArNnbqiDDeRDw8RT1z5b47vFePj
	iGDTICxwDTrhJ/YqaIdRBmk6IL0WKHwv6L2QZX0CIwlNIzEbYlNoJXWU3RWzNIjhVpAe7nCJ4gb
	hPziM6BjaHRWoYX2cCNlukAoMwwkQrBDeVTwPil+gxXUYVLE9x6YeEDP3Nd8rn6XtzZbY2Psls6
	hpyb9HWEf5Lif9sDQAOavmCylBvnDn7P6/us5GESM78Pda/ymTNomleI5n6sT9K
X-Received: by 2002:a05:6214:500e:b0:8ac:b471:efbb with SMTP id 6a1803df08f44-8cc7b59a5e2mr176982466d6.24.1779624960351;
        Sun, 24 May 2026 05:16:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 06/13] parsec-service: assign PACKAGECONFIG in one line
Date: Sun, 24 May 2026 08:15:33 -0400
Message-ID: <58ac5eda9a6e142fc7871cf5bd79becb58b010f5.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4012

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


