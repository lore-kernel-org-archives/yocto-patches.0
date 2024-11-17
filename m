Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFCD10F30
	for <webhook@archiver.kernel.org>; Sun, 17 Nov 2024 20:41:52 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.25497.1731876108404152085
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Nov 2024 12:41:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bqvjXqGw;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3822e64b2d8so121031f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731876106; x=1732480906; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XNqpEduLLP4pMIWte90djnKZhMwUFVCnT9mhBlS67fI=;
        b=bqvjXqGw/VUrEUodfUDF9ts5rREIsvXsx9CEN1blvz5slKozsWyGbezYHq/i+JJD3/
         2o9bVX9xkxkAx+hyJ5ils5GgeUPYj604oD97Bj8EiVHMmvqG/+D9T57dx378t/+dxIgp
         r5fFZ5gA6Z4SAvgBNycDpGsUdk0olQPGLKMJMDCM7BtiN8rTLUxhBUs7cZa2eyFzkfuv
         hNB5v3/0EZRfHYTYJFl/at9Tm2AC/WTsC8vmcciZcnn8lEOzjWmbPz8AIPC3YsgtEaSy
         8n3PvM7LsrEMzIf7jDXPzYXwgEaHkhyGhWGsaY05jGN1vN8hjJM/mV1O6UmrkTeFEwWT
         J+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731876106; x=1732480906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNqpEduLLP4pMIWte90djnKZhMwUFVCnT9mhBlS67fI=;
        b=SCUmmWx/1C+eOJXbHt6TgKC6/9mI0qhc/636znXn7bS33erzttGKBZWdNCeGV/dDFx
         KRb/K4gen5ruSXLepEvAFgLTkaJaWrK+Xagx2QumvkYL8k35Q7klwhFKWBmml7csYRdc
         DA6wRrQx/Pq94jhGJcqFErfnaw7kNHcasLFRINuvXzuttnQ/14Uj424lcd0FdgBm2kVy
         iGcSB499beVSmx4u7zynwF7yaT+PaHr2H0h43bfenFRW9VykdGwX5VeeBY9KxpHjCzSB
         frLNb3JYpCJcxR4jE/eIo3xdLz6oViZX+9ZZcWr/EAjX3Os3bLKPR9X6Ch7dOpmQI5LL
         tjWw==
X-Gm-Message-State: AOJu0YzbI4264Tv/xyKzJC0Am51kLN5t2Q4/amadhS2sqGAywflqTeXS
	RH/31BKpLEO48dj7MVpkjk2sCMxPtDZx7YXCjl6ob8DMKuhw5uZQXvPOjf5x
X-Google-Smtp-Source: AGHT+IFxzN4TZSqYoh8ph0oPh5QSvheNGDPBJzPA8WJD4a7sGX1J+F7Gv/s0lcHuReOVqjnaBRNmLQ==
X-Received: by 2002:a05:600c:1d1f:b0:431:55c1:f481 with SMTP id 5b1f17b1804b1-432df78f425mr35755175e9.4.1731876105865;
        Sun, 17 Nov 2024 12:41:45 -0800 (PST)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2658a8sm136607955e9.9.2024.11.17.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 12:41:45 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [poky] [kirkstone] [BACKPORT 0/3] useradd: Fix issues with useradd dependencies
Date: Sun, 17 Nov 2024 21:41:15 +0100
Message-ID: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 20:41:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/811

Dear Maintainers,

This patch serie is a backport of three patches below to kirkstone:
 - https://git.yoctoproject.org/poky/commit/?id=0f4fe4f7630b45228bcbb893f08a86e00109296c
 - https://git.yoctoproject.org/poky/commit/?id=ecef665062be55fcfa0915216335d08883aa86f7
 - https://git.yoctoproject.org/poky/commit/?id=f73e52dd71156ebcb5016f1241eebb889417e3e4

My colleague and I have tested these backports listed in that issue[1]
since a while; and it works pretty well.

We would appreciate to have these changes be upstreamed in kirkstone;
thanks in advance.

[1]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13419#c9

Kind Regards,
Gaël

Eilís 'pidge' Ní Fhlannagáin (1):
  useradd: Fix issues with useradd dependencies

Richard Purdie (2):
  bitbake: runqueue: Improve inter setscene task dependency handling
  sstate: Remove unneeded code from setscene_depvalid() related to
    useradd

 bitbake/lib/bb/runqueue.py                    | 42 +++++++++++++------
 .../selftest-users/creategroup1.bb            | 32 ++++++++++++++
 .../selftest-users/creategroup2.bb            | 33 +++++++++++++++
 meta/classes/sstate.bbclass                   |  5 ---
 meta/classes/useradd.bbclass                  |  4 +-
 .../lib/oeqa/selftest/cases/usergrouptests.py | 17 ++++++++
 6 files changed, 114 insertions(+), 19 deletions(-)
 create mode 100644 meta-selftest/recipes-test/selftest-users/creategroup1.bb
 create mode 100644 meta-selftest/recipes-test/selftest-users/creategroup2.bb
 create mode 100644 meta/lib/oeqa/selftest/cases/usergrouptests.py

-- 
2.47.0


