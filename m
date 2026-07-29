Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19392C54F55
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 17:07:45 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16612.1785344862242409723
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 10:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MszkT7Fo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954d29264cso5754395e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785344860; x=1785949660; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lTn2TlV8nGuJxSF0F9bED0j5Hn3NXow1vpkE/vQXqC4=;
        b=MszkT7Fo8cYHr3gx4Xr8OuqVeUzk34xcftA1FAfmozmMHp+dX0WmepA2sN9mUrpeIM
         JGcKLJIm7EpKXbVCgws0jfaL0rWKqxkU6+MvNYiRO7NFmQ0+WoAfpvdnXjzy73uZ2dLk
         5kcetZtJsUlllmh7tQHo5b8mgP1lxBCpeZEv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344860; x=1785949660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lTn2TlV8nGuJxSF0F9bED0j5Hn3NXow1vpkE/vQXqC4=;
        b=R3CkSDxd4sH8ZnkUxaqGwUz1SDbki7VWd0Ei/C6kr47ec5+dpaVE6t8pe4Ob6OginF
         vSE/F+8gPAh7D+PXNMXqj8qCG0mEy1Ud8tUu7sfwSxQNVTFutQCRuwNbAheRJAcSAwFc
         NArfzfePCovl0W0HDoCUCPW+hvYM6d4QpXj8Q2IBKw41vkMmAUNloG78syeOE3mPaeZ0
         E5i4RrHxsZ4sIta5TekZ0j4J9hdQTtCdjLR1J5OoSIJz1DFD19ByemlGGE17XPqTzV9o
         H4WqYmJnHjM8vYQ2UBeT+9dShyHqhHN/P7uCg9mVsrAczTDTtKTAI4z4VH9oOa1nLkuR
         ghTg==
X-Gm-Message-State: AOJu0YxfO+34XZI5j6ZV/MFy1WPacZvMB7VgEl34kHmFIqKKdgs8jz4V
	gatFQbLi7jG9SNNZFtvEFNm/dyqVoW7B6OaJhfXYQoRaPiItB+ZmN473Yl6PD6F5OzD9cxnpnfj
	64n5/7s8=
X-Gm-Gg: AR+sD13zkYMMzhSFQiRmBMPbKex3/4iFyGhIo9P3OIQbB4lGcRVcshGNk25bV+u1xZm
	Fe1hBUDe3ZJ81/eshNuTe8/BYH4oJ3xGsSze/G9TsYaU4GLCUwecqoc2mQYoP8Aam3+d7okIn0n
	a+lpzJRqIgOjoTZLA8rmjrPd1Gct5SygCF822qv/ne50Dsnb0wtn7J95WZERzGpNOs5PMyMFCEV
	hYSzRBeAVFgFHvolt9UYzpROE4TnGZasYsGmsQvrpwUgqdhGsoivztqPlEP65a7R60SpYxe+Gcw
	wkXRLH95saXjleI+3hAfnX0uPpfo9FXAWDrOSg696XT+UoIum6CTS+8UGgABE/yPsgt9/1qt5Bm
	YgymjjBfW0cI0vi0dDtZz/WjZM9eeKj1DwpdefMwqak3fqW01D3b62FAFPyJ73baghM3EPl5cqf
	HqgebjcXWl0rALcY4B6h3u27XeRTOAHkhSzf3HdP6JFSWjF5wjGB+2jqUZL64k5Qw4HnP9A2UeB
	2grs5N1SqvBSkHLrw==
X-Received: by 2002:a05:600c:154b:b0:495:4859:8f9b with SMTP id 5b1f17b1804b1-496c6420e39mr84075695e9.9.1785344860359;
        Wed, 29 Jul 2026 10:07:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b189fbsm9350819f8f.25.2026.07.29.10.07.39
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:07:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 2/2] config: Allow selftest to run on all arm workers
Date: Wed, 29 Jul 2026 18:07:37 +0100
Message-ID: <20260729170737.3034315-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729170737.3034315-1-richard.purdie@linuxfoundation.org>
References: <20260729170737.3034315-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 17:07:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4569

The 20.04 worker is gone, we can relax the restrictions, as per the comment.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 0f72f1ef..c571abe1 100644
--- a/config.py
+++ b/config.py
@@ -234,7 +234,7 @@ builder_to_workers = {
     "oe-selftest-ubuntu": workers_ubuntu,
     "oe-selftest-opensuse": workers_opensuse,
     "oe-selftest-centos": workers_centos,
-    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2604-vk-arm1"],
+    "oe-selftest-armhost": workers_arm,
     "meta-mingw": workers_wine,
     "buildperf-debian11": ["perf-debian12-vk"],
     "buildperf-alma8": ["perf-alma8-vk"],
@@ -254,7 +254,6 @@ builder_to_workers = {
     "toaster": workers_toaster,
     "default": workers
 }
-# oe-selftest-armhost doesn't work with 20.04, can change back to workers_arm instead of the list when that is decommissioned
 
 builder_tags = {
     "qemuarm":  ["qemu"],

