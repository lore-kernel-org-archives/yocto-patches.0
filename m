Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC132C54FB3
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 03:25:23 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web10.12820.1748489123067700799
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 20:25:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=F1CFZ4AG;
 spf=pass (domain: konsulko.com, ip: 209.85.210.195, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-742af848148so245760b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 20:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748489122; x=1749093922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neeaq75vTwnWJuTUP94mzo7ZeiY7HOakrFkZ/VbYSrQ=;
        b=F1CFZ4AGm7DiK+qj+hDcucbAcrxGWm5slUBFPIES58Tfjo5/t5QoBYIJk0yXRPmh6R
         XyVKFivCkQvRzCDx/pjh3jw2PTKKIn786n3SifAkTZmGItNIuD5uKVK7dtp3IFEVLAdt
         BsHjuRKnBis974IUiC8le0Sh9M3zpdNXT7mKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748489122; x=1749093922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neeaq75vTwnWJuTUP94mzo7ZeiY7HOakrFkZ/VbYSrQ=;
        b=EzpPe32RV+UBKrDiFc3hKdo+bRTEDY+JuX/HP5eYAZ90BC5QCYyBR3LkLLmWbxswTZ
         SnX7apJUzRjcpKEprigafsfMQwFHtXcQBQnCwRU6eZMW44AF9TBeZYph1Dy78IF9NUnI
         tJbxPhbmlNPtIqRepfDuQpP+GuRhxq1jSO8aOMzU59vecJOFDrZ00gH0VXg0uM01kgWW
         sP7SdK4vqx2GxFhRfNnArcR8PToBG64Ty5hSvYindLJxsiuSdR2UXI26HmYoUk0w78IU
         gCQuoENrFjQnOGk4Cgc5mHu15wT7rw1nWY4n9CGyhEmZMdgtBE7qGt6iwHA+Iyv3UYUy
         MVuA==
X-Gm-Message-State: AOJu0YzlIzUw3/Q9+9ude/sTxeSxEBi8MKTcUU6sEoE89pC8JfTivfsn
	tplONis4NFtBvP3qqXxvhVz3sEIJeL0Ft4vvwsx06hZm41cYL3bu3oPuP5a4twK/z86cnP5x5gt
	QpltR5Y4/t6Qq
X-Gm-Gg: ASbGncvYMcPbQA+LWigwISMOR/2b5pkRzQkK1BCLJm5xge7ODYdibszGjviFoN2cRDN
	9h4ygJ26TldBm8y6zpVVH80gw0VeFg5D7nWCpFfmxaWGrHGLoCp93npdMP3DiUDwO2E1mDmxvRi
	tWwfUM1Lgwoy52GVRHzrQsJ7fqRBbc/qIBENSzhTrYjZsqCX5ZdH/cgIHLNU/3vNwxM2emhiUqW
	gBXfwdqBFBRdP6GZXVcoyXX6OUIDw04gFajdF6YBmD6xWBrFlO9IVMcG1pmNM1Y5ZdSjmnoQfeO
	AXGXrYgGGumt+IQ3b8lk4oc9IiZIz5gJR/p+ReFd+KF3hkQLYHsz/w/U+mGVa57O8/96aaxDjk5
	GmE6cqZ+Jc06f2ClWUpJAiotGPw==
X-Google-Smtp-Source: AGHT+IEJ1dg6GBYAtI21ytIEVUGhF/f+n9Ul7YpTmqNUJRXFz1/RutfdVYscXLHuhx4EXcJuVDy+9g==
X-Received: by 2002:a05:6a00:114c:b0:740:596b:4a7f with SMTP id d2e1a72fcca58-745fe035e92mr27902618b3a.16.1748489121869;
        Wed, 28 May 2025 20:25:21 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd41d7sm342022b3a.123.2025.05.28.20.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 20:25:21 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [PATCH 12/12] u-boot-common.inc: drop tag from SRC_URI
Date: Wed, 28 May 2025 20:24:41 -0700
Message-ID: <20250529032517.774042-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 03:25:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1596

From: Tim Orling <tim.orling@konsulko.com>

Fixes parsing error:

WARNING: .../meta-lts-mixins/recipes-bsp/u-boot/u-boot_2025.04.bb: Exception during build_dependencies for fetcher_hashes_dummyfunc| ETA:  --:--:--
WARNING: .../meta-lts-mixins/recipes-bsp/u-boot/u-boot_2025.04.bb: Error during finalise of .../meta-lts-mixins/recipes-bsp/u-boot/u-boot_2025.04.bb
ERROR: ExpansionError during parsing .../meta-lts-mixins/recipes-bsp/u-boot/u-boot_2025.04.bb                                       | ETA:  0:01:39
bb.data_smart.ExpansionError: Failure expanding variable fetcher_hashes_dummyfunc[vardepvalue], expression was ${@bb.fetch.get_hashvalue(d)} which triggered exception FetchError: Fetcher failure: Conflicting revisions (34820924edbc4ec7803eb89d9852f4b870fa760a from SRCREV and v2025.04 from the url) found, please specify one valid value
The variable dependency chain for the failure is: fetcher_hashes_dummyfunc[vardepvalue]

ERROR: Parsing halted due to errors, see error messages above
WARNING: .../meta-lts-mixins/recipes-bsp/u-boot/u-boot-tools_2025.04.bb: Exception during build_dependencies for fetcher_hashes_dummyfunc
WARNING: .../meta-lts-mixins/recipes-bsp/u-boot/u-boot-tools_2025.04.bb: Error during finalise of .../meta-lts-mixins/recipes-bsp/u-boot/u-boot-tools_2025.04.bb

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index fd1eab5..b0ea013 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -14,7 +14,7 @@ PE = "1"
 # repo during parse
 SRCREV = "34820924edbc4ec7803eb89d9852f4b870fa760a"
 
-SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master;tag=v${PV}"
+SRC_URI = "git://source.denx.de/u-boot/u-boot.git;protocol=https;branch=master"
 
 S = "${WORKDIR}/git"
 B = "${WORKDIR}/build"
-- 
2.43.0


