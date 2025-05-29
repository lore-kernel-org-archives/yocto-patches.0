Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90FC5B549
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:03 +0000 (UTC)
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.12370.1748486514351456158
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:41:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XkNuRzFG;
 spf=pass (domain: konsulko.com, ip: 209.85.214.193, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22c336fcdaaso4339375ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486513; x=1749091313; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/2WLLIII6QkXJi+z1JlIqfWq+1bCAMO1Q7/3n1X1ag=;
        b=XkNuRzFG742zGMpodb885zSxu+gx8vR6N0PfOd/pXjAKN/gjc9I6cw9wltFdqRgg0N
         OL9eplq1m/dv+b36AwRWGOA6gresypT6hGv8AG0FU5N/S8tf3wfJERXPmnR8N1h4w1md
         Sl50ro15rijOtxq3m9JxAP4/3l7jze7Vup4Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486513; x=1749091313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/2WLLIII6QkXJi+z1JlIqfWq+1bCAMO1Q7/3n1X1ag=;
        b=hxhizCD1GCruk20p1ZVcsjzZA5ruwzJXnhYzhr0bgeMJPsnhBmYlqjnkED+sZC4X5v
         VjflVkzt2gAVdbPZyonVeoiESvvcoC6AuSEVo9zgWbnvM/A61eOSRx4C46cetleilamp
         bh2fW2YGrFr46m+n2eD5v6xAGCFACHK2LYV/5kUhijwm7PQzYsUmNDMrTVyMm/9nfagU
         Ay2P8w8laVW4PJpQWxjPjRBtfwsXPjrFDvlRKt5JEA0EhOM+vBIy1IchYCAw4+nCAKgL
         y955jp2/E4PfO5a/+6+C9crzsBBQI+TB47uBe2/aIaqb1J0KWz3yE6wPzMXullNl59FK
         LDug==
X-Gm-Message-State: AOJu0YzzZOZxwbu5yOs+YIx6Tw/SvPKCrp2wPjMRLYZ+Q4qOpYE2aYwk
	fuVJwVQDGEwp1+tbl7FrIWGmpURDDRNTM+rrX0H2mX7JBKTHGJSkVzs9UOCv1GZhkNGlr43bQ2o
	s0oTYmGWEG0AU
X-Gm-Gg: ASbGncuKp8ZmTKfxopVhvgAmckpKATlxI9426XmCtxDb5I10G39juf6BpWJVa8WNd3d
	VlT2N3p9PcRR/it98WHxZMhamtdVP8MDeMv0G1LIN5Uh+Y0DDXCqUb4DjHrvERdO+kRuf87+WGm
	hUxvQxc8G/TiRS+qQFqA5WhwsxzoLxksNkcqDOjjL6rIvaRktmyGExvzDBU5JfQE/XkyOoWXC3j
	v2jElW0e74GuFwxmFmUnHiETUm4kUy6GKqnSdF+fvZqlpQjiBqLjezbXxhzUCz9zC+3npK/iVdE
	lqBphuk9JvHpZjAWQksPCTLijBFHIDiv8aC7JH11+DvvgdGa/eZaowvtU3+swWt9rWlEqBLy3TB
	eiNMeKvmO4g2r+kGKckdqfP/Ecw==
X-Google-Smtp-Source: AGHT+IGavOku5bwS1nAPFkE+dmlUC34xcHfFpkoOA6oZX/Ol0XN2hcmtUv64H2HbvAL8fRnRHEcNCA==
X-Received: by 2002:a17:902:ed81:b0:234:a139:11e7 with SMTP id d9443c01a7336-234a139137amr99847165ad.35.1748486513181;
        Wed, 28 May 2025 19:41:53 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc88a7sm2865365ad.39.2025.05.28.19.41.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:41:52 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 00/11] scarthgap/u-boot: upgrade to 2025.04
Date: Wed, 28 May 2025 19:41:27 -0700
Message-ID: <cover.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1584

From: Tim Orling <tim.orling@konsulko.com>

Apply selected patches from "master" on top of existing 2024.04

NOTE: There are features in 2025.07-rcX that are desired, but we will
wait until 2025.07 upgrade lands in "master".

The following changes since commit 66ceeebd047d7fdfc8668b300319a76da8ae257d:

  u-boot: update to final v2024.04 release (2024-04-05 07:38:57 -0700)

are available in the Git repository at:

  https://github.com/moto-timo/meta-lts-mixins scarthgap/u-boot-2025.04
  https://github.com/moto-timo/meta-lts-mixins/tree/scarthgap/u-boot-2025.04

Fabio Estevam (5):
  u-boot: upgrade 2024.04 -> 2024.07
  u-boot: upgrade 2024.07 -> 2024.10
  u-boot: Update Upstream-Status
  u-boot: upgrade 2024.10 -> 2025.01
  u-boot: upgrade 2025.01 -> 2025.04

Florian Amstutz (1):
  u-boot: Fix potential index error issues in do_deploy with multiple
    u-boot configurations

Maik Otto (1):
  u-boot: Set CVE_PRODUCT

Markus Volk (1):
  u-boot: Add patch to use SWIG_AppendOutput

Otavio Salvador (1):
  u-boot: Ensure we use BFD as linker even if using GCC for it

Ryan Eatmon (1):
  u-boot.inc: Refactor do_* steps into functions that can be overridden

Tim Orling (1):
  u-boot-tools.inc: Fix variable assignment whitespace

 recipes-bsp/u-boot/u-boot-common.inc          |   4 +-
 recipes-bsp/u-boot/u-boot-configure.inc       |  36 ++-
 recipes-bsp/u-boot/u-boot-tools.inc           |   2 +-
 ...ols_2024.04.bb => u-boot-tools_2025.04.bb} |   0
 recipes-bsp/u-boot/u-boot.inc                 | 287 ++++++++++++------
 recipes-bsp/u-boot/u-boot_2024.04.bb          |   5 -
 recipes-bsp/u-boot/u-boot_2025.04.bb          |   4 +
 7 files changed, 220 insertions(+), 118 deletions(-)
 rename recipes-bsp/u-boot/{u-boot-tools_2024.04.bb => u-boot-tools_2025.04.bb} (100%)
 delete mode 100644 recipes-bsp/u-boot/u-boot_2024.04.bb
 create mode 100644 recipes-bsp/u-boot/u-boot_2025.04.bb

-- 
2.43.0


