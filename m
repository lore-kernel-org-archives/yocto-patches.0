Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6FCCF0450
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 11:01:20 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.13621.1728471676372032585
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Oct 2024 04:01:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R/Y/aXZG;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso8827751a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Oct 2024 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728471675; x=1729076475; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LCxT/psf6UepdDi6kQyGP2XcTbH1ISk6s9Kzh2bZtTw=;
        b=R/Y/aXZGKi9vfSwuai11E0EU22Q/wS3P/gkNtY82GZCEfyp1jUG2xvHeDQv4pDyUE/
         5y54Qevxf2RB241HeNdWVmJ9v32iMG15BaSAnf0EP4YdTbiCDZqXKdFeVdgfhjCwzkXr
         +AH3bZrqQs1ongziVAdbQLe3JF/TW0E4WL+UI/1ZO/dmnFeLvdQUOCQsfSA7QD88iKxu
         cUsmXCtHF7qKlcP6oHEdXjhw2M5/oX423nvq7WtrlbaOMoMoE6wuKvVu+ep3nlbW++h3
         0SAKMYNhrmNPbvtFsfkE3RVhezb3pvFO0cQbytbXrGx0IwCCGmZtP8Ifm5Hlqc+ovZHG
         /8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471675; x=1729076475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCxT/psf6UepdDi6kQyGP2XcTbH1ISk6s9Kzh2bZtTw=;
        b=oNmKkFfg60kMZubLcd4ivv0uTH5qsZC5VFZshiMaSARSH5L1c1ohGsgFg/Vgr5Pm9S
         nTTU6RTW7TvUDE/i4dPwgXZhWfxSfwVwXtVgWPzvpSjHXt8yERXnjQazYBtFOUbZtCa3
         Cc+EHYnFRs9/4XtEbY14VyaV1v549QY7QgXKsPqC/gOsNTyGa0x6JWVDK3JtJoJgpB1s
         dB9ygcdVMHUZ8wzgwe0Y0wPSzRD+i9hTH9UFUHzhUDBp7IoFwq8y09c6Jl3jNiYHss5c
         4NXy8dN8rHYX9yWUiaqxYpDkZGcIHGGU9CmIFXO3wDr+wvKqnWlrApQaA8GPX8Nqh2Lf
         y1uw==
X-Gm-Message-State: AOJu0YxrZQ2f3mC/U56w+mGWN77EGOL4z/6Fi0DtdzcfxZshE50GVLQs
	M8m/bqpqX9Hd0R3Aje4lpmNZoAGZXhGYOn9OkJWm0yYCHOpNEOE4qs09OQ==
X-Google-Smtp-Source: AGHT+IFIVOHCy+Os6TgxspCWYenXznAdd9V5DiKz8vdfpySbmynQteJsFPwnW43M2HtJlSsx8j/Ktg==
X-Received: by 2002:a17:907:7295:b0:a99:44a8:743f with SMTP id a640c23a62f3a-a998d199681mr176025366b.21.1728471674420;
        Wed, 09 Oct 2024 04:01:14 -0700 (PDT)
Received: from fedora.fritz.box ([2a02:2455:86a1:c500:cfe8:f434:3125:3cb3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7b19b8sm641062066b.154.2024.10.09.04.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:01:14 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: disable pgo in python's buildtools
Date: Wed,  9 Oct 2024 13:01:08 +0200
Message-ID: <20241009110108.995240-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Oct 2024 11:01:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/696

pgo requires running a subset of python's test suite under qemu usermode
emulation. With python 3.13 upstream added a strict requirement of making
that test suite pass, and this has uncovered that:

- we've been incorrectly running only a small subset of that subset
(7 tests out of 44)

- when restoring to the full subset failures occur all over the place,
due to attempting to run cross-compiled python sub-interpreters
(qemu usermode won't insert itself when sub-processes are started
from an emulated executable) and other differences between
native and emulated environment that I didn't look closely into.

This is not unfixable, but requiers significant effort which I simply
can't allocate now in the scope of 3.13 upgrade.

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 config.json | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/config.json b/config.json
index 13977d9..5d866b9 100644
--- a/config.json
+++ b/config.json
@@ -1109,9 +1109,6 @@
         "buildtools" : {
             "BUILDINFO" : true,
             "MACHINE" : "qemux86-64",
-            "extravars" : [
-                "PACKAGECONFIG:pn-nativesdk-python3:append = ' pgo'"
-            ],
             "step1" : {
                 "SDKMACHINE" : "x86_64",
                 "shortname" : "x86_64 tools",
-- 
2.46.2


