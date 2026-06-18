Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C40CD98F8
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:14 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22676.1781798050030325614
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 08:54:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PBHWTbNz;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so922677f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781798048; x=1782402848; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cjocNLZ4635OTGQjJXcWRMXg/3MZScDcTQWc/X6UZc=;
        b=PBHWTbNzpJuaJmnu/xj7ofz2YSWJ7HRIL9xORQBwG7nrbv1gX5PMEI4xtXBC/Yl1p4
         nEZanoYjVDQP2O2zUCr5R5DnWnVf7txPmVUFnkG6TnUBpmjb4BCqStQvHUCvKlzV48mn
         RDMVWhKsDy26BnvU48IAAzFsl68sXPUToJtbJkyFZPztndTPPZQi832hw8UY07u3F8cU
         hwTd+KfWGNp7DuzGBetJzJF+R6zxlubHawCFG/30t8h8yTa/fI60kDEHHImO/1sgVlci
         d4zcFrC7/dVpvW5eYJ5BMO/xN+rKf9YjLKT/lpzDZ5NhM/Zz0ePNaFeN7OJuPvqPxFg3
         7UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798048; x=1782402848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cjocNLZ4635OTGQjJXcWRMXg/3MZScDcTQWc/X6UZc=;
        b=ld2lHD9WNBseb4WyptOB8gC7rV0Hi2loEQsVmes6xxuzm1F+IGEoCOhmPOcWscEKrF
         0sR4QL7DEgb8yFYDxOJFoqaeFytLoJf1mhMY9IINGz1AXkobjQurT0hevP0n7DG4sIL3
         8kQUZPh94QThqECNf1RtRnDtWJ/Q5ygq1hz1BY+WThPYuH8rBItHaJIj9ky82BHxk5P2
         5JHWkHn7ppWtDQUe7J4oGVAHwZL6eTiZZrRIvWEskXC9J5848ccsxZIljEWu6/QoPFHG
         67/syBVH1sWxhjV1VYUbUZqvYL18iRajuMf3SVrnJOL2WclNBBDUTZgjdJ4hihIWq3d0
         9hoA==
X-Gm-Message-State: AOJu0YyHSetWbiYdAFlX5pxYXOIvzoEEIZhiRkLxUZkuVWdvajDHmzZr
	e1iTWObh8AV8xd27O1Psy+m5hmz1TBkGg44Zi5kpnClniT0e8fRHK6zI2k7mcQ==
X-Gm-Gg: AfdE7clf/izn2goP7+zBsHxkPRfhCNrkUeD3UG1/y6OOp8RdZyAC/fOX6fkvquMdFqd
	dwhTM7b/sxulDsxEz5i55y9XdwV4vA/rXYZDZw50ksfK9cg7XqxewTp1Se5vwnYaMLsGDPkHeqR
	QPKZaPJUx3VSSIOH5lNy81tOdaQDWNPzHWtpj3HFgg5SEqkKbxqUOWsw5LMM8Xai6zAM1vHWQsf
	EAhYqMgI4OT2TsA6ZsPfOWCsXY/v720kZf/0p4lWpmYnwU4+nkqnRvet1FgdERGkvYqOLZSrQU6
	iICuy7CEnNEe68DjinwIZ3YqFbcrWtv1cHCRNZMV+j9eWN6qxyDVnS2g88FRTf3kOuaawSJMG7p
	r8gUaGbgQoncNYkevUm1ZUFh/+Vh0C/IIDy/l+cejShEoU9OYojt7sWaUE6coNSh9lTmH2LqTFu
	j15UrX3fWpEdRY5Kn2ptATVL4XxfoSjpWLCbCR8orlUa+9a27G8l5mU/wEjjK77HbLslUciphJK
	zcsxL5PLwsVSAix
X-Received: by 2002:a05:6000:184b:b0:45e:df08:b02 with SMTP id ffacd0b85a97d-46501877df7mr40028f8f.28.1781798048102;
        Thu, 18 Jun 2026 08:54:08 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm29005560f8f.22.2026.06.18.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 08:54:07 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 1/3] layer.conf: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 16:53:51 +0100
Message-ID: <20260618155353.3633997-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 15:54:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4244

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index 5e1f7f2..59b9e0c 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,3 +17,6 @@ LAYERDEPENDS_lts-linux-firmware-mixin = " \
 
 # https://git.openembedded.org/openembedded-core/commit/?id=2b75c7ba5e3aa6fc57d7b4afe59e2277b4d87de1
 firmwaredir = "${nonarch_base_libdir}/firmware"
+
+# DEFAULT_PREFERENCE for linux-firmware provided by the layer
+LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
-- 
2.54.0


