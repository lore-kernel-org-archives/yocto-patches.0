Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798FD10394
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 08:40:14 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9046.1764146405800117515
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Nov 2025 00:40:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZQTt23eq;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73a9592fb8so176522666b.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Nov 2025 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146404; x=1764751204; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rhy6hWv5D0sDFebQ+Bi/pT4Eo2aAJ6M+vnccTl/nNY=;
        b=ZQTt23eq/c5euMn2FqSbaUnHr7UKvrhjTncuHyCP0KbwSGUsjP8KWeysblb62V03CE
         /oW0ZLsEQtrb+N22rXO71DR2rQDbEfOIcGndOFMKfTbLIF+9quc3EtHY+lZKVR3Y4PJu
         gsGgXOOxw4BWbv7qT92c6woxUXdzol+FhWKF2Ih8MFXkE5+lpWfR9vL2dtOTfLE28lXz
         9QE7wC2hHS6LoQn2IIIt5/e8reVB/46bx4nhyRlfD3L+IoY3MnAn8jVTJCJsdsVgnZfw
         Dfyu/XcnW1YysULOCs7ShR1E9PFXEfiq5VD/eCIYEJo+KNW3vhCnRFPLKPqxTjbILNat
         Roag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146404; x=1764751204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rhy6hWv5D0sDFebQ+Bi/pT4Eo2aAJ6M+vnccTl/nNY=;
        b=MPvcZCxbULO9bYBDkvr0dVGOVokbZVd7D+58v1nfYDXzu/ny5t1cVC51Yw8OaRZhTp
         1ja2tm9rw5eNGMzyhmUybKaeJraEUI27aC+WD4G8OqIepxejsEMV0gcJ7jjLiPC6DWgX
         1xXjlCKRZCkQrHg6QGnjc/A1zMWghDu/+VPAHoTFTHmU4pBbyd9JlxKDqYLFbgxZaynV
         Q/TNeMWg4svWkxJnSfcH4nb+sRfr195DeyBtM6sbP/+UcGuViIqBq9EdOK72Ehp/Q1Qe
         CkDon1sG/IgBn/eQQy96hur0cKbuwakORf6T23uy8QkornibcDdb0HylHYpOWFKqFN+p
         6TnQ==
X-Gm-Message-State: AOJu0YyFkUBO6wqm91+o/NQGN/ESUOYeyEZyMLoFHTZKJ+bUpENLeaBA
	sVlR5CqEgGgqXTgauVl7eFUM4sBPgyYIPVfpaGkvcwg014mWZDIzSqD5Ih8euw==
X-Gm-Gg: ASbGncvjpYEqf7NdKqP9j0eOD4h76RESTtZn16+AewxW/lKOEW8iYyemE2ROJD1ajnJ
	zkIrjVYLs3nvR9x4dpjgyarQlZBpvu4m2MFE3KX07tH5HW0yDCJtR+dNDJQ2pIk2fsBUvKgEU1k
	3R4LHDRyqXzVuLb86h4WUWkPwm01R3LnZlEFAggjjMtydgLVMbslOsYxisVkpMr5O/sF5HI6PI6
	QwIgemlm2tsoMkvLQTAAxfMZrt0NKppxlO42YieyKVDSRM0wwUgSJUKKiymZRqX1WPfKYSnw+kO
	mYFXTrW1kzgxGcFDrF1d0A4RxRS7XHteNymRlmM0SC2iO0ykg8Io/opd/Brb6s20j2DvWfWtf/2
	Z7ciKU6BHbLgiTaC1GDXvmgRb2qxBMHa/Pp7WOq4aYlDfgI9AdEdnOiXWHhaJJpU/QPtIZHaz5Y
	i8MydrjUYkM/hDNO/Er5iGjQK6vOaJgAV1iqX0H/LCOqeVRYqd1Us=
X-Google-Smtp-Source: AGHT+IGlkxRDqFzfQ6aw79Y07kk2cvVHdU2wqyr9oqxxMPvhOUYONf1RUZN9ZKBrmZKeIsGlfPNjuw==
X-Received: by 2002:a17:907:2d29:b0:b07:e258:4629 with SMTP id a640c23a62f3a-b7657285447mr2718820166b.16.1764146403788;
        Wed, 26 Nov 2025 00:40:03 -0800 (PST)
Received: from alex-lx-laptop.lab.linutronix.de ([2a02:2455:86ac:8b00:8de8:97f1:4c58:d8a6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765c1379ddsm1726134666b.0.2025.11.26.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:40:03 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [yocto-autobuilder-helper][PATCH v2] config.json: account for oe-nodistro -> oe-nodistro-master rename
Date: Wed, 26 Nov 2025 09:40:00 +0100
Message-ID: <20251126084000.1828294-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Nov 2025 08:40:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2712

From: Alexander Kanavin <alex@linutronix.de>

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index d9f14e0..db58c18 100644
--- a/config.json
+++ b/config.json
@@ -493,7 +493,7 @@
             "NEEDREPOS" : ["bitbake"],
             "MACHINE" : "qemuarm",
             "DISTRO" : "",
-            "BBSETUP_CONFIG" : ["oe-nodistro", "nodistro"],
+            "BBSETUP_CONFIG" : ["oe-nodistro-master", "nodistro"],
             "extravars" : [
                 "INHERIT += 'uninative'",
                 "require conf/distro/include/yocto-uninative.inc",
-- 
2.47.2


