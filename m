Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE76FCE06D
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 12:47:30 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.69246.1772110048239878217
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 04:47:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HUzneNuI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43994aa265eso475347f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 04:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772110046; x=1772714846; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cikgZIsPbSfuFgC+I++kshqfZoNh6Eq3VNsb+EpXtn4=;
        b=HUzneNuI2yuyVae0P8SxYyHLhZW3hRnGd7nnXc+9902VNjY9L/buUKxhSAo7uq6KRP
         c7iusNvXcBOpl7vSL5kY2IwgLYLRaVi+B0V9krkWIsg5sM9xsyds1OSIK0DrqpzyEXjc
         5vpYaG4owiPZ/HlcOLZyUVmRZUI1r+hl1pPbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110046; x=1772714846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cikgZIsPbSfuFgC+I++kshqfZoNh6Eq3VNsb+EpXtn4=;
        b=c6bgKPreoc+V+0r3kO1DHbjMdndX2ow65RbZz6dpASL18vv/m9ncTMT9fNSgMvAshL
         d2eq+N/qe8n4HEzS4eKdZQ7USnYiqYb+cbf6Zm2hZHtWaZkEuWyS2RmK8dPXHIxcxANs
         /+XApOHGAuIswHaLiEKrLFx0tBYWHhYl8ukJaLHcPX1kWze8G4EaxS8jazHLBUwYJd+Q
         gqFEne2vJqXkN2iJM2pR37Wp1/E/5Of8syTcG+rfeeC5ShVgP9fq5Dt8pPeZ5D2e3Ab9
         STxqpudMYhsDIdF6hwJM1CpJrV68in8+SBVgubFM7EQ9nTpsmnYqaCV0gND6l2+bC4Cd
         gnmw==
X-Gm-Message-State: AOJu0YxnehGG7KVnmVKzAPVWyR1PuIHim9c+aK7r3/NnD/sY7mm7AZTS
	BNHw2q+buwZ4Oy0DhNHVfebEd6lo5gnSKtL3yOx341wAEYeHOLOnIdVqTrTyApePhi4W9hgBd5H
	rc9dX0Fw=
X-Gm-Gg: ATEYQzwuMHdD95+q+a6fA3ZR0WMEYxCAnsQe0d1FKy+mt/L/9ctfzu2gKOfyk/p01KO
	W4511sakk8abBqdKarmg8qOW1LmyggiXZmwpHbJ14RTdxMfTvue5NJr9pTWQM/CzVFpYKV9/BIp
	ic8+AoE3ns/fiRzEGtXNBewAnfxrpBRmOw8ioLxr4nJOf2pAd9i+WTYbjRFIrZ0hT5wPUyG/aGW
	vEBTle3BzdYufEG3/BpnckzhgiYS8dO/LJaO2lvlfjO5fL/FJSRk2ka73e5yM9pHQc8dva7SAhR
	To+9F7bgvGQzFwabOFuIXuGnHorxOSp3igZtM/wcCzgaf0gBIcbPEDJDiQBnAFV6eXgsoRr4Mgv
	I7q5OxMYUH49Jsb3Q0PJ8puyFFodoe8lancNFlHl+8P3ez/FeU9+ls7zr6hCLYK0/a8jZ4SlHTs
	l11AEyuTD//Pul/WUOY+rOQ+jhE7CEPG60BhG5otvXgtXkLWTXqRo=
X-Received: by 2002:a05:6000:310e:b0:439:869a:a18 with SMTP id ffacd0b85a97d-43997f42357mr3813464f8f.51.1772110046191;
        Thu, 26 Feb 2026 04:47:26 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398fefa3f8sm10855302f8f.36.2026.02.26.04.47.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:47:25 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/3] config: Drop meta-clang from builds as a default test target
Date: Thu, 26 Feb 2026 12:47:22 +0000
Message-ID: <20260226124724.717336-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226124724.717336-1-richard.purdie@linuxfoundation.org>
References: <20260226124724.717336-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 12:47:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3283

meta-clang isn't being tested now by default as this doesn't mean sense after
the merges to oe-core. Clean up the config to remove the remained of the
triggerings as this is obsolete.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 70e41109..947b15f2 100644
--- a/config.py
+++ b/config.py
@@ -117,9 +117,9 @@ old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-a
 riscv = ["qemuriscv64", "qemuriscv64-tc", "qemuriscv64-ptest"]
 
 trigger_builders_wait_full_releases = {
-    "master" : trigger_builders_wait_full + ["meta-clang"] + riscv,
+    "master" : trigger_builders_wait_full + riscv,
     "whinlatter" : trigger_builders_wait_full + ["meta-mingw"],
-    "walnascar" : trigger_builders_wait_full + ["meta-clang", "meta-mingw"],
+    "walnascar" : trigger_builders_wait_full + ["meta-mingw"],
     "styhead" : trigger_builders_wait_full + old_arch_full,
     "scarthgap" : trigger_builders_wait_full + old_arch_full,
     "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,

