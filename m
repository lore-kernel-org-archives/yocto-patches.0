Return-Path: <oleksii.kurochko@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CA0E7717B
	for <webhook@archiver.kernel.org>; Sat,  7 Dec 2024 16:23:49 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.63032.1733588627656636535
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Dec 2024 08:23:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UgxM4Joc;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: oleksii.kurochko@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003943288bso13578111fa.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733588625; x=1734193425; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9RzY1PbK6RsIcjWW7PgwkO5mL5mRTTdKx3FU7v+2+c=;
        b=UgxM4JocgMZt8UMPpYO+wR5bg5R4X3kEhusJaJMbQXVBTJwtSNI5rbhi4d6B8qdc0T
         wFG2tFfq8DqG/mcWCmWIk1V5/SyuXr2Gb0AEL7YSNMhfvnbnWbAgt1A5I+yN2VjDlrRC
         ZaVd6WIrF6pmIzt0Uspvj3Dq4pZFTQML4a9IYLRcrV05LSk1wDc+SdIXp17Z6HCe/jzN
         lfzrgw8C5YVouFmaEF1Su/KvjAODiTB4u6keg5UsKGLruew8A4QaCJO+FkU0+jzOTQyh
         6mGAK9/BLLFWWBSPvXIluSEKjrlBUh7ZMems+0XNYJBUATfpd1T7z/COduvGSLHExhTx
         YpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733588625; x=1734193425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9RzY1PbK6RsIcjWW7PgwkO5mL5mRTTdKx3FU7v+2+c=;
        b=iOPugMJQ3K1bsPlZFLZERwi4PNc2gR+Iv21BbeOZ3OcwI9C1wMYxc0/Ix8VMYT2SaW
         lTJCG7Yt5oT254XKFoh8lAeoH9ubE8yfLhfRcPxV/iyndFNFfkAbe4Glcf/adofHlsBr
         jSeDi/Tojis05CJnCtwXJxzC15cghHtPhqMObXlea4QGXHsPJ0ycaJnK1IWOoohmSbE5
         cAETY4LGjGmcFSUzu6GICOinGs3ueNMthkyIqC8eTpUabiVRVWTm1zQKOlmnmGoV9GZ0
         Jsjt/VHQ/w86MS6dQmGYLzruZVBRH+YDLhN18J4/qt4pBc0QAgdiceR3Q1cVl3e8gyLS
         0DXQ==
X-Gm-Message-State: AOJu0YxF69kgjARGRDDoqGy3jDYCJJK4vI6xOLVZUjVTMNxtaVoROBZK
	ond1eJ3WFm/4Zav9QJCfvuY06jxnh9SGBOJFCkuQozas5QxFXwgJyXxzAg==
X-Gm-Gg: ASbGncunys/Wiis5xRN6Cr+1+q97pkFcla80smjeWyCw1kg28QCHj4Zn4Fd7EdK1IZM
	lEMBXNDLEmNcnhfV9VNf0d+CXqOk1Nh0LqMDQBlgFWmdseUJCn/uQCbwDlahTp67YD6ggrGM+/p
	G62e2TrouazaxVYS3meHu/Pphz1/gthLYUJv+oVuiBpILlzP6hE3cpCLwpoXxDE2FQ+aZzmZmb8
	0Ju3mh5AEzUZEbb7wUnm3OX2qy6m/38wSUsBmOcno+NrZ+JsLc=
X-Google-Smtp-Source: AGHT+IFMcO3C8dCfzyUdh5jZiJ2RVMgyytCy85mZuh3H8QD6zdjIYXnqIQBOigcKAI62ydt4qEUrgg==
X-Received: by 2002:a2e:a98b:0:b0:302:1861:6df4 with SMTP id 38308e7fff4ca-3021861726emr1673991fa.35.1733588624972;
        Sat, 07 Dec 2024 08:23:44 -0800 (PST)
Received: from fedora.. ([94.75.70.14])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3003e55a81bsm2398671fa.59.2024.12.07.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 08:23:44 -0800 (PST)
From: Oleksii Kurochko <oleksii.kurochko@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
	Trevor Woerner <twoerner@gmail.com>
Subject: [meta-rockchip][PATCH] u-boot: Update SRCREV for radxa-zero-3
Date: Sat,  7 Dec 2024 17:23:37 +0100
Message-ID: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Dec 2024 16:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/868

During the fetch stage of u-boot for radxa-zero-3, the following issue occurs:
  Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781126c8c in branch
  rk3xxx-2024.07 even from upstream

This happens because the hash of the head commit for the rk3xxx-2024.07 branch
is different from the one specified in the recipe.
This can be verified by running the following command in
<yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
  $ git rev-list -n 1 rk3xxx-2024.07
    2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead

Update the SRCREV to the hash of the current head commit corresponding to
the rk3xxx-2024.07 branch.

Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index c939a48..9432e2b 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -3,8 +3,8 @@ require u-boot-rockchip.inc
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
 SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
-SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
-SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
+SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
+SRCREV:radxa-zero-3:rk-u-boot-env = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
 
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
-- 
2.47.1


