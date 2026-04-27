Return-Path: <xiaozhan.li.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB35FF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 01:57:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33482.1777255020178917485
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 18:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XtFBMwTn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=857718b8ab=xiaozhan.li.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R14s2h2422044
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 01:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=6Lj0BjChd
	IOmTBwxArctoPa1npuzcgKJSVpzFbxwkYk=; b=XtFBMwTnxlZaliNqrnROHTCyu
	TekmCcPm2FccwoCNzujR8288TY5tv78dCromUyOAhnXT1KA5qc36kvSQ56dADZWI
	f5skMIIX3h6HKtnyLsAk7wKbyUnHo4iiZgyex+rofGtJl9uD6kOCL3y/UbzNc+GZ
	vud8dzVS9F1dWE4vbVPEkC/KXeg4ogsLoPTrC+kHqZpV6Uma1SPovfUb6C2snzi1
	cRH6KiFUYhY+3xozkKYSgAiPbwAI+/om3zybDJFPW1KvoeCEIc/spzmkSwB7to05
	+BlBRXKT4NKLxLnvTSdJF2xOMbAcswYjEFZ3p1Pxt9JZeDMbwtcqc2rIj5V2w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju09gcp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 01:56:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rib41HAcbgsQJme+Ii1eAH0w7wUdaEhydyqlopYDZMr66zNK59A8zTKQvQv0/HjYX/dudZHgU75OB7kMBjE8xwWOwGmZAOoiIjH3jvuJnaxCfHUEClmCxHgjhNmjioIF3w1MxbO77D1rb1dL/j2nkMreECZrxHgMg2ekpGbUQdDaLhkbp3gCuWH3pKBm8H+uIn6SK/5PDIJf9o3xKYfkofpCTONTZBrTICZqC0n1Y6ZTO1MzPcFNROtPSC9kQZj2gs5KMvJdBLhBOpI81lqzPn/9bGjCTUiBt0gcoK2SHUM9mDqZ4sbbAgDFgsw5iLJ0lrQVfGFhKNmZtazCl/uMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lj0BjChdIOmTBwxArctoPa1npuzcgKJSVpzFbxwkYk=;
 b=RZdyYXEsnEJwbQdmP11fG98CHr13vmt4ezsEg/hxB6HN5bpwa/tRvTBJ9KBEv3+jqIrfMaj8LRZCwGheEhw2tQtGGKqv+1C9PMdOcBZKpPJKEJqGxfntLo/LK4+aJjyKV1WxcfS8zEXPOcD1WzjR28y3ZPMZuDIJDXklJYALSnlrjGP1hEtyVuik11hDJ2JEUEZTbl02c4tujCdKB5m72ZF6C7GsIg9qFfwkC0b3C83lTMkEyJEU0SCiVAcfMgbJoPOMMXTdYNrqubRCoUQwpaZffkHzS5Td0SdhHAQvCIuUqifL/ALddQV5e8sSx7nh1ZvPx46KjRZ45aYjkNnGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Mon, 27 Apr
 2026 01:56:56 +0000
Received: from CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4]) by CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4%6]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 01:56:56 +0000
From: Xiaozhan Li <Xiaozhan.Li.CN@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaozhan.Li.CN@windriver.com
Subject: [meta-tensorflow][PATCH] python3-keras: fix DEPENDS override and add missing pybind11 dependency
Date: Mon, 27 Apr 2026 09:56:44 +0800
Message-ID: <20260427015644.749023-1-Xiaozhan.Li.CN@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0134.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::6) To CH3PR11MB8344.namprd11.prod.outlook.com
 (2603:10b6:610:17f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8344:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 754e17f2-7421-4443-4c55-08dea40042af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	xl6HJ7Z34dF3OhaKSzEIp1+FUxg2NXA7Re3SMMKk0C2+2ZgnIq3udgJn2heADwouOh3dqD+XlDKrml4pMP+wX6Pohv+/+aiBWNofwXwRNL/qn3+aMG0vR6cZU2OO6LoYj263cMifOiPdv+wKHK9PM9qsgu8/LMGxBi2gos77MbOw4bIaRqXzCJ5AwJZmggorMOYJ0YMX5r/dD4p7SkwXscisPf/JTPhzmf9s14afwrYAVVXSQTkYGKAmJCbjvstSSeqX8NCBtoyfxPThCRHtycZdtP4lPZ4FYGH629AVFerQpfN1hFuELiMqMc5c3dOOv+V/0TZNosOr6LDwHYQO1v4kJ03X6ROZ+aoI2PaC3cfkDhW9MSR/vCc/wk5ae2MBs4kaow5hBfCyQRKdgE/Rd+e3cbwJvMhSIKQkKly6gO44wS+jKEmXoskTClz5GZfqKnHOE5g750Kjmf7PWww9TaF40CimStPZYVfFaeyw7WCCWNav305abf23dwS0oSlgrJV/Xuv6XKowy2gOApCP3vWyu04OomveYNxMLYa/QGPpHMkyFScdO+zEesEFA/5PXe8aOswEKYsoJ02iH+VRpHodv3yTCfl5d8J9asKRVuf2agEAXmv4QgAOwcwMkcKQZeZFaN+FNOZ8wC5CUmi85pMW9BCQU3fNkTDdbYZGLareYmcuVaJOU/N1maI7IPQSI9EnDNDaMeZyszw1wU2TD49/Chjt+2v7JwhoK2lPLbvtxmRXeoxAiQqrjLFOf0OHIYuXojC7vnOXTb3N9ClJz6ge+7YV9/8FFwzfQYAW+hM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8344.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s1oRB/e2ZyJIbbVa1UzmzIqfxXfmHQrK4gGmRDJa08Xaa0/shk+pep23IUkt?=
 =?us-ascii?Q?SlE0rIsttfu7fF1KtGLDFTud22vI36dxSKBWxLfxpgB0Lt3pq9Q2lVqdHLsC?=
 =?us-ascii?Q?ZNTJxcgN1bqioe7k5smxKWJvBGFYfCwnYeb/WOMM1r6FsjGUEll/JE6pVKac?=
 =?us-ascii?Q?F6eM1hK0Ylm4hleuSwS8P4+G0grTcaq2Xow4p/xmbtXlqx45IUBldXa5Yj/G?=
 =?us-ascii?Q?ZN+664udATpDw8LbFGpXqOvYVOxKF3lknE8mC6dFfmDuFoo7nxNNyucBrsn2?=
 =?us-ascii?Q?zqUsB/omdPxP/8VGZlFGAVasRBjUhGW0nDddGDnBFPNf1OoFe53lfsSc+DMD?=
 =?us-ascii?Q?kDprEEN7Fi45mA8OO3pS4uy8J/TVYmxFPj2JhggnWjIvnCNQm1rYeAqgCxJF?=
 =?us-ascii?Q?oaFoc5XVQ33yFS9C0HEw2I9QBLCZgMumOkOx4yqeX/gJMqeNIS6+YV5yB7HY?=
 =?us-ascii?Q?1aG9J5ZRVDCgcWEYGvh5QnbOMIVmoOAkXSL+o+YftX5Cdxebs/tGaIThxiud?=
 =?us-ascii?Q?jtN65G4SZa3S3l7XZ/fJX05RH5y6F2/dUmCxTmvSjag7+JXQ6gJhKidCzk97?=
 =?us-ascii?Q?1vS72dBYyTAWvio7vZwLn1HX/qy/ah3DXNNKhVSsZNQyiYbGYQ89Wid1zLLH?=
 =?us-ascii?Q?Y5IF4Ibm1ln18WLXDF6g/Kq4VL+jzpkKmH7AOTnN2H2LnVpvRz4CS+mw4jon?=
 =?us-ascii?Q?ytZPtRoI5a5dwa+tTgOu8WE8tav1lTIopVMjQoMCwB53D2vgM5gbSnmrjGX3?=
 =?us-ascii?Q?2TY7pvmsxFD3ccbFdohlsBYMgHl1govNjczIEhY4/94vMsuEY4pg8kL9uF1x?=
 =?us-ascii?Q?nImA4LP1WtM3sGb4y7Hem+NQr7x4YKYdcFNQYCh1YZCNoj6CTg8yC6H0p/Ei?=
 =?us-ascii?Q?ay5A3mOoSOnXh/42bwcv/iS5bYyi6ePZ5vf9Q2vudMI2NHqnJuiRHGWhBmfk?=
 =?us-ascii?Q?AOTE03Eo0/S1fbehBew3RHt7AeM+MZ0tJqV6Y9ehd3TosEDnRau8I6qcB20P?=
 =?us-ascii?Q?zUfjrPBc4wKp6a8Qspzd21AiUtZNjYjecf3gVsu8xkgXLWtrGdoEld/z2VeA?=
 =?us-ascii?Q?q3cvQuoNiy9NwkSU+IQnYBq/HJIFJmngA9q3l0nZwAYwX5VQsP2G22E1qHSd?=
 =?us-ascii?Q?HWFKnt+jy6yUgj1qtcoP64pPzOjEKMv4dJhNSV6saUuHoRs01J4bmlBOp57o?=
 =?us-ascii?Q?MFs0+ccIdLwtP0XDlRaJQAzDSQtXczie29co50fEbtPHSh21pYiyWRWfuQ2J?=
 =?us-ascii?Q?Zv+lSedJ9kbJ6ZE8mg7H5oahL46Zkk//6SzGUwsSa7/Ct7wl0cV8e6Wn5AYF?=
 =?us-ascii?Q?uOeq9ZHGSl3Ni+sM+8DqW+UWbBKbKeAJvr7vziiXAfkimZR70PPyRX9knz7u?=
 =?us-ascii?Q?bDo8WpjTJLrwVtkH9vHCZluInc3cLRkavwu5E6ZxEwfYvkFaKPxOOUy2k1f6?=
 =?us-ascii?Q?B2Rghq2oZ0XMqoN61LscyuTsFC2Zx8tqyrjVTBq6Awx0lt+nz9vYfkMx2Ox4?=
 =?us-ascii?Q?+WtZUKvZIW9vhvbj3b0MOEGu74hQJ/zbZQkORppqA3NW+TELWFeh4i0uWR4n?=
 =?us-ascii?Q?e+ZGhUe/59NTU/5iUEv1kEpdXANL4zrYzViQSRk/Gkqj7rNEQNOUZ8St0DKg?=
 =?us-ascii?Q?mXhROpgak+A/Aek5ZeWnIDDveaGyeWrAMNipsLrtCrtKaWC977SqvNfYtNgK?=
 =?us-ascii?Q?5hygYu5sA83Qco4rDrWezxkN0jVd0gytMyZ+5yqKL1swtpZx2e6Fa7Qa96vx?=
 =?us-ascii?Q?vwGgkLpl2Hi6ChfXQM3PvU2IG4DstDY=3D?=
X-Exchange-RoutingPolicyChecked: 
	p6PbV8LXxafk1QAn6g701e+3Dz92U8MKxljab/0nO36sRiMJFYkuHDiuRj8xeTeAJzPtWOpE+2zjv6KoJgnv1ldix+sIiuZ50uQjNdpbgL7kp65S/xvnbPO7sot3LJlRsW8foA9AaMWnUtGGKJclBVV5+bVhMEB3zWX2GzQHVvMM1yk6/JYI6TzGlXkqKmtHInAxYAlc13pnF/A1qkEo9Ts2ziemonosXiL4+Mkacolf644+hovBV4glZqpYAYsarVyEu1fgxLdlhT4Rs5qMK/H/UaBPXQOuqznxNRFM6VC2Ql9VhW/RESVoimfLlbQm+KMaRPmSEAEYq9M3L+RxuQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e17f2-7421-4443-4c55-08dea40042af
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8344.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 01:56:56.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeBKmYcZ2DEuKaf1skzBXvtPyy+xsTzLTLtVx3kltg/YkEt0gFCRxyJhdHB3oIh0YzR8a+P1zaYvdNw3FxS+Y4hIvDQPDwgU+rR64JJT+Xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69eec26b cx=c_pps
 a=k0sZSnccHBAUCD1Alv6C+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=Fl1eH81wStyq4a4SPBwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: AqXnb9NubauwCZH1AMllnK4yl8-jMsHb
X-Proofpoint-ORIG-GUID: AqXnb9NubauwCZH1AMllnK4yl8-jMsHb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAxOSBTYWx0ZWRfX++oxeHtfvUhZ
 LzBuEbDQMmGqYdrSvEyicfAE6rFFeYRC9SbTYJZSiKhcsr6tEjJZnPowhKTa0SKwdVF6Ia/V8UE
 FuwkFl5vxl1lTRAAMyUnYEoQ3yyXRespIJSqMntS5TP7dVSdUa0lEEuFIjKwHnZRuuQ7fbY1QMN
 k2Q4IPOzoNz0vnTtk6ZVU1zDTnvJ+M7ksWF0SDJG2EV6fuC0jvj+z/AKgtFa/YZOOAOHeUqLqwC
 zbMN1WVT8THUPFb8Rfh/tiv7+YyNGOmW6m+grj9DN93kdcfOeXmWBkJAb2uJtw81GTrlYPic4NW
 8+ofkkZo+QfI87jmPojjL4cx1Hk5GYQS6BaQ3apx+F/tAkcqCiuGl9Nejvr+t4AHqpvVbgY35Oy
 x0FlGBTlArzvy7TFY4j1TzLUZBqYBu1JhQewic6x82Zt9xxFpNHEg3r6OjXjwnnpqZVib03nDMl
 C0/zE7XuiDMPFMeG9Kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270019
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 01:57:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3819

The DEPENDS variable was first appended with += then overridden by a
direct = assignment, causing all previously declared build dependencies
to be silently dropped. Consolidate into a single DEPENDS += block and
add the missing python3-pybind11-native dependency.

Signed-off-by: Xiaozhan Li <Xiaozhan.Li.CN@windriver.com>
---
 recipes-devtools/python/python3-keras_3.13.2.bb | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-devtools/python/python3-keras_3.13.2.bb b/recipes-devtools/python/python3-keras_3.13.2.bb
index b5b9338..6bc8adb 100644
--- a/recipes-devtools/python/python3-keras_3.13.2.bb
+++ b/recipes-devtools/python/python3-keras_3.13.2.bb
@@ -25,9 +25,6 @@ DEPENDS += " \
     python3-h5py \
     python3-mldtypes-native \
     python3-packaging \
-"
-
-DEPENDS = " \
     python3-pybind11-native \
 "
 
-- 
2.43.0


