Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373AAC3ABC3
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 15:03:21 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.774.1746630193008898146
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 08:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=xaGR/+FB;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54993c68ba0so8967928e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746630191; x=1747234991; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDjbm3g3Y2w+I9GI9GY3iJ+A5FTGHIS25XBiaHgm/q0=;
        b=xaGR/+FBbOc7gX9p04dn+xvVeNJc2gwadMFkOPOSH1r9q2e3IFMiVEw0msVd1scFvl
         k1lAf1CcaKeftrMqvFCWgNfzLPfD79LmecB59pu78K6LcImUgmBl9/RbTKZNFUoiOWAT
         7PIKxI+3t0A4pYgT+uxBzh4FeOdEZHgPJyofwnboXZT+gxBfbR5D9egFWdlHSrpQlKS2
         6ovm4GALaShlNmINnTKY1juv+fFEzC32g+WbNe5C4WzuSJKOa6sjA5z2WTidO8G1bjqR
         TIpgLkb9Vi5IB8ZGjHSe9lEvPVtgSo+M/tLVVZR+4zO/3/kv4i7wFlLVc1+bl+hPscPw
         9bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746630191; x=1747234991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDjbm3g3Y2w+I9GI9GY3iJ+A5FTGHIS25XBiaHgm/q0=;
        b=WOGtt6lZWCFWH8H0Pi7T0NSeXN5ayhi8rnaz+Th6gKWn0Ik5m9BFagujIVfyJQ/O2c
         pIcAtlIpI+PXPMjRGkTUUjHwGeKU9nKPezqTzfk+cYYhH4EojRews5vFaUne50wflP6z
         R7zCWhHhnBfh4HWHzRNc0ljeDt2mpNGu5A0W5W3OudMfCswxSLYhopjfrAFZT5zCBhtF
         NnYYOR7BzMrlKGVYcsC21p9PSv7EYH1pE+CLg2F2Aj8+EUBM9c8SjTTkkdTMF6SWEQp2
         f7iNp9WJh/8N1AfH8zngfsZ5T3C1QhbMnwq0VQWDM9vJbY3i10QkNlIx4ZLTIz+e/xAh
         Mr8g==
X-Gm-Message-State: AOJu0YwOOneMBC9FvcXPOnHLOMjzYvW0gzHlW4CMTTvk5Teuy1F5dRGN
	mva7pThbTG+8h2Cev8pphVn840yWMVbv59BAGspVHtxpa940H08DSFqfvRv6pklUuofU0xa+Z4I
	NA80=
X-Gm-Gg: ASbGncsgSSwQmZ5YkjmSHG3KuD9XpNbKNTYbjRSze7Isv81nHOOfJV2q9gW2ZTNqoFK
	4VYAN0xqoUkTc4TbBac11BmNIC++iNILVgJtV2i+zUT7jiXe4KCfNyF+YNHJaDsFOHPnOIVve8X
	SUJnEIZEDedmF7GX2k4d+oleLBByU/RbcEw2FfIm2NGAf+c0czAaIk3ZKwi1zCSEGnv1a1qfyNL
	8J6yr8Of+6Cud6Cl2aA1Jf8AgdSB+lf6uIp0rnhHeQ3YXI0DjgfmX/xdIrn6oD42/vF03jz2gEI
	pbXZfXKSIt4/rgMCYhifEu/aZylTkv51Vw2KJ+wLvFIseJH6KOJnrHkq2tVNed/JMO6qJslhsqq
	qo3llLbBXuMOPEOlP3g==
X-Google-Smtp-Source: AGHT+IF73vtnDvIsPXj3K51vnFQmhwhD5TZgo/6mKuUsf+oVkzQFB/rJzGCPjBwXyPBFIB48qJXq6A==
X-Received: by 2002:a05:6512:3b13:b0:54e:85bc:d13e with SMTP id 2adb3069b0e04-54fb96503d6mr1353029e87.52.1746630189458;
        Wed, 07 May 2025 08:03:09 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b1784sm2392059e87.49.2025.05.07.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 08:03:09 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>,
	Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>,
	Khem Raj <raj.khem@gmail.com>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Trevor Woerner <twoerner@gmail.com>
Subject: [meta-security][PATCH v2] systemd: disable linker GCS warning on aarch64
Date: Wed,  7 May 2025 18:02:47 +0300
Message-ID: <20250507150247.1408201-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 15:03:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1529

openssl asm code is missing GCS branch protections and
linker throws a warning which currently fails the build.
Ignore the warning for now since some branch protection
is still applied and only GCS is missing. Works around:

.../recipe-sysroot/usr/lib/libcrypto.so: warning: GCS is required by -z gcs, but this shared library lacks the necessary property note. The dynamic loader might not enable GCS or refuse to load the program unless all the shared library dependencies have the GCS marking.
collect2: error: ld returned 1 exit status

Cc: Sathishkumar Duraisamy <sathishkumar.d.cbe@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 3 +++
 1 file changed, 3 insertions(+)

v2: switched from meson.build patching to LDFLAGS since that works
    as suggested by Khem Raj and tested correctly by Trevor Woerner,
    tested on genericarm64 machine with swtpm on qemu

v1: https://lists.yoctoproject.org/g/yocto-patches/message/1524

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index c53b1e8..deb9164 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -1,3 +1,6 @@
+# workaround to GCS branch protection warning treated as error from openssl/libcrypto
+LDFLAGS:append:aarch64 = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', '-Wl,-z,gcs-report-dynamic=none', '', d)}"
+
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2', '', d)}"
 
 # for encrypted filesystems
-- 
2.43.0


