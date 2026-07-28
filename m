Return-Path: <Swati.ShivajiKoli@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D16FC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 06:17:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5745.1785219433564539613
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 23:17:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bML2FdEm;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild14.wrs.com, ip: 205.220.178.238, mailfrom: prvs=1669a5f1a6=sshivaji@oak-lpgbuild14.wrs.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S5Hjhu2304125;
	Tue, 28 Jul 2026 06:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=oXQW9/INQ
	ZCXheP2Hwks9OE0CPdUsmFeNaq3WbMgsWQ=; b=bML2FdEmXbE/uAyj9/I9He6FF
	ITnXkmLV13lJo0hiKEbnG0C2Qxcpg9K9ItWT++uGuiDuHLN4VO3/ESeaWH81BRJH
	bss/a6gjf/omiOdm9iRS2goaDAO0z5yvKlPWgNfjFPZnIjLJz+QB89LjHG78sjA2
	sRamA6HCgfHM9+HqpCO/vbIZR9nX5M9PO1YyFUsWfJjkx7NF/ItONzyyJcL+v/eY
	+MgEbgtouEzJXM13meG1JicujYc6LtHmDsnVa2QZyn6HECzushjF3hasHP+039G9
	isAwjVYsaNC7Tr7W8cX0izQmdBZb34XZNjKGK78RcnxI1csPzaUtYZCGtu7qw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fmm43ujk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Jul 2026 06:17:07 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 27 Jul 2026 23:17:06 -0700
Received: from oak-lpgbuild14.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 27 Jul 2026 23:17:06 -0700
Received: by oak-lpgbuild14.wrs.com (Postfix, from userid 1762445472)
	id 5DF036D0035C; Tue, 28 Jul 2026 06:17:06 +0000 (UTC)
From: Swati Koli <Swati.ShivajiKoli@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <anuj.mittal@oss.qualcomm.com>, <Randy.MacLeod@windriver.com>,
        <Shiva.Komati@windriver.com>, <Swati.ShivajiKoli@windriver.com>
Subject: [PATCH 0/1] dpdk: fix do_configure failure on 32-bit ARM (qemuarm) targets
Date: Tue, 28 Jul 2026 06:17:05 +0000
Message-ID: <20260728061706.3250521-1-Swati.ShivajiKoli@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JVgtgg c=1 sm=1 tr=0 ts=6a684963 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=u7XHKe9o866yDJ_U0DAA:9
X-Proofpoint-GUID: g6FzjAq44UIB2-7TSmn62htBs44IJhBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX/e6dDgXLZJXr
 UgAVtgs6SEiuQnDXwdl/0iF/G0HUaxyNEE1DXqAMZVhuxJxGnpq1LOJ5+A7KVSrGuKRnRJPuok1
 3Kms1GYqiOACIuViCteu9vNWgVmgXAMuHGb+jDF/DCcSPg0hBgf5gZlATuGTPSOlGvkSXfGxkoq
 wC/2Cd81iHCzqqIsWD0OfF1icPqWg4Ggg/SreP3jboTQ4xDt0YcuKy/vvyW16V/6K/N+4/64drn
 8R9/KwmGrf/fjd9RiYZSJm6c91AVM64+yGkCHIaStjwZIGOKcrcieApesYK9WlDp5Mtke7lXP0H
 DVPjn3fgCOGBAhi2bKCSXWDIVkTYTtMYRkribqhetvVV0rG1ZjO4/oESdtMStjAWCfWO/XhskO5
 Pyd0Ls+vIMrTkT94+MHqWdndm0tOn+VVVzD1l5HLvSSnuw5tmPcPg48fC5sLB3HpHS7invwogs9
 +U6SFaSXQbq3wq1N/Wg==
X-Proofpoint-ORIG-GUID: g6FzjAq44UIB2-7TSmn62htBs44IJhBw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX2/d1rYllpIEb
 UG46Lf/a6mrvNcoGuf/0CqIPD95T7eY6+HSvDjg4glPEFyXqkMZLyA/QJdukEqnSqmWv7NUuzv4
 CJshAkxIQu/Sre0JZduRzlsiJ/B3kiHPuZtUSz5A6MlP3uzs5UFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 06:17:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4554

Hi Randy,

This patch fixes the dpdk 25.11.1 do_configure failure on qemuarm
targets, reproduced on master-wr (LINCD-34249).

Root Cause:
-----------
The get_cpu_instruction_set() function in dpdk.inc falls back to
'core2' (an x86 microarchitecture) when -march= is not found in CC.
For 32-bit ARM targets, the toolchain uses -mcpu=cortex-a15 instead
of -march=, so the regex never matches and the invalid x86 fallback
gets passed to the ARM cross-compiler:

  arm-wrs-linux-gnueabi-gcc: error: unrecognized -march target: core2

Fix:
----
Apply the same pattern already used for aarch64 (commit c4e5897):
- Override EXTRA_OEMESON for the 'arm' tune to use the dpdk.cross
  file instead of cpu_instruction_set
- Set RTE_PLATFORM to 'generic_aarch32' so meson selects the correct
  32-bit ARM platform

This fix is intended for upstream meta-dpdk. Tested on qemuarm,
do_configure completes successfully with no errors after this change.

Swati Koli (1):
  dpdk: fix builds for 32-bit ARM machines


 recipes-extended/dpdk/dpdk.inc | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.0


