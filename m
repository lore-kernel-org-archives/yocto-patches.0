Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632BF531EA
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 05:32:20 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12276.1776144734583929898
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Apr 2026 22:32:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TLwGjW1p;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85642e362d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DNiTW41269595;
	Tue, 14 Apr 2026 05:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hUK1j8mgDET6VpiNrqLnKwN40TUKYfkJQR2G97lZfQ0=; b=
	TLwGjW1pS04U2gJiFdslOXZgPyMyguisEKiy72HsGT2AAmxeQBXnpEd7uMPNwf2r
	sTMhGUeqywY2cNQMn+ljbLKfWNPKAPO/rB1kd83FN/9eF2HjKS3IXVN4s1Ch28uI
	Jz6hJ64h+J2F4PMLb2J8o1R9usYBVIRMqPFD6RPJe+/MyUlZ4ukuBS8ryAIjxKWx
	uQBr0U11C9wBRH/CJ+/2pGIFnOFKtcPpllMyxhjdYZE8kBO27hhi1J+6he/+Z2ks
	77yUtgQk3AUyEBSgyqzu7G6NGptOSmDpqu8m8znSwTCQHqWolpay/vgsrxLIQFi2
	uECClt2KEpG6GKx1EPEy3Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh877gatx-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 05:32:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj2mx8dlMbs1PIl9Sf4dkSuY7n9QQe7ffx4weyTiiJMPzcMfuWRY9QAf4TiJhgJI101LKFqRQptDWSSphBdaFY/Ab4B9fRXMaeGCjHOXyN7/ecWCUAWiJLJ9X0ogUACsFR+xyX2cNnxZtMC5SsAwH7Mc6lPfc5xYEhG5mCPFYyTVOmPOjQblZkDHfKw2vbmu1+Qmjjgr5e7vykNT0evaqZLYDgpJtoRPDfnNqjmsCKyDjpiAycFrMNDSKpruc3dbUb2jnLlLg13IBcsbd2NFkQDmq8Tn6eI8JfWm3Xj1czSv9rVJDpb/ylXuB2BKl3r0TV8h+aYMt5b2vLGxNFE5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUK1j8mgDET6VpiNrqLnKwN40TUKYfkJQR2G97lZfQ0=;
 b=gXyj6BqNCmW8sviqcl9R8bIPPyCRvBO/ACcGDkMC8+zwaFz98LFNcPusS1Nf+OWCgX1RiDZhOJRMxm+lfcl4+Y1EPMrxy5CKmkv50EkGZ4A8k25YbASWHHdiVLwDMNLzWGG02N91YoAKO5ZDl25pKObczfYGyoncd6LfncqZo/ZmDqrexrMvNAzgg4G1qB16ZOvZWryVxNzuv99may5W7kzZR8bNddSAg91dXJOjbm+SW+mCU33hKxEIJm4KN1sBBPEzBe6d8Z0h+yo8MjeLKem4pbHx5qI3EpgusQMbnPjk7xS2noGPYzSqguJwTpCKVlA54AnZMb7OyRCsf+4mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 05:32:10 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::ecf9:dbb:16bf:5b2d%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 05:32:10 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 2/3] modules/steps.py: refactor compile() to use parallel per-machine builds
Date: Mon, 13 Apr 2026 22:32:01 -0700
Message-ID: <20260414053202.3869771-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414053202.3869771-1-Qi.Chen@windriver.com>
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5611:EE_|CH3PR11MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 42210831-1a9e-4f9a-9400-08de99e72d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	pwNnAPx7JFUPa/Q+QL1a5VmLVIIdMiLjOTlW3GE3UdKXBD3I/HFRFR/DY82RSnaYwR4eFkdCCkw4eQWrBK40Zs8RsKM+htrEiSUUSV9slW6imr5vw4Ep2D0Ioi1mMcjPsUdXw5UNgTqCeOzsDN9HRnMJf7Le+lbpBrtfBYXp4TMrfkbZwjWS0DCWeyPgCGbKxR+HOWsrQB09xucDSPw+ecv0JtcXSb6fP5P4ECTypGg5LVTgi7MTy0VPnPOb6ZrhAY+iDgh2Clxorb/1BnruhUiHn4FFR0gzsbXKbJ9LIjwcvi7X/NBqmp6bh+iUiVJEi5o+GndlyfkfXEIKxFMwRxYAc/16etP2W2udD6Y616l7ynkRLhZ7UbYAMZnLAUzSLNm0tr7T9PfYVlbvaB8iovdMeZdCavrlbQ+Uhg3A9eH5ojCp4GfILoeq1PJT5H8mNWiMfrL7HxJALAp784RdMDrM0WIcj6NAC98uLmT+Wz2SB1JhGG/PDX5FI/mTfdTHWn7apO3lywTQuVNDN5TMaER2CMBN4/QCA3S4AxUnjRx06Rwf3rvxAjrWZprTMtvCDRpvPAuNDGULXdZpYvdfK93lxrbE/Aj8lo3mwKRCFUVW4R398fL7NxDRl6WjJhBl59poc8M+36BtzSvsXxMvfZdblNCvo3KvSQ05YhPnO2FxE2b2fRtERyTq40ipcULUm/Jh3QmTdcL6JeSgvthiyC9B9MZzguTXFh/esgRb6e2H3ElzwSMIkkrn6rvbKdla+OjslxClY39Y29+WnGNyAv5P97g7Xd2AbwKO4s7J/YE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2eGMIH416KuqpByVw3Fa6upN/VbpKfXH28C87adxfhjLZVzKZcpRPWW4QJOV?=
 =?us-ascii?Q?rCv9IoTWYxs9szT3F7AvX/qxaPbexp9fIwQ85wePrDtwh7xXFiKaAobH12Y8?=
 =?us-ascii?Q?xnsXxUoX5TG8P6v+W/Ym0+Gn4k7tYRf1aykB1dYJck96TTnfk5F1nsu1JMFb?=
 =?us-ascii?Q?7O+IpPUt6rKpStAYDybD5UIZlnvGFXp6MX8b3uragvjIdiNRqeK+1GFMxHSK?=
 =?us-ascii?Q?DpoKODZQKPvYz6Btm1pprbdfNNiVbE0PDbv6x9vh3VX8Dr9UOxRq1f5uKhJK?=
 =?us-ascii?Q?S8mvNPBC6CRph7+qVdoVKcfPC5FmpFebevcR1boYjAgNUsK7CsUGUTKwXxSH?=
 =?us-ascii?Q?O9JyqJAWNvxyPVev4Y9FGyRMtM0hmvuUUItc5GK0cFDjBFOHy9/Ge7nasUmT?=
 =?us-ascii?Q?UY9dEtH4vPE9zD7J20gu8m8MCxHwBQoHJuJqxhy1JEDmu955EYCtvRu1tsTJ?=
 =?us-ascii?Q?WkfbG/XuErBhaha+mZh925YscF+tjG5iA9plnTZV0mhoI06wXshzdESv9J6q?=
 =?us-ascii?Q?Cnu0KxA5IQrggNbj6aQsrkmLSIIclWNhzY7hbhkp2CO7Bqu97SwmhZSQlv3G?=
 =?us-ascii?Q?AL4zqee4A0rHxLAKRqR/5l6MW+BdAmhXRcugBTYyIDblScHgicFsq/yo1nSD?=
 =?us-ascii?Q?DyiEgDEPRaCpqF6UHlZRLtSrJQ2/ZhoQtD2q/uHNyKVQxFEJLRc2CzUO/Rkt?=
 =?us-ascii?Q?Tr/P/zUFYrTNZLSlV7n58kQtHolVvrnLWkYnvrSzuDdD4b7syw/B5LwmA6f0?=
 =?us-ascii?Q?AKirSQZwpAsA7GgftAyOa0PYRduErZzRcJ0dlizsX9CYKaFEB1Evbgpcgz69?=
 =?us-ascii?Q?lQkGB40d98VBajsxH1V+CrHE5eq9Vbz4hrUvemZXEp2ZhklP3A0HimgX+Pqy?=
 =?us-ascii?Q?9OYd/kfcV+iJUFV0XcuU1NdphJtqIfAHEyy6yyqTSsRXgDB/XJ5aSY5rTSNL?=
 =?us-ascii?Q?/JtFpuUeo5n793mKqmwcxVfeVW6s8waS/IyzwF1Ux0wxS86nFXYhR5m0gf4r?=
 =?us-ascii?Q?fXNq8KWcjbZqXyC8zbXkwBu/lnzBnb6vnxva9pJfmHRgBfD5myMVrQasZBE7?=
 =?us-ascii?Q?+k15Hn9g4+QRqbH9mt2f/5Yr9esADGCVeeISSnYNZCC7vMP/YLMfnJvtItN6?=
 =?us-ascii?Q?u+PiB2GGz0VIFvteih/MCqqkGEkBQCU+kZmUOzxZp1jvg40IWbPhNUmI246A?=
 =?us-ascii?Q?pue/rSwKEuUSyKPWqfxQVHPO1nE4ReihpfOnC/GegrPFkeV8rzTrlMwd9qk+?=
 =?us-ascii?Q?DmLRr68mlc0TnuFNK9AnR51RaEUkh5Xatu4mtlsMz4Rhbx1X0mIrR3YJF8AU?=
 =?us-ascii?Q?BrlWaunKtqDCKxnZ0uJzMeDSxMCuOk01qCY5xff2APUcshS/D4+OW9V7qZpY?=
 =?us-ascii?Q?cfQkjn+mTBIf/TkYCnBK0fivWNNLl4yELPXkJhNLQBJOlXU3w46OeX4Tf7R4?=
 =?us-ascii?Q?m9fs4a+kPNeNKxf2g+X4Df1lrnw9avQpGD6jwArDdih4dbn+bpICKUA8tQ4W?=
 =?us-ascii?Q?QmFDcZbAmNG+iX3xugLuO7OBg6GqSTCXfUm7ijT5Gm3l5iE0LLlIFQz6oiNa?=
 =?us-ascii?Q?dEDlL3fNt9S3n8qnIWU2mxQCoTq/Q3VUzR9D5KI0zplHBjL71iQhalwR3wLo?=
 =?us-ascii?Q?VsVTz5WESUYMogNjgKBDMq7v4BFE/NYRCU5p7AEhtBQeyzonVLPj3r9JrkWP?=
 =?us-ascii?Q?Yd3610pL1PicNFM0kyax31JbSTGMZqFoEELp3Uqghn3UYjZyetyohsYlf20s?=
 =?us-ascii?Q?YeR4Th0BZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	nJCHewZM4UnI0qiEqfVpOnyvkFoEKxmRlYrkXURbwBW/jv+l4aopqnEsu51DOXCApdsg3ORhH6lUj7JMcE61EOM/4EhS6KcgYizJVy3jOgNTX4e3nghCz4uHYTSv2HZR8TYS5brp/Il1ohTozDUC3E2ncwUiI3o4l/B0ewhmKLPbsxnVb8ps0B3hvjBtiM2TAsf24EKxaixRZZgutx17KIAhNns82lKXZornZcPBP9iRLBjdSgYgVsoYclc8gP9UB7mL4AygGKPDeVA2BdTckzk/ZI4QcJJQbGe41hRAJfhSly0jvZi16QPPs8n7B2O49N9eR4rXOJT4FdTqrryKAQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42210831-1a9e-4f9a-9400-08de99e72d04
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 05:32:10.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/x2gDmHb/Yf3qJM34pLjlbmoihdHmZ/Y7ZpysqwbukAgh9vyORnSzvVn1irgM6Dq8wak4LJkRYu9c4g3jncow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-Proofpoint-ORIG-GUID: GB4fIvEJx3caI8PDurkzd0f8S7bB2tCX
X-Authority-Analysis: v=2.4 cv=ZtHd7d7G c=1 sm=1 tr=0 ts=69ddd15c cx=c_pps
 a=Bsy78vmKOeQIAJqgrxlU3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=7tNdCL_qoV_6EZ841JMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: GB4fIvEJx3caI8PDurkzd0f8S7bB2tCX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1MCBTYWx0ZWRfX36AokghEk4bA
 pVgvPYgbwTuPlNxWjUbcwMg6Ygr2IQULF3TALgT4KcFpLYYhbxMapdJ7CUulDbCj6C5KF3VzNfx
 Q7dMgwWI2CSDG0Bx6baihigCsO7nY1dFrYD3QffYLesIUguufmdHF4ZQsnJvAv1xruZuQG3vTQ8
 LbeZHsIRAwhUTPDY0M5Tdwb9mAJurrvFf3/QJfF0b5UzXm9+cvAwSB7c4AXz5lKw3u5SbKSgVzJ
 ZmphzMyrp+OQ8BY4Lb/uRTpOV+Qg1Y1t8Vm5Ad1xBAdh2Zgvpgp0nm4uX333jLoTK+fxNDPP/I7
 /vL82FWnikKxfhmw3FqEQVAmL6uF6Ri78FuzaWW50W5ToqygiXB/cRH4VxMacNvpGY54YTz9wsi
 4Z7BUk/VkzK1O1jR9vTqz3Pq+F3BsHU2xL8A6yG6MqxKbEyg8srlBzh1yfpHPwHuJvG4zQaqw+9
 TqImFlA6OgPiZi4/bFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 05:32:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3696

From: Chen Qi <Qi.Chen@windriver.com>

Reasons:

1. Building recipes one by one consumes little build resource. In practice,
   when building one recipe machine by machine in a serialized way, the
   machine load is very very low. This means AUH is not making use of
   the machines' computing resources.
2. Yocto project has good and mature technique to control the build to
   not exhaust machines' resource, e.g., BB_NUMBER_THREADS, BB_PRESSURE_MAX_XXX.
   So we really don't need to worry about AUH exhausting server resources.

Technical Details:

1. Each machine gets its own build directory ($BUILDDIR-{machine}) with
   BUILDDIR and BBPATH env vars set accordingly, and conf/ copied from the
   original build directory. All machines compile in parallel via
   multiprocessing.Pool, with errors collected and reported after all
   workers complete.

2. Use original build directory for the first machine in parallel build.
   Skip creating a separate build directory for the first machine and
   build directly in the original BUILDDIR. Only the remaining machines
   get their own $BUILDDIR-{machine} copies. The purpose is that if testimage
   is enabled, then the build can just the previous results.

3. Always refresh per-machine conf/ directory before compilation. This
   ensure anything new in the main build directory will get into new
   build directory.

4. Add --serial-build option to use sequential per-machine compilation.
   When --serial-build is passed, compile each machine serially using the
   original build logic instead of the parallel multiprocessing approach.

Note:

After this change, AUH will use parallel build by default. The '--serial-build'
is there if users really need to use serial build for some reason.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 modules/steps.py  | 96 +++++++++++++++++++++++++++++++++++++----------
 upgrade-helper.py |  3 ++
 2 files changed, 80 insertions(+), 19 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index a6ec341..300ae72 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -22,10 +22,12 @@
 import os
 import shutil
 import re
+import multiprocessing
 
 from logging import debug as D
 from logging import info as I
 from logging import warning as W
+from logging import error as E
 
 from errors import Error, DevtoolError, CompilationError
 from buildhistory import BuildHistory
@@ -104,31 +106,87 @@ def devtool_upgrade(devtool, bb, git, opts, group):
     for p in group['pkgs']:
         _devtool_upgrade(devtool, bb, git, opts, p)
 
-def _compile(bb, pkg, machine, workdir):
-        try:
-            bb.complete(pkg, machine)
-        except Error as e:
-            with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
-                f.write(e.stdout + e.stderr)
-            for line in e.stdout.split("\n") + e.stderr.split("\n"):
-                # version going backwards is not a real error
-                if re.match(".* went backwards which would break package feeds .*", line):
-                    break
-                # 'not in COMPATIBLE_HOST/MACHINE is not a real error
-                if re.match(".*not in COMPATIBLE.*", line):
-                    break
-            else:
-                raise CompilationError()
+def _compile_worker(args):
+    """Worker function for multiprocess compilation. Runs in a separate process."""
+    pkg, machine, workdir, orig_builddir, use_orig = args
+    from utils.bitbake import Bitbake
+
+    if use_orig:
+        builddir = orig_builddir
+    else:
+        builddir = "{}-{}".format(orig_builddir, machine)
+        os.makedirs(builddir, exist_ok=True)
+
+        new_conf = os.path.join(builddir, "conf")
+        if os.path.isdir(new_conf):
+            shutil.rmtree(new_conf)
+        shutil.copytree(os.path.join(orig_builddir, "conf"), new_conf)
+
+    os.environ["BUILDDIR"] = builddir
+    os.environ["BBPATH"] = builddir
+
+    bb = Bitbake(builddir)
+    try:
+        bb.complete(pkg, machine)
+        return (machine, True, None)
+    except Error as e:
+        with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
+            f.write(e.stdout + e.stderr)
+        for line in e.stdout.split("\n") + e.stderr.split("\n"):
+            if re.match(".* went backwards which would break package feeds .*", line):
+                return (machine, True, None)
+            if re.match(".*not in COMPATIBLE.*", line):
+                return (machine, True, None)
+        return (machine, False, e.stdout + e.stderr)
+
+def _compile_serial(bb, pkg, machine, workdir):
+    """Compile a single machine serially (original behaviour)."""
+    try:
+        bb.complete(pkg, machine)
+    except Error as e:
+        with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
+            f.write(e.stdout + e.stderr)
+        for line in e.stdout.split("\n") + e.stderr.split("\n"):
+            if re.match(".* went backwards which would break package feeds .*", line):
+                break
+            if re.match(".*not in COMPATIBLE.*", line):
+                break
+        else:
+            raise CompilationError()
 
 def compile(devtool, bb, git, opts, group):
     if opts['skip_compilation']:
         W(" %s: Compilation was skipped by user choice!" % group['name'])
         return
 
-    for machine in opts['machines']:
-        I(" %s: compiling upgraded version for %s ..." % (group['name'], machine))
-        _compile(bb, " ".join([pkg_ctx['PN'] for pkg_ctx in group['pkgs']]), machine, group['workdir'])
-        if opts['buildhistory'] and machine == opts['machines'][0]:
+    pkg = " ".join([pkg_ctx['PN'] for pkg_ctx in group['pkgs']])
+    machines = opts['machines']
+
+    if opts.get('serial_build'):
+        for machine in machines:
+            I(" %s: compiling upgraded version for %s ..." % (group['name'], machine))
+            _compile_serial(bb, pkg, machine, group['workdir'])
+            if opts['buildhistory'] and machine == machines[0]:
+                I(" %s: Checking buildhistory ..." % group['name'])
+                group['buildhistory'].diff()
+    else:
+        orig_builddir = os.environ.get("BUILDDIR", "")
+        worker_args = [(pkg, m, group['workdir'], orig_builddir, i == 0) for i, m in enumerate(machines)]
+
+        I(" %s: compiling upgraded version for %s in parallel ..." % (group['name'], machines))
+        with multiprocessing.Pool(processes=len(machines)) as pool:
+            results = pool.map(_compile_worker, worker_args)
+
+        os.environ["BUILDDIR"] = orig_builddir
+        os.environ["BBPATH"] = orig_builddir
+
+        failed = [(m, err) for m, ok, err in results if not ok]
+        if failed:
+            for m, err in failed:
+                E(" %s: compilation failed for %s" % (group['name'], m))
+            raise CompilationError()
+
+        if opts['buildhistory'] and machines:
             I(" %s: Checking buildhistory ..." % group['name'])
             group['buildhistory'].diff()
 
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 2ceb722..1c05333 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -108,6 +108,8 @@ def parse_cmdline():
                         help="layers to include in the upgrade research")
     parser.add_argument("--layer-dir", action="store", default='',
                         help="the layers root directory")
+    parser.add_argument("--serial-build", action="store_true", default=False,
+                        help="compile for each machine serially instead of in parallel")
     return parser.parse_args()
 
 def parse_config_file(config_file):
@@ -193,6 +195,7 @@ class Updater(object):
         self.opts['author'] = "Upgrade Helper <%s>" % \
                 settings.get('from', 'uh@not.set')
         self.opts['skip_compilation'] = self.args.skip_compilation
+        self.opts['serial_build'] = self.args.serial_build
         self.opts['buildhistory'] = self._buildhistory_is_enabled()
         self.opts['testimage'] = self._testimage_is_enabled()
 
-- 
2.49.0


