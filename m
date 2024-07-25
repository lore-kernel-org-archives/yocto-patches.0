Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC90C3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:02:15 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.32007.1721898127359674563
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 02:02:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=nP/AfLsO;
 spf=pass (domain: linaro.org, ip: 209.85.208.173, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eeb1051360so7067731fa.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721898125; x=1722502925; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SXA9g/1g2hvjQxZAAgpdGDxQtmVlctPP+APW+fegQo=;
        b=nP/AfLsOt+R+hv+DHvKpg7Otgi0ZvztFFRKs5XRSrCN4FWitTPAJZrWAiTXAN3iTOF
         W+d4JAf1jPzxmU4VU1JPbIVIhN269Kt9D9LQusptvXLH0mHRcgQNHQv+q0NeK1f2f4GC
         uoJtdXVa8k+CHD1gp+BwOiFYxp2Sxm/AVlaJ2n6V+PpO6MsBMYIXqdm6XQYlzu7azUjr
         8mLLakPhQb06DsLPtwHIG//w5+Lf/5/Qfm2C8zfs9dupNnYWZA/DX7W5NCsRcXE43tYj
         8NDkN0Pd/5Rs0f7LyTWQJ/9lyv2B7EuLeMtDgFHFMRZHcFpuMhSDtlRwNuXZAVXQHZka
         1hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898125; x=1722502925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SXA9g/1g2hvjQxZAAgpdGDxQtmVlctPP+APW+fegQo=;
        b=LgUitCXLS8BUE73sTEvIJ8zVHuZsn3C8mNjvW17mp6+OTbxjfB6BO3hFLTBZxYXz3E
         DY1BVnDsRhNi9E6hfuDtXbUff13HWZlwsDI2fuPgxKc3FCddbH2LMl1Cp1f+Dr3IZmxj
         IPPLz2bm/j761rypDawWyI7FsdfxVjYzs99UHS4TeVsn2GPN8m7FL/YduSZt1AxnWMbG
         jgtaA+M7klbSfOW8abP7NgFOVmWxcEsGexRFKWPnJYt91ycqtgPECuQEpauYjVzrM54Y
         yAluUgApJwFxodZgX1vl8VJRPhL3yAN03yyKr5wFZmokHrVNI9iLTMAoJjU3q3C6G3yz
         xSRA==
X-Gm-Message-State: AOJu0Ywsme9uhMmGrnJev6cFFRP6FkhVqub5vCEH1ZeZcu43lER38DEz
	it6YU5oE9SJDSzb/bsLyIR3ZH1OslA8gslLmfhD0Y40MmtB55PQa6d4OAkFLZiLkR/314dC/tGh
	0
X-Google-Smtp-Source: AGHT+IHp1pavsnkl8F+R2R/LrD5HkjW5iNpBfTiBJ4+Mw0CLTGOjj+hFpXBgkN4q8WLNrpj7sq3j6A==
X-Received: by 2002:a05:6512:2256:b0:52f:c833:861a with SMTP id 2adb3069b0e04-52fd3f82889mr1505313e87.51.1721898125245;
        Thu, 25 Jul 2024 02:02:05 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c08d40sm152827e87.171.2024.07.25.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 02:02:04 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 04/17] initramfs-framework-ima: UNPACKDIR fix
Date: Thu, 25 Jul 2024 12:01:18 +0300
Message-ID: <20240725090131.75860-4-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725090131.75860-1-mikko.rapeli@linaro.org>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 09:02:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/461

New poky uses UNPACKDIR instead of WORKDIR

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-core/initrdscripts/initramfs-framework-ima.bb       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-integrity/recipes-core/initrdscripts/initramfs-framework-ima.bb b/meta-integrity/recipes-core/initrdscripts/initramfs-framework-ima.bb
index 58cbe6e..fed4609 100644
--- a/meta-integrity/recipes-core/initrdscripts/initramfs-framework-ima.bb
+++ b/meta-integrity/recipes-core/initrdscripts/initramfs-framework-ima.bb
@@ -25,7 +25,7 @@ REQUIRED_DISTRO_FEATURES = "ima"
 do_install () {
     install -d ${D}/${sysconfdir}/ima
     install -d ${D}/init.d
-    install ${WORKDIR}/ima  ${D}/init.d/20-ima
+    install ${UNPACKDIR}/ima  ${D}/init.d/20-ima
 
     sed -i "s/@@FORCE_IMA@@/${IMA_FORCE}/g" ${D}/init.d/20-ima
 }
-- 
2.34.1


