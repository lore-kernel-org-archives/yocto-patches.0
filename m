Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EFBF531FA
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 07:39:32 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13536.1776152371570418076
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 00:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=H5RI1a23;
 spf=pass (domain: snapchat.com, ip: 209.85.128.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso50021505e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1776152369; x=1776757169; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RduI6fPWub6RGLZlGIkgqkL+1+UcjnXkPmw/gTDjy/Q=;
        b=H5RI1a23uMrm27wENRkB2v8gQkiH5ziEvHAybgScLrsx3bn9Lpk8Vm50rl174izMOW
         hu2ju1Iw1ZiudGVR1kIf/a+U5tuUGip+Q2n71uJ78yrZ5xI2NlIODNIM3dbcVmPQL0S2
         ipP7CYAV+izgN6eTN3PPYPgxKIbodoYYjhEk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776152369; x=1776757169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RduI6fPWub6RGLZlGIkgqkL+1+UcjnXkPmw/gTDjy/Q=;
        b=T8tqP4Sn021YRw+pUNUJN+stwecoAYs0MnRm65RCQjDpzev9/Le+comI4zN/cof/du
         h59nc4JZMG57+cK77I+oZ1vMtfL7LnITNmmwUmzrHLlkdsbYs/M6IP9Avo+jq2LNoU6t
         JZqDbX6o2XLKoF7W3bVMz9ihL7S4TJRRen6b/ZI8A/qL1B4Q/RT4ElmWm22uzcqidov4
         V0wD2vRGuxJHqnv0UOB8ReoXnUe43RBRqWdCBARzZIV+hNLj/h8VWtqVNs1eXfwlnUU+
         vHHVYWauSG+KFctDW7WqqkBZvFj7Q+v0R4tGAEkZ92ErqUb4uz8rJvyeYItVYsfv5KMV
         YIog==
X-Gm-Message-State: AOJu0YzqYFjZaFXczU2qXT8vaB3i0XUXE1Z4n3TptTeND9Qp/ekcFS1T
	g+m1In1uSLxn+xRkQ+Tq2spkrGS7eCUQlQn+fiu9VDzN4SK7clFJSFS/ZdVJZpNiw1mX51I7X1a
	xDFoavDg=
X-Gm-Gg: AeBDievYn/De6d7q766i30szhOyblY0xh8qSvvHvoloMbUlLKSdMGV1HI6XmwaB/sV0
	cS6ouYWUgnIcKJ29Cr8usHdyozkEALVh5TiWT8qXrST3O2ZdiKdG3B/ExW63Dj3LxzRDZu5ZpBm
	4RKs8mKz+DDlY3sHqADYqmL8DQrsoaK/iuRcn0CukkpRFtm2o1juql2P4yfTHkL9JNkHGn+zUYm
	xhAmGTB8AVT8BL7CsZ0GGi3zmNsxJFPNadAakwGLSR/kxc64ttKxBVYHS0gL9XPwI2dOuJ+Rtr+
	qTwAd31MYeT/zdfq2unIlp0rRjXQfQqVMWVjzz8fFTXLPQJCJK71s15AawGERba9eC4zf+R6yZy
	ZKeneEJnpveUgj08U9R/f6sJVBsh7gYJV9AflvCDJMypuN1udskct4nG6pYJxt+fYyqwPp8XgmZ
	a9/n4m/D/e0GFZIlbTu34by6GEBTh+YM452oAELtWjecUmRXhBjzeTgbQ4vkDywwfoC2BeqNSDT
	bT7tQ==
X-Received: by 2002:a05:600d:4:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488d68ab2bfmr182982815e9.24.1776152369361;
        Tue, 14 Apr 2026 00:39:29 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d750f0ca9sm20314629f8f.37.2026.04.14.00.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 00:39:28 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][PATCH] refpolicy_common: enable PARALLEL_MAKE
Date: Tue, 14 Apr 2026 09:39:20 +0200
Message-ID: <20260414073920.4112974-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 07:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3698

From: Etienne Cordonnier <ecordonnier@snap.com>

Using parallel make threads speeds up the build.

This line was added in https://git.yoctoproject.org/meta-selinux/commit/?id=1139c40cb687deefddc31c5fbc8ab61f3d50402f in 2012.

The parallel build of refpolicy was fixed in 2014 in commit "Fix parallel build of the policy":  https://github.com/SELinuxProject/refpolicy/commit/c1c11fa2f8ca03d47adaf31bca4b257459448c19

I've tested a build of core-image-full-cmdline with yocto master branch as well as a custom image and it seems to work without issues.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 2e1a929..014714c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -103,8 +103,6 @@ PACKAGE_ARCH = "${MACHINE_ARCH}"
 
 inherit python3native
 
-PARALLEL_MAKE = ""
-
 DEFAULT_ENFORCING ??= "enforcing"
 
 POLICY_NAME ?= "${POLICY_TYPE}"
-- 
2.43.0


