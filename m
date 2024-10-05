Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AFCFB42B
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 17:34:39 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
 by mx.groups.io with SMTP id smtpd.web10.16209.1728149673951790655
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Oct 2024 10:34:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f4vmtTJi;
 spf=pass (domain: gmail.com, ip: 209.85.219.175, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso2970850276.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728149673; x=1728754473; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ1EanwDtMyQlo+k+gGEge0m8mnKnbyuTZo7nELp91Q=;
        b=f4vmtTJi47yd9K2vT+rkKhAq16vtjHMN9SJeDtzj5jnj4z83GcSV5/DaBBqonBcYkX
         55oIJXxKjl5KM0mFtrua9Su4kxgoNgwLVBksm1Xfgwnt9hU44l8WouTyx7eJ+j8aEeeB
         CVx9gorGQ/ZZCnIcO59RGHSB9CvH5EPco/19n4V/ZSeUt8d6o4JLtBm1uIRfJU3zpXPC
         eYWAssL4mtv2ig8JdTVxxL/5Tzdy3Skybk1yjIVxBjVFoNEL1AqJ1LDa+d9cfhHCqmY3
         SYfAV/LWQTj/2MJ+ADL2NoIe81hw6zQVsg58R0H39dd+TpaxAlgiO/YTLUhd88/exZMK
         93Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728149673; x=1728754473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ1EanwDtMyQlo+k+gGEge0m8mnKnbyuTZo7nELp91Q=;
        b=J4naKdaaXu7f7Tg3Gzsqts2P42BwHQpOmEywnT6IL4t1pP/mv/uqDGo/WQk5l7j4IG
         75s4qTqBNeOBaFcP4hUtZXFpcRNZbXLfD5fd9SxTDD1YZ4Df0cihU6cxwF4kG/so90fi
         5epn9p/CLUk08lIWWSkvSCJJZS04xmMJhhfl71Gu5urXEP6w74BU9JVdiPSObgEUydqb
         Ym47iR7ODO1xj+2l1BO4+NJkC8FrlTEBdB/EnzEiuJ8ycmsfAuCqHzAccjVObnILe1OH
         OVivmrYM9PKb44AYSHxOGMSBg1EOGaONlXmIqtozR54DQrhsFZe6iLfRLBpEwOiPO4W/
         2NCw==
X-Gm-Message-State: AOJu0YxotzmcJajnvh1qyxMBg5JDwH1KScoSFS3J997mZM1d36gRos2G
	L7cFqn6T+XyIc8497CHmR6kr9iBA1pXnUnycsTA3hvECGab/frtrxWX18A==
X-Google-Smtp-Source: AGHT+IFYcrWy4m5X05w28NeuokM4lL+8+bx2ReZ6xIeGntmJWRz1JaOYlPcDSg085Vyfc2fAGSbzhQ==
X-Received: by 2002:a05:6902:2204:b0:e25:e343:5c7a with SMTP id 3f1490d57ef6-e2893946b76mr4933678276.47.1728149673030;
        Sat, 05 Oct 2024 10:34:33 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8a15:aa34:73ec:b252])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5c3a3fcsm345137276.20.2024.10.05.10.34.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 10:34:32 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/3] tpm2-tss: update to 4.1.3
Date: Sat,  5 Oct 2024 13:34:29 -0400
Message-ID: <20241005173431.2697319-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Oct 2024 17:34:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/689

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../tpm2-tss/{tpm2-tss_4.1.2.bb => tpm2-tss_4.1.3.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.2.bb => tpm2-tss_4.1.3.bb} (97%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
similarity index 97%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
index a27acca..67a51e4 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.2.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
 
-SRC_URI[sha256sum] = "6ad3ef0993cf3bc953710abed847ff727ab427b5577e812e3ad3197bbcec069e"
+SRC_URI[sha256sum] = "37f1580200ab78305d1fc872d89241aaee0c93cbe85bc559bf332737a60d3be8"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.43.0


