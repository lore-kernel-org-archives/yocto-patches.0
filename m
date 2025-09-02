Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B23CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:54:48 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.web11.76686.1756817682484666141
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RL/gitHm;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70ddadde494so44253686d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817681; x=1757422481; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KApzBZR+J1H445xNp1BMuzk6ttn0+7VUVsGAKMnuSSg=;
        b=RL/gitHmLnGMXzsHccHR76fDOFR3IO0kggotFRz/+wrTWcKPKRmE6s10WPR6JUIcQd
         x+pwTTnx37s9oZ+7vO6xzXaesNwxn4qc7YvmDaq3+knM5YDYu/1v3oJVuevM0nw5gV5i
         HXUUIoGT7ln8e2X/SajFt7rri9uzezvCbVztJuBayVXAgtNGksvRSEihla7EGDsjTD03
         zjL6LEwJT8br9o+83FuwdiRFBKhlTeEwVlPl2b55vTq8nf3z/pY8L9z4LhiLawRXtllS
         Uci7cxJ3zOsmvg7rqgIRFsGK7JxADDXxnXO7aPpQEtAbzwa+7Ej05aLuS3XEUs+UzLe/
         THlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817681; x=1757422481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KApzBZR+J1H445xNp1BMuzk6ttn0+7VUVsGAKMnuSSg=;
        b=HtCGrrzpvivSAV+r1XqOga/2v33NzkzPwr8HeQ64P1rE35fuAI/MUGGnlYBnCsYSdx
         n3deUFZh9BOSjC3q00PvPrwNlCEqyjDuyaAvxcM8AyGEXzJvCN/uJEYQ/JkSX/Wptlz/
         nEVk91t4mPm5KuxyIyA8ViucZ6s2XoGQRtewUPe92xwxwyfeS0FThYe/hqfukDUfkvHB
         74kdgWq0BoiE7cSMColXpSebkH2Y8gXKeNEqYg5TA7eYO2UvPEFZjRLfBKaJCwLCilU0
         MYvAi9UDWKNOjxhvVVlfbUJpl5kjhbf2Yju7ep34yGZzGh0DZB/iHq6wT774eu8L7fGP
         XEoQ==
X-Gm-Message-State: AOJu0Yx5qMSphwYzO17sgUlrn7ovjrUqeciGTY3FOq+cePTLnxbzk7Jh
	RHSwouBYaDhiSbrP2HVY3+VAJcQ+z/yRJBxLX3A7E7U8aUydDFYEzBxHa/OxGQ==
X-Gm-Gg: ASbGncvIj/r0z1eJbS0/n41nkdrcBDyAXNPewB8Ko1uiOHN6kX66ULDc4Y1JBQQc7v2
	joJ/a2hvRWYimMmmGAnQiDn2N7mjzwHB0J4k64GYVzZZSNkMLpe13Zgv8ibPD7vSuyiEJGWInwt
	jVgfdiXBV4cu6z9rJazxp8jfIDZSRv+iw4FEPxCq+klIA+1W/4iPRMhDvUDNpra4J0JSYyFWZB8
	F1Vf+dKsIDer8NkgvnED581cVIbvP+iwAg+qlKcILa2TJRtkDelgQjsNRYG6SvFPv/UbqboMVd2
	1RvgCgSZEz0YwHzrHJHqQnslb8E7kYRxR86f4rfEtuGwgKhfFM/S4n3dBXf2jfcsKOXZ1y6Bftq
	Rjib9drZ0Tyb2ZltWrNq0dGfkzauiVSeGwJl75ACQBkcIuWvrps1K1yV3u4bSR362Zm/4CurJ3m
	rG
X-Google-Smtp-Source: AGHT+IEUPVgA5ABxKHYw9xJifCYzomhrBEar/hrl9g0/2azyJg8Sjwnn3VPDSRrxA5iyMp/3KoTCDA==
X-Received: by 2002:a05:6214:dcf:b0:709:f328:8ec5 with SMTP id 6a1803df08f44-70fac89e457mr117886926d6.39.1756817680679;
        Tue, 02 Sep 2025 05:54:40 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b644f53asm11198976d6.60.2025.09.02.05.54.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:54:39 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] kernel overrides
Date: Tue,  2 Sep 2025 08:54:35 -0400
Message-ID: <20250902125435.28394-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:54:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2113

Add a :rockchip override to the kernel SRC_URI appends to play nicely when
multiple BSP layers are used together in the same build.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-yocto-dev.bbappend | 2 +-
 recipes-kernel/linux/linux-yocto_%.bbappend   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index e06c8a4f717d..67a16b4d67ff 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,3 +1,3 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
-SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index f0fbe57955e1..75de6110c228 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -30,5 +30,5 @@ COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
 COMPATIBLE_MACHINE:rock64 = "rock64"
 COMPATIBLE_MACHINE:soquartz = "soquartz"
 
-SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"
-- 
2.44.0.501.g19981daefd7c


