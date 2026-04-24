Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFAFF8851
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 21:08:55 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32235.1777064929503574285
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 14:08:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=MLsR8vCp;
 spf=pass (domain: smile.fr, ip: 209.85.128.67, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488ad135063so74545455e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777064928; x=1777669728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6eYEmaoDbM2VCKJzJyAOVh0yMPFjNDidXMstiE1lSE=;
        b=MLsR8vCp5z44AQnhnjlJVbp90dqeoNiWRVHhSf/n3LI3H/BhtPBaCp9F0r8TpoEekt
         i6UeLmAVAPSMFje5Ubj9ZrRHdJNKTvrJQ+/Wu6rArSbPLp4p1CXFz8FXFSSyKBU9G49J
         zgE02kxtnJbdrsi+W5uflih+ASM6+7g63DzdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064928; x=1777669728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6eYEmaoDbM2VCKJzJyAOVh0yMPFjNDidXMstiE1lSE=;
        b=KyJLMO6HEEZ54T5CULhfIjaZHX/AEnVbna2c0Tv36k3WEZ2FzKpqibiNE3FRxBArP6
         iF5ZkbFOtfkiO/9sed/x+2QyxRnsdeCphGAMu4PURiNj26E6cPF+/9XRQP9iFSUUGa98
         wGeqfXXf2bJEAx2ruYKrkrjy8f6SZ6UDArkUjqI7bJlwN7ExEvpi0V29pSxhRDGNHuBO
         Od5e0M8KBz260Gx2bQX4elLgYjJ43Hcw6GZIK9rkClLx/PCYms5I7qDfaLGUiCHcrD18
         8jUnH8XzjvgzHEfYfy+OmdTCSvtxv9cZeyaT6Q+Gsps9EwVeCUkfEkiV1bC7AzPPnXp6
         Q5Tg==
X-Gm-Message-State: AOJu0Yz5qYG/9rqo576z69GBKFNShxfZMRCtYtgBh4u9jUDMhplazIDY
	Cyu/GX7v7PURNE4C5jYCYn9mp4aRi0CD7W4Rn04b3C5/Tb5p90t7v0WUklDN6+z8QKeoLenXzk+
	IHKs7vfhs4UN7
X-Gm-Gg: AeBDievKhtHp1b16oqe0sc0w3rc3nQfD1Po68Ps+w2xHZ6IK+OlHaNjniuBk4k3Q+iP
	iRLZm8SslUId9Cvd+NSm7cqpfEldBbWxWjAT+WxNGyGpp9g/126C6J3SBPpZGAObsaRpSwrZdLy
	8GofX4/ijxv3U2Am7dMnDuzSXGKdPsirNmnpuB7l7WGvnlrQEwq9Db8bwcQnvqHQd0XVJn9j8If
	PuZmp6gcmSrK8G52iDLLvXIV6WKkTzAPx49oP8p4odnnhmUf80bHcVtHRe27Wfn6NXLZOCorS6X
	/IWVuReNAsp9NCyNXM0qqFPYQcRslCiAablOCIFxA7RfLNonD89BJVThBiwZIDi0jrJQC63aBoO
	4dwyi5QYDCqB8CeF9sF7L2beORh8A92svQM32owM8YXZBgT9jcNisNALyrm7O11X+dkWfAVxe7O
	alZABpRuatlgKlPhvyGn92pJ4BjslNqjyqXRkqlBmZs2ekddHqhBfJ5YjCO4it3bqj4g8zaye1Z
	C+qrrQX3F+qy0PQpva9BU3CxCTC9jsbj3964w==
X-Received: by 2002:a05:6000:2008:b0:43d:71f4:7ed4 with SMTP id ffacd0b85a97d-43fe3dcafb7mr53802582f8f.15.1777064927622;
        Fri, 24 Apr 2026 14:08:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm61436286f8f.16.2026.04.24.14.08.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:08:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][scarthgap 0/2] Patch review
Date: Fri, 24 Apr 2026 23:08:40 +0200
Message-ID: <cover.1777064869.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 21:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3809

Please review this set of changes for scarthgap and have comments back by
end of day Tuesday, April 28.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3732
But got impacted by 2 intermittent failures:
* qemuarm64-ptest failed with a python3 ptest failure
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3558
  * I reported the (new) issue in:
    #16267 – [scarthgap] AB-INT PTEST: python3 failure (test_wrong_cert_tls13)
    https://bugzilla.yoctoproject.org/show_bug.cgi?id=16267
  * successfuly retried as https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3559
* oe-selftest-armhost failed to download Rust crates from crates.io in bitbake selftest
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/3835
  * This bitbake commit did pass in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/3814
  * This is a really recent issue (it also impacted the 6.0 release build)

The following changes since commit e45f35e484b1aeef7f3a2278720c446949fa77a3:

  config.json: Drop checkvnc usage (2026-03-16 20:33:02 +0000)

are available in the Git repository at:

  https://git.yoctoproject.org/yocto-autobuilder-helper contrib/ycongal/scarthgap-nut
  https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/ycongal/scarthgap-nut

for you to fetch changes up to b7119bff3aa6faf31a2e72b33a8fe2040d407bd7:

  scripts/yocto-supported-distros: fix the centos stream regular expression (2026-04-17 15:20:43 +0200)

----------------------------------------------------------------

Antonin Godard (1):
  scripts/yocto-supported-distros: fix the centos stream regular
    expression

Yoann Congal (1):
  run-config: drop one more checkvnc usage

 scripts/run-config              |  2 +-
 scripts/yocto-supported-distros | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)


