Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EEDC27C65
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:32:51 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.21150.1718029966858436235
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=PmtOzljW;
 spf=pass (domain: snapchat.com, ip: 209.85.208.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so1970681a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029964; x=1718634764; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6FELu/jP2WLymVsLH5Z+yi/JvwWHMqXWiYg8OC63f4=;
        b=PmtOzljWSzx61tn9vA3qEi3rQ9whl7uYWcY5hqkF8/ZUhyXGzhcTVyozCwia8eT9KM
         M1dukIpLGWvcVDdnhOqMZH9WJ+gdv9vFNKhq65BpFqUINliOHHwrnVlN8q1tOs7+OFej
         TsjXMN5vrufiigjL6bqv5CzPT+9KSrfyx3YJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029964; x=1718634764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6FELu/jP2WLymVsLH5Z+yi/JvwWHMqXWiYg8OC63f4=;
        b=RCvx/dI3YG9gtkHNobKF0e6XnDOmmn1ynwNa3J86MLth8Sd+WlQ4D2Gp2EcR1IfeqL
         wPKiY0lX1Gez+pRsEH+FbEC9bMSqCcR2hfcy5ONJqjjECiZXqcX1gymofOgyZb/y5kzm
         /b/fJpKZS2V0q1QtbUQ2SxRdFhXKMOojp0s0fFntq6hkWo4fzOx5pX4ZHts9ArAlUlxZ
         W5RyboZx6c2nNyC6ADo8pVABmCt/MQvnAcoaGpw7n4+KxxwHJanJGTVTXppbFcKTXQtn
         j8f4tJ8q1sHrjcH7ZzTryltJUa7Ga8+kOQG/4xuEM+Ig9X8cSy71DTX4/MSjRzImRxJB
         4lfA==
X-Gm-Message-State: AOJu0Yy04ip4hBPRyGfLP6f4DLXKw8ztUrj5PlFdaFeRwgAbFQOBvpVk
	RkHt4dVgoVZ83XUVUHuxpoy2EIwH7YsYs93e/rBlD7LUBU2+cYkYxDJDNNJzgU2CaclamVZXPna
	uWwU=
X-Google-Smtp-Source: AGHT+IEYtcOsMRVSPpf2QEvTaEBSLYvhtBEwhCPv1QnjIpzKZBHQpqB/dFrD9dTiGIcIyDFPCjt10w==
X-Received: by 2002:a50:d6d7:0:b0:57c:60e8:c519 with SMTP id 4fb4d7f45d1cf-57c60e8c5c4mr4204866a12.16.1718029964374;
        Mon, 10 Jun 2024 07:32:44 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:44 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 04/11] cctools: fix APSL2 license
Date: Mon, 10 Jun 2024 16:32:07 +0200
Message-Id: <20240610143214.2376414-4-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:32:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/286

From: Etienne Cordonnier <ecordonnier@snap.com>

The license-file in poky is named APSL2, hence this name must be used.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb b/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
index 4082150..93062b1 100644
--- a/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
+++ b/recipes-devtools/cctools-port/cctools-port-crosssdk_973.0.1.bb
@@ -1,6 +1,6 @@
 DESCRIPTION = "Linux port of Apple CCTools"
 SECTION = "devel"
-LICENSE = "ApplePSLicense-2.0"
+LICENSE = "APSL-2.0"
 LIC_FILES_CHKSUM = "file://cctools/APPLE_LICENSE;md5=dacaafbaf91483700da837d31213a1e8"
 
 SRCREV = "f28fb5e9c31efd3d0552afcce2d2c03cae25c1ca"
-- 
2.36.1.vfs.0.0


