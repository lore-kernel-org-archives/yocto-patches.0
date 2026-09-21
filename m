Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB2FC982DA
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:24:00 +0000 (UTC)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39714.1789950231846926151
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=M98rXaXP;
 spf=pass (domain: konsulko.com, ip: 74.125.228.43, mailfrom: tim.orling@konsulko.com)
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso1966873a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789950231; x=1790555031; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWd3bSpJGaZ6cJtUc2kBEw8eHBEHBmnni1ZVjSJG8Nc=;
        b=M98rXaXPraNK8/McD/JAXHPV3d9qGif0/CJjS9G2tSicSDksZMNfkgQKcOOan72YHX
         vbZQgkfSo9ZvcjQBFmRbJ5MWq5BWXbHzZLRb3h62SBixs4PCK8tp/JztD/KRWRa93/7N
         KZWWl1GiKv3BS4aoa2kIVDD2NNcaMEBZDMweU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950231; x=1790555031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWd3bSpJGaZ6cJtUc2kBEw8eHBEHBmnni1ZVjSJG8Nc=;
        b=n2L0xMzL/ioLIiQOH8X1cHgVHIio22AEzm0kQg1Sg3wtfLaicwO1BrsGgVqfv4mdJO
         5X1vmdVw9ax5qtmgDBgI0Q6tsVsV4JTIcv6S7ZWOJT3Zk3lZHt9jwKKf0OVr5ZcAedm5
         MU0NtxUOghl9/Di/3zQy0Ry2lD8x7dmkLZLSPsnWeJgifALBQekhLTqDcaagCvN18Kh9
         vB6OoxlRTLVum7YJPglfg4523K75zF1INrG4x0DPLQ14qKIM3Gs/UmCtTT8VnODxoKgG
         sSHY58ssjs6Y0WMV/+AFuapASj/MpNQfqMy3Jky5/K0jo4RRZrue6xkcwASFv6Yc/BMW
         dJIw==
X-Gm-Message-State: AFuF++ncH8DRTW5qSoXMTuoKoPM9yp9HhaCiWC3g2YrJYG8lWHb8DFLa
	PbiDJFn6GROM4lxf76qyjJFemMMvPnLoZJjSnhu12QlcKTVa8Hg/nn/y7x6TypTaud2r8hIHvrr
	90VfV
X-Gm-Gg: AYBFou1GjzsKiPPH84Gf0dBK7vAmDDq6Xk2YR7T23bc2GghTJqIWc38LXjYPOo97y1P
	F5gvYWfq8MAtkC6m+hNd+O2Jr9mZ3PV/m0mQW8L49dc0PzlP5DJ+N1M8h1qSD9NseNVPaqJb+jU
	b+G3pA6LrytEvaYRWHLIb0RL8zecN39wBO07uG74jVRjLR8Cm+aJOm+UAI8Q+2AtKfV/ZTOnwKu
	VLPOXUQv3inr3Et/V4wwOMorYG7SG+zZRM3ZITAw/RwRLakSNuFf2wLbfM0bsQxd/jTwy46H6iu
	YdLMTtR7xdJHL9vDiYjFcgbAly81zKtkjpEjAZJe81a/Z6tTE6FD25kUHBO8relAWDcP3GrHGva
	boBv6B4eknypXa+olIH0V/TxnRhgl/NIDTNZZ2mctxG6FY7Hc0RPsiTUjCSozwG3Nsgp9ashNJJ
	VRQKpozX2tKbkQnM28XnJrrBJQ6J0hwf9lr773VIc7hSKCHDb80ZNffuCa0bV1WPWDa5Zb/kyhG
	u8roFHYnCoJbFFfRGaqqrDB4paVq1qmb+ZfypE2WGPwce6Raw==
X-Received: by 2002:a05:6a20:cd95:b0:3dd:a196:69dd with SMTP id adf61e73a8af0-3dda196779emr8086464637.56.1789950231084;
        Sun, 20 Sep 2026 17:23:51 -0700 (PDT)
Received: from localhost (c-24-20-171-118.hsd1.or.comcast.net. [24.20.171.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae8bf29sm2555551a12.12.2026.09.20.17.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:23:50 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: add Sunday/Wednesday container jobs
Date: Sun, 20 Sep 2026 17:23:13 -0700
Message-ID: <20260921002312.547973-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:24:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4912

From: Tim Orling <tim.orling@konsulko.com>

Schedule vcontainer-tarball, vcontainer-tests, and containers-library to
run in that order on Wednesday and Sunday, inside the 00:00-07:00 quiet
window when most contributors are offline.

Use fixed time slots, with no completion-tracking between the jobs:
 - vcontainer-tarball at 1:15
 - vcontainer-tests at 3:15 (2 hours after vcontainer-tarball)
 - containers-library at 4:15 (1 hour after vcontainer-tests)

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 schedulers.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index d606b85..5413676 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -750,3 +750,14 @@ schedulers.append(sched.Nightly(name='nightly-meta-webosose', branch='kirkstone'
 schedulers.append(sched.Nightly(name='nightly-meta-webosose-scarthgap', branch='scarthgap', properties=parent_default_props('meta-webosose', 'scarthgap'),
                                 codebases = {'' : {'branch' : 'scarthgap'}},
                                 builderNames=['meta-webosose'], hour=2, minute=0, dayOfWeek=4))
+
+# Run container jobs on Wednesday and Sunday
+# - vcontainer-tarball at 1:15
+# - vcontainer-tests at 3:15 (2 hours after vcontainer-tarball)
+# - containers-library at 4:15 (1 hour after vcontainer-tests)
+schedulers.append(sched.Nightly(name='nightly-vcontainer-tarball', branch='master', properties=parent_default_props('vcontainer-tarball'),
+                  builderNames=['vcontainer-tarball'], dayOfWeek=[2, 6], hour=1, minute=15))
+schedulers.append(sched.Nightly(name='nightly-vcontainer-tests', branch='master', properties=parent_default_props('vcontainer-tests'),
+                  builderNames=['vcontainer-tests'], dayOfWeek=[2, 6], hour=3, minute=15))
+schedulers.append(sched.Nightly(name='nightly-containers-library', branch='master', properties=parent_default_props('containers-library'),
+                  builderNames=['containers-library'], dayOfWeek=[2, 6], hour=4, minute=15))
-- 
2.43.0


