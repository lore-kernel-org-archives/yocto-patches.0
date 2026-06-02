Return-Path: <li.zhou@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DEBCD6E64
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 08:09:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20085.1780387793108453279
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Jun 2026 01:09:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kAU1q79z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0613d761df=li.zhou@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6522o3rE757523
	for <yocto-patches@lists.yoctoproject.org>; Tue, 2 Jun 2026 08:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=9tYNCIOAv
	sBYsGlIMJ/a21qtloI1e/MuYHxufdZFTSE=; b=kAU1q79z3XlCc0KzeE5D9Z8MD
	/Qzm9X4Ug+DE+sx2Ki/cEfT4CubkYFNJ+fbDGzEkS31MjpNLfdPDrM2lxDQXhqKT
	LkJZRsGDyUe1s7w4JTpIejucVskkvHM0zch9nH9fD27EqyCyZCqV/dcrYvVREy3+
	xALqlSO6ILwn7v7d1BKmJhSxirXBkLsCUzxA/lbZW7DOURrlpw2JtM6bQxccs4iw
	oPe+9UD0LWGGFjnnKDN0q4ROCU9gUIwmUz6vW2gV+wV4GcIeqUNNZEFvDpprg5tp
	8wuH1xdvHczIEpzdDczEiB3hkQUIOP+nqfV2A4WCpGnbBVMWB0vLa+AGO3Lwg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efn404dr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 08:09:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g452bLtCVWww8fjYQoxkvB3MmsO/K8nNKK28cWQpCd5x2l8SNXhJcQEoqcDdBh6C1FiLKdxo+Bwk0o1zEH+z11Xk6lq9vRFn/oAFhXXuYv6Lg9sQpW5ppJIevOkMKVlVj5mIZgYxio2IHm4OsHQpiD4MJpRcwEES4blmsB2xAj4sG47m3Mt9FaxJ062pIg4f3OVroNy5NzyY494/FlSK9sAGdXItGPe+VwoT43auT9BRAm6innJx02EbKhEW8dW9rx3hfIDXdz95toV1RzT+wNWTv5BxUHyX9SpIALFT/n6/vAGU2ny4t+Gj/DBmnwBw6HAmV6t6xq7IS0hSbc7M8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tYNCIOAvsBYsGlIMJ/a21qtloI1e/MuYHxufdZFTSE=;
 b=NRW2akhygvx1YBHXuzDZne39+Zc509tJCCDdQZzUz4rebiGsMFb1nc6CJ3+PdG1xZCgA763Pfq8rPH75wlBl+TLSEF3Iu9OHXAe3MrxayBBAt7C/YR25kQCXqpsf/ET1hpkpbCmqk7v0tfNcHFiYVyuPDr//U1Pr9hiiUi2DmakjVunIJPzGC1jhHaxEdO0bcbEfB5OHbKGEsTyNRyDzemrUBhWFbw6YaJo/VyGex0XBt2tdwJ7axu8ybBUynpAdIUMBQBhQ4c04JwPzG+WcJ2qdNPIoXL0+980dcbNQHeK2WPPJvcfyUMukapkk6stC9f2QrdBi5mtWm49zJTnGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19)
 by IA6PR11MB284697.namprd11.prod.outlook.com (2603:10b6:208:5eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 08:09:49 +0000
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae]) by SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 08:09:49 +0000
From: Li Zhou <li.zhou@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Li Zhou <li.zhou@windriver.com>
Subject: [meta-dpdk][PATCH] dpdk: Remove support for arm 32bit build
Date: Tue,  2 Jun 2026 16:09:30 +0800
Message-Id: <20260602080930.2429351-1-li.zhou@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SN7PR11MB7438.namprd11.prod.outlook.com
 (2603:10b6:806:32b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7453:EE_|IA6PR11MB284697:EE_
X-MS-Office365-Filtering-Correlation-Id: cddada23-2232-4425-f3f4-08dec07e5065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|18002099003|38350700014|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 
	oynknp3nlyc6/BDnvzOJvw/ZLujD0X8VR1ADYAgpOT7XKumWjp89IDl1CABUay/FEa6z3S6pvGQs3ep0r85LtzNZK9msfEd3pTvET/3V3/nnOfT8L9l9tEMQ4zuhsFg/uN+s1hhur4qP3yi1KDfSWWOsrAnujH7jsked/H+O1v6Fw1yOplDgKyk4QAypziRJMfKTVnzdH22ldl7gpr4EZJb92AQY7x96dYVvpenhp4rWQxdUSATcI79HobutL/2MCy8O5Ti6RJwfc5K3uRGa5NzaRGF3EjXvLQeNPQnqYA56YrKTEWyZA2Vr6ZyoNCWCxhIVLbIROanVPCNOIPhnanv3rD2Ahtp34j5cKivgGS7oNfF+jadD6xbX+g+YwsCamPzDhAeIUFi6kDPbqQLRwy+OJM4PVaHGu+DQdkeQgTOFcpLgRKQBrBItY3FjxLhgBLoHytUozbU5r6nwVhPpu9U2/BTy3oAklWzGYEBV5eVXG1nsojZ/6uNPbrur2i7qA50/27hKt+Exsi9wcm9DEXHD1ol1AKLH94bFRG39OSdZ4i912+kT90OPOTV3CKrMe7/HUyus4ahN/tDWz+6BFBvIf0OfZjCT5F5bDtqFspSXHNixFaTtscEGIErHRS2h6ATGrXIyrgb4oY30ygtLZnyCcPf30oW/asNHGs9iLGBLkMllflVov6FBbdYTImXVhZ/XA3WcOaNpSFZuuwPDzNvIOXCSA10IHnJdz0idXsnSaFUhjG6UcdTmm2ZhRE30
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7453.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(38350700014)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HZKIo2hrj0Lrtc4yiitD8tYHEOGAwvOwQPjJ8wnwxrd1CPIEzz3/t9ZQMT79?=
 =?us-ascii?Q?qvvIrHoz6h+02yYfnahBUYdATv6EzABBr/T/p/EmwVLWERhX7dTgUUkvY8Wq?=
 =?us-ascii?Q?+C+LfLYvgQTybulZ72PNDCBvoiYjMrl8dbxa+YMVi9xZqDfryoq3LIBZGFfq?=
 =?us-ascii?Q?6TLP4tWPgi/9PM9MfWhXahwHm22n17eLZRgjB3z7xHgmmT4c/ge+/CEL6cM2?=
 =?us-ascii?Q?aafI5PdD7h6tIt4q1Yb3jbQWJKZvbuQfuGXgh5gU8fBuLkuA8sXV3xisd24R?=
 =?us-ascii?Q?5GES34D8PxGHrPOAa8d7SYLC42d0+KJEPTlYYwREOX66yP/v/saQ08c4omyJ?=
 =?us-ascii?Q?ZX9lrzJYsE8A/u828hr7gmRscdjGvIq6vtwgbjCJS5tfl6Qn3CT1ATFx0NKy?=
 =?us-ascii?Q?jOZGZ59aZonsiEkQ3/tCT2tJ7tE0Z80VRyxMuZ+R6wF2ULyCQRGWVf8QtxqP?=
 =?us-ascii?Q?5UCwWW07CR9biC3qNqPuLd55wtCL3DgImr9djHqIxUnmZGBeO3R+R7FfAuTh?=
 =?us-ascii?Q?BCCKjP0vcxU/IF8oHPMe7mOrK71+qnQTUfOi/MNdRIZpHZ3wm3TKjIlnqAi3?=
 =?us-ascii?Q?X9lEYhHfzLaP/ZAq5hbY7ptAYBB4EH75qhfPs7AORmMpuUtTUVQQAAjmHaeP?=
 =?us-ascii?Q?2gog0PsFyXjh4L3NotDiyvSxdpVjdp431/Dv+3Q6bFx8q4HYHeDoPqHTmNtO?=
 =?us-ascii?Q?2uOiWfE5pqF0Px45tvyQkjeowmjRST2rl8aLhdOYcgv3C94soxcCdB4yzx9v?=
 =?us-ascii?Q?TRIQEBrLNS83ZMZiMogM4hogqxvIp3EhFJ7iPQgfEYeeyO4vz9AW6mnFo6Cv?=
 =?us-ascii?Q?8b0fOtymUSKW1etKz7TM5vXdBNN+WqaOa607TORLo4wR2/QS4Z/0NvJQh172?=
 =?us-ascii?Q?UW1keOucy9tBiqZ7qXBKtWpg1uJTA+zGKGrVB0vPh0bDmJSCADIhFuh+NpLd?=
 =?us-ascii?Q?D7XKvv6QAdFrQEKNAWyka3DyQg7bVPR9Iri7FPav883jH9OoeXAx4OiYnnM7?=
 =?us-ascii?Q?17FpSDOvlLpjh+zpSp/rQPL0nsNVJFmeBF87s9W1q4Zzw3AjOcTj548SEokk?=
 =?us-ascii?Q?t2dTCovUvEIwoOqf7tns65I/oHrcuz/Jn6urc9rAvSVmS+rCWRwOrpfs4R9m?=
 =?us-ascii?Q?C0DepD/nC/r8Sp7jLdexmEWtPVeTct0JMSajSQXV3BdnKSVyGzVcqZH27CM2?=
 =?us-ascii?Q?iXjcuitbVaOuqbqcd6DzH6nyEoNZiq5i8IVhR3gq1F5VOt+Ufrzhto1NS+qX?=
 =?us-ascii?Q?Eas7WoCJU9KifyuGgCgtxuzcn4+cUgd5kJgdTdCCSfY4O47Vbz1eOHQZOywS?=
 =?us-ascii?Q?ByPMxYVVlLW1EhM5Tcj3XpjXd1NwUUGzfdXlvLJLbVq4McJyrPTT5clea9KY?=
 =?us-ascii?Q?coMUa7/3x+DIPXz1drqJRogploGrXMz9OCRujEFsxikhlpLFLBILkKOuphgy?=
 =?us-ascii?Q?0K426AMGUVniMm5lhepz6a/7M6DxskkqJy3nN5fx5r/3/PnXn6uJOqs8hyqs?=
 =?us-ascii?Q?HqhXpnIsAFRdkaSc405b+AbKm8wB2yNiDjCDRguz4ejOo3VIjayseX2jFU5h?=
 =?us-ascii?Q?f92P0anPfObpvG1EvD2bNdFnjOamcfRwJ6Dc5GHQAbLHE2oOVEKiRIW0IZjm?=
 =?us-ascii?Q?Yw3Q/RZHEK2ijeI+ZIjBQEiUQ2K0lEmQrVJWm5y6QopOyRSedUO6bVHXP10u?=
 =?us-ascii?Q?i6qwFfUbGUlbfEpOm8JKZnH7xfzpyySykoX1oHiTlk69jC48wUcB5AEvMmrA?=
 =?us-ascii?Q?6Ux6tU6HrQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	qo//fmx8udJCrnuhsuo0bUjwI/M45oGCigXzZq371+hbTmHDLnhN6am5vJtu3XtPRMlfpXYEqjLl1++i12GPMb6R/KyScsIeBn+hDc5/Bo0ZVpOcHiuC/AMQ1BTN5QkdY3aBJUwHbfkun+VyKOMk5FoOPefH+FiqfZsKVOy55pK55v8q60sdciYj9tbmqD6r0fgNuP4NN5fWwI47MmSmxJX7FWXZwoFPp1QUeNuH5JN2OKQGxYjaKayzwH2Oo+F48w86GA2x6FylkUJ5ZQcc9MyGGNr49AIWrNTQunLEgVOmFW2zqf2Ez04BkwrMeBHLJcvcGCR1e+xAU41iyx6ODA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddada23-2232-4425-f3f4-08dec07e5065
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7438.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:09:48.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAxNkeGamF25H96xJ7tbWqOvVYL+ZT8eCrcGqBY+MV803EUmfX/v4MKNkdJgTOmRnlf5dC6eaP+SnvG4l5vj4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB284697
X-Proofpoint-ORIG-GUID: iiSTQkx24XbBDt6xWLom-Qd95Xn664Nk
X-Proofpoint-GUID: iiSTQkx24XbBDt6xWLom-Qd95Xn664Nk
X-Authority-Analysis: v=2.4 cv=GI441ONK c=1 sm=1 tr=0 ts=6a1e8fcf cx=c_pps
 a=A+iiJIZ7q7LOtbDGyL1ITQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=neKeDd46kZfmq2JYDQwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA3NCBTYWx0ZWRfXz5ooHH1LxG1+
 nakww/RQxjHsJtD0wQGqZ3wb5pMsYwvt4mLesanQ5w05DQ/Om4w1+Jf2ju/UvV5XHAEuAUNFQQR
 Ak7TeBTjlSeCYZ56XVpFOZ1dMtERbU/b1NEijukfa4MMsMICBCfohEjimEfkhv2P1gvJJ1kGVZK
 Mo5suThS4c/fCkR1ZmtOXWLSlI/t9JC/PLENvfcoB9HKSTFixALl8cYSUz8ukMe2MbTxXMdmodN
 zwTDpJZHZ0QHlDZx/l0/8SZoN6Y70mxlNvf/FqQbzQXXkAre2NlAnt19lLaty01gwWM2XHTl8Ul
 cLMCk2iyesobPibrqSIesB6EyQXUce8MSkB8B5PaIsh+6/oNNf9ri6VOWGXH5nYKZjVBqM/ou36
 RcnbhEVYI9ZL6224a/PsC+VAi98SOyCg1ef7zpTgvozUL4qyg6/OVk278tRiaUszJDY3rv1ruuN
 m/hLV0N/lE0VLEMU7Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020074
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Jun 2026 08:09:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4108

Issue is reported as below when run "bitbake lib32-dpdk" for
MACHINE with ARM arch:
../sources/dpdk-25.11.0/config/arm/meson.build:853:12: ERROR:
Problem encountered: Arm SoC must be specified in the cross file.

DPDK upstream has very limited support for 32bit ARM.
e.g. There is only one arm32 related cross file (arm32_armv8_linux_gcc)
under sources/dpdk-25.11.0/config/arm, which defines:
platform = 'generic_aarch32'
cpu = 'armv8-a'

So remove support for arm 32bit build here.

Signed-off-by: Li Zhou <li.zhou@windriver.com>
---
 recipes-extended/dpdk/dpdk.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index 6c76a1d..4abd110 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -20,6 +20,7 @@ def get_cpu_instruction_set(bb, d):
 EXTRA_OEMESON = " -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
 EXTRA_OEMESON:aarch64 = " --cross-file ${WORKDIR}/dpdk.cross"
 
+COMPATIBLE_HOST:arm = "null"
 COMPATIBLE_HOST:libc-musl:class-target = "null"
 COMPATIBLE_HOST:linux-gnux32 = "null"
 
-- 
2.34.1


