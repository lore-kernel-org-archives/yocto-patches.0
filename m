Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15825.1713870214048501617
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Apr 2024 04:03:34 -0700
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N1Cksw014597
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 04:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=dYop1IdCOyj9DVmma6
	qVsCdK5KbRV1P2+XS22Esok9o=; b=keV2CuQggYjf/c6atvrBA+epxIc1Cus1v5
	6YdknZJzLNH2ov1aI3OFD+WLAyUqjhJiDrYT6z7SH+RjpCVeX5tnWdsIgtfbZaq4
	YPqvFcLaTg9ULcMz58CArl8aNXLAsb8LXIJKCIVSP1s5BR2nrUQKnKZWxeOVMzfZ
	RmA8VmE88bdFH3Bczmvi9uHEvdRj/dwTUexlySVp5fPqRCvdwsw1B1ULD2z9pSTL
	8Bj5JWVyKdoRQ5iwDmxX/LhX13fsig2wdxmiS2cwnfTXwNE/KQ5ZLYP1T1tUdVj0
	8HHZLUGUSpGsr+vBPkQ4vn6niqRl8hckBCZYg+C9MGv8leR/YiKw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xmd7gjf3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 04:03:33 -0700 (PDT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH] scap-security-guide: remove __pycache__ in ptest directory
Date: Tue, 23 Apr 2024 19:03:19 +0800
Message-Id: <20240423110319.1053510-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

Remove __pycache__ directories as they contains references to TMPDIR.

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

