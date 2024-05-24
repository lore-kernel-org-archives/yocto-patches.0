Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7843FC25B75
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 02:37:47 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.7336.1716518258329144533
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 19:37:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MWben/5q;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792d65cd7a8so345621385a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716518257; x=1717123057; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9W1nmeMNRigqjZUejhutH2j96GZPEnF1samUuchFJdw=;
        b=MWben/5qY3yDq6ziwUpyG/3nT8qiD8803Fh1Eb9hmxebkWMlirWJnQrXO/GLkF3rPy
         0O7EADYvyMDmT+txZfDXgqdYwvshqByhDhv4rESSoA6We4ULPXynzQCYuafAPnXyQ/M3
         iwqpXqvf21FAS7L81Au4NE9JSvJomzQOizgkGlpSPNXJByo8Q/AV/fhK1Ht5aORfF6sU
         FoxDCeeC3NkCA0jUUwNSnDA89knYzQyv/pkJ9cGfYcA6YM3eRdqlS9H4k3WTkaKnDOFU
         k6Pg4YXQiNuwOXnhCVMw16I/n9Hd75Zk0gWivR4/9uxDrJikO+NFPgcC/XFuiM2tkRHh
         0pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716518257; x=1717123057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9W1nmeMNRigqjZUejhutH2j96GZPEnF1samUuchFJdw=;
        b=uTNZI2cV8ZAVkVjrtKi/k4TOZETU8ZRWdDaPwfiIuibQC9eW8SWjbNh5Uvsg/slnAU
         Z5+rC4nCnCTbbYKiWD8w7Q6AKAnLoHT5pb82mcaFlPT3dUgM5MQ+pkX4l/DaneHQvWuR
         NakJA5PkEebZnTybr2vDxD9VRrfa5bailbF3rIadtpM2nOMg014uGbvJeSZotudkfKdX
         HNb9xO3EJbDW5q+26E2nLsbpzVwohsoLiY+8IcAbdiAhuX/zDZ7BA+nobhnC5GGRcWI6
         5KVYRbTpFxSBZts3nMMg14dPJ5izryMWHsmmaYGsWPGg1xBzsyUzuBsFVQKrZ5OdJKoE
         LFYg==
X-Gm-Message-State: AOJu0Yxqc9OZRhOXYDFA6dSBx3nZqxxD3jN9T7N7VHteJapAailoqvQv
	TlR8vnyMqXiF91ctrf2Sc7RresqhLke9yCqNMZRBorUllJAKLEDDNyLx0Q==
X-Google-Smtp-Source: AGHT+IHhQDV/nv+jOi8PsyWkkyPbQrWh4eXVWjdMLxd4bMq+74Z9s8Emv005+LKHKKkuwbSpZdXC6A==
X-Received: by 2002:a05:620a:56d9:b0:792:bf91:3d41 with SMTP id af79cd13be357-794ab048955mr97571785a.15.1716518256727;
        Thu, 23 May 2024 19:37:36 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca6357sm23285485a.15.2024.05.23.19.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:37:34 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH v2 3/3] u-boot: remove upstreamed dependency
Date: Thu, 23 May 2024 22:37:24 -0400
Message-ID: <20240524023724.20109-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240524023724.20109-1-twoerner@gmail.com>
References: <20240524023724.20109-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 May 2024 02:37:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/186

The dependency on pyelftools is now in upstream oe-core making this one
redundant.

oe-core: 70eca6a5ccf4 ("u-boot: add missing dependency on pyelftools-native")
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
v2 changes:
- add a git fixes-style link pointing to the upstream oe-core commit mentioned
  in the commit message
- added Reviewed-by tag
---
 recipes-bsp/u-boot/u-boot_%.bbappend | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
index 33b521021a1c..5c9e442cca8d 100644
--- a/recipes-bsp/u-boot/u-boot_%.bbappend
+++ b/recipes-bsp/u-boot/u-boot_%.bbappend
@@ -3,8 +3,6 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
 SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
 
-# various machines require the pyelftools library for parsing dtb files
-DEPENDS:append = " python3-pyelftools-native"
 DEPENDS:append:rk3308 = " u-boot-tools-native"
 DEPENDS:append:rock-pi-4 = " gnutls-native"
 DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
-- 
2.44.0.478.g7774cfed6261


