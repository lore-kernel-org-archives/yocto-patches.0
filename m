Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.17403.1714052652946994795
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 06:44:12 -0700
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6jYmw007264
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=YxEDdA9PLEt/zObOZj
	YuuHlQyl52EiQpvCP0z618eAI=; b=L+3qWvFMue467WzW8uJOAVkKHQwwvZ3OBd
	OVK2jSWeYFqJyGEGtU+z6r6BcFYyKKCrAuWHIccih/lW7bF9ez9kCaaE2vi45jZo
	1hm/ds9Ir3ecY3jyHOvNA+3Nzozy2hUxMQL1Lsjq+fmkt/4COj48/GfuHxPcReHD
	0fbJ/hqHGa6c5ANvnh5VGY9J7IRw+qFfnUBKd3S4bNwb1n02UWglvZ/uoUiX1LBp
	2er8pL0NRf2hVxLQro7Fny8/g6+z51EqpOXKz8ATmu7XuxGspuTatTVOTqi1E+kf
	UKLMfYBfztqCUP7hU5ZyQVHUGxlLaDvXPo36K0knNH244+OfWyBA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm900whub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:12 -0700 (PDT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH 1/2] openscap: upgrade 1.3.9 -> 1.3.10
Date: Thu, 25 Apr 2024 21:43:58 +0800
Message-Id: <20240425134359.455795-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.3.10

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.3.9.bb => openscap_1.3.10.bb}          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.3.9.bb => openscap_1.3.10.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.3.9.bb b/recipes-compliance/openscap/openscap_1.3.10.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.3.9.bb
rename to recipes-compliance/openscap/openscap_1.3.10.bb
index b35ce9f..d3e44a8 100644
--- a/recipes-compliance/openscap/openscap_1.3.9.bb
+++ b/recipes-compliance/openscap/openscap_1.3.10.bb
@@ -10,7 +10,7 @@ DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swi
 DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
 
 #March 18th, 2024
-SRCREV = "0e7f654570971c1acee6dd3f34b17121372d6152"
+SRCREV = "6d008616978306ce5e68997dce554a1683064f8f"
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https "
 
 S = "${WORKDIR}/git"
-- 
2.25.1

