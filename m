Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE8C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 18:44:41 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.30773.1743014675978377850
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 11:44:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PFzhxF6O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso1309255e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743014674; x=1743619474; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUOV8UBEZ0uO68ZLjMC2vNZc4FlS4RN6mtpnhEs0dsw=;
        b=PFzhxF6OKjy/ecQ8zKq8rmfx8dMKRLCUVQ9fOBY3i3qbkyG6dZ9FqpXvCjXT13kqrs
         YCeTfmZ13uBINw8m08YCsgds0gHRMx4BSRv6pCtatpAEWA6N0wUKZZfGAi1mRu+l543b
         ELMS/rSV8uycnVHeq6DJW3S8grPXWIpvziEvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014674; x=1743619474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUOV8UBEZ0uO68ZLjMC2vNZc4FlS4RN6mtpnhEs0dsw=;
        b=LTs620BPROG1N3DNuylAcO2DXSKzPRbt0QHx363RCmkHY9qvdYp47HHYyDrMypDHPb
         2YHPm0oXIlZ42xKYHNEiw1llfTcZ1u/u7UfuRJ78an3ROSfXi4DpNgIcfZcfuv53yFpr
         vJx+PiGb0FdFZulDWua+5W3m9ckWFbWqkxwADnYs5h+0TgofisX1Hog0A0Miznfl9syT
         IcrBPXhbpi7+l+Habm677l9CAbzXMXj7vSuFt6xS6zE6I6tzSp22YG9tD1yJZf6POSjV
         075g5Vj1sC29SmJ2YYiwztO7djyDbHaL9eokqA9u3hT6m+1J9LM8Y71bZccc9ooZmWIj
         Q4HQ==
X-Gm-Message-State: AOJu0YwX11GksF4ad4z+Y9RX8f1qHBISo3hMDdJkLlW/E4eUrl+4BWI/
	Zd7JVwTT6NZJxRBEvGEhs62H3E4e2WepRw00agDO1/nCqpSuxww450AxQC1VZJFwOdGEQcXlGt6
	1
X-Gm-Gg: ASbGncv6jNtmcqZ7FXDyJWC3jpp4Y6BzBQTYaGh/nE7/ZLL02LN8mvl+oeJ6Zi1+AYb
	7sQ9LMhmBCxo2oJTbPXFvcStory3s/9wexeZgl5DziKgZ3nK516gH9WR1DgvHW0r8kXYffIcbtT
	gmiSf5tS/AXO7HCpWOEOCIiuiDWYEuhRTHpvJfUG/GkYhnNliYCJIa1kvOkAiS1TpFkvt0Uk3r5
	nT8Z1cFbBUVLSLhu8+lEED1+zpqhrYRqUiS7VQKBhy3ve8MRCTQ43X36nGycqSyuA4QnmF1md4e
	FuuuTE70yclUKYyJdbAg19HZ5zdv5pirA8ZSsW2TbrrPMQZLU0q+ApbYU2y2sFo/vLJx+Eyjqg=
	=
X-Google-Smtp-Source: AGHT+IFqYgVHyLvdFr0iEuz4x9TQDnmVhGv/fF8nNr0G4qRQMMp0yhHK2YX74pYDwXfxfvS2U9LRxA==
X-Received: by 2002:a05:600c:4f0e:b0:43d:1bf6:15e1 with SMTP id 5b1f17b1804b1-43d8465f999mr8776355e9.1.1743014673732;
        Wed, 26 Mar 2025 11:44:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fab8:513e:e094:22ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314bbf1sm10333305e9.38.2025.03.26.11.44.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:44:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop qemumips based multilib test
Date: Wed, 26 Mar 2025 18:44:28 +0000
Message-ID: <20250326184428.868803-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 18:44:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1262

Since we're not actively testing mips, we should drop this specific
multilib test too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/config.json b/config.json
index 0a2a4b8..03472a5 100644
--- a/config.json
+++ b/config.json
@@ -954,16 +954,6 @@
                 "extravars" : [
                     "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib64'"
                 ]
-            },
-            "step6" : {
-                "shortname" : "mip64 n32",
-                "description" : "qemumips64 image using n32 as default",
-                "MACHINE" : "qemumips64",
-                "BBTARGETS" : "core-image-minimal core-image-minimal:do_populate_sdk",
-                "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-minimal:do_testsdk",
-                "extravars" : [
-                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-mips64-n32'"
-                ]
             }
         },
         "pkgman-non-rpm" : {

