Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A30CD3442
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22609.1778084505496593903
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BDMi5iCL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so7256655e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084503; x=1778689303; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xVep6Kz5QGwNBFg4sLuVprOzYaQW4wLEsRrqW/bLVk=;
        b=BDMi5iCLp23G+LEP32M85dWgoWu0kMxPbGGOXZPfOHtpFL81RFBIJTyzrX5/QOxwFH
         KlBrFaoB6KzqrqqUIVw9M8PM2B5Sy9WEiq9s5d5Sb2dUTV/kiiZ6pQ8Ub0v3WDBSVYiH
         /So/3svQxanWpa9xEugJwBCba7cWCdKlvdxp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084503; x=1778689303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xVep6Kz5QGwNBFg4sLuVprOzYaQW4wLEsRrqW/bLVk=;
        b=Bw3UM11snYbz0gmVxvXlskMYbko0wLje6gBvHJ+HQ/GJktIjF9+GEBVQJeVhSfUZIc
         kq/EhNpVNSPyH0ow7mtoJnh6cZ7TFR9T+y1Qrel5Kjx/IQqR14WtNGAEfxNiJyKKnTEJ
         hy/tfIQQUUY2yBIEaAiib8bT8XmRMIItxhcCVd06hHvAZpebYN60KBa2gpOcfrP54BNd
         Vl39tN/OBoyBDhMbIK+vAacJvyAAfAAKWvbZFCofAKyLBawkTnFSLJD0Uq6PpbFhsStN
         qMSAgQzFoPwsWUIYLtmaW/Sie1roFP4PTxbeb0rKzgadHffUIKz/j1OrYLx6wl/LSDZR
         STrQ==
X-Gm-Message-State: AOJu0YwVavkUzKMIQqASHXbxImHeF+gmlOlXy2qZxv45Kh/XOFfXF/gN
	j9Q0Bi1RqUKpK22woNYxUeptmw4KLmICnMmo7jyIphCWtR0ATn0ubBoYDDJczELYuIz2katbSIU
	J+XdD
X-Gm-Gg: AeBDiesBQHaqpwnSN4aXFkxmjx0qpTEs5fCeZPBTska6zu6GXtCegfeaCJ/u/fRU9Nq
	/kjDWiinn2BcRxBK7hhW4i/S97mtpHaNdIYkwa9/WHt05JE4Aj+1NJSHuHt2GdAQO5mnSFb7WrN
	9Bi5J+tHPW98veuu3MSfKQBCOt17kGY55SMeOxI6S5zXgnjqTCbbpHsC9gWpTgngwFimGpTJGGW
	XZ3odsEx4v2uINT0PX/gYIn1ilH9Yks4hwF8vzfXqwb/hc5afXgYMIoIq1QkpGYExikyt40VACV
	Vr8UAk6tgynjkvtqLyPmt3FuYrPBAnRZZLzM3iAfMkiENkptqefHXF1dacfwxg+3v0smberadOT
	mzi4HV9mYZsxd2pwJHmfgUtRDdh/7o7kOb4SakYrq+Kf/IUPp+jB/jyXgg7cfzaKC4CQtv7Xe+A
	O6IkjCrHtbcztltpaXO77uXEwEN4/irUKw8SR93C6gel68jm8GIoPZ52uKjC9v1w50LfOU+NEdP
	Q==
X-Received: by 2002:a05:6000:2a82:b0:451:ccce:33a9 with SMTP id ffacd0b85a97d-451ccce379dmr3317363f8f.27.1778084503408;
        Wed, 06 May 2026 09:21:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/6] publish-artefacts: Drop eSDK toolchain output from releases
Date: Wed,  6 May 2026 17:21:33 +0100
Message-ID: <20260506162137.4180049-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
References: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3923

We are currenty publishing a lot of release artefacts which we suspect nobody ever
uses. Drop the eSDK output since we don't believe anyone is using them. If needed
someone could easily generate what they needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index 8881b7f..4a1e1b1 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -26,8 +26,8 @@ case "$target" in
         mkdir -p $DEST/toolchain/i686
         mkdir -p $DEST/toolchain/x86_64
         sha256sums $TMPDIR/deploy/sdk
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*i686-core-image* $DEST/toolchain/i686
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*x86_64-core-image* $DEST/toolchain/x86_64
+        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*i686-core-image*-toolchain-[0-9]* $DEST/toolchain/i686
+        cp -R --no-dereference --preserve=links $TMPDIR/deploy/sdk/poky-*x86_64-core-image*-toolchain-[0-9]* $DEST/toolchain/x86_64
         ;;
 esac
 

