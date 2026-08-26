Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4768CC61DC7
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:04 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22439.1787777935486617786
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ui0gBouR;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90cd3aaf01bso3127736d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777934; x=1788382734; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I31Vdyl6cARUirtJO4XD3a1m7dRZ6vcf3KuG8CoR+vg=;
        b=ui0gBouRYAhQduyrvkH75uYiD88oq+q4+mXfG4Fa3Reg8BBA93jNv76iZ8XKt+dA5M
         S9TgbSkYIFlV1+zqT0MOeGQAUU9DoGIpG0fNmfiEw/iFkFEw/kLvh9cxUXfdIUq/9EcB
         TJX9Ggd1O2QPUZlZQAjv3mIv5Xk+sNAk7CUN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777934; x=1788382734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I31Vdyl6cARUirtJO4XD3a1m7dRZ6vcf3KuG8CoR+vg=;
        b=CDFKLwBlE395H8F8LLl/4wHehIe4l+u2g0U6m66XOZvgTRgA1G3F01glh5oUwHdtde
         BbNpGj7fKZGuul4Jr/ADnCtsKSvkkNAGPq6O64kKuURACOA1HEvF2AN2XugbOvRJBTfS
         kctFxA8XFv6JtGyCrVDTIBuPIORhqruo+7FgpDYoEt8ZYxT9eJFpfJ2QV1+77WpI0FH0
         dCJzRujws8xWTSNmKRsrnryS26xP+8QYxZg+ViJPci2layoAwp39bgPbaDK+MSMlEJSi
         XNsskqOO9R+MXo5HPX2ZUTUY2oaAwC9B7uO4DzdTzv1YmvM0rPpimIq9WgbQ9EfjQagS
         RVaw==
X-Gm-Message-State: AFuF++l1/H5m3JlrJ+3sUWw2g7OddFcGWaLBURudk4rocjjYJ7EYdJvH
	hQuMREnOgkoJaUL7kkoeI42eKIAGUgoFvIiXJ7LiRjETQ9uPnNM86dhQImp6h8MKvdQW/K/s0bC
	or/uJ
X-Gm-Gg: AR+sD11rWz8M3DPL8e70IPhSVIjJ65VkdUSHWoLm3KpP761utRhRxMoYpnS7AQupWL8
	jS+V8qPE3R26Gw/Dy3ff7EKWC9yM0FuGVk5hQkHoE8OCOIGGJQzhHyMfub9uVcADByNC63p1aJV
	OL4UsvbADDR/xTI0LO4VcFJ84dxdKXkFNn28zuG1V0vcIY40b4xAucIBjYI0XktNFi3wMKkHI+t
	5PVPPRqPU317s+TbZXv+zB1bDnfsO6NySCW8TQERnp1x8+d1+BESH1GEbLF4GE0I40tVgTFL41D
	CyK+vZlQvic+Ba5aKDSaPiQ6gY4bIsruJKM56K+rV5dGl8vpgVXPG982zQ1NxRxOtR9a0QOKY/0
	pYpcXCrJ+EBLJ4fRch21AQG71PjH1PNiK8U2vQVlL3wXcZHPXYmslrt+71evJbyBaBd8CejeuUk
	NNqneHX2JJHGtzK5fwBT9H4p6tVffgHv10o7XoNRyWwvcggWpjDJcPcnhKW3hnw8uFDpLQxP5UR
	5vE47TYFaAKkH+dHr1b5hXI3+dl2yHbHevLPDDmB8Rz2o7gIuuZXPMlalHSv4+QKldzeGdSD3ow
	oBZe+Ik68VRlOrAWcbuEWzjPQ2+3+y/lzb/z
X-Received: by 2002:a05:6214:4606:b0:907:64a4:ca00 with SMTP id 6a1803df08f44-90cc7958781mr127615176d6.10.1787777934219;
        Wed, 26 Aug 2026 13:58:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 11/15] tpm2-tools: fix PACKAGECONFIG typo
Date: Wed, 26 Aug 2026 16:57:45 -0400
Message-ID: <c6025730f636354a17d8441765e67d1b1c06264d.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4703

From: Krupal Ka Patel <krkapate@cisco.com>

Correct the misspelled PACKAGECONFIG variable so efivar is enabled by
default as intended by commit cdb4e444acbb2b9df467d716241a206c9ea6d3b0.

Signed-off-by: Krupal Ka Patel <krkapate@cisco.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 5c968dd..7c5d156 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -15,7 +15,7 @@ UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
 
-PACKAGECONGIG ??= "efivar"
+PACKAGECONFIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
-- 
2.55.0


