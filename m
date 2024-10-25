Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D7D0C5E8
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.7376.1729844569032579393
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ejLBKKGv;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so2284555e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844566; x=1730449366; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJiDyb7y08ZD9dtuF18zy9lt6+qGojlyvNXzQn11cMA=;
        b=ejLBKKGv6IRUGWrC+NUdcYH7uVc1uS4SIaxmk+39DLtDzGNdg7Qu2SPmnmNulHK1Mb
         HyRGcCBBkPVFxC03x6t7HRCot1vhTgmUOBA36D+3jGhRpzqy9uwO7sDhG19H21WuEJwp
         fs3b5cJxDeqCu4NvWeYsChPJXmomGYWExVQoPbb/UBxtKppq4Jne/FfFMdCn2X2xaDlb
         6NuKZMZ+lOBgOTZNHGsMMT2DGdSEpRxbMXOQxGMVDrLrnTaj9zGpVIgSWz7eNkzyygU3
         iPdTW3VhcHySwDIwuqOuTMWjn3ZTaEjDb2vO6Rla11xBWHEwykTpRim7AhtXn2oN+dAN
         Mwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844566; x=1730449366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJiDyb7y08ZD9dtuF18zy9lt6+qGojlyvNXzQn11cMA=;
        b=kWP0iBV1cEJP7RAW6Dld2rDvdmZTJCgt/y/gJRn/hgPNKeekTI4fZlemL85DKVV9Mj
         oHHJD9yu7muVm2IKReCRasHgi6gEH7rl4Idy1iQWMQdtm9jK+ISLu17Z4HrNPo+PWcIL
         LdXhAZiCwNKSvR+qHPWkE4Kkhkpim3fWb7NQiHyXMpp9fenqEiHeLvHLIWWiE/fJbbBc
         5eV24sH1XG3qc2cBb9enUdFok4SBbzAK5D2LVoMUT6D/E47NTgzOKi9ewv4BJNYrARl5
         +dYDZQNkOBOT5+ON6DGCorVzKmhRSoAwmC42H8kIOTKA+dwSZPlLAZYoIbd4LRTaT/qd
         bnBA==
X-Gm-Message-State: AOJu0Yw0FBXUI2LQYfMudcOwBle6wXzGQjOtvwPqxzUyZzOAw0J/8+gE
	sVd0lplQlN6zjayzYBLjCs0e1uALYRKKB78Cn4FeuUCK5iznpsjO6GWRQ/ld
X-Google-Smtp-Source: AGHT+IEcndjYT8ClWyg2Y7LxKm7HjJl5IM+8fbKXLnZfO6Z4TEIGAdhuIr82wxrDJybgy3SzcSK9kA==
X-Received: by 2002:a5d:64e5:0:b0:37d:4864:39a2 with SMTP id ffacd0b85a97d-3805b3fd077mr244283f8f.7.1729844566379;
        Fri, 25 Oct 2024 01:22:46 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:45 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 03/10] sssd: fix missing python3-logging run-time dependency
Date: Fri, 25 Oct 2024 10:22:32 +0200
Message-ID: <20241025082239.3468351-4-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/751

The internal tool sss_analyze is a python script run by the sssctl
command analyze.

The script sss_analyze imports the python module logging[1].

However, the package sssd lacks installing this python module that is
required to run the script.

This adds the missing run-time dependency python3-logging to ensure this
module comes along the package sssd.

Fixes:

	root@qemux86-64:~# sssctl analyze
	Traceback (most recent call last):
	  File "/usr/libexec/sssd/sss_analyze", line 3, in <module>
	    from sssd import sss_analyze
	  File "/usr/lib/python3.12/site-packages/sssd/sss_analyze.py", line 3, in <module>
	    from sssd.modules import request
	  File "/usr/lib/python3.12/site-packages/sssd/modules/request.py", line 2, in <module>
	    import logging
	ModuleNotFoundError: No module named 'logging'

[1]: https://github.com/SSSD/sssd/blob/2.9.2/src/tools/analyzer/source_files.py#L2

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../recipes-security/sssd/sssd_2.9.2.bb                | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index f6bbac3..e8f3031 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -156,4 +156,12 @@ FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
 
 FILES:libsss-sudo = "${libdir}/libsss_sudo.so"
 
-RDEPENDS:${PN} = "bind bind-utils dbus libldb libpam libsss-sudo python3-core"
+RDEPENDS:${PN} = "bind \
+                  bind-utils \
+                  dbus \
+                  libldb \
+                  libpam \
+                  libsss-sudo \
+                  python3-core \
+                  python3-logging \
+                  "
-- 
2.47.0


