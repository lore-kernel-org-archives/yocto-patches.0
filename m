Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.15719.1713870568611932544
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Apr 2024 04:09:28 -0700
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5rx5m001807
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=MNq6nAmzPZek+VZclz
	EcOzD2L64hxmyl2mMn5whI8rI=; b=fPF4wKZVcF0xjYzFWRgA0ahHtGinCwkBEs
	JVYewT4a23ZzfApF+G3TLPtP4pQMB7vgKutug1hShx5Z/B3es15OX+5OO8DBDz+R
	D7zUsyyLvn9R6wlQXYIuaxPKT1UXxbzt1X1kgdZ1tdlD0Bxl+sOLgK2TkP4v7bFz
	2alQQoRtKBhe4mdwO3OL/npWfmeBuwCQIEbQoMT11dKe8SKi6Fqaz1pyU7IS+4/Y
	j3lKBYrLZTIIi+5UVbwd3vSqqsu4ep6vXPixI5kk92QmdVUAtdahLTcB46I90ODF
	Uwhp0xgYRki034cRtTHKQ3B80nqkWY+eEKGPEkqs7yI5vcORt+fg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm4p7at3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 11:09:27 +0000 (GMT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH V2] scap-security-guide: remove __pycache__ in ptest directory
Date: Tue, 23 Apr 2024 19:09:13 +0800
Message-Id: <20240423110913.1082749-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Remove __pycache__ directories as they contain references to TMPDIR.

Fix QA warnings:
WARNING: scap-security-guide-0.1.71-r0 do_package_qa: QA Issue: File
/usr/lib64/scap-security-guide/ptest/git/utils/_pycache_/gen_reference_table.cpython-312.pyc
in package scap-security-guide-ptest contains reference to TMPDIR

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.71.bb        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
index 5e45332..43c8b8d 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
@@ -82,6 +82,11 @@ do_install_ptest() {
         install -d ${t}/$d
         cp -fr ${S}/$d/* ${t}/$d/.
     done
+
+    # Remove __pycache__ directories as they contain references to TMPDIR
+    for pycachedir in $(find ${D}/${PTEST_PATH} -name __pycache__); do
+        rm -rf $pycachedir
+    done
 }
 
 FILES:${PN} += "${datadir}/xml ${datadir}/openscap"
-- 
2.25.1

