Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D520FB5E8D
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 23:23:23 +0000 (UTC)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.64465.1773703401626566946
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 16:23:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=C4tzEp3q;
 spf=pass (domain: baylibre.com, ip: 74.125.82.45, mailfrom: hfranco@baylibre.com)
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4e9694so1393945c88.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773703401; x=1774308201; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=893CgwWRFld5w0uSHF7/Ak2Osln/xGz+Yq9DN9i8fRs=;
        b=C4tzEp3qYAwKZclJ21cM/AC8RhH8T+71ptipRWqTT145vnGz/lxjZTXQRg4PVmdkNH
         rdWViKWtrhfPUku0PcnhXbhSPP/xU1s3XA/8G/mSYsPJoPCXBb3Ju/lAHRR5B5nrpdHV
         UTKdAZwmIHcirKDKj4OJiZoSmAGNmCgS74yxjLRYwtw1l/Qz1NPWw/HloynMZPK1QiFR
         TsfzKAwR0uwK21MkxM59W7Iy/IjXDoojx3lhyFBISbdB9i+s3RqTF5sOAkAO4wFq1dvC
         t9Jl0h71xrnyBaRnbOGWkfaZsZs71AKHiRpeOujXKeIbCKH455N7nRK7lSFqrKkfo8i7
         o6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703401; x=1774308201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=893CgwWRFld5w0uSHF7/Ak2Osln/xGz+Yq9DN9i8fRs=;
        b=CWqJ/Fj0RRARkYWDxIpPQXUSb1VaetHfaHWu8cnMeDnI1gPwQ1nHyBdGpemwojiJMr
         Fyvd7T5yKJcvRE27lPxKGS+f2q2cp/erlMPl4iwzN9fR1lONlhbBSeXCiCBr9kWgY1GQ
         nkOWrQDOV/HZeYtOvReppmIN+nrVwS/okal5/i3IntmOeW7KmwNPhNExq8qyOSlcs4Px
         zIjtuKVpqRbsRs61wh6img606fuZQeSwCXldWkwz5vfo+7gmnlQjreGvFdw5/6uegfRe
         dPD5B5QX6/zEGnQ4YlAEdzesMgbV6H/JLlf/71IZi96/SBmYRP2Qv+49RcjGwpjQnDu5
         3Czg==
X-Gm-Message-State: AOJu0YyAoJaxyF1Ruu3YI2/zHEO8Bd4Z9yEtsHQwfMuTAS0jgJ8DJVYd
	DQd4KvX+n8ENfUhowUgw5xYn4X4DeI7TVliO5p423B5qAiGIHYZfTyj55WVprsaNsdYAp5REKAz
	JPGByESw=
X-Gm-Gg: ATEYQzziGpZhOYtkQ30wjeYbw9HcH1gkSkfQkXMryn3o8Bd/wy1VPvYWdjkGJ2aNS4a
	nRKZuWifi8IX3BzllxQPRYNWQIZqATYIk0zjmF8PjxRWrtRO0WALoBpF0OueulVeGNVX8hHXJGI
	WQc63NSCYJqSqdCA6sl6icInIBfaRp7lb4uqsyRMHvub5AGxu0tog4XD4IPqXAtN2MvSb82cPBJ
	q17f6qH+laj3SHr+tAe1TPWwRSunqkfDy+H633HBz95SoQIUwya2JyF599yHLd6KBkf1kJbmSfp
	wcdxQ4Ds54bzJNiO387kUCKqk7L7UcD2KH5o5TfB4P6+0UOLWhs33zwgrrr8DOjWNREykdDy9zm
	Xb5soiqYS1Xub5xJMf80cjU9ecXRW6jIjyJWsbjRiTfXkKBs9HAmC4yy0ILU+lXcNdyR6LmNgw8
	qguRfnRykVdcTRua0b2HNYvLf7Cc2Z1X2PTqtMeHjhFtw85dMpUI5Nh0RU6O3kJHmBM0lSleMTc
	zC8GqlmhjONIfk6c+49
X-Received: by 2002:a05:7022:2393:b0:11b:2de8:6271 with SMTP id a92af1059eb24-128f3e350bcmr7711765c88.39.1773703400576;
        Mon, 16 Mar 2026 16:23:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm13492586c88.11.2026.03.16.16.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:23:20 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
	Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>,
	Yi Zhao <yi.zhao@windriver.com>
Subject: [meta-selinux][scarthgap][PATCH 1/2] selinux-image: Preserve SELinux contexts in tarballs
Date: Mon, 16 Mar 2026 20:21:57 -0300
Message-ID: <20260316232253.937832-2-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316232253.937832-1-hfranco@baylibre.com>
References: <20260316232253.937832-1-hfranco@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 23:23:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3480

From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>

Tarball images were created without SELinux context information,
causing loss of security labels during extraction while working with
features like:ostree. This breaks SELinux policy enforcement and requires
relabeling after deployment, adding runtime overhead.

Append "--selinux" to IMAGE_CMD_TAR to include SELinux file contexts
when generating tarball images. This ensures security labels are
preserved across image creation and deployment.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
(cherry picked from commit 9a913243ffaf26e06f151c3c293b62e28ec549f1)
---
 classes/selinux-image.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes/selinux-image.bbclass b/classes/selinux-image.bbclass
index b4f9321..852db5f 100644
--- a/classes/selinux-image.bbclass
+++ b/classes/selinux-image.bbclass
@@ -26,4 +26,6 @@ python selinux_setlabels_handler() {
 addhandler selinux_setlabels_handler
 selinux_setlabels_handler[eventmask] = "bb.event.RecipePreFinalise"
 
+IMAGE_CMD_TAR:append = " --selinux"
+
 inherit core-image
-- 
2.47.3


