Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99331C83F34
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 14:51:37 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.17075.1753282295849125622
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 07:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I25a4ibc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso59817895e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 07:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753282294; x=1753887094; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQZo0/oV36YnRdGqBsv35hNd1TWXHtUfyeQgmICX1cI=;
        b=I25a4ibcjCfJqnYsuTCZChppitf20XLxXNDEFcxvFF4y1HMykYPt6Aco0fe0lj/CVa
         gwzSCFA+cChkb+5wji6i+B/hCG6HzubEPm0db1AbOEwXvxSN4tRh3/6zCGDg7QEQ1dQk
         cHzQ94PbCKNYVJ8fisTvbArdh+i3BpHvLsNQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282294; x=1753887094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQZo0/oV36YnRdGqBsv35hNd1TWXHtUfyeQgmICX1cI=;
        b=PC9IjAa2iM5RLTg+uw8JTAFfaVJOhaXe/BlSdGuaO6XuBggiYLXXCtXWF1zEbZiQKh
         pXVln3VtlqvxGfx8tWWIh2aDSyOQUM0flva2JLhUcnsX4WArwyYE0UG9acflW/NNfiFN
         VGC5yhz91W7x0WDQOWtoT1RfAPRXioGt7XQ/68CdBnXe2OUeFc0IvyTyVyuNbeOrDU+b
         QjvvRnvRljlyj5O3kivtmLt36s3fcjAl1zuIgiDVD8r01r6DDQ/Xn9CfMu3mli/iIzSr
         f3lH28pnLoloQt9hsiwth9LYxV82/ZPor1oR+ytPVcEde8ufEH8A3c1oM4yiglhndvSC
         13lQ==
X-Gm-Message-State: AOJu0YyeRDkaJCNnt7A1ucYc4b5FCLalnstEM1nGK2dSXuPqkQ8QwvQM
	iD8tGLzctYeVfU/zE8SK+ri7tsCfrJKH/yRafMrfRxPYhZQCzTszrx51fdqphm3T/qA/AsVnj3o
	tHgOk
X-Gm-Gg: ASbGncsg+RGkllhlvLYYuZQBRIIZQiIneT9Kx+6Sqg104byEDybHb2FsXyqLiEnjAOn
	391RBZDIU/FTbA4nSuTzfv2y/xthpsmI99dudjVg4pZvt5buxA9sHsBZEGS/6PmIUanTa/jgBn5
	3P2pCaY75amqSEu/Fw6cnPHvMID96sLvM4t7AZd9+WEbJlTNkUFfCrNnE26ldulAbFjDoZgYb8b
	EjzK9xzPxeHW9H5bhAqwjr4UipTYbgw/rqYLzBOw9NEDLIL3cquTSzyG8THUttHbsjI6VMTEWMc
	3QQdvDKsAkPPrWAoQ5UKU7KiVyk/GBI0XND0KE7Q3VSTWB8uJMbkiEn/gOJwkR7ay8b5WiVOEys
	T1kvwArL8AxzSoTJ/ZvFGAV5M0uX68u8rZdG59gZK84SttLTvu6g=
X-Google-Smtp-Source: AGHT+IG8NiYGWgSUwW/XmAc6j6xt7v1SEuQVTPz2ys5LS3Jnlkh5TvLzVvpLt8uEtHyglCu9U4Utnw==
X-Received: by 2002:a05:600c:3504:b0:456:1b24:533c with SMTP id 5b1f17b1804b1-45868d6b895mr27080775e9.28.1753282293692;
        Wed, 23 Jul 2025 07:51:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8e54:5d9e:fc41:f168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691b2adesm25385225e9.32.2025.07.23.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:51:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] dbus: Adapt to traditional-activation PACKAGECONFIG
Date: Wed, 23 Jul 2025 15:51:30 +0100
Message-ID: <20250723145130.176701-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 14:51:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1826

With this PACKAGECONFIG added to OE-Core, we need to disable it on mingw32
since it doesn't build there. This looks like a meson configuration issue
which probably needs looking into in more detail.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 recipes-core/dbus/dbus_%.bbappend | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/dbus/dbus_%.bbappend b/recipes-core/dbus/dbus_%.bbappend
index be88280..f95e960 100644
--- a/recipes-core/dbus/dbus_%.bbappend
+++ b/recipes-core/dbus/dbus_%.bbappend
@@ -1,3 +1,7 @@
+# There seems to be a mingw build issue where if either of these are specified,
+# the mingw build fails in do_compile. Work around it for now.
+EXTRA_OEMESON:remove:mingw32 = "-Dtraditional_activation=true -Dtraditional_activation=false"
+
 FILES:${PN}:append:mingw32 = "\
     ${bindir}/dbus-launch.exe \
     ${bindir}/dbus-run-session.exe \

