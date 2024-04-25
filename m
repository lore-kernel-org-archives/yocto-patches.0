Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.17451.1714052653740137519
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 06:44:13 -0700
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P4s5je020682
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=WtKNvQ2wZAh4Uk1DK0ys4l8MnSAu2Q75gO++x5AIpV4=; b=
	c7PyOO/jzuKMp/175mufHH5YCMOkazxvs/0uYDkVYGPhdalFAANULINXqAlQOJgg
	CyT/9Lh1C/4oK/X9/ZVbSMO6Qehn96mMnJDczdSJLV7uNs4wn3cw/Y35henITcCo
	8A1SO8CiGc34daztTTQF/aQHtIu920rGu6bEp5MberxkGN8tsEP4HOm3KrVEJQ/x
	G8CeqC1UKL/BPu5k+C63tH3fdz3Igc44lIJGKmjAW3G7YciL7LF23ngSwwauxbKC
	e7ikHuZdoh4+zMmzDvmiftqs2a8q2IIaLoixHb+3e3ts3N1wLM0pEo6Son9nvh3z
	Gprf82y1sVCcNJL+nrY4Dw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm900whuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:13 -0700 (PDT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH 2/2] scap-security-guide: upgrade 0.1.71 -> 0.1.72
Date: Thu, 25 Apr 2024 21:43:59 +0800
Message-Id: <20240425134359.455795-2-yi.zhao@windriver.com>
In-Reply-To: <20240425134359.455795-1-yi.zhao@windriver.com>
References: <20240425134359.455795-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.72

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.71.bb => scap-security-guide_0.1.72.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.71.bb => scap-security-guide_0.1.72.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
index 43c8b8d..549f04a 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "459f0abf2ac08d36e5fc4a2619bc75cff7000da9"
+SRCREV = "7fb44f78bf33232aad587e87a799afcf576f9b47"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1

