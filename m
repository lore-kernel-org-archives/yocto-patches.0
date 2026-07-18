Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2E2C44524
	for <webhook@archiver.kernel.org>; Sat, 18 Jul 2026 04:38:03 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.530.1784349473627658042
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Jul 2026 21:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QqwaQl0Y;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cca0c5799eso60553645ad.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Jul 2026 21:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349473; x=1784954273; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Sgos7H+3ejwt25dJd5Sq/IPpDB6eixhU6mXCDuFsyY=;
        b=QqwaQl0YUqS/d/DHOLyRIKpJWmutANTG4eDN3UqjGrqSB4/P5/y7uOiVMjbSO2xitn
         Yga6zh/NUAoq2YmuT1mJXSp9GGFzVev/sXu4M3AnubU5svrF38ov12nkflea04KMtHbw
         i0PuD9CiWNLzch3+9ZwLo8Gf5I6fH2fSgjHOynoDHphmFb7DMmz35I1g3PtL8VX9EDNi
         +BQ1qP9loSUgf26MhWM6lTqTdXpxO1cErQ9uNEUbk06X38pf1biBbIBWWi7inKSm335K
         qLTcib0mq25kkQXtl7aahlwwb4EsolMS2pkNW6E4+YuPODN+/4ZWsPlG3Vx42jO5gz6S
         c0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349473; x=1784954273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Sgos7H+3ejwt25dJd5Sq/IPpDB6eixhU6mXCDuFsyY=;
        b=odGAIhIr/cUzPsDq03rFW5qKkgR50O3/Kt7ZF9+bZZWRE4ybVj34u7R5NSs5fiXCcj
         pNWNAi0dFflMpxVVMzbw56XT47B4KEw8wR9rbpCComxLZRTxhlgm+rNcg28zEnXQdbjt
         ZHBE8Ov4qgP5M60UEVc4HmKTIooAqUrsvhjqDCt+bLiQ0KuBNfG51J2iFpMGNhR7ppO4
         kq80/VWepSL7GYPTxC4ZrpvxKh/xtTVmFyfX/8tvMb9b3zVqdaRYKL9uA+2IOeiQSBP0
         JgCgJ+Rfym7c/5NzWW7aYz4PCD9+cCGjRO4MsnA7ju8Z2B1Idy32uFef/EZD5CzMHQnz
         BDmA==
X-Gm-Message-State: AOJu0YzEr4Zt4St8RwPLgRYZtpjCLNBxIEe0IZXYoWKV9+uTWpx9d9gm
	nL+KVflDOQEpPDt0NorxmSuzBDi4xW+cfkuEz9cOB3fJLuXOvA7LQWLm+FKeiWNxh7E=
X-Gm-Gg: AfdE7clmW4Aq0eQkx9o+q21MH6z1hOm3VizUbhOby51alVPjGxWdPkTjlaD7rY7nGGY
	tJxXzsTZmZ/EvOqIUpFg2MaCMcGlR7tfO8wsScFRTZgNdTEomc+ix3E8AmeRMut/tzxW58umqgm
	qLxyQzg1WnA+VYojoks4ZoXf9vm9aECx0ak4ijwxC0Uj5BQnjn8Gh4CpthSJ3Tr72kHeHH5yRSd
	AR+kPH5vVvtraXnmn8k+HHxXESmQc8pgoECtz+69yE1LExjcMyYk8uKo+K7pyj+mAcELZogglt7
	RTY7RJWoLB/wUENCqGQpdlPlTrMYaE+JPD6U9mpD6ZLHPfc1vWUPA9M4frojcu37UjfUTtwZbFC
	J82u4p5XCfLY9m7O3916sSEO0Y0+tHMt9JK7c6UPq3EQdXenOmrX70aR2BFKFSNhJny8iWErYoq
	Qr7F/lbeAlBKMe
X-Received: by 2002:a05:6a21:1404:b0:3c3:824d:5200 with SMTP id adf61e73a8af0-3c3ad963e99mr5527690637.41.1784349472887;
        Fri, 17 Jul 2026 21:37:52 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f8f067sm1626903a12.10.2026.07.17.21.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:37:51 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 0/3] closefrom/close_range: protect every pseudo fd, then drop one
Date: Sat, 18 Jul 2026 04:37:47 +0000
Message-ID: <20260718043750.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716055633.7-1-bbnpreetsingh@gmail.com>
References: <20260716055633.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 18 Jul 2026 04:38:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4507

This is the follow-up from the close_range v2 thread [1], in
the order Richard suggested and Mark agreed with there: protect the
whole set of descriptors first, then remove pseudo_prefix_dir_fd on
top as a separately revertable commit. This has been built on top of v2.

While writing a probe to demonstrate the missing protection I noticed
something: the sweeps can close a descriptor that is already on the
protect list. The startfd computation uses >, so a protected
descriptor exactly equal to the running startfd is stepped around by
neither the by-hand loop nor the kernel sweep. My understanding is
that the default layout reliably produces that case: pseudo moves its
own descriptors up with F_DUPFD from PSEUDO_MIN_FD, so the local
state fd and connect_fd end up on consecutive numbers and connect_fd
lands exactly on the computed startfd. If I am reading the history
right, this means every closefrom(3) under pseudo has quietly closed
the server connection since 21ff2fb in 2021, and it went unnoticed
because the client transparently reconnects on the next operation.
Patch 1 addresses that. Patches 2 and 3 are the protection and removal we
discussed on the thread.

To convince myself I tested with a probe that locates pseudo's descriptors
via /proc/self/fd, sweeps with close_range(3, ~0U, 0) or closefrom(3),
and checks what survived. On the v2 baseline:

  pwd lock fd (lckpwdf held) : fd 3  closed by sweep
  PSEUDO_PREFIX dir fd       : fd 20 closed by sweep
  server socket fd           : fd 22 closed by sweep

After patch 1 the socket survives, after patch 2 everything survives,
and after patch 3 the prefix descriptor no longer exists to need
protecting.

[1] https://lore.kernel.org/yocto-patches/20260716055633.7-1-bbnpreetsingh@gmail.com/

Babanpreet Singh (3):
  pseudo_client: step fully past pseudo's own fds when computing startfd
  pseudo_client: step around all of pseudo's own fds in
    closefrom/close_range
  pseudo_client: remove the unused pseudo_prefix_dir_fd

 doc/program_flow |  1 -
 pseudo.h         |  1 +
 pseudo_client.c  | 90 ++++++++++++++----------------------------------
 pseudo_client.h  |  1 -
 4 files changed, 27 insertions(+), 66 deletions(-)

-- 
2.43.0


