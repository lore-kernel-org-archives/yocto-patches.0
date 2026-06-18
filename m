Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DACD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:14 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22680.1781798052536490008
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 08:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sWbw87TR;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-460166910e6so750899f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798051; x=1782402851; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyp/E7z237m72ywD1GlLJVI1glQpfYAzU5bVc0kV0gY=;
        b=sWbw87TRSoebAuNFvRc7r9uSC1jandGHJN0y82GvggrzVlVeaM0luQUyQNEHNCl1dO
         /NidE/AkERzigSljXa2chPpMPIMAure9EciyPO4Vn7Fu5PsKBBOhLnwVTr0VmCXhtlaE
         bNmb9qm7L/MuWdgZlcmzhbnbcf/2Gq5kDKKa6DD2sXxc7vJcYFK6X9PoxUZKP6PZelAr
         /yNwHC349XUQQxesFBbJc/zmohFQvvRTail3LtCy/wlWJIRPUQzZ+GNfcaacqS4dcxI7
         iDK+egfRQkqK3zoS3jKxaZ6/FE8sdTY6SWUuisXclCNahhsUiDWGboGCr71MexALlobP
         xwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798051; x=1782402851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pyp/E7z237m72ywD1GlLJVI1glQpfYAzU5bVc0kV0gY=;
        b=Bkw/X0Z9Nr/5Lja5gYpV74qqoPudwV8/vcY5pDE78E3VeLrM76fHPqbrCHubPg+E87
         TOt6SMHShjYWcGewiq5cqSGAK/aDvIB+Z65nO8nHvlb7sNjTbkcAyCN1B86t/xy0N4wF
         Tj/WrWiO+t3aAPS8OgOXVF7+RY6AWnRaBwXpBxXOyQ8S+0xRt3w3/HHU0OBMaRtUeaiF
         eWrgz7DmkWanXX7ReV81AzU3Z7jvCRSAMZaA/BBna4W8ASXiLyQp8mf66kjYgui6BlLM
         O3bQtr64WyoqkHh3ChG+uvnm5u+izCdl2GdIoC0JS72M+r1bz5GWqCrMwQXQuIjmn1Jf
         Y7jw==
X-Gm-Message-State: AOJu0YzxyW9VhPp8FfpenFeBwHW6loQnuiUGMgK/WMQkcCt4OINKvi6Q
	Nyde03AgK5jBGGfIY3w0R49Xk+4xqLf8ynwpLcgwkOa8qmOuajkVobV3NpLGXQ==
X-Gm-Gg: AfdE7clfUCCxTi5OUYeM1TZtOIXnBIez8OebMsnYJnasetr+J6jsVw6RsUJrvaOsxzF
	7LYtV3UXQ0KoWDlImOc9v3q/YMiQmuD1cVgZbvvhgYAdJx3Vw2pHLKasHAHC/ezN/2YxkkmHrXr
	kpuaR9kBoFxEPdA7w6y3xkSR48fzSWNCY0BEyL8bd1P++T+zTmJ72oXHA9u0idp5Z0W5eHxcxCN
	jU/Fb2WhPdg2jNRQv7B+XoghpMYfZQBwb1Q+SHOfCQCvlJBRXlpxgsdmLNc+lggq61rfYGpXa1u
	SRkaliq3V7Qvx8SVglxrTuShUrLXRbYsIRvSuOnEQTuKMeq5CRYyZv+P3RLP5lLzIol3yk5rK0z
	XEx1AVLDDaVCYAqoj6+IP0e8AzjSRKuEb8tLIwVHhBOIM03Yr5l6ITfsd8YZAfJhnFW/ltTvVNL
	Z/icm6GQfKceHpFS/dyxLh01JOX9J3M+oP8RRI3Fi8CT76xrjIkc3LCkWo3zZ139ciAt/kkaOZD
	Ln5d3BXAE+TfCP4
X-Received: by 2002:adf:f9d2:0:b0:464:32d2:ecc5 with SMTP id ffacd0b85a97d-46500a02cb5mr41702f8f.7.1781798050687;
        Thu, 18 Jun 2026 08:54:10 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm29005560f8f.22.2026.06.18.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:54:10 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 3/3] README: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 16:53:53 +0100
Message-ID: <20260618155353.3633997-3-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618155353.3633997-1-jose.quaresma@oss.qualcomm.com>
References: <20260618155353.3633997-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:54:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4246

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/README.md b/README.md
index 16c0d8c..deeca33 100644
--- a/README.md
+++ b/README.md
@@ -8,6 +8,16 @@ and officially Wrynose supports only that. This thin special-purpose mixin layer
 is meant to provide a current Linux firmware for Wrynose by backporting the
 linux-firmware recipe from the master branch of openembedded-core.
 
+In order to make this layer Yocto Project Compatible, the layer should not provide
+new versions of packages by default. Because of this, the recipe provided in this
+layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
+variable is modified. The default value is:
+
+```
+# DEFAULT_PREFERENCE for linux-firmware provided by the layer
+LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
+```
+
 Dependencies
 ------------
 
-- 
2.54.0


