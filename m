Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5331CFC287
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 14:21:46 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12353.1763734898344751785
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Nov 2025 06:21:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Nd1ajZ3q;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2148ca40eso279272385a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 06:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763734897; x=1764339697; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtWHk+s3CFqQFj2hc+MdLVnGFiuxJi916CbHen6WkuM=;
        b=Nd1ajZ3qCaeCmeR8jZBhplNZIBP0TxjWdUNm6f5bE+VD/8xLGq39Omk82udEvd1B+2
         hZJTCaW4T1pqjxeWVMvRANyhnuuzgHMfLxAdzhN0U8GLsnCSRYh++Tf/FgjTGsYvtSaO
         3z9smIuwkTQoWULUWoO05z79dYI3zNYx5CPeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734897; x=1764339697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtWHk+s3CFqQFj2hc+MdLVnGFiuxJi916CbHen6WkuM=;
        b=CJ44tx/Fh3DUU6gkNWQLJXUUrH0Ye/Kf3cLn7upA5EyHDTMourMQ2fY+N2OAEhle9L
         w4MCtyamXRURl4y1dcBF6/BQDP7pPjtDFOkDzKflmhECFbpsmnjG4iXyUHg0hci1N4bi
         XCJ3FCBAKkB8phyUv7HNXt0ujWq928Mmf+JvWeGnWHu9hBgtDB6Vd8yJLIKqJGWGGqsg
         xhHrl/iOi1zEp9TsbWk7/PUNcOrCyn7a6wtEnSdbVgQlRd2yODmxFpqtR+4DaUgtM2x4
         egFUJ8kn36+mUW8dYIczeBSccgq/H/IpmL1MBWQE6y+LU5PDBaRkcp2mf0VPEnS9gw8f
         bKtw==
X-Gm-Message-State: AOJu0YxStpQCwYcuH95JjoZsEURAWh9HYkVoFuRudLJPWg28JwLxqqQT
	uNJiTKYoraEC7bgO7BzJfUwgkN9erQPqlhENNOrf5L49OVX3HJAF+rUCi3j95N68KAZWInSxRVM
	/AfLw
X-Gm-Gg: ASbGncsLJswWYE1SQURUZXbm894VjCSssNY+nChjL513KJ50QoU375L8EXWTYNGeje7
	6XlBKYagN11b1CJ/8IVRiPN0xMdUxeJxtvpLFGpBA0FI1pQDM5mI0OsyFIXMyQd00c1OM3wgKLb
	/mCV076E0a5Z/vHfZGbBuMwzt4CaH05TxkAiurT2VWg2F2VkBgrxLNAvBvTtk/cQgis86GMdtT5
	ooVV2sKXXEie3q0+QzdBXvgC2m9DwdJzGnCwbg6DCd0V572I7VGd6H513tprt4lFrOcHxDuxDmd
	3ni5+u4cdEd1t5Q28OTdGz2LUXiGNmx1pa447dvAWDi4BJtIcJZKXWl68Pq+6w/6koBf9NBPYxe
	/omYAU6AGJz4WnFmajkMRJx9t4jEcPvOrlZefhMxmGIUsfIRx0BId643Ac/L5IT6oe3x+J6y8dl
	lopx2gTIbIhisyoHBne8CH9u5KJi/jz5IWjXwk9FLOJNzoKlJOedfVlG2RUkLu5A8=
X-Google-Smtp-Source: AGHT+IEMa+dPhcmbBuCU8sFKftGivwVBGLrd6lfSULXFM+lmznHGbRoZgadh49t2MCwxEvNz696y/A==
X-Received: by 2002:a05:620a:444b:b0:89f:19e:46fa with SMTP id af79cd13be357-8b33d1f9394mr219526585a.20.1763734896980;
        Fri, 21 Nov 2025 06:21:36 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db58fsm374815785a.37.2025.11.21.06.21.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:21:36 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/6] scap-security-guide: upgrade 0.1.77 -> 0.1.78
Date: Fri, 21 Nov 2025 09:21:16 -0500
Message-ID: <37b9e32763e15986790c6bbfa447a25d1b5f5f23.1763734538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763734538.git.scott.murray@konsulko.com>
References: <cover.1763734538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Nov 2025 14:21:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2646

From: Yi Zhao <yi.zhao@windriver.com>

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.78

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...p-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} (96%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
similarity index 96%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index cdd22a5..8489218 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
+SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            "
-- 
2.51.0


