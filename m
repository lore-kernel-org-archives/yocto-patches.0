Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC3C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 03:39:10 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.3655.1742269142989168667
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 20:39:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hzbwXspb;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: raj.khem@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso4615018a91.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 20:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742269142; x=1742873942; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMLuYlLuAtkDnuTWGjfbL5HUg6rAX1e0h8lfrnl1xvU=;
        b=hzbwXspbWDc3O4ZmpjMcKaqfrAtzqR8ACcFsqd3pNgp2CxQv5mWiVUYQlvOrtbt9/r
         SfYQ95r7n7roBii5wM1hDmaKgV6JE2hn+5av7tEm5iBMswDQopAp32GUj0Mv9zWewNf5
         ZrVTrO+vqVBcdPeEAVCPnxNuqr+kyJBB9x6DM0xq0smTKRUD4Ft5q1VjqY5NPN36uvav
         YUVZFcCLHa2M8UhID8C4lePifMvUu75n+reKOV+j4sSesuBLNDU6A5GGQF0I/iWJKxoY
         nDbfWYOfzIBrVKD1cwCXIQ72EruH/N6FMP5yXIKU9Idf6uXM0rQFDyTXzVPi7sFgIQeZ
         LiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742269142; x=1742873942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMLuYlLuAtkDnuTWGjfbL5HUg6rAX1e0h8lfrnl1xvU=;
        b=dwb2P5/OHfqcuJpOXuwUcyX03JXguyJqCqY1WwIe7zjvNb6zslQUFinokIwlYS2oqS
         gAKePT5IxkWXGXY7TpfoQJL73SA1BTPI2x+ZcGKryhX9cu04ReDd+2Wn852G2pl2Kc5z
         vLES7WhL3AMsdVuV1iiIVM2G0uLtxNbpAUXMuZY+yUog7VPbRByjhBsqfEcgtQvhga9X
         h1XAwNiugG9a7HICczrzgbL7xIo21RP1jI6lX4uPrS41qQ+v9TB23QYk/Zr3sghGtvGY
         WU1Lx1DVeFy3/UhDImeS42L9vCcNHvPMN7Xuv3fbDyQQXH9w++wlhQwhDSiRTiHUAUx1
         rdDg==
X-Gm-Message-State: AOJu0Yxv4zNJrMV13SKx7dmd7ZMztnBjE3d2qG09LX2/aTzswriJcmWz
	4/hIShfb83oq9y+5XTNUwPSit8k0kKCetx+Y/iEYbCfhrqLqiVQmeUu8pNT3
X-Gm-Gg: ASbGncvqpVyjVuS9l5Eh6z+Q2jirPGyANszFrJ/qtEhLaohEXI3nZpruktJndViOpL4
	1r4hMvDcdRCiXV4RiZTU57OGsvne3igv7ot/CH+teDekDDj83BP8bVpXqzqcu/aJKjsM7aHpRvG
	JWM8dhIimCXCZvG4TYRFd0+0eQSJ2u/5+i198CmcFIjoT6dLQjZWqn5cB5tuUNOAjNM6lxDm3WD
	91YYg7dHWeBUZICZGdTq8ZGMo/KVpll1nR82RPCmsgbwviMiH+QIfAY+RtfB+S++WfMm25aVTHm
	W+7zteOy3ik77ZBaq/wv0VmTlUhw2kY/uJ9/Stf4zn8pnzQ=
X-Google-Smtp-Source: AGHT+IF3z0sIcBpYOmZ/3yn+J1+dOyEysWuvBxE2YvMfNPvc+Wi1OCdQGVnbE8KFeKukSuMC9frh8g==
X-Received: by 2002:a17:90a:e7cc:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-301a5b173b1mr1084437a91.8.1742269142152;
        Mon, 17 Mar 2025 20:39:02 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:8201:fd20::6874])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301534f477csm7000408a91.5.2025.03.17.20.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:39:01 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [psplash][PATCH 2/2] README: Update mailing list to point to yocto-patches ml
Date: Mon, 17 Mar 2025 20:38:58 -0700
Message-ID: <20250318033858.2400370-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318033858.2400370-1-raj.khem@gmail.com>
References: <20250318033858.2400370-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 03:39:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1214

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 23d5bcd..7c61e0b 100644
--- a/README
+++ b/README
@@ -12,7 +12,7 @@ psplash such as boot progress information.
 Contributing
 ============
 To contribute to this layer you should submit the patches for review to the
-mailing list (yocto@yoctoproject.org).
+mailing list (yocto-patches@lists.yoctoproject.org).
 
 Please refer to
     http://openembedded.org/wiki/Commit_Patch_Message_Guidelines
@@ -25,4 +25,4 @@ When creating patches, please use something like:
     git format-patch -M -s --subject-prefix='psplash][PATCH' origin
 
 When sending patches, please use something like:
-    git send-email --to yocto@lists.yoctoproject.org <generated patch>
+    git send-email --to yocto-patches@lists.yoctoproject.org <generated patch>

