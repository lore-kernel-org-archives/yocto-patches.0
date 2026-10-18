Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D8CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:56:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7903.1792288580089042717
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:56:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oh5PFNji;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e96502e447so7347455ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288579; x=1792893379; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8UfeygiPcr2svmDtbxdH24So3sEhPFtKY/WkZYwe14M=;
        b=oh5PFNji8pY67D1mHkwQlPLRZgHVRb3IxVy3OlZ87uJy/55jjsDpMfEdBOfhyDPz37
         sk/MZD8RF+9FJY1OocV7kZpGVk4QsJ1BoCP/S8sUfe5anKALGSIg/7Q1+e8yH0ZiaxLt
         tE625/2/0uyKjtG084K5X6OjBCRV0PrVqfMKqpDkH0G5dVJDGDZTwAw3X8Tvrm0qg33h
         +I7XTwlx3DPx6kw+Gw/eM3q6/kXCQx/Gjo12xnlnLSqOR+w4PpcFRYU2E8k/FnFoLUVo
         aSc2XRcDuk5krYgcZMO8vb4xFrnUYSzrZSdTvGfYgeQ1km9Sk/+oZxOjVRIed0ZCK0PX
         J7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288579; x=1792893379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8UfeygiPcr2svmDtbxdH24So3sEhPFtKY/WkZYwe14M=;
        b=JnDaEx9oIzOf/hoEelyZtaW7/Eum9sSWlZXDZXcilNLLjdH4wLxvXsFifVaSMkTO5s
         mbZ1b441UnJV8ZRAl4qwIopRABK8/eGryDQpqH3ZzNgOjZlftpWz9j57NeX1r0ukoeQn
         r4gsxKGdCiFeFn5bbc4qrn1Qx36z4Tv2FEDuotJDMYoHgTDUF3fH2R57dqyzhHA7nkoL
         +Eks06bgdlraansDGUnO2WtXsjcK98786Ks0VLCjqemnyttlxMOQh/Fzj/cma9iVZq7I
         0NxNPoV4+00uDSts1Nukhc4SwCS2b/h15g+Qe/+gbDKIKcJUcPwg32NCyrbyfI3widLl
         3+tA==
X-Gm-Message-State: AFq9FYIY0q8+fff2e9anMUSAyOMBQ8qUJZklpNdmJYvsF704kUp3qR3n
	SL/JKVfA74ZV7DjHD0tMMFjwBxZt74w8vyJRdiPaXVX72kiUsHdl+zmVdTpMSg==
X-Gm-Gg: AYBFou1H8GtoDPKgZ4xKaCthMI9SnrLRTU5eryAtHQEefUJIVrU6DgPtcXrlCJ4WlD3
	CjfZTa27D3CpfWvevKM4QavdmkFn0CEO5Z0SrNZ3JyMcldrKAeItSy4Nww/u2I3vubWaHwhpppC
	p4w9x6+4pj/U23AT7qLeRnrMtbANzVW442VNY9Zpmkv4xpHpr1DA+81x5ZUkNE0unxx+Ntztkej
	88PckdeemtQkdPHxsLfCI5RqGBpH/gYnskjUsPT4E1k9jH3pRAUit67jqFkBI2mDTwI4tvPyw5M
	i9FwFUXRdAtEfVz0YsZYTqn/FiroqswhyXEWpgJI+qYq6bJJHu9G6+V0Y+e6csj/XRTEpZ/gxU8
	YobvdsChMtdAv5Qd5scwQGLy7EDIvwOKdp43vvvA0NAdvfU55ZayydGIaq4UKx1YBrILx5rcvjw
	uraEkUWAUMi4ut/dTvhgGhUVHY8kLHO9QhrjeugrjrRMEU9o9KdvC6yJm8YUzTT6FCC9k2/EVqG
	OCM0j/TJamIk/uAS4WH8EOUWqvTVg3U8suU0+JazQ==
X-Received: by 2002:a17:90b:584c:b0:39e:6c68:c77a with SMTP id 98e67ed59e1d1-3acef56f8ccmr3338029a91.48.1792288579391;
        Sat, 17 Oct 2026 18:56:19 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm6135920a91.2.2026.10.17.18.56.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:56:18 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/2] Fix deployment security checks
Date: Sat, 17 Oct 2026 18:54:36 -0700
Message-ID: <20261018015615.74684-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:56:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5058

The SecurityMiddleware was commented out/optional. We really should
be enabling it all the time.

Security settings should come from the environment and we should
always be using a proxy like nginx in production.

Tim Orling (2):
  Enable SecurityMiddleware and XFrameOptionsMiddleware.
  Read security settings from the environment and expect a proxy.

 Post/test.py               | 11 +++++++++++
 README                     |  5 ++++-
 docker/run-tests.sh        |  7 ++++---
 project/settings.py        | 27 +++++++++++++++++++++------
 project/settings.py.docker | 27 +++++++++++++++++++++------
 5 files changed, 61 insertions(+), 16 deletions(-)


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
prerequisite-patch-id: 9c9d012e1163dd1d335531d0451657823f17eb64
prerequisite-patch-id: ddb4df3e54736ed25846f91d4918299e601f4071
prerequisite-patch-id: ab69f4aa494291611cbe0e916f18b07f4aeebe57
prerequisite-patch-id: ac2b802ea065536df3854c48e265f5508d201cff
prerequisite-patch-id: 81a7de0e9568848efc8c66d397abb5f56218db95
prerequisite-patch-id: cf32dcaef20903890a020211a35f46b2384207da
prerequisite-patch-id: 6920bc5c70071bbd42b55b08bfc2bff04133c3ab
prerequisite-patch-id: a72bee4356db80ccb45321967d18081961f60860
prerequisite-patch-id: a2285b682329ba20d838085588b7c6681a86d273
prerequisite-patch-id: c3980e46d49b00b419cf4a7c2bc32c346478a453
prerequisite-patch-id: 627f58daa68852066f56558f08b07ad4af7bef9f
-- 
2.56.0


