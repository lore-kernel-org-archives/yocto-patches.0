Return-Path: <mbober1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D695C27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 20:00:38 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.67276.1718654429662140127
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Jun 2024 13:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IzgX2KTk;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: mbober1@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so5600108a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Jun 2024 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718654428; x=1719259228; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Db0lYnlth+PXeTlG9vMzTtKoUgoiDvTtG5CvRRAeYzA=;
        b=IzgX2KTk1eoswK/4+9g6IogUVBUJxhT5gglBaXOypFGLsztQr0in9SRvQxoHxC9JFG
         74QLE1xcHR9qcVPulHRICAVjaiHdWbczCtQ228go5kgzLM/UD/S1uIzUJ0FsbHYI+Gc7
         /i9TXpr9DH18LMiC4DvC9MQqgTEQaawvNA8xz4Q2Sw6mr5bCu/xiK6rV3R+xAjjoTXjx
         KHbfOGZlOnxpzZ8blaAR54AEAjh8tFeM+LuncAPHLHhOsOw4NeW+56JTXD54UT8YhDWS
         oEKS3FBUSREcVXaJbPL7JhJepD/K9r8YxhH/n2trSyJ2N3UqzBBNyw08A771x9lr4GYZ
         1xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654428; x=1719259228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Db0lYnlth+PXeTlG9vMzTtKoUgoiDvTtG5CvRRAeYzA=;
        b=Qi39OF73mQ6cxyqYf08//psXH0IG3xxLQQXvlFq8xEABnTta+jXDj6zMkIIhQgCqJq
         CAFn7bGKCofOsXwDgYCXuHeCs5+CSRdA+eNAPplXYzNLVCNOjC883+SZYZWj+DYSemga
         JTiN0zszEtJoaogkUMAWWVGX5iNOt2ifDXlaAqwjORopN6jA5qfscUR0bt7EHaegv1G+
         oP1PagtyD3Yg/1JDNVSahfJMgQeGiiFXUNgGP7vJZD8ZbnYUN0glOvDGH22xE/mvlTRG
         u18RBRRCH2JWdlsJazR8iZMTNy0Ny3k+NzMZHBEgbo1VODssJY6loUuHU6U1dhI0To7+
         AdIg==
X-Gm-Message-State: AOJu0YyrORi98Us7cLVv1eENSj7Ds8VX/NCHZkw1ysKtujfhkYVyee42
	y70zZ/qh89lXplFw1YIVkv8zObfymAJSIAdhxPVkPve7OZargwZdfESIOIakhlE=
X-Google-Smtp-Source: AGHT+IHZLWUSuiML2TrH/XZxuu/pxN/5cKQlVhoESuC4O7U1K/do+y3WU58LqzppWiuCe9Ra3KMKPg==
X-Received: by 2002:a50:a6db:0:b0:57c:6004:4375 with SMTP id 4fb4d7f45d1cf-57cbd66dec9mr9119759a12.15.1718654427773;
        Mon, 17 Jun 2024 13:00:27 -0700 (PDT)
Received: from compiler.lan (dynamic-78-8-216-220.ssp.dialog.net.pl. [78.8.216.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e725sm6757933a12.69.2024.06.17.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 13:00:27 -0700 (PDT)
From: Marcin Bober <mbober1@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
Subject: [meta-rockchip] [PATCH] mesa: build panfrost for RK3566 boards
Date: Mon, 17 Jun 2024 20:00:24 +0000
Message-Id: <20240617200024.389206-1-mbober1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Jun 2024 20:00:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/333

The RK356x SoC family (of which we currently only support RK3568) has a
Bifrost GPU that is supported by open-source Panfrost Linux kernel and
Mesa drivers, therefore let's build mesa with Panfrost support for
RK3566.

Signed-off-by: Marcin Bober <mbober1@gmail.com>
---
 recipes-graphics/mesa/mesa_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index 2d9ec2e..ca1ad70 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -2,4 +2,5 @@ PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
-- 
2.34.1


