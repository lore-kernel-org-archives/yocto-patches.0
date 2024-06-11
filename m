Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E2C27C5E
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 14:15:57 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.10738.1718115348622886317
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 07:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BGM1eysm;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7955af79812so174586385a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718115347; x=1718720147; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBzXE6hJOPeOM1wLU+anPG24q5m9cR+BJIwx/e1TYLY=;
        b=BGM1eysmjzBo3gC8d9oP8TqsOze4C6qHYIyK3K2hFHHJ5pyD5rHknBB0H6j2m/7m4D
         aKOsZlx6IngmFUjSJDFlKGJ7y1LTqUFGfqQ1Jn1nTdXbc9ihGrqAnVQFG9C047I3jLAj
         W8uhRCEAORXnjWjt0c2WmXqPCcH+NN0S2aCJDPv+j5cqtPbjOjIw7KNV3TLBhLUWWXb8
         kDuOsAjIjUDfy8NL6cz7nD14gRxaUOX55IWE6LtE64q8kM5GcocFZErBHophYhfkVMIk
         2Y2o4ZLXsRMmehOBDKcKyocUUyH99KLMfK2Ds1Sg/nvWh0N4FxW53fn6xP2ELc9VRxEQ
         X4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115347; x=1718720147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBzXE6hJOPeOM1wLU+anPG24q5m9cR+BJIwx/e1TYLY=;
        b=kaAJnVJOVFL5T4uL1lwbsUh1RkGHiDvfrHovGVaKw415FLRXzkGYx7dm5aWj+thtss
         0htZNnsfB44UQwHsqY3sWBYjmPq0j8Al1RmtnclhKoYEyv8DKBiM1mGgtHl6kwFoW/Dt
         Rv85wqst4yfGw/TIE8zttoiX/fiLEnNIG0N2Lw59kVGnGS9e48ZcqSdRH0T8uBCfXuYi
         a64z3RmffrBu0uV3ffTlve427rsxxhY0RTfCDFCgNb/Qsz0miiTva9qaEuswxOczI3px
         V71UIxFrayjtLjafC07rehy3O5XALuOZXhal4pdmQZxQDzesnGUTwlTAZCtMIUAOfbx2
         4l9g==
X-Gm-Message-State: AOJu0YwhA59cztW/52LpSp4vOrQqW62+QXxe84zu7I7GYS9JEFTC5Xkv
	E30H0nYJSeiT7ZHxHZvP3IlEPyhB/MXB9sEwuDTZXwZoxo8KkFZD+2Et+Q==
X-Google-Smtp-Source: AGHT+IGbT9n27mL2RppL/rhzSiTDP0vAUv2fmGV/IqTn1sxb38cWdUlo5lU+f3JCG+IfjK1PhYuAOw==
X-Received: by 2002:a05:6214:5c01:b0:6b0:732f:b92b with SMTP id 6a1803df08f44-6b0732fbba1mr82836066d6.12.1718115346488;
        Tue, 11 Jun 2024 07:15:46 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08925291dsm11002466d6.118.2024.06.11.07.15.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:15:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] user-selectable wic format
Date: Tue, 11 Jun 2024 10:15:40 -0400
Message-ID: <20240611141540.4209-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 14:15:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/299

Allow the user to choose their preferred wic image format.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/rockchip-wic.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
index dab61d83ed2c..eb895cd0b4ad 100644
--- a/conf/machine/include/rockchip-wic.inc
+++ b/conf/machine/include/rockchip-wic.inc
@@ -5,7 +5,8 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
 
 SPL_BINARY ?= "idbloader.img"
 
-IMAGE_FSTYPES += "wic wic.bmap"
+WIC_FSTYPE ?= "wic"
+IMAGE_FSTYPES += "${WIC_FSTYPE} wic.bmap"
 WKS_FILE ?= "rockchip.wks"
 WKS_FILE_DEPENDS ?= " \
 	e2fsprogs-native \
-- 
2.44.0.478.g7774cfed6261


