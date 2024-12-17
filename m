Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F28FE7717F
	for <webhook@archiver.kernel.org>; Tue, 17 Dec 2024 17:21:49 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web11.87385.1734456107617854029
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Dec 2024 09:21:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MbmFciSn;
 spf=pass (domain: gmail.com, ip: 209.85.219.175, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3983f8ff40so3362266276.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Dec 2024 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456106; x=1735060906; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvuP7Wb0zS6+me+H9QjHYfQE10YUu+Hsi10gUorDLwM=;
        b=MbmFciSnyFShYCwZVhphjKFxWgnqOJpy0wXGPEh6EIh949+VgPgYPeTp6ilJWEaydM
         BIFU5thEPnkOXPCWn5GUqsOatwehT4Q0JZlokpbW67uxqpUWejGLu+KW1iI/CBIHDzkk
         jufIm+/Ksol7BGZDoeYkok0Ui+0W/9dIakgChJTG0bhK7AbzSuf/xKJ27gninEZlV3TT
         xUBazE3bLL7ddB3PPMtSNA/LcU1OAsikmXbT5c01WbNe0s0Wa5z1ZU3o/Uej34eUj09/
         G68nsNSmpcTO0xnGYFTCJB70vJO2Dnaa6sz/ilCNVe8KHFT/9UTVNAzL2yFkvnuQf8os
         x+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456106; x=1735060906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvuP7Wb0zS6+me+H9QjHYfQE10YUu+Hsi10gUorDLwM=;
        b=GVQMneCY4F2kFRbdHpn/A9ECuAClgrRZiANRyPp3BbQ1IH9GIhxgpkl4JWcbJ0qcLt
         53d8CuTz36ZEJlZj4o5jCCuT1ErCl0T/HesU5HTeYLwcoTntwQ5N1RCHHosXcDON3NDU
         VB3AFpIMBc/z0wO2jl+QL7lG4qtc4G3NRXZ/TNKLi/eK2dE8XspP1yGyHCHCHufBzskP
         B6gU40zPfTlCySqWPiu/a/f/DP7ZMi0YKcrqh0ixpeEsAFqUm73iNlI60Jd5LtGgYe3a
         irstDhjaphrJoTB9Pd9A0Ulq2QdslrSMnmjWuA4dnFcfHFpRBY/Jl5/J7HuUd5RNYbEE
         JXKQ==
X-Gm-Message-State: AOJu0YxAMTlluYSAacgTZIra9CdzyJg4s+U8S+MiCt2ShgmJaAfleaHW
	l0nNmovK4Co+gI6n1oVFUWd4CY7izv6WLn1yDHET5k88ItjTyyawfFWBCw==
X-Gm-Gg: ASbGncvOSg4lBIxeUDMUjUbDfO/sRwlG20s+8VeKYgS6EBuSDBH4wno94nZwv+EELQ3
	yCWD6kFS4zTaBQfGCbRenXZIoVz+z7PQgDvQKcOZMyc7G5JA6RtZT01FJ2KgVP1udTP8NetCXn0
	qVgfE1a4VDQSHaRhoiOwDWD6+BRq4zVAMP6Hsn1yML3lOZ1Z6uGinWyUBNXKerL24tB3RYx1/S2
	gN3THDMSxwScfo+LtDudd5DP+nRgDf+sTLhavOpu5GM9DRR5EbU6kr57r2DvGCbyObpLGk=
X-Google-Smtp-Source: AGHT+IFwoZ31k+5hY3M5DEC+Qs466uPlDVtVXfn/2yi1TDI96x9WGw9j10u/dS4fWrpz+KGPIFfC9A==
X-Received: by 2002:a05:6902:100e:b0:e39:8ff9:4f47 with SMTP id 3f1490d57ef6-e536069d50fmr383546276.27.1734456106681;
        Tue, 17 Dec 2024 09:21:46 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:f65c:cfa9:620b:bdab])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e4ae7df857dsm1439176276.36.2024.12.17.09.21.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:21:46 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][v2][PATCH] harden.conf: drop debug-tweaks
Date: Tue, 17 Dec 2024 12:21:45 -0500
Message-ID: <20241217172145.94592-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Dec 2024 17:21:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/933

Use the new root/pswd directives

Signed-off-by: Armin Kuster <akuster808@gmail.com>

---

V2]
use new primary definitions
---
 meta-hardening/conf/distro/harden.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-hardening/conf/distro/harden.conf b/meta-hardening/conf/distro/harden.conf
index 1a5eb3d..2553152 100644
--- a/meta-hardening/conf/distro/harden.conf
+++ b/meta-hardening/conf/distro/harden.conf
@@ -6,6 +6,6 @@ DISTRO_FEATURES = " acl xattr pci ext2 pam ipv4 ipv6 ipsec largefile usbhost"
 
 VIRTUAL-RUNTIME_base-utils-syslog ?= "rsyslog"
 IMAGE_ROOTFS_EXTRA_SPACE = "524288"
-EXTRA_IMAGE_FEATURES:remove = "debug-tweaks"
+EXTRA_IMAGE_FEATURES:remove = "allow-empty-password empty-root-password allow-root-login"
 
 DISABLE_ROOT ?= "True"
-- 
2.43.0


