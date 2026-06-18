Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DF8CD98F6
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:14 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22679.1781798051779033688
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 08:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bJ05i6hM;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so889485f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 08:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798050; x=1782402850; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgw0X3ChIgUjbp+w404bMIe7IfoJ8wM5Hl/2v3zrKgg=;
        b=bJ05i6hMl10sGiUtQCwjh6B4etD+C75SiNPoAZGp+l9lxff4eaGCzA2lLTTBEwTLL7
         T+1BVDpaDsDMauc7fHDr/0oOAGi5DJEmTRgb80uLT3v1F00VVc7um8+bWz8EOA0r0Q/S
         t97/BckNFSqJwFeTbWS5y/uFDZ/psme6B6pJZVepKpD3gI4vppldkRbxDt6eSpOv8XSy
         VO2yh4mp3OgJxFPwRRq4atM3gwDsLVNiUI8vgXTkjWmZBOWQKNBBDnhaAOr+7YKYfOck
         S4m5VNMpCFxl7lhsJ/5hq/XRwUMGmhYj3mwaWfjCgyyYVok3m+rTBVKgA+o/zDF9ruxD
         AqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798050; x=1782402850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dgw0X3ChIgUjbp+w404bMIe7IfoJ8wM5Hl/2v3zrKgg=;
        b=ndJ9DYIRK0e96L8fAPwhM2KdchwV8EvP4Cs37kusFWxsBVPQPl4L7+d+6XYdxaj1gh
         LYasLzjUeG7S/wXx3vuQnkOvnPAbxFDZ1WCL5H4dCsCz2PC0gWWNWPZr8wdm9z+0gFuj
         aEWoZUnh/f8j+FzbWwj9RUmf1BBpA3f4p1jVGEkH5s2Wh/MaScLu2Z9j5cOBNSZ58WN/
         NlEpZAXoS8Ue9XWN0zzeoJAvtEGxr7Egj0q4k1UwUtMTfmOSos464ddb5eLWtTtf6VzF
         TaWzmIv0LuJTUwYKGTujfh5i684KxkYfwa8klJ+kesC+lwEAT8EZLbKEsLKSo8VPYtVP
         IfKg==
X-Gm-Message-State: AOJu0YwX/HNYqDIq/VcOvHACXunqjEHQF8oFQ06reypg+XfMKmRZ/yER
	9Gf9N9HyBuWSIvpeD0rgHbbSCDMkWCqkfbCJgxN//L1LmHNeOPP4mHXi+6MsVw==
X-Gm-Gg: AfdE7ck9jc7KoTepYoTOslML7qs1rLeVVbBL9656dd/JFaoYSts9jy/cUlCG1qm9HyT
	Po7qC0jEAG5DF3mZeyQWyHECqYUBMUWNdESpos28P6e116yelPm5nsnAsEPNW5eCyxQPfVqKrOD
	+JK6L9dXlhcszNfgDEnqVQ/2ROTMV3Njk9O4iae4tEZHLg3et2668bqmwX8j0SDamv9FCtIuYcC
	19OVM/Ir0sBMUMv92HlxfDtpUHyx4NS5ILW4khNptAMpQ5B1Ml4zMHHjViU7GbBuJpdoKdQZwrh
	H+8fZp+hKeHMqWKclNIZtHdQhHovFfb565iW4gIC85WADZd7pbWUwdyOOags8skT3zlVJBaIJcK
	IDxF1YTyl2RK7WH0l9df5oasXhr2iouzMsxx9xFTCo1IZMkReFwO9DNzY+H5XTFINKqbLyXwYiS
	pUq5uxTOKBeCzLuWD47Tn5TsxdOSK49rwvWYsCx8M3ZF2RqdcRIoAHkOX718kjaN+4mVsuKTnhI
	1I95Prl6WvKyjwn
X-Received: by 2002:a05:6000:46ce:b0:452:6aaf:76cb with SMTP id ffacd0b85a97d-464ffd794bcmr55286f8f.1.1781798049497;
        Thu, 18 Jun 2026 08:54:09 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm29005560f8f.22.2026.06.18.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:54:08 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/3] linux-firmware: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 16:53:52 +0100
Message-ID: <20260618155353.3633997-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618155353.3633997-1-jose.quaresma@oss.qualcomm.com>
References: <20260618155353.3633997-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:54:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4245

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
index f2cd873..50df8e9 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
@@ -3694,4 +3694,4 @@ INSANE_SKIP:${PN} = "already-stripped"
 SYSROOT_DIRS_IGNORE += "${firmwaredir}"
 
 # Don't prefer it by default
-DEFAULT_PREFERENCE = "-1"
+DEFAULT_PREFERENCE = "${LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE}"
-- 
2.54.0


