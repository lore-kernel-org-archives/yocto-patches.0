Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BA5CF8856
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 12:53:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33445.1763643218136258593
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 04:53:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Q9PBdGR+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=341940cbf5=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK5PMuY810550
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=+nLRgC3oGua6sT5CdXrh
	oRo70QViB1q+GymafU4UXAA=; b=Q9PBdGR+z7/DiQsa3RfuVfrtCYGwLXWzuFHr
	7c5UYLHBpsxIqYtK/lh7haKCZt7CzvYarpGG4rzKOFVFP3bZgRwJNLJ0Qn/dfySk
	PsMUvR1tqnnf6jmvTfGMgQhiSSCOzjfstiKy9Rv27cXvKNE6ioPJddrJdX8dik1N
	cC7v6wZH8dNt2o/BVFki7yY4hCKJP8wr0hdjAXT+vJMk5x86akywS/Hrd4Fzv5ck
	/4OsHdeTWq0uUZw43OjfA+DMslhyd7lBZa8yOfNMwTBjzS1/QlYRHxkdYimM4qVD
	a5B8lCWL4hYWLDrnWRGyehB75VlHnozC+C3bWEMAetsiCu3lKw==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ahayrsm19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:53:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 20 Nov 2025 04:53:35 -0800
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 20 Nov 2025 04:53:35 -0800
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-selinux][PATCH] libselinux-python: support reproducible builds
Date: Thu, 20 Nov 2025 20:53:34 +0800
Message-ID: <20251120125334.2528444-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hjPtT135dSqWHt1QVLhzyDOE6MAuaCa5
X-Authority-Analysis: v=2.4 cv=EdXFgfmC c=1 sm=1 tr=0 ts=691f0f51 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=SsMK-6ewAAAA:8 a=t7CeM3EgAAAA:8
 a=EiOy-mP0QIA8wsFujAIA:9 a=49hUO6naoDravHwzbBTq:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: hjPtT135dSqWHt1QVLhzyDOE6MAuaCa5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA4MSBTYWx0ZWRfX4kDXG7nL402C
 9YtKeFx3CwEdwCfXMrJp/nxIN4CsaAN/cWQur4VFs5V/MfhKeBGEQ3PNjaJiRO3/4dvpSybtQuB
 FEAdeEfoxLr41annhV8zSyhXnFUSHd0o0hKd84nqwD6cGhiTW0pieAcZKMf1erT84gK7XL0lUM+
 Q99qvMCrkRKAqVkSH9H6+URFq4KqBb6rre/eYbmxF71PZenTPVwNWJsbppIMDNnr1mtCbiEs6Wc
 gl3DtQJda0bV3pMd4POxeDz4Om69FNEP6eeEViXeBR7DgXZaxvt/YYTs1SWN40JN7XTrEasCpNr
 wy1LqcOinyyeZ7rNIOfKf9LXrLjMdoW+6iCh2TULp4j2+jrZcVrKTtvKmC/AKxBvAJBBiDZehTh
 aCqMuGyk7G+GWgtP56qcAp6XZvx0Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:53:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2630

Originally, direct_url.json contains build path and it was removed
to fix buildpaths issue, but the hash of direct_url.json in RECORD
was not updated. In order to support reproducible builds [1], this
commit manually updates hash of direct_url.json in RECORD after
build path was removed

[1] https://reproducible-builds.org/

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-security/selinux/libselinux-python_3.9.bb | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libselinux-python_3.9.bb b/recipes-security/selinux/libselinux-python_3.9.bb
index a4de036..97e0043 100644
--- a/recipes-security/selinux/libselinux-python_3.9.bb
+++ b/recipes-security/selinux/libselinux-python_3.9.bb
@@ -51,9 +51,19 @@ do_install() {
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
+    dicect_url_json="${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json"
+    oldhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$dicect_url_json'); print(f'{hash},{len}')")
+
     # Fix buildpaths issue
     sed -i -e 's,${WORKDIR},,g' \
-        ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/direct_url.json
+        $dicect_url_json
+
+    newhash=$(nativepython3 -c "from pip._internal.operations.install.wheel import rehash; hash,len = rehash('$dicect_url_json'); print(f'{hash},{len}')")
+
+    # Update hash of direct_url.json in RECORD after build path was removed
+    sed -i -e "s/$oldhash/$newhash/g" \
+        ${D}${PYTHON_SITEPACKAGES_DIR}/selinux-${PV}.dist-info/RECORD
+
 }
 
 BBCLASSEXTEND += "native"
-- 
2.34.1


