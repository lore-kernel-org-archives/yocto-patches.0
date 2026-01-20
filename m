Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D27D2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 15:14:57 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8729.1768922095164589136
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Jan 2026 07:14:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ANE1pap3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3310391f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Jan 2026 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768922093; x=1769526893; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=od+mi+aDqE7CPKuDMxJHQzuw0uWDvb4ZZJ5LhyMSC2I=;
        b=ANE1pap3GaRu5rLFn5fMwoa98ZjwQttncYd2+tPooOYubSTWnzFYVu2t3TOvPWVMvV
         /w409nXFMSp51vA+BmFcM9FVtEOhn7TfOvrxiYdDNx6sBDWFA/XanBw7GrqUZpUsNnOe
         Zb4aKZb6yYJ2aXEOQCNtFlTMGkWhzDml6sSvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922093; x=1769526893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=od+mi+aDqE7CPKuDMxJHQzuw0uWDvb4ZZJ5LhyMSC2I=;
        b=e/GCzZt5Zvbq/ko1cX6k9oFI4EqLxe64s+KJowas9UaSJcQaXBHfA4u3KjPb0i/kKj
         yx6cO7LB9WcYIc9yeC40nGlcMcTE/9/dXn+eLS+7U0xvGOkAnfku8TVp9QG6KFaNGY3o
         62bpmCLBQIGhbk+g7br74BNWImF76xSgw5F17kp5Qt6ykVRKCOMWBDaEsi+sNF+c27Xn
         N7xQFfstW5e+SPd89xfzbGHA2txJO5sIvbvki1NB0azt5jQQro6fX5ihxNjiG079YCSD
         MjcYr+n4kHkh6XkU8Nfs/zypTuRIUl9reTyzudHY8ApXZgl4QZHYyuDHlKb8UGBiKhai
         0G0g==
X-Gm-Message-State: AOJu0Yw3Mw2Otc6O3rmaRzCEdKr/TewCPOzjNYUbJh2iong44hCZ9CwS
	SVxsujheTLLEOeASntezuHKr/CreVNCJNDbh+pO3iTSsPjXE2GLEKwU2KupzIQEUKuUN8Way62S
	cATDgcCo=
X-Gm-Gg: AZuq6aKirUdYpwJfXwafvEDKtgwTCbVTv4eT3AnaD/HOgLPLalTFkm2IkBiYdMISV8P
	OsUhLduTs1vJ7dpccjWJzq6u0Nth3nKG9SHwRFSCKADI2+3FBcnTBhgaj1oX4W2iv7csot240L/
	+PWyd/Ni6BKLba7OxOzM1GaPLr2YwOOBjxYWcrFh6puRBlM+vGdjDTaZ7OlyTYs/DF3p7CjEJhW
	/sFFgOUaJZ/t5EWGWW/pWHRO6PhAje34s79QlYp6B3S8CNJeMx0pp6QSYBD3DzVmy1SJy7grVYI
	HterET/9jS/HPGzDb55sMX72ZNlZcH9xy0cFovASZpqIhQEctYZbRfglnTY35X+wUhTD0n04PMX
	T2cNcUolG5rBJNmtDpMvmzeMV3KUgtQmciw2SDCD5Rla+vdz/j4RbY1wZIq+FKU83G36cg0xc1n
	kX93qKHQJkYw0MULzx9hJ9KgPKlXUaGVBKZD+4Ag==
X-Received: by 2002:a05:6000:2584:b0:431:b1e:7ff9 with SMTP id ffacd0b85a97d-43569bd2ab0mr16552186f8f.59.1768922092748;
        Tue, 20 Jan 2026 07:14:52 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:62c:c694:1cc8:4ee1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb1fsm29966452f8f.35.2026.01.20.07.14.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:14:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/2] scripts/send_qa_email.py: Add missing log parameter
Date: Tue, 20 Jan 2026 15:14:50 +0000
Message-ID: <20260120151451.3809578-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Jan 2026 15:14:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3032

The previous logging change didn't add the parameter to this function, fix that.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 4f2b900..6fb121b 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -23,7 +23,7 @@ def is_release_version(version):
     p = re.compile(r'\d{8}-\d+')
     return version is not None and p.match(version) is None
 
-def get_previous_tag(targetrepodir, version):
+def get_previous_tag(targetrepodir, version, log):
     previousversion = None
     previousmilestone = None
     if version:
@@ -93,7 +93,7 @@ def get_regression_base_and_target(targetbranch, basebranch, release, targetrepo
     if is_release_version(release):
         # We are on a release: ignore basebranch (which is very likely None),
         # regression reporting must be done against previous tag
-        return get_previous_tag(targetrepodir, release), targetbranch
+        return get_previous_tag(targetrepodir, release, log), targetbranch
     elif basebranch:
         # Basebranch/targetbranch are defined in config.json: regression
         # reporting must be done between latest test result available on base branch
@@ -102,7 +102,7 @@ def get_regression_base_and_target(targetbranch, basebranch, release, targetrepo
         return latest_tested_rev_on_basebranch, targetbranch
 
     #Default case: return previous tag as base
-    return get_previous_tag(targetrepodir, release), targetbranch
+    return get_previous_tag(targetrepodir, release, log), targetbranch
 
 def generate_regression_report(querytool, targetrepodir, base, target, resultdir, outputdir, log):
     log.info(f"Comparing {target} to {base}")

