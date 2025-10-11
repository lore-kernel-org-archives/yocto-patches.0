Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1629CCA476
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 09:54:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.8138.1760176454294726240
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Oct 2025 02:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bSBp4o8+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=23790b5689=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59B9d3p4578546;
	Sat, 11 Oct 2025 09:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2Zdgxixi7VUMSOGUn7VAh4zFXuPio/mqyHbE8VeqmWg=; b=
	bSBp4o8+01iWe4N6SDyb1FWiC9aKS7YbVbP+BXOOxb+KfHQQKhlGJhQcRjXmKYKM
	zeDkqiIVdp98plmMZkywmS5u5v+hBa7quaAj8tlRkhrKt2k6SDgbkcWkEEfoA89S
	VCKcHi0KMw4bqwrH32fSHoTAU7T/2KXBZTWxV2le5C6Ql1wp+f4a4t2XkhB1kYdK
	sE4sqv+4rHg9U7ONQgHp2CJK8q78IZRjtIkvDK5Az+Pk1DWG/plD4hW1C9voNbuu
	vSM/5iozEpe13NuTudx7pPvVKcfTH2ZFty/kRX+Ac/IxJnN14uScHuHSAj+a1jPj
	Zi63rVQL+Sb1TT8o2SJDKg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qe7687n5-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 11 Oct 2025 09:54:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otkfoT9YbhE5NrPDbJIcTqk420aVRvrYPOsmYK4KP+oLfKJJgB+SSugNxnWFPsKp3qAjYhSnYfQChUqSWM1DEJfOMWEfhJ3WBuLVFQXtFy7sW0XtHwBIkv32j9Jj6N65Wus5QlVozr6yeTonl0GOqLZVGHAlqV8qk8tiskL0Xr00r3nJxHbp2aBfJJzURnwtCoChMZAUAQr/MYlDwE2ZmkdwO750SZcejasPHSOUtkTTbkqEl4yfzN4IbzSfmV8OGKOn+IzkcrXa/Cc6Qfmt5vIEF3Ze0Lod3bLReM7m3xtuCYhyFGufDwxSyxlN1eF9CVSdYa+Dbu4+jglQYKYahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zdgxixi7VUMSOGUn7VAh4zFXuPio/mqyHbE8VeqmWg=;
 b=u26AH6jBPVMbYA5luW/934k9PR3l0jaK68NkqBvQY6C3DmwM7D459WV0XrKCliTmmnXdOa5jNLpMjbYwbsOaNiBdUO2pUu7tgn/aE3yrA40sJ/NHLNp3bGfj6/z+akAnUhcqw3+706MM/+PeY6Lr20HRpnpIuEm/2pGWXIQtLHxCFxCvWaLp/gurSikHlFKTrSjP84rD5G6vA0M+PXKMy4kkSQvIavGTZKp6TmjIjh7b54TrwG7PDFssSyWzK0+dqLExFGkleAtx+4D+8k7kMFlc4GnBUmmlsDbX6q33iJe24KL2//MxIHYO7RF5O8J2RIhN+0iNORGNyYa0ko4TDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:54:10 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:54:10 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH 2/3] scap-security-guide: upgrade 0.1.77 -> 0.1.78
Date: Sat, 11 Oct 2025 17:53:52 +0800
Message-Id: <20251011095353.2909174-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011095353.2909174-1-yi.zhao@windriver.com>
References: <20251011095353.2909174-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7512c4d5-edd1-4dbf-f998-08de08ac203f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QjAEcG58NoxKambnCfp7rvPYrKUDEpD9HLvG5g51o5hiASi6abApkQ9+Yj2C?=
 =?us-ascii?Q?e1jJ7KJEijJOwoiIR9YDHXqVeLVGGASyx7/vyNCrYio3RuIlq2rQ/JsGSJPJ?=
 =?us-ascii?Q?5O+Ewx+f6vYCMYfS/0zrAQN42Peq8tfgdglLfzpSa+I/Bv7bWn0AEKfM1dlI?=
 =?us-ascii?Q?nFpGFaFOW1jh1SOaPcnXHI+TrOQGJWZG+wj81p0hNC4rgiVYbW7tzy28G57C?=
 =?us-ascii?Q?mrkRYVSe4tXWdcEW1AwPuPd4vhxcao+ul4lwNHQPC74mrGTMoanCc35RzSG2?=
 =?us-ascii?Q?EmcRCDy9up6QcgkM8TpMHSE8wvzXoG6Zch9/9S1jsh8rrA8I13uuWe5r38zg?=
 =?us-ascii?Q?mSVmhfrxVBNHKZQwPRLUuOt94AXGClgdbFSNMDMrapLZnh/bxFHDRxk91qDv?=
 =?us-ascii?Q?pImHcZ+o5LqiPC4l/Zi0ERb+tyjwPH/I1DEKdudr/0tRgQiCYNH8orbHmwFl?=
 =?us-ascii?Q?LdQUWdfcgh5dLn251KPoUP6ARQUXi7P87blnFjOj2J3fh11sLJk3T2yJBa2M?=
 =?us-ascii?Q?/ssG8IGRMckcf89TPmTfahLeyMceiLN+a3+Bo6QnS/dpZz3jUyxoZCUoNx3M?=
 =?us-ascii?Q?OZf1ZGJikxNE87Vs9TRvQe7F/0Y3VtPQj4mNH9P52bmUKbFEQxlBixjOfrpa?=
 =?us-ascii?Q?aR4AAQVYZSJn2OVCknGMG8rXm71BkW9kDzjBeqDQntAnvYRVHa/wpqu4wcbI?=
 =?us-ascii?Q?JLk6yXtH91gNn4F2oaUzuujyxN17JkvUjVfRE6FqIh/plFFImqiSirDF6djd?=
 =?us-ascii?Q?d4gJUGNBRfpXr9YtboARSlKuCMsEsEBBvYtehwxlgeeIANbr/hPoD3tnbUSz?=
 =?us-ascii?Q?448W5Kr0gUjnMg0vvmK+baNEs81haXftUG04BDERvLJ6pFLrnp2kqBsNK9ko?=
 =?us-ascii?Q?0uuOBZpK5KDC6r+pD08SQ/c1C3pno7Dx8jw/Z90MXOPDxN9SOKa4GHpmLgd8?=
 =?us-ascii?Q?J1IZN+qMXdDvfKbZeMfNwuZ3nQ0tkMzfRNgpSGPm8P8fnuTvNM8gZgYtATSX?=
 =?us-ascii?Q?c3LBjj40xns6S8ZzPif7vfT5/9W+KynGo/d+A9eKD87TiUQLb0hxANtoRyba?=
 =?us-ascii?Q?1A2B1bJr8IL4BOGBpI2x0nWQ+bJkcEeQbBohKka9wRpNRzSABE48/bkIjphT?=
 =?us-ascii?Q?rX+D3Mod7osWjeO/BB4SU1f+2SSzkvRkklcd0frr7EiqS5V5rhPFv5DaxVmG?=
 =?us-ascii?Q?if9iHALn6kOhf4aqN4YldQ5939a0AF4vWuI+yOhkXoerhzrlAiSZJYoig9+Q?=
 =?us-ascii?Q?68vS+c839obZ6hQtBkKMZm30KrqyBU9TAl3aPQOpUFo12ZVF5wkXEGRBWSuk?=
 =?us-ascii?Q?yppiHbjfScBtNbELMAAy3/DxCXRnS4KLbkmaEjnrBZfLTyLqKnDcxUX8xk90?=
 =?us-ascii?Q?MqAFBsYSOgL07oe5Pgmif+GLk1CsKWlNLH2OwdUiEbJUvkvTdMtut67maF06?=
 =?us-ascii?Q?VuZskZwxY5vCBFdAyLgbc1JpF4xBBBvAQ1Wv788HjZlAOKjsvJEl/w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o7K3Pr2zl2JNg3kNlHqOv3+8nVpTf2LutyOLPuw9hcKF7ZpEuWuG5Ze1dw93?=
 =?us-ascii?Q?VetlT9trRY2je6tKC8rtEu+ZZzGvyG0N4Zz/mbSWzZeaJNT/b2zfJfMRUE3w?=
 =?us-ascii?Q?Dc0MPKwUPOoGf1hBjdeh6YsfVVCmDwyTANlNYRFGdUcOvrzmysdkuH3W3d5u?=
 =?us-ascii?Q?c/hNCd1vQms1CyxMvmPkARkaqIsecdiBzO6NBk31YGrZ2Tb3uheDK0CbJtF4?=
 =?us-ascii?Q?P9P81nYSYd/ZD9g4QChF3skR8CgD3EIXRO+ux18Zdj/P7pjp4GbipXzaXkQA?=
 =?us-ascii?Q?HNgHTNJtTXoDQvRyabQZFYcRLZuhwfIb9P2m7SyMZa/Aa6AeDXkXE0JI7lRg?=
 =?us-ascii?Q?TBqjzr1/gwFggFU4eaY66aFhLT0NIKCLRwiSRBUU+1YdsmtsbyTM0jZItSqt?=
 =?us-ascii?Q?Ah6m8mEBN32MT1N8El+d9jP+xO7/+1hAaDvTyNREbRD4YUJ91Ooty5bwpzc3?=
 =?us-ascii?Q?6R93wmWlV9IkxKD1wfPBvKB0qLpZxtdNHAU0ac53ivKuRAjhi2Oj/qy+cFbM?=
 =?us-ascii?Q?he6O9nROFoTurjQUoi3YBRcZb07lfBRaMAaCTdfU7yQAe6/IQPEFFfK8N6us?=
 =?us-ascii?Q?5M4UeV8nIVX7PoeBZeGM3+CLvIoCrFjSqTCWyjo/UvNNUGlGfQZZMTBZNk2Q?=
 =?us-ascii?Q?4e4dpzv8yIFr8Zaqzp2XXsNzxkAUQJVhPf05ZqEBTRL9+MFM0DI09B2Ki9CL?=
 =?us-ascii?Q?vbfMW/zIhZJSYX86V5nQ9LBNLdYYHxtRB5OfeJKeBxwcpoiezEs1Mk7laXc4?=
 =?us-ascii?Q?Ze+rgWwY9evfSra+0YJawlpZkC9lLEG0+RTHca/CBL6i9yJJeQvyEvSxbVvu?=
 =?us-ascii?Q?685W7s8pmHRlTo5g1GM/1QTKaRZKC3vIM9SjxegpywKgXSdQY2hhmOb3SP+O?=
 =?us-ascii?Q?2SvmHhY3UKw4mL80jqF+GCCm8R3SV01OMtnviOwGC3ecDG9YnJDyadg7Az/d?=
 =?us-ascii?Q?LgfZhYTOaRWtlZtGz6XUZyQGTBnlFvWboJq0jncq5nYIQSNBqmTa30FvnFgv?=
 =?us-ascii?Q?JqHOxu9jEXwHqGV2CdoLSBvA8LzFsfwiH/jORHPHPecQWJUFbuz0JPttP/vC?=
 =?us-ascii?Q?mWrn/9SlClYHtL8jJKzzQYPvG8wrdkJxfWp+KCNM49U/f73IpYJkgNykEWJm?=
 =?us-ascii?Q?ZfWAXrjxR2Aehi3u0dg4b8yBUwtHKMyC+NBsPrdlkaB65iqlAB/X3Yd5zfjj?=
 =?us-ascii?Q?mf4wpewM3kTeRZSAiKg4eoSo/KUGYXELE+/b3oExxdIfC6ok8qFgXxWD9kKx?=
 =?us-ascii?Q?RIl0Wvu8pxHWzFS6oeaQdxnXXkVDI6ZOB4fOSh4xEfv5L0pSYrwmO6ILuwwg?=
 =?us-ascii?Q?UqTyN5mb7P2NNyYLD588zkpeiMhqkmK/U0VOpHLZlfQN4red8wHUNJwgY7vv?=
 =?us-ascii?Q?8QvjSFeEzlzQO5llnBuJ+Ay98fZJHHaAZ/kdickirhcwdVPX9hp2/669Z15n?=
 =?us-ascii?Q?gMBg9eCLwuMmHavSg/bQ1+aYBYR4sFZ16ZeLoxqDbnMQl/Sox2KxAdkL7Zyj?=
 =?us-ascii?Q?ZiI7K8AyN+HZOnppm5ZfUQTKrbWO9zSEsS+8QXdju6m507cUMHEZNSJXNYVg?=
 =?us-ascii?Q?PPth45Bawgy5kcsm39SbsQRrnVZuPl1LP5Jxz7ib?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7512c4d5-edd1-4dbf-f998-08de08ac203f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:54:10.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZtTZNgtkjud4aoOpkb92kcxQNSzmGVhyeAmGNoH5v32vDNHPJs8mfqcV7/xEt5uw8IaaZmrSWHyhvpp92wRWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA1MyBTYWx0ZWRfX8fyEkGvpxrgJ
 fVJBEYru9+MIizfiyNbSqQLeNAAVvgbbiWKvyPVK1RNSIpfPafasFPQ+ZoiPWx0GtuS8ACEzVef
 R6EaewzhoRL4qYkJjSVLDo0Vnfxag/lw9vtpPrYfeqYSX29J4d1FjskgQOV8EgjJEdQltEOYutJ
 v3+xlswINX/nhfKETM6Q+JRrUjBUPiQ0WO8T2CAR+LuCE7UU4RDJ4JDqbKfCvQHSwXWLibQBgnt
 rzTqh0hRbbpQsLuyMJ8QiH3KfO8RPNnmq7/MIzjdEe3Abl0Hr9OXO9fPMciUZs3VJeJ17i5C5wS
 eW9Dq+rcIo89IiZbcevL1z6Mg6+VBiLmcPrFhughk4owcebFAu+vx95DoF9FvIPPg5K1R5neqLj
 FWr/PrFIkV8GZY39RJb9g6DSc5Y/5A==
X-Authority-Analysis: v=2.4 cv=E8vAZKdl c=1 sm=1 tr=0 ts=68ea2944 cx=c_pps
 a=mniIB+Hk/8HPdz+5sH7poA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=5B1P-IGBAAAA:8
 a=t7CeM3EgAAAA:8 a=wM68xyHfRYrai-RZu5cA:9 a=PcRJL-ISiCqaXG01ICqs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BXHgKVn0plx5h-hYeVoOYle9i6QBnWUC
X-Proofpoint-ORIG-GUID: BXHgKVn0plx5h-hYeVoOYle9i6QBnWUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510110053
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Oct 2025 09:54:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2289

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.78

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.77.bb => scap-security-guide_0.1.78.bb} (96%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
similarity index 96%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index cdd22a5..8489218 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
+SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            "
-- 
2.34.1


