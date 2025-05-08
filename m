Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F36C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 04:08:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.7861.1746677329151016691
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 21:08:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7223240b2b=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5480aECf009591
	for <yocto-patches@lists.yoctoproject.org>; Thu, 8 May 2025 04:08:48 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c15gm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 04:08:48 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 7 May 2025 21:08:46 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 7 May 2025 21:08:45 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-raspberrypi][PATCH] Fix lack of whitespace around assignment warning
Date: Thu, 8 May 2025 12:08:45 +0800
Message-ID: <20250508040845.554486-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=681c2e50 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=jhrmjlrxVr1sL9fIu0oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XzUdFGjYK50GXLGwFvTNMXPmMYwzw1n0
X-Proofpoint-ORIG-GUID: XzUdFGjYK50GXLGwFvTNMXPmMYwzw1n0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAzMiBTYWx0ZWRfXwmpXNlN3Ex+3 g/TdAqEqbx9o0IkTz9xrizjEI2okAYIVN7huWQowP0VvxQShTNNdpHzHjP4WuJ0djlmKp949Zzz p989WBEGY0RuJ1AITOU0TlWuwfoedr5zdZ93XHs/3o+Po+h7DUG2cRJ/ss8wb/tVftlywlYrB8v
 9IapdxQeA1BoWeSKqOnxaAiAgCU3VNJqx4sGOu2RjXq6/RiLVFv529anIa/0TrsUVH+BQQ0Eefd vbTIXUJsNHczOLN5+prQl+nJuHdiZ5cw/dt69eI5rTJQNzTAwEZq+16Z3qInv0G2lO4sHiWPZx1 xkI/OaJr7xU1qzw46Fb6GI7QLWDSEO2Dl4DhxxfYS2vRGV95Lj5wgTMpLEseZskSi/adzRibU++
 TWBTYg664q7MRQrUrga7I5NRgw5B8Jaf48uQitGNLqVtpan0rUOlZEAtlSTM2bWc1dFnDhqS
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=704 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505080032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 04:08:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1535

From: Changqing Li <changqing.li@windriver.com>

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-bsp/armstubs/armstubs.bb        | 16 ++++++++--------
 recipes-bsp/bootfiles/rpi-config_git.bb | 14 +++++++-------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/recipes-bsp/armstubs/armstubs.bb b/recipes-bsp/armstubs/armstubs.bb
index 7e389df..361aa96 100644
--- a/recipes-bsp/armstubs/armstubs.bb
+++ b/recipes-bsp/armstubs/armstubs.bb
@@ -11,14 +11,14 @@ COMPATIBLE_MACHINE = "^rpi$"
 
 S = "${RPITOOLS_S}/armstubs"
 
-export CC7="${CC}"
-export LD7="${LD}"
-export OBJCOPY7="${OBJCOPY}"
-export OBJDUMP7="${OBJDUMP}"
-export CC8="${CC}"
-export LD8="${LD}"
-export OBJCOPY8="${OBJCOPY}"
-export OBJDUMP8="${OBJDUMP} -maarch64"
+export CC7 = "${CC}"
+export LD7 = "${LD}"
+export OBJCOPY7 = "${OBJCOPY}"
+export OBJDUMP7 = "${OBJDUMP}"
+export CC8 = "${CC}"
+export LD8 = "${LD}"
+export OBJCOPY8 = "${OBJCOPY}"
+export OBJDUMP8 = "${OBJDUMP} -maarch64"
 
 do_compile() {
     [ -z "${ARMSTUB}" ] && bbfatal "No ARMSTUB defined for your machine."
diff --git a/recipes-bsp/bootfiles/rpi-config_git.bb b/recipes-bsp/bootfiles/rpi-config_git.bb
index b91668f..0140f30 100644
--- a/recipes-bsp/bootfiles/rpi-config_git.bb
+++ b/recipes-bsp/bootfiles/rpi-config_git.bb
@@ -18,13 +18,13 @@ PR = "r5"
 
 INHIBIT_DEFAULT_DEPS = "1"
 
-PITFT="${@bb.utils.contains("MACHINE_FEATURES", "pitft", "1", "0", d)}"
-PITFT22="${@bb.utils.contains("MACHINE_FEATURES", "pitft22", "1", "0", d)}"
-PITFT28r="${@bb.utils.contains("MACHINE_FEATURES", "pitft28r", "1", "0", d)}"
-PITFT28c="${@bb.utils.contains("MACHINE_FEATURES", "pitft28c", "1", "0", d)}"
-PITFT35r="${@bb.utils.contains("MACHINE_FEATURES", "pitft35r", "1", "0", d)}"
+PITFT = "${@bb.utils.contains("MACHINE_FEATURES", "pitft", "1", "0", d)}"
+PITFT22 = "${@bb.utils.contains("MACHINE_FEATURES", "pitft22", "1", "0", d)}"
+PITFT28r = "${@bb.utils.contains("MACHINE_FEATURES", "pitft28r", "1", "0", d)}"
+PITFT28c = "${@bb.utils.contains("MACHINE_FEATURES", "pitft28c", "1", "0", d)}"
+PITFT35r = "${@bb.utils.contains("MACHINE_FEATURES", "pitft35r", "1", "0", d)}"
 
-VC4GRAPHICS="${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "1", "0", d)}"
+VC4GRAPHICS = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "1", "0", d)}"
 VC4DTBO ?= "vc4-kms-v3d"
 GPIO_IR ?= "18"
 GPIO_IR_TX ?= "17"
@@ -35,7 +35,7 @@ CAN1_INTERRUPT_PIN ?= "24"
 
 ENABLE_UART ??= ""
 
-WM8960="${@bb.utils.contains("MACHINE_FEATURES", "wm8960", "1", "0", d)}"
+WM8960 = "${@bb.utils.contains("MACHINE_FEATURES", "wm8960", "1", "0", d)}"
 
 GPIO_SHUTDOWN_PIN ??= ""
 
-- 
2.34.1


