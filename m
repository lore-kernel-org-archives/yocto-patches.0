Return-Path: <bin.cao.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5772BCD37B6
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 08:58:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3309.1778662672736898836
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 01:57:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rewaeTmo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=95939e21be=bin.cao.cn@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D4oIoW338454
	for <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 01:57:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=sT9qUSEm/cA/RYT+XfHC
	yULjtt8IwYR5pmG/LTJ7WsE=; b=rewaeTmoBIlWjbu90PKMimHA3AXGWsi4ge68
	CMgENKQCJve0Hj1PBzYE2VgxhCB/0IJqHjo8u7UpBikn11W2RJJLJUP31fR+qxaJ
	u09AC9KbEQFHCRFbOFZsofGkaDyEybCi4rMnLjotrDs5LgpCQne+DLlrlDTaIqct
	/pRq9ySpjJneSByuW4z7GtURqWZPXX9b3bgyCLU551W/v+ihSX8t4nZ9PG/IXmVG
	ggskgVqZHSukkKuLp62VLf8Y24bdOFcLBYDp0QO6mK26b15alF+YXWwLffk/fp3p
	RmJhBGt4CJMxcw9Dsg+Hrg4uObNiVizTsT0uBV1oIpO6iZujmA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8eqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 01:57:52 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 13 May 2026 01:57:51 -0700
Received: from pek-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 13 May 2026 01:57:51 -0700
From: Bin Cao <bin.cao.cn@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] samhain: upgrade 4.5.2 -> 4.5.3
Date: Wed, 13 May 2026 16:57:49 +0800
Message-ID: <20260513085749.2307627-1-bin.cao.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA5MiBTYWx0ZWRfX5z5JMhqJo5E9
 gyeBkQ5DiznLH2etnONv9QrAxBAVKmY3OYxe8y6R49TOnhKzdFlqTCf3bARFYR1y7+ctn7dlIhF
 HAN5PuDUYqNUi8XTDt8zyiLiSzTvQeiqDsyHvKESWC4kKg5rBTV4X96ZeXWvWVDnP9MaxzE10wF
 zktLIfsh87Dx5RxHVsL3thZ3kEBJiJaBltAa8ELagad7x/MD8NtcwHMrxRUn/TVdbM2qeeLZ+5h
 ispDWRjmGtaR85ZMaaMVstD/4xDnaH5rbJkV64x2l4xLmPBhZMevWalUBsLWl72UfyEHjqOPbjA
 K2A1+6/enOrtMLa6aqaYToWh5+K8jT1FbrjX1/Q9a9apWYBV5iFUgYwlHtm8mou2fVJ0Lnq9GhJ
 6dEagTK7ukNnJjvisHtajxDGXdB0GWKXfYrAbsxqD0an0B4qk2FvqRvMUEVWUJVkTqe9dPTnzuI
 jnNuRUZQCkcQVVqUgrg==
X-Proofpoint-GUID: LxQU9RMmzQ3rct3zHamE6YzFUdRTU8-n
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a043d10 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=nDJU2pNIAAAA:8 a=t7CeM3EgAAAA:8
 a=-YBnEpcesZVAYn57l0oA:9 a=cvUpGn6QkLxiVzwzn9tb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: LxQU9RMmzQ3rct3zHamE6YzFUdRTU8-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130092
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 08:58:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3981

Update samhain-client, samhain-server, and samhain-standalone to 4.5.3.

Release notes: https://www.la-samhna.de/samhain/archive.html

Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
---
 recipes-ids/samhain/samhain.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index fc4e423..95413cb 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,7 +3,7 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.5.2"
+PV = "4.5.3"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
@@ -22,7 +22,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
-SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
+SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.43.0


