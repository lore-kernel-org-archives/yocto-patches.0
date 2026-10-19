Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5910.1792445718064237579
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 14:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cGpmTlwf;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-885cd98d226so43985b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445717; x=1793050517; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtES/B0m2x1bu7G1pOQdB6jyipt1stsEsXvtFaGH1tY=;
        b=cGpmTlwforFfXx+YUXfe1Ld4qGsvpVxHurz/sfoklUKIagDGj0oUw3XzF/COUPFO8k
         I2DmGBgsiUWOen6SxyRIGFccxMgddqqYURu/ilHtW5eXjNx2X2RmqRjvC7P3trtDB47F
         px0x1Y01muUtQ2OXwtLvYBIIPoJSQmS7RcxhqJnAX6gArKVtMbjm5Zh2AiCrtpu0bmvR
         MOeSrX50jiBqAGGkIzdOyAQJUt07lAPsrNWbotSA+4V4dBpdt+IIkM+xaPTYuieHs1vo
         hvFNsak3Rfe1IQYvPGvspjMELl+xnpNhaqptSHHtuHR0SglM/8JATeMjj7CvgeF6C+xI
         c7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445717; x=1793050517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TtES/B0m2x1bu7G1pOQdB6jyipt1stsEsXvtFaGH1tY=;
        b=J6N2u6ob/2qlTNQ+Ig/3FTYdsDVPLqCaaBzDUdeaqFz9td00a8ZCCBGMF95Epci1PH
         16RGJhANWmkSqWqf8oJrQFMfVlXyvL0d/nMgEyqOloqwyzi8SLhUcqY+Q3436GM0SyTA
         3MdeeL9tmTIxyKi7E/zcErk7tDEL7BV0IoDhbrB6tIderX0jqnKnHGPyh11BPfPkTwK7
         DOB2yalqUJBoxmCk8Tq+gJBYd+elNE/lQHmvtLLXwLy+Jpt+rr3n2XRm6WWS+wKrx8CO
         IdwO6EjP1UTO5J+cN0RskSIxyksCa+AhkO1Tqtr/FcTHRi40rw6L4xDNy7ckF+geBRD/
         hC6w==
X-Gm-Message-State: AFq9FYLlyE6JWz7O0BRTcz3OVqqUUNnLhieLjBIXMnfX+q9pKXLYZbny
	9a2o8dKRQVqA5xvAO8wbpqr5mLRLBJqOBFpuy3ZI6dtse8dlTPaXp6GqKp+F3IS8
X-Gm-Gg: AYBFou06pkF782qRi7kZ0GfBEjgK4KlhXkG9BNnQ65LMaykQY4dpAfPNG1KFZSLSQ8S
	CWlwC/xYutyxHbpixT4fxi3i8oGX0W1aNIg9P3wtx4WhzPYukAsQXTX7lm2LFc3Funp87dasn13
	XU4jjDPxDG+R2Xh1VAzHQ2CI4u5iarB7TU9/vhWh/UK0QV0Z3f+5F6tAziJSi1bUPWZYyj0I2x1
	L7Ib5+FVlm/v+qnrvgO5hZislKoxPWITRHR3TQDBSV4wluf4rxf25chkCMommo7agwd1V8g9zd3
	GA9o0bx28ZSHVmcF9dUdsrIFjTQxeDz5DyTh7lYVAfs9Bimb24HXTaD8+EYaXjChJty0Hor05Uu
	PsjBLVNp7g9hjpGdJYD661FEL6b3G8xDsO9d0gW59cmOVGSzsCBRfvD/0vzIoiCNBdd7PVEesJw
	mO6hVU1hC1n0zFhq+gConcNbphLszAGyqB5lYTu9l1wEq9X/IjAmnJFJhWqTFfvvY9vmfG5FblM
	YYhCIQL6rQrynNb53XYT2lll2Cb7fk=
X-Received: by 2002:a05:6a00:ab8b:b0:8a0:2d72:17c3 with SMTP id d2e1a72fcca58-8a07bfad81cmr211032b3a.15.1792445717320;
        Mon, 19 Oct 2026 14:35:17 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm4307747b3a.53.2026.10.19.14.35.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 14:35:15 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 0/4] Fixes for errors and warnings in layer updates
Date: Mon, 19 Oct 2026 14:35:06 -0700
Message-ID: <20261019213510.4384-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 21:35:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5100
Content-Type: text/plain; charset="utf-8"

These fix problems found while running full updates on a test
instance loaded with a copy of the layers.openembedded.org database.

1: Files in layers within a layer were indexed as part of the outer
   layer on incremental updates (e.g. meta-voltumna's vendored
   openembedded-core and meta-openembedded). Affected layer branches need
   a full rescan (update.py -r) to drop those records.
2: A layer first seen on a new branch copied its subdirectory from the
   oldest branch, so meta-tq failed on wrynose.
3: The core layer was in BBPATH twice, giving a "Duplicate inclusion"
   warning for maintainers.inc for every layer. The matching BitBake fix
   for include_all has been sent to bitbake-devel.
4: Long recipe values (LICENSE, inherits, BBCLASSEXTEND, ...) were being
   truncated. This adds a migration on layerindex_recipe, which took
   under a minute for 365,000 recipes on the test instance.

Tim Orling (4):
  update_layer.py: skip layers within a layer on incremental updates
  update: copy a new layer branch's subdirectory from the newest branch
  recipeparse: don't add the core layer to BBPATH twice
  layerindex/models.py: store long recipe values without truncating

 .../migrations/0055_recipe_text_fields.py     | 58 +++++++++++++++++++
 layerindex/models.py                          | 27 ++++++---
 layerindex/recipeparse.py                     |  9 +--
 layerindex/update.py                          |  2 +-
 layerindex/update_layer.py                    | 41 ++++---------
 layerindex/utils.py                           | 22 +++++++
 tests/test_latest_layerbranch.py              | 52 +++++++++++++++++
 tests/test_recipe_fields.py                   | 53 +++++++++++++++++
 tests/test_utils.py                           | 45 ++++++++++++++
 9 files changed, 264 insertions(+), 45 deletions(-)
 create mode 100644 layerindex/migrations/0055_recipe_text_fields.py
 create mode 100644 tests/test_latest_layerbranch.py
 create mode 100644 tests/test_recipe_fields.py


base-commit: ede7510fae1ea6225cac56a020e5e9ae0033b467
-- 
2.56.0

