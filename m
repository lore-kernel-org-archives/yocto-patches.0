Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14493.1795779654633321156
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 03:40:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=ywfk9In1;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-94958650b09so760564685a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 03:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795779653; x=1796384453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTooZ8VNHmwR9MY1P0vk1IwBBvMplum6w1Jjfzxa9co=;
        b=ywfk9In1S5vDVAQqL13Fiw15ZNrfIo87vKIXDnDfLJVcwFMTyJ9o7ZchLZxnecVGdP
         y4O3j9GpKudWWpb0GbSE35NLtK7MbU0zhAn0N951bmcpXgKa9fXaT31m5wnIjSpDy74e
         8EUH+7oeEjmW3+MwTRCHuQ7KbKf878VV4zkOotveKa5JyPy141xhJ17SXDTzmWst1EsB
         rNgGNC6Y4GWKEG34c2FWW2vw69ERlcEnb6a50H87SAPMb39lvGQhRR8EYGMMQqBMmg5h
         uHBT3ISAzdOXSjJnz8z/OglwGFA46feARMiHvZPNGniFonIUxwBogdTCfIbIDKBgzrJ+
         FZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779653; x=1796384453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTooZ8VNHmwR9MY1P0vk1IwBBvMplum6w1Jjfzxa9co=;
        b=oyMZKfexHCintbuOcUs10lIVzyd+xF0/+BhDvcyJQxM5x5/j6ql7eQcN+X7L3j8h6C
         MzjnNTDIIRdnHHBQSEtB5KTTSeQirdHb/woqB2JDJpU+abbwIIUawz9oSjUiq2niKmp/
         3GsvIleslUFjIn7unGpzOdaWf4KwQULluE72PgyP0bZfu5V00zN65b9Q10yceIll8GfH
         ehzST/T3yroZfAlnBIJfYRRGkoNdooUMHcuQdwsGxNNDyAGWGx3EK41i3i9sAPvuZHsd
         Ue5ycNJKZYTNzMYz8jQVsDwcWalH6keVmn4IUY/6L7C9LbjELl9/D+DjTEi56+386wbA
         lrqw==
X-Gm-Message-State: APuU4Z9aBiQea7yrqrrRY6PN91UkoEf+HjmJrLrnIhsNCiuRssUTRokS
	C5ZBVwRn0Pqf3MphjbsoGFlfneIg7+c80xeyHs3zZiH6iUHisF6/9FpDj1BF2g==
X-Gm-Gg: AZFdTZfbWGzXekuMM5uETPBggDVFwikNT/c9h80n8vrPA2u8snjbDkfjteUWkMoIVhb
	RuYaWzgwyGUv3syS42jM7IgbmlJG668ct5KMCKfOmcU5ynDGfRTKSLVPOV82RXzNvJ4ldZz1CEu
	7gpIZ/PjEehRNiA61ev4etnVGudnQyVCWzzGqT6MNCiytmYlpLavfkVnUL9nVnBAhuc9swyJRJs
	j4TJiEG7Bli7+mE5C0bl0ftHpv+PO2pT2C+w3ezH1GUaYUjAbUrfGKB5bYkyK5JCkzvjsfHxpU3
	exYIst890/68WZEX9hTOedH3moGKKMud8bFudgUpSuWaoEMiUUzrK72RUGfXx5Z5wuSGhpEFrIu
	+moGc3EiSf9Eppkhrmjtu/sQJrHVhT5E1miorVIJ08sqrp66C06NErhsdOCo5FYelbUm0wbWyC7
	IHhI04B4HUNt2k5OfZ6T4vAZlQWN7CcPdzdCbF4Qm2QaqZo6v8ORMunaf3gstZHloQpaenKHz03
	Y7CCHRxvgNwnSswIhg5OUSxLu7oKFE6KNaz17ehXFCxrGHYFv/qigdJ2WajWz8Q5uuOjMcc6o1V
	a/t0dtTk7TybZfrwL19cw4jHCtRnWvwmHKKP3FS4LHiP0jOjs3jNrwXqy8ZVjL6IgXLf/BZcFaR
	OcFMZeSRzbk/sH4H8AnATlYmULzIEtAY=
X-Received: by 2002:a05:620a:1b81:b0:949:7497:7c17 with SMTP id af79cd13be357-949ba96eaebmr4285783085a.19.1795779653559;
        Fri, 27 Nov 2026 03:40:53 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031601sm1800526485a.6.2026.11.27.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:40:52 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH 2/2] kernel: build the rocket NPU driver as a module
Date: Fri, 27 Nov 2026 06:40:49 -0500
Message-ID: <20261127114049.3566943-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127114049.3566943-1-twoerner@gmail.com>
References: <20261127114049.3566943-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 11:41:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5548
Content-Type: text/plain; charset="utf-8"

DRM_ACCEL_ROCKET depends on DRM, which the arm64 defconfig builds as a
module, so the fragment's =y always ended up as =m and the kernel config
audit warned about the mismatch. Ask for =m.

Cc: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: codex/claude-opus 5.5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
index 9f6af63928c6..18dcdc469904 100644
--- a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/rocket-npu.cfg
@@ -1,2 +1,2 @@
 CONFIG_DRM_ACCEL=y
-CONFIG_DRM_ACCEL_ROCKET=y
+CONFIG_DRM_ACCEL_ROCKET=m
-- 
2.50.0.173.g8b6f19ccfc3a

