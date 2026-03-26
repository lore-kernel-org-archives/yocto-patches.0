Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977D10A88C1
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 15:13:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49911.1774537975680219949
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 08:12:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=f6S1CfAF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75452d79ea=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q5fMaS324396
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=L8dudTf131HKD/9le6tBY3fzG5j6cj51BvFuzN8gz2U=; b=f6S1CfAFjM/7
	2k55rYc2aJwZx/lVwkxSscIn6ACeobQbCBDaqeABVAcgE2cBfLfzm4dPKcm35Q9N
	SgxwjEujcel4AST+ExU5tKwVgaxeoKhet2L6T+v6RrE4VR6y2l0vlIfSURy+FNIj
	bcieVrPv5gOQ8EdYIctrs/CyUZyNRI7tduWnZAQQGICDfTvpUHJmF0XmZrXFpGVn
	5JhcnM9l4DUXw6K2JGpWUyYdhJFyReGfNoDb18M3M9u0v1alkSHjRZShOUP6LG96
	hdpxmnvWqCXcPSUTAsWZNaS1vxF/sXS05Q8ehL/gY00hTVhiMQeyAVbzb4jsoJt/
	jnCdrNQKbw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6xq7v-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:12:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNhHRrqOiYZ2Dc1L0FSmym+LcwP+oqVkz/w69JyJy4YAEwo2UJaDxV1DauJ41IDxeytQx3xtFDABIcFRt01s5z1aZmYPTi9aTN+rY6sO2Ex/fQXtmG7RQbv5PN1tK70pBF58s1jSMwhMj2XRrxhZijXDyPCZ8Mm6QpjEIuhDIrjLcrseP6xACwoG4oP1Vw924oNsH331/WVYWKQTzoNzwugtoEdLku3QKFau0HSmdHRHolNclsAoEhabWZMsxjzZEE3K+2NuFjh8DVuF1OABeipVwnrezX1Kxz5Mi53VQClnb7/t5iJnI6EUDlQk0sLJ6U9Yir3qMR0YMSqcZbl11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8dudTf131HKD/9le6tBY3fzG5j6cj51BvFuzN8gz2U=;
 b=Le0spkSeZf/+Ytw8h/cywOCdmcanVQQ+dG1dBmDEJhaK16npjjq6ibIF2mjmaXYecprDX5dEbQS0YFlU7FF9DylXBX1Yf6kUDG4aS7Bx0MoiKBoGrsw1Z3MGnjkAHHd1E5JN23ZVW8G3dvilL3cLbuWp1wnXia2jy+Hnc3ejKsRddooD0Zqe4lHMnNzggNvDULEadXirwjkSpZMHnDd9FFQs492ghqt4auMBcMl5UHbYEBeDra6E/YEZdux+XJ3kULfmyEJ1pr2LNNu2D7KDnMsHTf15tNtyR7fltSJpjWPe+4ekagXBNn01aLY0IZGCHcEha7I6xtsrusz2yY5KRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB8295.namprd11.prod.outlook.com (2603:10b6:a03:479::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:12:51 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 15:12:51 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] scap-security-guide: upgrade 0.1.78 -> 0.1.80
Date: Thu, 26 Mar 2026 23:12:34 +0800
Message-Id: <20260326151234.2077655-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326151234.2077655-1-yi.zhao@windriver.com>
References: <20260326151234.2077655-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 868a8547-c07d-4dde-5671-08de8b4a25ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	6z4IIeINkJfrCw+GEIQnDNzwh1Jc+VeRieETWiUIO8qZTp+8rMLEmGrHh1ESjsKbakGhAaI6s7uehHX4wLhlL92SE7/rouD1Wsw9X376Csp2mPV96L0gcvhRKU6SDAJeTefR18eh26JfnJDyyM06egvuOIjM7IOr6nSRqY3vfsSZt56Cstm5yIXd58RI82XVmKDBddKjsMWcpVPJnvJQ4apZ4Rpu5687JpSA95L230iPOjp6rO/fTDFvGiItk5Ze7ebg2nu66Lt7QV8O9sqlijSS7YbvMvJc+YOnwsD5aGU2pcb6TzuH5LZ5r0MTjaWf1QBZ789TBjTvz45Tw8BBS5z7DrF8ZzKJdZry6ip8UV8xrSxlvrHL7aw/z6hH9fxYD0ShBEOCaR527s73bEX+i1jcC7VyUJV6/PWoekzM4rYVhkwp1sp5IYJ+dTwwTu5IwNw2tTiUWQCdYQ2Mk/qkkyOqMhi343zX6KbTAc9VwVYH2oOsJG6AFfyOzGRcNzWiv8zTylTo01AsHobqB/mIk1ItKxCnfoTqfizJ4M70olxoHuSSpdO5KG34ELG7eZ2/XJziAk4E5Sm6sSIIOSjTujoYuzJxBZ7U4j4iQq3lRLhC1IoE3dGjoobBAaYsFko2oDrTh5OqUgoE+hvaedKuiHWBXaRt1IAhEFg7tG5yb+wck2xYfe2LsWgQ5Hms8aApU7kYwThupkTKOhzgt+QRG6GRtuPdJpqGZlYIVSlMZkI8cmGx4L5YOuAuiA8F5IDT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QX0VuunYEoGsSIQ6xLH8kfQV+2PdL8Yj4pyEPk2L3XwOlR5aJ1CQBjduzxYb?=
 =?us-ascii?Q?GEwaSZfj3Ffn3gZUn8vkgLTTat5PCVFdCtWK9U36RO83fF2/df4X8BrCiGlR?=
 =?us-ascii?Q?wyrZ20t9cTSwRX4hdNluubD70Itp6FmFn3klEdo6bxknLWKIXJILbcOHmUxI?=
 =?us-ascii?Q?s3c6UZFfJpm74g5JowH1WBn82s7TGLGMjhE8J7YiiCCeTIHsmfz2bgvDbgHj?=
 =?us-ascii?Q?oqm5sqTGUF212ZZ+/ZjWY31Ckq8h3fkllGV8b0oZlIpb9UXskqwFt0TfW9Y2?=
 =?us-ascii?Q?x/HiZc/NFdbZ0T6jt0oVV9S0NNmmKNDMEbgJdEuHsni0N+LCLyfIN7lwMjBn?=
 =?us-ascii?Q?Ka1VtF135MzaVNORe0oJ1+F4IQoxZj4V0F7prrrpBRchwwDapSP48VYLHi9V?=
 =?us-ascii?Q?2QtS2Pdc7bIM8f0tqrcWAKM8PVv1IKhB7QlYBiDW+AEgxKp6S8D5uNHFkbni?=
 =?us-ascii?Q?Pk2qHX5HNRj/QzQmtPKLhNxg3GSrx1xTWRKEveaSvXmEtHL8Eli9W1AcwyCg?=
 =?us-ascii?Q?v5usFbW+F9V5vkaISwAA0qgjoyGhZdl/1fVVl8FaafS+2WbGnFcKwvQpb+MC?=
 =?us-ascii?Q?oeyOXUu+7FApFcJCy0yU+T8TxsO/0hTK6zpx+vbbf4eeUwmdJZqJa7Tu4/dl?=
 =?us-ascii?Q?6EsSyw3BOFSf/IxXRbt5V1r3zkdVq3CuuJBgDMjZ+a/1uxUu2DvfR4VDn7tJ?=
 =?us-ascii?Q?oERSCSMAKaTBLViBYmnBaYgS/01Putb/eh3Q7MGjOFEzYeuWl3oXs6k4GBFh?=
 =?us-ascii?Q?9hHLmNEdFlN2GiviJO+aEy2g0jEnM0YpFNl0D3lZhiRmrcq5hRJXj3o3xSvd?=
 =?us-ascii?Q?J/rwR4pNvyS5TNkHrZ1fHrxArHi53Jl7RyAtFKnbt1rwW9s+XTHE9X/++i9a?=
 =?us-ascii?Q?l7Om5Q/BBm56AVHQqFkFsSQx9ywX9sIJF/GpVehbTLz8u1g6N7vpE1lXn0pX?=
 =?us-ascii?Q?3IvhX23XyVRh85iWuiU7WsnNOTbTBA2ldW+4smL8W9XNMlCSDzl7j6IeCXoy?=
 =?us-ascii?Q?4cmBJfMMLUyoQ6lea3ExT9AcN7xFVPE43RTtCa6wY3qgGNaqaOKBz4pIkoTe?=
 =?us-ascii?Q?bO1V4J6omhFfwqVjiX7FKee9h9h9dEHnEhHTKy2KrzibqLJ/ZLqnYUrXAgJJ?=
 =?us-ascii?Q?WJhpOdPhJubrd4UkxcV6X5iY1gZXSdf/mzWggM3pCteasZ455nYUWHjkUkIY?=
 =?us-ascii?Q?UciFYtxdJA0dtriuVlTuKfWBxNFjLjalHyuc0oJXUuplFW97grmGSKhJ4EU3?=
 =?us-ascii?Q?cY2bfNEVlfUVtj1ZpqABXa5yWHJh6aBjJbFAM3CUET/3vqEayqvXoX44QnzO?=
 =?us-ascii?Q?Xz3GgDm3sEWDeteMWwS3ikC8QBXy3Mu2qwZiTojbmG9nvVjjoZYLPmRGAM/9?=
 =?us-ascii?Q?UO1bUSBJXm6zfKyMoZpXGv/iPFqRn5AKSenmpA6NARy/eRog0Xdh2Xdqswwn?=
 =?us-ascii?Q?Rjz99ApK0n4SLxFkWhTsqimJKUoj92AkvLfCgxIuLTNwlhdc1HGqmvc+k6cp?=
 =?us-ascii?Q?1lZ2tqHRgRsBj4+7trE5N6XXjXcZ3/K1njHsgXwuJl4h555mS2rLHkvVR9o8?=
 =?us-ascii?Q?YUJqr5JyLNGJMOeKD5a8Ic9JbFnRwizxAKXeUbTdXS2yfcHUbTuV3/9n/SEC?=
 =?us-ascii?Q?DzwLkIWj22JWZFFUrM26L4c22CMku2NjVectr7Kqp2iU2BwXq9EcKrOe9PkK?=
 =?us-ascii?Q?gwzZvI3BroI57N7ZuZ62BwIotjhSz2d5hXwh0TEE82bIzaI22NixiJTOTLLF?=
 =?us-ascii?Q?XLMngPfGAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	tV6L+2HsiZJIch+eXid50Guu4dCYuJpa2r7KaJ9jI9XKtQoWSyzCYsJNoFecRRy2hCrdtYF4MQd9va6Ez7QrB3P6hB9kJ3wfHyT/1aBkuObH6Bp+xb/2xgAFHieXTWFsnRBtBLM54Eyeq5hoZzYqWJ7w97ES9A/as4FZkGZk/ogJdZm2TrN4t8KHjDM6SpDbBUPoORGdFqjBrjtVP2aMHdeFrSI5umVgZFg3/VT9is+Pt+tB7D9LV2NnWhQophqCYxQepoy/9wiygncKWmy8hx4w+jUo07XaZnPNAW1Kkcgp6/pZTVfhQi4WzaFX8W2iP+IRHkoeSKxIDyNNMb+zqA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868a8547-c07d-4dde-5671-08de8b4a25ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:12:51.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNKrXEmXDiamdiyMXE9Hc52ydwvyLlop1mG0jDePe4/9JuinZ/MyHxon0eB761CXiLhV+neo0FRbehZqtaP2ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNyBTYWx0ZWRfXycy1t/PKo2WU
 DkrMGdRLIsz45PXETcqZjhWLwX859b63XiybRXQUpfFY/JPWVcrAPX9lHc8oj/kysOIf3pz2wrx
 M1LzCDTVMpqBCJp9s50yaOwT2qh/URF6+exFqBZD3mhskJxAG7Vmxxrnp3DUilUfoH7bdyFYQSe
 2ut961CvYdVtFGtXclYhQZzyL5gHRZSbwsI4AlxBwmuIpROSXOB1f5ew52KvvmymABidt6RFlWW
 nsDgMThJD+H9G6qFVnGmWWuW5KpEbElnVCgCr1k/GIBapegFvztUcpCZK0JlXK1GaYekzHwMQLp
 GeirkIJ/6g8lrSUfLp9Wn5w/76XjcWRIviLbFAIeM6/XlTGD2A+PUhDs4VZO11G2kZpgxGLX1GF
 nNk6/B0FqrtWaCCxJH1e+5N6A8hAhK8otbDPCma5sGcGW0HMZxJVt8t+VmvHxXOzFHlHZxq0HkZ
 wYC0WFtSlYVbX05nu1Q==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c54cf6 cx=c_pps
 a=+HTpKnCyMzx6Y2VIV8u7NA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=NtrGBYHXAAAA:20
 a=5B1P-IGBAAAA:8 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=38C86fsX8-FL1nup4doA:9
 a=PcRJL-ISiCqaXG01ICqs:22 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 495niXOxST1TbNRZd5Lf_NyI6tdHsyhe
X-Proofpoint-GUID: 495niXOxST1TbNRZd5Lf_NyI6tdHsyhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260107
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 15:13:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3558

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.80

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.78.bb => scap-security-guide_0.1.80.bb} (97%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
similarity index 97%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
index 919a09c..ab495db 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
+SRCREV = "a1b32362394c7739a7a94426c61c7cb24449d9a0"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
            file://run_eval.sh \
            "
-- 
2.34.1


