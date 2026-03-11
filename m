Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA4FD0642
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15108.1773211722406667991
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hpoupHRE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B1p95f2435337;
	Tue, 10 Mar 2026 23:48:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=; b=
	hpoupHRENWgJx8c5eAKC52VIt/Uognyvtr8x7/xrwhxwngBgEYawKVMwPXd9HBCn
	JRA8j4ssVwQLQQKPTLNdKiDyxj0IA040b2gH0aCDb0qu/S54erItpX3npkxBjyA7
	pxoGXtid/1boXo90RJPCP5s+qprt4ZrTB4Z066l/yoMvEJntRRbiUVOPpV3aIXpV
	RMJwyN6wlD0l8glMebqevRnpoMNwyMsogQzmAeJYEyjVpeAuqqiUIRYiyYDfi1Wj
	59uo7dRmS+O8mSmS42a9NCwUdKkkVx3nHp/J4ypV0APb+5AcgqFH/upgqIOmmTco
	BgfFy2IU3c8nGGQMlyghSA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty3j07dd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh9IBvGYhrMkaBxS0z1y940kTFCxeGo4N5ww4HfxP/Px2R/qgpV2/ObXQAToAUS/Fa046DoML9a1JpT/Cug/uJYzpf3FMnJ+MpkmnBGxRkO+/6BaSGQ665/DJnz1FQ8v4VTCtkZ5GrnLDSS5+cxqOLMNdzp/qxMprHtBszgR3MD1qNFPA0FvaAKSVjdKc+s/7ORSjec+eAMf8YtzzhstMJY+dngBq+hPfaGdiS9dPDLkSk7d9uX/y5YSgLkd62OsQDffumJQQePlBnv1seQZFJFy8aZLIU6ugBGF9Y0uFCyAqXNt0A7KyQ2BwuYWxXNEPHJVXL66TdPNhM9EuldPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=;
 b=LsCWGw+1KCXB2K0ruj63I7zMGq3dmvMejFbMEnXxu5Rbe5quEGVVqpGWsfNm7/1qyvbRthtwXMpF12y5G3A7GsPsU+KQmyoEggMndFJ2+Hw/GSWSfBYNCCIhCX2rXUCQjEpmuyoetXmp7LqELrH/jhqb8m0zgnB4XCvU7Lpm9zu4r13Qf9VShbjYSbSAjbQmYrR8vUBHvBqM0xpDujlJ9mNyrNf356aIvMaQ7YOsdwbp/QmgMw24Ff59KRgPRlEPXuPnWOZZnmSw/KGPTgNGXR0pIdZTXqikfBObs5ddlO4awtsTGV8sIHx7C5P9AUqxzDrsHMnjCybo9/yEOYGlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:39 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:39 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 08/12] upgrade-helper.py: avoid unnecessary and confusing short names
Date: Wed, 11 Mar 2026 14:48:09 +0800
Message-Id: <20260311064813.619683-8-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c366223-7636-4a26-9069-08de7f3a39e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	ZX9CmtLHXL2pT/yWRF4uShaUS9dr6fbBoOFRmKqotmkeF99cjJuxhyyM6R0AJ5EBeD2E9du8QTOARBB6+oNtI7C6M0yh7Q1/YYUInlSk+WYn7iTWcGrq3XPPVyQnWa/JE4GFwtOVOq1Lk4vO3h6ps8ENGMT4Oc6NAzfPymwadNARVBv0Cv/2CCHAFpGbP4dfrA1p86C7JLG0f0YAyabnke+Uk2AhzmR5xNmuXF/oGucPIU++TG+NJUAX6JyUGsXAAfWS7R5Q6sxlmUvdq8ZyDxVsoT7j+ORLyKb1yPO+FaVTU2IXbfPhI6EExjmPowoTQCElg+Zajb1QFclWImYCa/zLMdCuweoJEgrd56K0k/6X/AhHgqPadhpjhA1DfJONOfuBobKPcsOvplQgVkyQovRSEn3Tl4KjHh3N7c7obqajd1OZ20iDzxabIvXmTWb+8pjrTyDAcNb5gcoewMU9PdDHXpsXluxEZu7R4bNdKZDwjK9CcWQwU3Ono5VrLbYBR09pIHgxLk342laaJKL5CTuuyWFLfcu2r1Zd+Vb4HlSa7LUidubiKDsSLi/+d0uYxpzZQGIQNN2dG7bY9zX1+GQlrZa7eWvcFZkscY6Z6EfQYCrJa2cAM6DQ88qs3wlE8xgFhpxqFjkJuELmTNMlqncOOiPaNMLh3+Pqb6dyFm/Spp67HnSETMcND6gjMQkFbBvnlOun04rSzj1Uz+SzELyN4qwwwYsodBaM7OVTEsmXNH7XVUOvqQ2Sx7VmzGvt8A8FCkDNDhqpckRh/YUi/dS44WH8IEFAwf7F5CzVDPc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X2XlMFxf2ZZxSlbJZH4hOCTmMizqkpUafe0YKulnqNtEViGJ4hfbv8ekxBfT?=
 =?us-ascii?Q?yjgbrXVU0MOHCRkUgjDpPEBym34uGEmb3kXCTv0tbTMiTPNwvvz7VQr9ZCjx?=
 =?us-ascii?Q?pE9yNUuY4xQcF17V1snya8t5QDE4Qb6Kd580/92RtoRxhJ4o68wuKSAp1BVR?=
 =?us-ascii?Q?lCLki5NxQC3PgB1x5pyPV6HIfG1CXfYh/q+9tCOWiMCXIELD70SLcCfXvrrR?=
 =?us-ascii?Q?w0PDCj03ig0+LiyhAA2TRBeF+wNObiQHYMb46QzpqlS13EF361lPEREJFb9G?=
 =?us-ascii?Q?v+IGtmWhukLb+KPnq7DTgMSmkuhXY968qk357T1KF79tKxul3ZyMXaLmfTs/?=
 =?us-ascii?Q?uLMB8EMbBA758FFWgbcsdPEmtB4aDwP2r6fqy6ZkXKwAet9XAnPAIiTne0+g?=
 =?us-ascii?Q?jNWsAiWHt0tX1RPrmJUM01Xb3h+cCM7wVmMV+gDuN511sTelvHIRc69ASd1l?=
 =?us-ascii?Q?dNy22oA5xXbn7/ZNlCmbILCPqp+h3jOS3CBGfxjiTDjNCoip8hwlHANtOVES?=
 =?us-ascii?Q?viIZn2h2UaBQ7X5cDT1sKXXqDwngonM4wIoPmVxxujdEMG6GSra3toIiNP2e?=
 =?us-ascii?Q?0H0VhnR16dK5YWrd9JQf9lBaOtGI4C70b7ZCWvnsG3W9Tk8Au4VvdgfxDoWE?=
 =?us-ascii?Q?gIaZTdMXEQJGNZQkr8L9rkc7rUIE281ajILdxt8I1sb9AL3SV3NQQcwD1rkp?=
 =?us-ascii?Q?qOQPxXbLegyj3Ce4h8EmP6f0lteyUnCZqoUVN44jHONNiD3nmmTi+YLvUsFk?=
 =?us-ascii?Q?q98Z5X78o5FiKI78QAa+WFpP0YL/6Iza0IaprlKTrYia0LY8Eu4FHyUvpGJ9?=
 =?us-ascii?Q?jDzq+4Fy5QBo9N/nbwq+SMaLCr90xT2YBWOsf5djFSkhuibAJi+yXD3euLzn?=
 =?us-ascii?Q?N2NxhwBVR9JpU2elcUNnrWRsQ6HfdYiU9ODwgXaO1LZH48txwKTUjI/iwd0n?=
 =?us-ascii?Q?5Ngkjk0AIO4aFCIfgPw1VIxKs1TUZNNFPBxKIFwhOASaXt279VRABFeYyQen?=
 =?us-ascii?Q?hV5DumHGKlFLY1iCHWJ1oP6AtijmExNrv01c2OxEGBwpWz6fY+NSUDrvft+P?=
 =?us-ascii?Q?xOSxCF2tlIkfXzmSvIKiCkKyn730j9G5tIAKivNVyJP8V4NtuKJFjlDXcASM?=
 =?us-ascii?Q?99S1gl9IWxsGI+59O7UVvotOd2JAh4xBV2v4k8e+P1hZsrbZty+DfQyN9Y0o?=
 =?us-ascii?Q?bmbYdwDuSjU4Nk6msr5ojdBSGC4a/Qlp3ZagoNpIRsANujh38drOubOFwAsb?=
 =?us-ascii?Q?SM/6/I8JLIMDHxT5AxQ5FrlXxh6S0a/c72JTRKiMFeMd/6Ue2E2x4p0QMxwj?=
 =?us-ascii?Q?hbWGXskFSi0fQTeJc3PHa7Txoi0eyAmqdnqtl7W3L8zdKZ0NDNC6FjTJIyv0?=
 =?us-ascii?Q?RBOzd7sltg0zIVAm7CAzAIGklP0D+poC8Hy65Wwih6Bix0QfZy2hCcgENXot?=
 =?us-ascii?Q?LaM6nYvbd88WmPqAyCouiBC0qke67Qno0F2BNiHSp8geHwnJKSR7xczlujCI?=
 =?us-ascii?Q?F+nbJTnlqhLFcdWoLn2ixJvQayrnf/TRHv8YxS4c/ctYTJPo3VDUYgLcZKdm?=
 =?us-ascii?Q?NJAq7njlVCEoygTN1UdDjiYiqElBknZjTV/YkfFBl/tlDEAFCXS3ca+1b/lr?=
 =?us-ascii?Q?LzqfIX7ZXIP5KdeGBZOmvlRkvsNlnYVf8LgZUQ9ab7QAs4/voiQuWAr8fgvt?=
 =?us-ascii?Q?irQpUYoX8xWL8BC/wD4VfINRO/bEVG9T3h/TlhjRoZCdOVW2myGYjf8sZQWD?=
 =?us-ascii?Q?nlB6rGeP7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	aupTMDYYUMDa6oKQOR4gznpz33yKADKvAY0p607HTqXcEsYcO7XT4fpp2f1+Sp7sG06+/2NHQZXehzi4PhEwMLS8DAxaU5DoG/7DA1pCfLopb7ggG/bprbUklmawyj6xlfSDAGyW1EI44y2s2qNUIq3aAC9GQsfit/5gXMLlvokhYXkzWwvIoJdk3CE62c4PqcYcOu/4NCqULKfGJNk90xTaFrGNRwu0geVyoQ8HjbPMIX2tg7QHHY9ydkJdpotpc5x10Km9gc9Q7T3cR9z9a9mVUmwUGxTu+zzpypO5G2KGVEFzXkqHCpL0aG0QUnNbBJKwrldCcJn6KIFzCgNsQw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c366223-7636-4a26-9069-08de7f3a39e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:39.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c6Bs+U+Ak0S04YThprKsSC3owXtoKGsIg3rMCcTKvdxgAY1jOPRQReeFuly5c1DcXDT+ux0f33GcB345CV0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-GUID: y9wwUAUIa2vPbAYGRhUTU-rxSPMJd_fJ
X-Proofpoint-ORIG-GUID: y9wwUAUIa2vPbAYGRhUTU-rxSPMJd_fJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX6IMegs4EipnJ
 Is2x3uI7Fjh66YdPokfwQ5LYVxvEU/vY/u9W9mLhuE0OvLsuFT+2c2ah/uQnsN9v385lEvA0f4H
 o/j20Xy8om7wEyjjdaCa5prWD6ilPa630555xbaFzl6BkkX37RZs0RrUl8c8UHwH9VgRc5XCQSS
 Hp9vEdaCSLgzOXmONjvOFnbR/zMaXzY817dEXIT5fFnFnrbFVAdHcUFCKAPiPcWtU8NXbBXM27Q
 3bSvhSAKp4XAMo2yPL42KcMlnCYBSOhJuhk5sShzQDpCFHexRWE65XFalVB4nhFf8EKi57gNt59
 tqPTwYy8gqoj1IqPC+vuwZSiqLJQmpSdz91w+NP7G+5edo8PXzrX7+Wg2CG4Pb+0JiBgrZedW9x
 by32Dy9OdITF1DQclQ1efXEXQqzEVe6FB7lVp71MfHTVCvBekvmnBfT4wSruyYU7ZrNny/npLSq
 CIhpK4/gVArjNsuCE6g==
X-Authority-Analysis: v=2.4 cv=Qr1THFyd c=1 sm=1 tr=0 ts=69b11049 cx=c_pps
 a=k0I/Xeyziwozq/4EdJtLuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=WP5zsaevAAAA:8 a=qV09NasGAAAA:8 a=u-Ev9gDpdlag-DNbPkwA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=t8Kx07QrZZTALmIZmm-o:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3421

From: Chen Qi <Qi.Chen@windriver.com>

The following two import...as... statements bring developers
little benefit.
import logging as log
import configparser as cp

For example, the second one is only used here:
cfg = cp.ConfigParser()

It should be clearer that we just use:
cfg = configparser.ConfigParser()

These two short names are not necessary and they will just confuse
users. Use their original module names directly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 428d66f..9920126 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -31,7 +31,7 @@ import argparse
 import os
 import subprocess
 
-import logging as log
+import logging
 from logging import debug as D
 from logging import info as I
 from logging import warning as W
@@ -41,7 +41,7 @@ from logging import critical as C
 import re
 import signal
 import sys
-import configparser as cp
+import configparser
 from datetime import datetime
 from datetime import date
 import shutil
@@ -125,7 +125,7 @@ def parse_config_file(config_file):
 
     if os.path.exists(cfg_file):
         D("Reading config file %s" % cfg_file)
-        cfg = cp.ConfigParser()
+        cfg = configparser.ConfigParser()
         cfg.read(cfg_file)
         try:
             settings_list = cfg.items("settings")
@@ -217,8 +217,8 @@ class Updater(object):
         os.mkdir(self.uh_recipes_failed_dir)
 
     def _add_file_logger(self):
-        fh = log.FileHandler(os.path.join(self.uh_work_dir, "upgrade-helper.log"))
-        logger = log.getLogger()
+        fh = logging.FileHandler(os.path.join(self.uh_work_dir, "upgrade-helper.log"))
+        logger = logging.getLogger()
         logger.addHandler(fh)
 
     def _get_status_msg(self, err):
@@ -755,10 +755,10 @@ if __name__ == "__main__":
 
     signal.signal(signal.SIGINT, close_child_processes)
 
-    debug_levels = [log.CRITICAL, log.ERROR, log.WARNING, log.INFO, log.DEBUG]
+    debug_levels = [logging.CRITICAL, logging.ERROR, logging.WARNING, logging.INFO, logging.DEBUG]
     args = parse_cmdline()
-    log.basicConfig(format='%(levelname)s:%(message)s',
-                    level=debug_levels[args.debug_level - 1])
+    logging.basicConfig(format='%(levelname)s:%(message)s',
+                        level=debug_levels[args.debug_level - 1])
     settings, maintainer_override = parse_config_file(args.config_file)
     if args.layer_names != '' and args.layer_dir == '':
         E("layer-dir is mandatory if layers are defined")
-- 
2.34.1


