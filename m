Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E60C5B549
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:23 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.12378.1748486533320768913
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WFaC7EsC;
 spf=pass (domain: konsulko.com, ip: 209.85.214.182, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2320d06b728so4308035ad.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486532; x=1749091332; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ/rFKhYOtX2WexiAgN2vqC2yw6ZQHSny+K/H2TqT1U=;
        b=WFaC7EsCAOtMYBbWJYYr/vnfWJfqlZEvydJKbcDjZ9E709RL1CKZjDc1NX1s9J4+5c
         6V6TvWPKDwHgCZdXvs0YwAYjcF0epooPegiMOKaVbxEmAyzQ5gAA27kUkM5tyCiZeKr7
         E37lub71RZUuag++6ydTytIj1s1AfHUULMorI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486532; x=1749091332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZ/rFKhYOtX2WexiAgN2vqC2yw6ZQHSny+K/H2TqT1U=;
        b=M2+YCh/V7Tg7P+edk6pHEkEeYUiUGs+FpQlcxsNPw4hQzdeyF7sijHoWIthsy6cBEe
         KAp9ep5/uXZ48aSdh+mgamCrdTN3PCf606VPspid7En5dws+q3RdQIEgUDcGpDTOr76K
         Agp241iexyvq3134E7vpasFVHJIl7M+bf8OK41KDbeL+J0QE5d+dc/ulZAuUCRr4o1rI
         W2OThM7BMR506Duzu9BwEpWicUMZHnWPGCHuD8uXNTDec25qU1UUGOt93VUa040OE9yY
         t6xKjNZ08AhYiAXvG5fCo5/3ayRLNMaH+v33z5i4M6SiZgOsS18LvZnWhGeX1D+r6fRh
         Tq0w==
X-Gm-Message-State: AOJu0YwuwlueHN5ialep723DFFJtfz0X2jNEcpbC70A59vRXav8tZy/q
	4uPkLcBuQlfFr9GdckE/9/DuXE7vPTHW8JTKfb2QZtq3OuBkmA3prcB6TMtNa86KUec13przjvD
	4p0L8yhFG0g==
X-Gm-Gg: ASbGncvphJx4PLWwc4n7j0OSFX6VClQ9h9+5t5VvfrnLvBwhyd0hMzFIxWopmPbKeM/
	6HsmvUlAanvgCxX4dkda8YNIcHVhzW7Bkl7VoqjaSVu2tVftAEQo7jVh8SKczfOUbwgZ8GJGFju
	/m+fNtLLYyudXV1z+sjdAnrmgWjjAjDFeGnRf27saXZmbOO4CMrQHMgSj9SbNbChQtWyzWWI6IT
	ByIzkgVR0X7BPYmKN7igNv8lLx9WqGa9fu89a+sdLP2C7W4wr+uy7MyQwsz8XM6B5zumohy6cIm
	RHWDxDoxbM5ixLZVhd4NplHHBoTQGANN25ZzBc8pBDPr/j/g/TokGVccUHpBdejzol9kZHIR/QB
	z6pX4SRcgGgtl48Y=
X-Google-Smtp-Source: AGHT+IFFgPUrPUiVC7cXsnp01OZ21BABHv0Y26wKkhS4L+EVY9BroTIHTHA8IvNRs2Li48FBH9+ORw==
X-Received: by 2002:a17:903:245:b0:233:f3df:513d with SMTP id d9443c01a7336-234d2c2d2bemr71980475ad.35.1748486532376;
        Wed, 28 May 2025 19:42:12 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf9100sm2748245ad.198.2025.05.28.19.42.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:11 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 08/11] u-boot: Set CVE_PRODUCT
Date: Wed, 28 May 2025 19:41:35 -0700
Message-ID: <fe07c57bc6694fe769fdd2f4faa1b6625a563bb3.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1592

From: Maik Otto <m.otto@phytec.de>

The CPE vendor is "denx" and the CPE product is "u-boot".
Set CVE_PRODUCT for properly matching in the NVD database.

(From OE-Core rev: d2e5d427de13b33694a1d802f5ac833b2c04ced6)

Signed-off-by: Maik Otto <m.otto@phytec.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-bsp/u-boot/u-boot.inc b/recipes-bsp/u-boot/u-boot.inc
index 9b612e1..b9c0ab0 100644
--- a/recipes-bsp/u-boot/u-boot.inc
+++ b/recipes-bsp/u-boot/u-boot.inc
@@ -20,6 +20,8 @@ PACKAGECONFIG ??= "openssl"
 # a host build dependency.
 PACKAGECONFIG[openssl] = ",,openssl-native"
 
+CVE_PRODUCT = "denx:u-boot"
+
 # Allow setting an additional version string that will be picked up by the
 # u-boot build system and appended to the u-boot version.  If the .scmversion
 # file already exists it will not be overwritten.
-- 
2.43.0


