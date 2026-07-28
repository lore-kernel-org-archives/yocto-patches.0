Return-Path: <Swati.ShivajiKoli@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FAC54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 06:17:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5905.1785219433564832044
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 23:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Ap91NhO2;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild14.wrs.com, ip: 205.220.178.238, mailfrom: prvs=1669a5f1a6=sshivaji@oak-lpgbuild14.wrs.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S5Hjhv2304125;
	Tue, 28 Jul 2026 06:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DxDdgl0eZ163+IhUzCacSazxYmNWmwBWecgV/v0cg8o=; b=
	Ap91NhO2odOOmebDxT6e7MY1CB+DLKxkWa54ULK1oEk3HoW+OkD3vzh6Rt+L3zcg
	HcwkpBpwxbDm/JatxHrxar2cQTiFZxGekxTZTf8DxvkDXqNM4B+vc41pIJlhquo4
	Lk5+pks01XCDcU6x6RT5yuW4UkcaQsyo6QxkaJEPbmI21CPtGEpkf+u/ilxDyrZM
	H05cLG/fn0hQ+iEetafft/rFGgJrbEBuW0JN870sptOkk2Il2ygCtzJhCymbsIBt
	Z2h5UJ5cfAJM/Cq49JkTEcJpB5H7ik8SF00Q/OO4ylFLkszO+M7BZcxs2pNBSpt6
	xtzI5bwceJHXxj6/a7w/0A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fmm43ujk7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Jul 2026 06:17:08 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 27 Jul 2026 23:17:06 -0700
Received: from oak-lpgbuild14.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 27 Jul 2026 23:17:06 -0700
Received: by oak-lpgbuild14.wrs.com (Postfix, from userid 1762445472)
	id 992F46D00312; Tue, 28 Jul 2026 06:17:06 +0000 (UTC)
From: Swati Koli <Swati.ShivajiKoli@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <anuj.mittal@oss.qualcomm.com>, <Randy.MacLeod@windriver.com>,
        <Shiva.Komati@windriver.com>, <Swati.ShivajiKoli@windriver.com>
Subject: [PATCH 1/1] dpdk: fix builds for 32-bit ARM machines
Date: Tue, 28 Jul 2026 06:17:06 +0000
Message-ID: <20260728061706.3250521-2-Swati.ShivajiKoli@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728061706.3250521-1-Swati.ShivajiKoli@windriver.com>
References: <20260728061706.3250521-1-Swati.ShivajiKoli@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I/JVgtgg c=1 sm=1 tr=0 ts=6a684964 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=rNv7xtCG3ER1PE4rAX4A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: AIwHGNus0elLAMoiA7j1yLX6NNpk5XQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX1RRMGAvVybS3
 Z+Q6TlDz7WQ5oHmzweZfK+v27xv7mXLk0vjZhmahR6cbglA/fhrdniNN06Rgxsc6x22I6mmRSs/
 46mfPM6x7VZ1PZMsRHj+PvIsnziRVMJFE8I+DVU1co6TKBTGakWe8gvDZnY/WrNW2n6VTMbvEex
 55Dmcmd/9/XDmvVh/Ut8wZ6SqX3xZmGSz50pgklZ2p1xuhVSBO1fWII4vejsQ0n5W3pLeAGnBIr
 p4vvFpD8HfoN3JqzOkYlYr5j01wOxjCvaROtNVO0E4G4U0a1dsQLlkdnq/NcxUph0Ju4ahdlVkr
 EnH0jEB8EnWXBnDy/B0u6shbThMcs+wLvSlLlRDaxDfXaph2bkJK2liQnTpSlkj58fSA6ZpA4LQ
 wrFX+ji8ANpuf8xB5LIjAfA/8/zjC0IxYgKpTP0h2GG4aP05NN0nlBm/GZPAI6e/GJVSCaylo9u
 IOTWZfkG5+pVV1WRA6Q==
X-Proofpoint-ORIG-GUID: AIwHGNus0elLAMoiA7j1yLX6NNpk5XQD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX79FeMQKDtUr2
 iJ5bhy0v4yNsHf9omZMT/hhD8EeBAW+0c63TZLTMPUfYn4jNV02heA+K2rqQjHPkdqX9t5+bTQU
 MdS8ozROeoc1WL3htpK2C0kCnSIpJebTIeKEEBXnl312+o9LuyB9
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4553

The get_cpu_instruction_set() function falls back to 'core2' (an x86
microarchitecture) when -march= is not found in CC. For 32-bit ARM
targets the toolchain uses -mcpu= instead of -march=, so the regex
never matches and the invalid x86 fallback is passed to the ARM
cross-compiler:

  arm-wrs-linux-gnueabi-gcc: error: unrecognized -march target: core2

Fix this by applying the same pattern already used for aarch64:
override EXTRA_OEMESON for the 'arm' tune to use the dpdk.cross file
instead of cpu_instruction_set, and set RTE_PLATFORM to
'generic_aarch32' so meson selects the correct 32-bit ARM platform.

Signed-off-by: Swati Koli <Swati.ShivajiKoli@windriver.com>
---
 recipes-extended/dpdk/dpdk.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index 6c76a1d..5141a00 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -19,6 +19,7 @@ def get_cpu_instruction_set(bb, d):
 
 EXTRA_OEMESON = " -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
 EXTRA_OEMESON:aarch64 = " --cross-file ${WORKDIR}/dpdk.cross"
+EXTRA_OEMESON:arm = " --cross-file ${WORKDIR}/dpdk.cross"
 
 COMPATIBLE_HOST:libc-musl:class-target = "null"
 COMPATIBLE_HOST:linux-gnux32 = "null"
@@ -38,6 +39,7 @@ inherit meson pkgconfig
 INSTALL_PATH = "${prefix}/share/dpdk"
 
 RTE_PLATFORM ?= "generic"
+RTE_PLATFORM:arm = "generic_aarch32"
 
 do_write_config:append() {
     cat >${WORKDIR}/dpdk.cross <<EOF
-- 
2.43.0


