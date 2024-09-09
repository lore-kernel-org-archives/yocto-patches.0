Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DF3ECE584
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:54 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web11.55123.1725893746799649223
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 07:55:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iv+jIucy;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: twoerner@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7091558067eso1893635a34.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725893745; x=1726498545; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzDz8rk95kcE6nRSmJh+Xg6izIHEoJVNOWK0TbHVirQ=;
        b=iv+jIucyaW0ZdbQtNanbvpjPUrvd/U+DPaR/dx/sB5l/qOp0AJlEFttHrVhFf0YiVx
         XI7Oq+FRJmmut22gVK4Pl8TIguGWlLvbForf49+ZDU9Z6K0d34fYk/KVVH3+K3/cva9S
         X3264U3AgJhMANwphDwv2dQQYdpoqKm32jjx7XnlGBv+K2GK9Se5IWCtFyyG5n+ebLtO
         krhKPTyVzHjmkGC96A3jYz7GIZO+KLNkpNVaX7i7mxhCWGQTWU6qGwqk9M5ABCDzjNvT
         HWtRzXX8aWHUdwBeiEvtqVMdJv2fEIpm8K0LOtyRQu67qF9zQGzi/F0mFO2b4b8v+/Ze
         f6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893745; x=1726498545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzDz8rk95kcE6nRSmJh+Xg6izIHEoJVNOWK0TbHVirQ=;
        b=HKGdRPjOxzYEfmo8y0/j1iC9GYd/NUmCSu1Cr6MBGN6CwQ1esuIA5V+AQXq0/GeBrI
         dcSd7qpThYXMH1LarZEsat0tUgoLDRK3UWVx5tSngScKcmPNsa26B1QYggnEcbRSE4TX
         zA5UwLy/lMpO4u3NaE0fuEDxeCZw0OeGZ9XggvYq28hQwtIV8/IBVjNevQ9+1ngwuJV3
         EvNnr3wTUMOlAmXEqVR4Sbxs/zYvv8UhQQefyrfZ1o2D7htphBtoxKGD1iU9iRRPQOSV
         j6lpNTDf7F+e9+px0GF4NqW4DUpfgG0RKUb59dzycprTgHE+11bDgm+R2bFGns8EO7Et
         Y/QQ==
X-Gm-Message-State: AOJu0YyqN/Js69RGQSBjQo0ruNd9nffvL4ho25vNvMhPL8jIlV/9ZP+7
	xWfg3CDHuy4VYKt59+M/Y56tkoQDcjWyw8RaV8f4Jc3kSeSC5o9mrL8X+XoT
X-Google-Smtp-Source: AGHT+IF5LRXjBAXFngPPlGZe5vzPO4oVLPZHK2DKdCQXc4EfU62kAuqBBhw29aWWy4GmVYjsFO6QYQ==
X-Received: by 2002:a05:6830:6f0d:b0:710:e67c:e817 with SMTP id 46e09a7af769-710e67d0203mr5554494a34.31.1725893745315;
        Mon, 09 Sep 2024 07:55:45 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e772a2sm21050231cf.27.2024.09.09.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:55:43 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][scarthgap][PATCH 02/10] mesa: build panfrost for RK3568 boards
Date: Mon,  9 Sep 2024 10:55:22 -0400
Message-ID: <20240909145530.25301-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20240909145530.25301-1-twoerner@gmail.com>
References: <20240909145530.25301-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 14:55:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/628

From: Quentin Schulz <quentin.schulz@cherry.de>

The RK356x SoC family (of which we currently only support RK3568) has a
Bifrost GPU that is supported by open-source Panfrost Linux kernel and
Mesa drivers, therefore let's build mesa with Panfrost support for
RK3568.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-graphics/mesa/mesa_%.bbappend | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
index a31d99b5c65b..2d9ec2e676f7 100644
--- a/recipes-graphics/mesa/mesa_%.bbappend
+++ b/recipes-graphics/mesa/mesa_%.bbappend
@@ -1,4 +1,5 @@
 PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
 PACKAGECONFIG:append:rk3328 = " kmsro lima"
 PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
+PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
 PACKAGECONFIG:append:px30 = " kmsro panfrost"
-- 
2.44.0.478.g7774cfed6261


