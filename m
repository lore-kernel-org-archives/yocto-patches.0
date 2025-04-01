Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD33C36017
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 20:09:55 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.3538.1743538191526702539
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Apr 2025 13:09:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Tz9Es2bY;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab771575040so34834566b.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 01 Apr 2025 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743538190; x=1744142990; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0/+t8SNMYYCWFIjfalgY+i0vbfjPzVkYLzCBLK0dU0=;
        b=Tz9Es2bYL5eX9E8YNpzsBvrwJJ96YT6W9mXLhCbhUgyxlQd6TdxrMcUPNirbWu2ggs
         zvnhxhu42x6jc4XEs4gLNyqR9girMOKn4s42zdLnDArelNfSw3k1hueqnNq5S0GHHZWj
         AhpkwST6l0T0WGpiNJ2sd20bR68xsR1V5jWQOFU8yUhh2d8H60y3+Fr8DdPZ820YBKxC
         L7OnLQz5tTL1rxn4ZbywGyCbm56D2PFu3DiojnKunCa+rLyYuv+wEzzEn/M4Nt2DfygH
         /+rDUSWk3A3lKP4kAyYTp53TrXKWWkoFJEuhsCwIMdMeQFRTOo2D3HPJTzCBKpukbzSd
         jGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743538190; x=1744142990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0/+t8SNMYYCWFIjfalgY+i0vbfjPzVkYLzCBLK0dU0=;
        b=P+b15Q/aQmf6aUnELFd3XD6l5VwpWw1aNyGkFsWIp4DAwElFUJCypwIXRxrBALuoOl
         KMqpezo0cGtZMZIPuG1fcr6L+vnAyFEAYL/PRGd7XsvIxI4jceBAl5HyeCcgG6UXAoVG
         9mdl/ZymlhYzca7IBUQ2EfQswVpUHN2tti4kXKhJTqEOYUPCGsokwM0d6vrRuPHLJVCW
         aMVAwvsV4//mlODP/MVC4bLYucVBpJ/VKKjQvZEeshiAXTf3khmeTqIFOzxSlMX2/1LZ
         k7r8m6k35mE9sgyWjmwmK/BnYkT/0+XcCqqDodFxisrv9pleUiRxnhDNUDNOoCjdIj4g
         zUDA==
X-Gm-Message-State: AOJu0YwrYXTZzneH+ZRZzy/AMNG6Yk5Mu7tZKIrJVMee2OQqa23iEcw5
	i8e8BXzDfivWWhDk1ydqTGUtajri/MgfD5Ji7Dn63+xj8u5F+szJggFjcbbU
X-Gm-Gg: ASbGncuLh3ZxnRUncqoXc4xB0UQUmNEt1iNjhGz1+tAtB8bWx4dkWB7I/6MKCPGM68J
	Rm6clDFwDvJIatZmnW3P1KLAafQBI5I23ffK43yLXC5ccrE6AwOeS4C2mVYCoxUysQfKW4DyuOU
	tpYqGmSK14M5NpxP+RahTC+6rekoX6YEFsaXKkmbl2QbEruYCP+KxJB5kEKkN1oGsWbZdySe5QT
	AzwrF0YDN67w9cxbSK1PD+c8vj23p3lQFYEp1EToHAM6OwCoC9IV0rwWcfLQLGY7vk8bDhKCYv2
	k20pRYvwhY4Zwqj2rLxpt7tm4qe1tepRLV4Btiz97z/8KXHvPdy14imF+XA9GzTX2Lw2oCITt6t
	00g==
X-Google-Smtp-Source: AGHT+IH/F4BpHtf//1COyIiRzyYtj4nPNAupDusAlntRrFvU/xOQ4TZrmrH7UPT+tDv+wpVSUveQIw==
X-Received: by 2002:a17:907:7202:b0:ac7:2fbb:ba5 with SMTP id a640c23a62f3a-ac797af177bmr114353066b.7.1743538189648;
        Tue, 01 Apr 2025 13:09:49 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac719621718sm819995766b.102.2025.04.01.13.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:09:48 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hieu2.nguyen@lge.com,
	jaeyoon.jung@lge.com,
	mathieu.dubois-briand@bootlin.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [yocto-autobuilder2][PATCH] config.py: Update meta-qt6 from 6.7.2 to 6.8.1
Date: Tue,  1 Apr 2025 22:09:22 +0200
Message-ID: <20250401200927.3449242-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Apr 2025 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1274

From: Martin Jansa <martin.jansa@gmail.com>

meta-qt6 is only used for the webosose builder and webosose now uses 6.8.1 after:
https://github.com/webosose/meta-webosose/commit/f2155a6afcd15729857032bfed364fb5f20f0c48
https://github.com/webosose/build-webos/commit/c9440cb8f05048755608a2b618fcfc16d241dea9

This update avoids:
WARNING: meta-qt6/recipes-qt/squish/squish_7.2-20240124-0915.bb: squish is currenly not supported, build produces empty packages!

shown on webosose builds on autobuilder, newer squish is included
in meta-qt6 since:
https://codereview.qt-project.org/c/yocto/meta-qt6/+/611845/6
this time without "inherit disable-build" which was showing that
warning while parsing.

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 config.py     | 2 +-
 schedulers.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index e07e558..a3489ec 100644
--- a/config.py
+++ b/config.py
@@ -61,7 +61,7 @@ repos = {
                           "master"],
     "bitbake": ["ssh://git@push.openembedded.org/bitbake", "master"],
     "auto-upgrade-helper": ["ssh://git@push.yoctoproject.org/auto-upgrade-helper", "master"],
-    "meta-qt6": ["http://code.qt.io/yocto/meta-qt6.git", "6.7.2"],
+    "meta-qt6": ["http://code.qt.io/yocto/meta-qt6.git", "6.8.1"],
     "meta-qt4": ["ssh://git@push.yoctoproject.org/meta-qt4", "master"],
     "meta-qt3": ["ssh://git@push.yoctoproject.org/meta-qt3", "master"],
     "meta-mingw": ["ssh://git@push.yoctoproject.org/meta-mingw", "master"],
diff --git a/schedulers.py b/schedulers.py
index 593dff0..2cd2d9d 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -180,7 +180,7 @@ branchdefaults = {
         'branch_meta-virtualization': 'kirkstone',
         'branch_oecore': 'kirkstone',
         'branch_meta-webosose': 'kirkstone-webos',
-        'branch_meta-qt6': '6.7.2',
+        'branch_meta-qt6': '6.8.1',
     },
     'honister': {
         'branch': 'honister',

