Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDDD7234A
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 08:17:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63682.1769156254823252736
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 00:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=1PzGnXBJ;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so15108885e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 00:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769156253; x=1769761053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkztfcVg8iJx9OpiKFcrOjxTKbiUb4SqdOHQVPot1L0=;
        b=1PzGnXBJhEraxriri/uvScj0cYc0cGqXgijQvwUplZPgqV7VgXabFBH7Kw5nDxqK8w
         ctgo/i3hb9kTbTS1WG8u4tmVR8KSZa+IbARDU47Ie24q2I94h7JVYMekFP3oya1yCQqT
         TXqYvEpbvSdqpz6YGJ5RGkh7BdILIUZjmrAvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769156253; x=1769761053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkztfcVg8iJx9OpiKFcrOjxTKbiUb4SqdOHQVPot1L0=;
        b=nqlBzSWKNKyw75M40NLPB/T2X3q2YgIa0s/8d0BosA8H22Gub5Ivs26cT4s9t54hB+
         56B5yRtVJoP+5R3/PXf/APQDeUUHGNwhCBZB1+4MtQa9o4BUKmwQtX6d5664WjxPt9jJ
         dSThQB0dvde9II7kgTXfEtjYj13ymMW+q5gU2B2YvJLqmb2d0gySa76HGhm4K0DrP4iT
         kOJLj44Ak4T2L0qK0eyJt/GvaIX95w0quaRLXblPy0PPoqPnEyQJRgF1qzvkMpvrWa2P
         xSBMxEWwzZavyNDFBCRziTw2E47mxaePzmsk9SDQjB0GJTUpJBWL0ihCy0RkNFXSn9Fj
         Kdnw==
X-Gm-Message-State: AOJu0YzxqoPGXMN7uloPy1Agxl8PCOQtkt30Fw6i18sY05cCerbgwmf6
	IaFl8IJ0GSYHceMPzkLjJf+IL6EQ2HiQrvtQGXpw9bA7KFpRhUJjwcKTjVUuUQ7rSO77YRtSZV4
	zsbb1VDQ=
X-Gm-Gg: AZuq6aKlDvMUASGthJ4BzP+tror8UXLy3DlM05kVsrlviYYwgLp0vQyyleGtPGy2cHS
	eECgQkpphOOnhAj5aE7pT3wZ5hQ3D1EkdGaXZ8yfsriBDJ9WKurgaUSPSM+2F0NxcFTl/M0ByEQ
	l3nS3phA5CXMX+V31T3XPDKZkxPWim88SCKN1R9ZlmeZk93Qt7Bep07Qc/JJM8NbDIO0Te+k2fw
	SC0h15gWybGvO23iplB1rMvLe+D4zXx2tXqBdeef17KfNcpXT7D1RW3UwxnVMgy6rD4OP3ZkyZD
	HsJcjylSCkFT2wQZZwn3J3ppsz9cEyq0vemFXjC2rpCjVkaOUUZGvxbYw2TMLIFJphJiVEVTeN5
	6fC+ljgNSN+rO9KDEYnLPn2h4T7vZZ7KhA2TWdbdVncRZVvPvbkXP2A78T4uyxa8oyaR4LyYien
	j0ewOQqzaG3aYISJaqj0BtR8oceM1A2vekYd5wV19/1ZgRwFqzHFwoxBhipfuFvs3Df4HW6l8VC
	Kwd3CR7zwA9sUXvf0WcuPNjgQ==
X-Received: by 2002:a05:600c:620c:b0:47e:e20e:bb9c with SMTP id 5b1f17b1804b1-4804c944f38mr32911665e9.8.1769156252662;
        Fri, 23 Jan 2026 00:17:32 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745e6sm4763532f8f.33.2026.01.23.00.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 00:17:32 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH v2] schedulers: Remove non-existing whinlatter branch for meta-clang and meta-intel
Date: Fri, 23 Jan 2026 09:17:21 +0100
Message-ID: <20260123081721.74223-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 08:17:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3054

From: Yoann Congal <yoann.congal@smile.fr>

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v1->v2: meta-intel, also, does not have a whinlatter branch
---
 schedulers.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index 036d66c..c2087b9 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -76,9 +76,7 @@ branchdefaults = {
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
         'branch_meta-aws': 'whinlatter',
-        'branch_meta-clang': 'whinlatter',
         'branch_meta-gplv2': 'master',
-        'branch_meta-intel': 'whinlatter',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
         'branch_meta-virtualization': 'whinlatter',

