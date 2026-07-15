Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DEDC44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 22:32:49 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.881.1784154764145296126
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 15:32:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XnFTmWiv;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f23e851626so61343516d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154763; x=1784759563; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXuFbvkgxrjpFuMMTf8XxlMp4vpmqPfS2IHxe7hgstU=;
        b=XnFTmWivooG/PAQ3KxqBHeKHjOW3wibAWrj3AfY9Z+GJ/iFWl/2zR0xMIszBBsMiz0
         i04oBUdX07Cma2Tux8YyIlJVagYd2KNwkJxk1vM5U/gBpR8hKFEILl1IJGo2wLWj9R5R
         rxOguH0X7XbHi3hb7b9Fe4X3d2UvbfsUP8eg9BoWft+OsEEpa/1SACCQUJKHhFtRD7/f
         1UyuhUXR9AE5v4mboGnURYqtUdBK4DkM7XlCe+DJjjwI49FTv+Up9BMms4DJcIPExhlT
         1szdV6tmt5tgGD56DUaBbvVDRZs0sFc2OiOd2OWLx3vL//dV6GfjbfWHJvbUlCYFz+fr
         B9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154763; x=1784759563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sXuFbvkgxrjpFuMMTf8XxlMp4vpmqPfS2IHxe7hgstU=;
        b=BGfIeolDTRosLfAweFzYGFBztZRfMK4vREQa6/zbViIDMzm36xoAbC8dUgYvp0mvR8
         y2t7+UjZuUO3blvD52s5R7zF1VGNTn8ix/7PoptkUlTWTV1hC0wspf9p3uimphH+2BOc
         IQ7YZlzqj0U9hcd7lCWduI9d1opT+z5XjmTg/ZGZ8iOVAtiE3L0SWjnmzJmA3mGrVAeO
         AlymRIWtbRhrrindt82RC9rRa+G6JoG4BIHOLPu0e+nz8Xh/FAZmtc+UplkWtpYvMNhT
         3yn3CcCvLxsMuNs3xyn4mCSf/uo2o9byK3fujsnqZ/DNxgs+Ft7lWeT4ypextK4dEVTp
         xGjQ==
X-Gm-Message-State: AOJu0Yznzyu3L+6owpOwnk+9/1AM/YA+p54BnH4hb5qemUmyiecaAMbY
	6KGefRoRtOHYcjww3229mOdj0/yuTVkSj4kurLp9CCRGyjdYl3Q0Hwps2hWRbg==
X-Gm-Gg: AfdE7cmk6fH86ZY3Wlf4nRy2dPUVzQDA/zcyTlbWty4GCzdDRRYIjz/K9dglc0Cbrn2
	i8kDFSlxvD1fLh1a9M1I2r5aCicmcMydaLk/jb4plntibNbEC4h+PGta1lVi9vmYLZ5tIfY8mxe
	u3tGZVEwWxRC7DqaV6110O0eRUKry4H3h2pdUUiaYTXua57796Qpp9n9yOHbLc26mYki0rG5y8C
	GXEd1VW3JsQiXlQrvtD3xpUmUHhEUAYV20c2AnTPoeuLwDjQ/leoRwdn8Ay5F+vP1YOab6JOdrO
	Ndts9XsjCUcDOSQ/9VnFndhubucCT8BF5hahPq57PaGky7kaVwoO8VZwGeVSreRQufapSuYdQee
	t1nwt0/a5QmJp4mIWeg0Sfzez09XiLOwcCvfDTPPzRy6h9q21oVP8N7H6USO1HTq7EYxiTqcxpg
	fhYme2vd9ckPqGjC086YSvSlhR3fPLuV3ueu8SnSRqQUTr
X-Received: by 2002:a05:6214:438a:b0:8fd:7913:b34e with SMTP id 6a1803df08f44-90747c52bb1mr113878906d6.17.1784154763018;
        Wed, 15 Jul 2026 15:32:43 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f43e6sm205883726d6.39.2026.07.15.15.32.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:32:42 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 0/5] ksparser: four argparse-type fixes plus unit coverage
Date: Wed, 15 Jul 2026 18:32:21 -0400
Message-ID: <20260715223226.3371498-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:32:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4484

This series continues the standalone unit-test work, this time over the
custom argparse types in ksparser.py: sizetype(), overheadtype(), and
systemidtype(). It keeps the shape the suite settled on: each source fix
is its own standalone commit, and the green test module lands last, so
the suite passes at every commit.

Four fixes come first, each independent of the others:

  - sizetype() accepted a leading minus, so "-1M" returned -1024 and
    "-5" returned -5120. A negative size is meaningless for every
    consumer (--size, --fixed-size, --offset, --extra-*-space, the empty
    source plugin's size=/bs=); reject it.
  - overheadtype()'s below-1.0 error path did "...message..." % arg with
    no %-placeholder, so every out-of-range value crashed with an opaque
    TypeError instead of the intended ArgumentTypeError. Add the missing
    placeholder.
  - overheadtype() let float('nan') and float('inf') slip past the < 1.0
    guard, which then multiplied the rootfs size by nan/inf downstream.
    Reject any non-finite factor up front.
  - systemidtype() converted with int(arg, 16), which also accepts a
    bare "82" (hex 130) and a signed "+0x82", contradicting its
    documented "hex between 0x1 and 0xFF" contract. Require an explicit
    0x prefix.

The final commit adds tests/unit/test_ksparser_types.py, covering the
three types' accepted forms, boundaries, and rejected inputs, and
locking in the four fixes. Backing any fix out turns the matching test
red. The suite is green at every commit and ruff-clean.

Trevor Woerner (5):
  ksparser: reject negative sizes in sizetype()
  ksparser: fix crash on out-of-range overhead factor
  ksparser: reject non-finite overhead factors
  ksparser: require an explicit 0x prefix for --system-id
  tests/unit/test_ksparser_types: cover ksparser's argparse types

 src/wic/ksparser.py               |  15 +-
 tests/unit/test_ksparser_types.py | 226 ++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+), 5 deletions(-)
 create mode 100644 tests/unit/test_ksparser_types.py

-- 
2.50.0.173.g8b6f19ccfc3a

