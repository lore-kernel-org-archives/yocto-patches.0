Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0BCA0EE9
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.61168.1755464897787711952
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bIvjZn+p;
 spf=pass (domain: konsulko.com, ip: 209.85.160.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b134f1c451so9075821cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464897; x=1756069697; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfnthYqZEY2DIETGId2O4rHHoXv7nshbPXG1qEXTrd4=;
        b=bIvjZn+pP5oS1gx4l3vdZuH1eNR4EL7aMYpnfeoKduwvlUC58MzfC0k3wd5p60NY0s
         TDFqbmj2WFxpUSQv3nmpQ13PXDbiNk/TeiP3sw/Yw/jPC23Gne9AJwbZVJsacvcw3U+7
         EwyvEb+PezEUS7xKwwV8GqMSvSuTdVt4SdFDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464897; x=1756069697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfnthYqZEY2DIETGId2O4rHHoXv7nshbPXG1qEXTrd4=;
        b=wI21uc7/kNezcSOk8tflRcFX6VLbVWCq9UrWjrLStwL5G3MnsF8YQ1CwHBs1QX29sL
         vLCGI7yQK75kKvqAE19e5CljX59Zzx/xghWo2nDTp8LHDXJsObuWXZTkLuWhOqfnW8+6
         rM2z86hGPb4EVnPY6i0Dc2fey3pb4a2DPCRgfJj5FDzDrYWtxTkDQv1zS1yatN377OIw
         5eHXmfKJIHH0YrGxYf5mocrHTkc3c6vrSVc0bqHPPKql130fmy6CKm5cVKTJxftnz28m
         D7C1VmWjDoJaKxr+a7IptT1VIulV/Mpmm3eZnqXYhi67U2KGgS8JLf4bARdl13GxKgAR
         sF6Q==
X-Gm-Message-State: AOJu0Yw7glKxqqYIUnSACWgmdxWpE7tq9uROc/TIAU5dI4UeMH9CnPBx
	l6MTSygpkkS2Qx/hTqeDxhTDhCuT7W4EAUQHy8PSlmFj6RTLhVbiH7TOQh15xX7tOYJJyqAlbZx
	PGwGj
X-Gm-Gg: ASbGncvtrI9UxuZQRLjAM6EIOIH7L013vrV2XLcXXFOjJ77qscSl0Hmz/0wcq5c9vj1
	NEt+LBWy787WeJNlHB8sOGKkGPx/pTJ6zDx7xBQAJSDEwhiyF5kZECrKn3ZNH8ZMlOffpN6+AGJ
	GXgC+Q3g3IiAGPFKZBymJsCxe0DFLVJcpn7arguJ+6Yj65kiXqmry7QAgaVERSNAztzmWQ0fS4c
	QPmqTRyNCcl11iUBa65iMBkgYmPe310FmQ4lEjJSQ7Q+UDEnm89rUqRyyBLBFkLeRBgUGxKK6xL
	4uRpN36M4htxAZyPcFHI4aJ0VXmGYLN+yOdMem/APhQ/Mj8rtWImM68bst1x0O7HwNkVBq5L6GO
	lNsEtOmzLNc3OSVMlkmO68CJ8bEmIx5ispXrlzkQuYWO5ya/HjmNKhWhywq0OUhe6WW8MTvRshw
	==
X-Google-Smtp-Source: AGHT+IG3uRid+nlptQ+CtHDSNe2nS2wWZ/H3WgMr+LHTGxf2mLTMyL8oi2cJe1X9KHIE/b6QPydqgA==
X-Received: by 2002:ac8:59d6:0:b0:4b0:61aa:e38a with SMTP id d75a77b69052e-4b12a5cc8cbmr91781681cf.12.1755464896641;
        Sun, 17 Aug 2025 14:08:16 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:16 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 7/7] scap-security-guide: upgrade 0.1.76 -> 0.1.77
Date: Sun, 17 Aug 2025 17:07:59 -0400
Message-ID: <1f7eeb8e84811fa79b98f236ade42dc52d44cfc6.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2030

Update to latest version to pick up fixes required for building with
CMake 4.0.

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.77

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...p-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
index 8615f97..4da6c66 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
+SRCREV = "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.39.5


