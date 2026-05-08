Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A888BCD342F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 09:02:22 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9583.1778230941548287048
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 02:02:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DIVyAwLY;
 spf=pass (domain: snapchat.com, ip: 209.85.128.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso17514565e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1778230939; x=1778835739; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YziJZyouJRXIk8kq+ly16aR/vVOyJ2SMjeoJ3Xm3oFA=;
        b=DIVyAwLYYNxgHovWIz+Y5rlHxSPaRu8iHZWf3c9G06/YnKoL2UIQx+pOi5COvwavju
         Fm3ytf2AjCwOkN9xs6DjEqyv7tG/pWTrOcH/+KOa6sn1MyIZzWi2FHfd2WlYiX5JxBA1
         li7aM/YgALuBpi/T/7MBu6VHJ6Va2+RdiE4qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230939; x=1778835739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YziJZyouJRXIk8kq+ly16aR/vVOyJ2SMjeoJ3Xm3oFA=;
        b=Bc9sAogw1qvyfj+retqWzumJRJ7vD3qYMDHbn3aVMu3PZC+YC8KbqDRNaXWSgDyZti
         Ho/dZLH5r92gH+78a3Uc6i6Y6DVx5djq149rwqstUGC5AFmWRQM0eHvg4s4SWXVmSd7S
         TfqyVHOKJmvN7myTqSbY9wCXSdL2qTcPLxLCHlk6J1X+/rkEFxzQZugsShasR+ZzNoxW
         ps3Vcbkf15cfro/0s+ks76DGYJfuFDcmBqM7LTZbGyzDZDOVy67Lw3g4QiLeVqiXdMka
         SZl/SXAUkFuuyoKqDm94yGJN63XQuMMhW2oHtdcdE8KeGxjdaaQSoCywdpZDK0azZWPE
         HC4w==
X-Gm-Message-State: AOJu0YzaHTHCHTOV6X7U2Y5AqyikDLC8imU1UkC+8jUsy8o4jJIgKFaK
	10gyRIVgUdeUz0WSz+fLRW+oGmHrNitZNsdrcuZIqMhtjYsqD4Pdl+dFc7EB9yCITMndCbdmubY
	ljvw+7pA=
X-Gm-Gg: AeBDievJ4ELGvJMdZd6ytwxr/Mvl7KeOqo9yLu0ybxzXd64DXdkNclTm+58UPvF+7uJ
	Ij33PdwpsG8rwNcn44oQ9+A7Se+uXjKl78Pqt2yl6t77wgIAp3GVJGaaWpWp93QJsvEcZaY/PQm
	qFpV5lkksTN1pcCoyuGLb6f91upgf8pJap4ePl+twuhHy3+SAwi/eebkNr3VBHj/8CgOh3P18vz
	xy4n+6NdFVgaIQ/uj9FTPjw3R2ohfq3fLu1clAcFyEPpAXFRG2M7Lxl6e46nrvAPSbv7Lz5hwnF
	jJu/5K3QXUUhDPvUYK8rStpVEkHvvQ0nwQVRy1CqLjZ9dy9slH0KHsX/BTZ1vbDAcxDmOgM7Ee6
	7GPeqliSn0LNFWXTUlf+Nam51yy8yfiPym63CZdf7h7JAD+pyotGhIyueMte+e4ER1w5rjCgxfH
	PL4DfgIgHlGmukSWVVVVaZNw/ThR2emsMOT7X5KyWUYlS6MzT7UfQudeEn5276SnAt8k8=
X-Received: by 2002:a05:600c:c11c:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-48e51f3b57emr137363285e9.22.1778230939307;
        Fri, 08 May 2026 02:02:19 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eddff3sm26457955e9.13.2026.05.08.02.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:02:18 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy_common: enable PARALLEL_MAKE
Date: Fri,  8 May 2026 11:02:02 +0200
Message-ID: <20260508090202.944572-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 09:02:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3951

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
index b1d2701..780f913 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -122,8 +122,6 @@ PACKAGE_ARCH = "${MACHINE_ARCH}"
 
 inherit python3native
 
-PARALLEL_MAKE = ""
-
 DEFAULT_ENFORCING ??= "enforcing"
 
 POLICY_NAME ?= "${POLICY_TYPE}"
-- 
2.43.0


