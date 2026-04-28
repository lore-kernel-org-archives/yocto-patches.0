Return-Path: <Haitao.Liu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A15EFF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 08:23:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8221.1777364599930797370
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 01:23:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ESoWm7tA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85783cf450=haitao.liu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5QjsM1295968
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 01:23:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=Aw8vXasiui08AB8hEap9
	pMV1Di3iT2TbrjJdfXz09dw=; b=ESoWm7tAFQQY+fFKYck0lYWikQcN55D+2xrD
	tbmHLQ3v1UulfvwVZk6UptGG/0rhweU4kFCLRmvdFif3AGjKB0Im+4qm9dTIyRsV
	ehFu5gpQBR7aHF4Jrshg13tyEi9TZ7ZB9cczyOcorezcJDZHyMlFO8OeORkCAqZQ
	j/pEWsjmK6dQ3Q6OYVPb51HFgz9JFYhEUseThHeHSX7IjcWIn8nZtSoYSFf/c+FT
	6pijNftZCmewbfk+s6UgdQQFl3Tm6N7ExeOE6Ow7fZuYx3trAAoQ0CsR0pFJIJ8p
	f9NSB04pWAB1gAmrGNo/DZkMURl/fxXx/EKjkwpWkQpTy/gI0A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drrw2txj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 01:23:18 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 28 Apr 2026 01:23:18 -0700
Received: from pek-starlingx-w1.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 28 Apr 2026 01:23:17 -0700
From: Haitao Liu <haitao.liu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches][meta-security][PATCH] google-authenticator-libpam: update 1.0.9 -> 1.11
Date: Tue, 28 Apr 2026 16:23:16 +0800
Message-ID: <20260428082317.3832189-1-haitao.liu@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: i-WlAE0UL1KNfesppx5wgxGqjoMYy0MK
X-Proofpoint-ORIG-GUID: i-WlAE0UL1KNfesppx5wgxGqjoMYy0MK
X-Authority-Analysis: v=2.4 cv=Pu+jqQM3 c=1 sm=1 tr=0 ts=69f06e77 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Rqg5FfbeET4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=NEAV23lmAAAA:8 a=0G_0xPkq_L501H7wF-oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3NyBTYWx0ZWRfX8pq/yiM7Ew3s
 MiW7EZOT21eczmzydwsf1q0i3Yomz9GT/X/jp8QO2pdiL35ul7zqgjrHbmZfPJDMWh5Tyhqg1U1
 UzLuWQa76Nb0aTiabZexTsonQ3iBq6C9wm9GhyzzFekEd+4IIayQxM4CVYtQpD5wD5z4/2bdbXk
 W+GmwMnxn7NlnTAwhxAOSL/O6UQGrqsioHCgyz/GQ7W/CQVwVGhAWMUwxJ5mmqlf918fXhObjXA
 VskAg6ax1URly8CP6ce/QmDG3FJ1qrW3S+2eSArlVhu47my3pR1uR/E3SS0mSnDBbgVuzDc7uws
 FW/2rdDKbrGkFMcU7x5v2KI1HCjhNAqqkwLcIYIjSJYR1VnHJAVWfhfqIGxYUJcRu+/GWsOA2jg
 0UeD+dcmz4RgXI3PVYgyLvzx03jlVtrcA+1dClLjR9a3nOCUZfcbe5mAVwQeXafFEB6Lj6ElZtP
 +l4P51g6F01D/1bM9BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280077
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 08:23:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3862

  Changes from 1.09 to 1.10:
  - Shorten syslog name to work with rsyslog (#172)
  - Update config file with grace period in all cases (#193)
  - Remove printing QR code using Google Charts URL (service shut down)

  Changes from 1.10 to 1.11:
  - Change secret key bits from 128 to 160 bits (#266, #271)
  - Add support for black & white terminals (#268, #270)
  - Fix grace_period for IPv6 link-local addresses (#265)

  Also fix the .bb recipe:
  - Fix typo: RDEPNEDS -> RDEPENDS
  - Use new override syntax: RDEPENDS:pam-google-authenticator
    (replaces old underscore style RDEPENDS_pam-google-authenticator)

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
---
 ...tor-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)

diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
similarity index 85%
rename from recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
rename to recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
index 333caab..713f60f 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 LICENSE = "Apache-2.0"
 
 SRC_URI = "git://github.com/google/google-authenticator-libpam.git;branch=master;protocol=https"
-SRCREV = "962f353aac6cfc7b804547319db40f8b804f0b6c"
+SRCREV = "016774b0b75ee8f5e80028998d386de762ba1697"
 
 DEPENDS = "libpam"
 
@@ -18,4 +18,4 @@ EXTRA_OECONF = "--libdir=${base_libdir}"
 PACKAGES += "pam-google-authenticator"
 FILES:pam-google-authenticator = "${base_libdir}/security/pam_google_authenticator.so"
 
-RDEPNEDS_pam-google-authenticator  = "libpam"
+RDEPENDS:pam-google-authenticator = "libpam"
-- 
2.43.0


