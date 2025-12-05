Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83866D2F7E1
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 11:33:40 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3685.1764934411898880171
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 03:33:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=QxApNZYO;
 spf=pass (domain: mvista.com, ip: 209.85.214.169, mailfrom: vanusuri@mvista.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e239baecso21920865ad.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1764934411; x=1765539211; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=loYyF/8Gxlzq/MqOCGhh+PDHDtxR0FHWwlQcxs4/Q/4=;
        b=QxApNZYOA3gwGZDrIUV0GlsX6fjM7zd/Mz45RNF8eC6NjvHHLAIBaOTbPPOPAHEz6/
         +aCdlT6S6Aii5FhfFLV5VEkwynTA08f2ASxrDhS3f7imSii+hH+BCl47APoqDj05SRon
         KlQAWs1PGeqEvBwKZgmsvW7pw7688GlovkIIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764934411; x=1765539211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loYyF/8Gxlzq/MqOCGhh+PDHDtxR0FHWwlQcxs4/Q/4=;
        b=XvUQ5Og4oOVLllKqj3hpPr45U/vbvK4omx51C44nEHBINAv07WvjNWmQ0QqAD+j1yH
         P41DKnL65s1UlNnQsZDypJDQgM1eJOvb5QjgA4EDPKNLo7TTk++PBFb/DTMj0xLBBk6X
         RNxx2ojmt7GXXRri0oeNUSpNx8zX5/CiS/cfgTpkYNGQvjOsJmgOoUu0c5oOT5OMiH3z
         eg93QJagLoTTK5a1lV0vNnK9YwZcr6Yfluhl0sObYKOi4VaFHIRa+6GHv/gk9/SLOTeT
         ieDsy504tVrf5bNuU4RWpImbXcAaOTXdnOonLYL7t3/LLnUUsKxkk7K/3gY1Y5rJCxZc
         1MuA==
X-Gm-Message-State: AOJu0Yy4KoJV+jd3k7e6a5cNwK73AJ6hTbFU4z720J4QTsUkqI/ubOZ6
	fvBY0XPPMHBlkEsG2zI3Zfr7yUayTdUe+iXNofTppBhw/zWl+dOcGG3c5Iarg1Thvk2UZ0WG3A2
	KI2RS
X-Gm-Gg: ASbGncvuKKN+ed2agbtO6By4kcTaqq3HzSJOtqGOkJM244ElkE8+6rCVwhlGpPk5qz5
	XZx2zGPJ+QtXZc9+zY1DYzeKhms2yHrvDxYwUvaKyUsw+NU6y9ybpdvzjEmpAANoUr7Q7BDDEHL
	IjLuNcFAXrlq6qoZm6XOxZyLMV+fIc0QLI6trcUL54nNF+P5mbs23lQFkomtPisHnC9Aada7IH+
	QR16FdIbPGB8eShaMdnC89Gt5xyt7n9bKMTepW7wNQBZbVhrQSA2/2bl1xeQpl7j90oA9dZIT3T
	tebvU8EfT7BbklIXs86XQB1NjNyczBRMCQtUoq000/gYDh4vykia5HEAlZpzY5UsKpXj8Co8Gy1
	IgxYEPfzv7DdQDA5LvQVcpu6P4bkFKZphm8xG1eYyQIs09wOQeZBzCKavJASdQw9tQArMCowRoS
	+9k/EvMURryKWxzspxEWH6rt9ySarF/jMRjg==
X-Google-Smtp-Source: AGHT+IHcPdUIHGCt4p8Q5CxYPR5NwZXCJqmBB4L19fM8ESmUFcll6IwLCflaOg7arrPBYecfrkGhOQ==
X-Received: by 2002:a17:903:1104:b0:295:55fc:67a0 with SMTP id d9443c01a7336-29d9ec32352mr81488265ad.2.1764934410837;
        Fri, 05 Dec 2025 03:33:30 -0800 (PST)
Received: from MVIN00352.mvista.com ([2406:7400:54:7205:8451:cf5d:1824:de5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf968sm47535555ad.34.2025.12.05.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:33:30 -0800 (PST)
From: Vijay Anusuri <vanusuri@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][scarthgap][patch 1/2] sssd: Upgrade 2.9.2 -> 2.9.5
Date: Fri,  5 Dec 2025 17:03:15 +0530
Message-ID: <20251205113318.3647529-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 11:33:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2743

Includes security fix CVE-2023-3758

ChangeLog:
https://github.com/SSSD/sssd/releases/tag/2.9.5

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.5.bb}      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.2.bb => sssd_2.9.5.bb} (98%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
similarity index 98%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
index d61471c..cb27675 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.5.bb
@@ -26,7 +26,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
            "
-SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6f762ba"
+SRC_URI[sha256sum] = "bf955cc26b6d215bbb9083eadb613f78d7b727fb023f39987aec37680ae40ae3"
 
 UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
 
-- 
2.43.0


