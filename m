Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E953CCD1AB
	for <webhook@archiver.kernel.org>; Fri, 24 Oct 2025 11:10:20 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.7673.1761304213553873969
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Oct 2025 04:10:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VZMz+d5k;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2392d54f96=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59O5faiQ1420968
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 04:10:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=sYOpvPbJ6ShxT6Ul2YYo
	R+Jbxp1u0kXnzLpEoyjdTnU=; b=VZMz+d5k1yLxItswuwEimUlLD2So4xr+fnoS
	vIDRoGZIH8ul0FwBxgPzkwT8zrm/7ba9Ag4z01xMsf4rm2eEum7TTRrOEQfBDoyl
	zxPTrh30b/5/NPUyskcCoKCbfcj1ZbTy/1YrwYH0DCaGtBcocgOXf1mk02rPLCAR
	qXd7CJN8rxGRjg5b3ikwpid3su2XNO88wWN1ezg2o8OMfsFd6tZfD1A++nacvI4n
	cJFZl5ztFn3ni82/ZVIf8WTs47GtMq+gva833Hz3esMQxoUvuYFzGnqhOQ2MsyZy
	9NQj4/nipIjwqj816zb5K0OMZS/1YskNDD/9RJblTrUlTgU5HA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49ys00grv7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 04:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5HqHvGijITymKTxouiOiuQrEquuT4oSHF1vC3qy3wIYffdPaVwDWMKG9jzMHoGBiv9rTViNPoNEFrK65m8OKfarFm4diPf6UYIszDITY13A1UzJBT9SWXYnNcapiARDOdAGtVZ4jrVW5WwVIgbDP+nj8H2RHNR2brvwfRuT0FQnlvNfMvK3PGkBEZ3FxJYcMpTQcpgzbhHObiIfq5aSLTSTAyr+aY+jYKYGCRiYHcdeqPjMjmevGKeWBY0k1suQNERcX7zHO4eahwrLQB+k/g7fV/rq/peA/XS41pWmtkwIum1ubUjzJVT2c2iSL/S3TFfhA8qDm6SLyOZwGGkJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYOpvPbJ6ShxT6Ul2YYoR+Jbxp1u0kXnzLpEoyjdTnU=;
 b=sAtp28z1xtlseFwxejYGdGX+tXkzUSGZyModvk8g9FBxke5nYkb8H08OhxW71Aa5TIDfpOM5foGZbXT/+XaYU3HeY6OPD3V5SsoKGC4ZRBoi6yRdzP40401BZz/qayjexIiFblg5kpN/H3IaocySd1lAohn7eDDS+L4EC9jjlDUIf7/kHKVEYLsJv9f8qunSEsplT8GBQOdSZytn1MwTr3+s0lelh6zYnpZ9oT5LZuNx5Cxl2tdKOAS0No27uGDjeYwULhunQd1r5T0Vuc7mlSjcyWmm3wErqj0aD9KRu7aQYDA0yY0FQHwZB0GUJzPSEWzcbcET40X9m7gHMy5xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by SJ2PR11MB8403.namprd11.prod.outlook.com (2603:10b6:a03:53c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 24 Oct
 2025 11:10:11 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:10:11 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH] fail2ban: replace fail2ban-python shebang with python3
Date: Fri, 24 Oct 2025 19:09:54 +0800
Message-Id: <20251024110954.2798030-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|SJ2PR11MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 4173ba32-1184-41be-da1e-08de12ede61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NfUfWAXmJ9jTQKGjAEora7rfWbtmcQ+KDJRtbm4yYw3MgYJpz/XE21uCG/Ks?=
 =?us-ascii?Q?/oSPDZST3nv9l1X1CxsIZLDi9xc4MFXpD8nU55l6QRkkDzJIVsIEV/SWe85X?=
 =?us-ascii?Q?QK97w4OUdDaiVay6bbIdS+zeSODmxOHSkbdk/Eg0R1c4mmRdB2HElB9yRYQs?=
 =?us-ascii?Q?O9KeKak3iCjs87yn2zKNlRW3dCT0QDKoycpBPu0E5CLKbqbbJBIHtDiw1Bjg?=
 =?us-ascii?Q?f+KGgNgxNts7vF3vdN4U5vNsZZ4beJJ7gEM3BvRNJDhv8/X9twKrSCjeKC5v?=
 =?us-ascii?Q?LgA810ZYMBTy+wJ80+vznkFJtJ/cK+BLvCEsq3y1ls4VL0yGUf9ug/wrWaqo?=
 =?us-ascii?Q?bT1vzGhrBDyWhC3ap9vnD3+H0kq1CJNqLQfQl6amSTRQxYkoDC29DVhMb1xP?=
 =?us-ascii?Q?aSfPJO4Rdq73qQJCtF1Dm+nHeUWkn0VqKQ2iALPmggn7HP8hfAXMoW0TGKmI?=
 =?us-ascii?Q?dBlzohA1rWBpWN0FaRejrZSbOYTPxPUNU3QdOWLbcUtrNxsrLj8R7KZYCwXf?=
 =?us-ascii?Q?01smPvXqwH0UgDh81WytG+kdUA+2Y2KoP5wojcFDmafde+Eym5MpjO3t9gSy?=
 =?us-ascii?Q?fth3a+4d886/QN4e5VPjT3+Oru5DJci+ZwUaX9bcF2ndr4xqo0KECf7s6yWa?=
 =?us-ascii?Q?H/E4WfxiIOR2K0YU0JbuAWizPcJ244ybW09bvGjU1Q7/+2eRV+KPkhI6Tu7g?=
 =?us-ascii?Q?4sgumB+UZiaA5GiKjtf1bgq5Ss+ZgtuZfGRJgoa7FX4meMpuB4/SATTBJ2Ha?=
 =?us-ascii?Q?WLLi70Bpi6GDLpUs0D5oYf65pwKcLe37FKe9aRaT7LbCYdl7xXrvqSFAnEsW?=
 =?us-ascii?Q?erAoEFezCFGJiYxCBkiwT3Vt1I7KnZL59Q+ZInk2YrEHJ160bu2rbKdVarLc?=
 =?us-ascii?Q?RR85WVxytM+pnEiXjr0MQLBMlO4dSypFfsqvu8AwJGifM43SlUbmNp8wUPJk?=
 =?us-ascii?Q?ELrxfvKj3TpGC/Mve/iHv25vZd9zL9AERCXP3K+YyF0hdQ25ws+Y5q/AEXFH?=
 =?us-ascii?Q?6ciWLQNtAvhPR6vIZWCO8dscwYfw50QidBEfzsiJ2Qt09nVlFZ4U9L7ljC6J?=
 =?us-ascii?Q?n74eoMQn3F+YwyGa13nm99RYoXVNH7g9BuA2LE4gMQQmzwNoN5fspFNiTz9+?=
 =?us-ascii?Q?3wI84Fy0hRR3CBF+tlJJ3kPnouwoeICTP+ZNYoYsdUBgoPtq2IFXOoaxHMOl?=
 =?us-ascii?Q?74Y/ha7r7YPpOFDnN1+QbTyHrU8sIGtbGdNapZMpe3QqUDMT2h/OBYRW2vnq?=
 =?us-ascii?Q?VaI2tPJTCbuQRY4wGYe8I1758YiZoLieV/TTq+vSFat7kgvO4hdsU07eLEtM?=
 =?us-ascii?Q?viGPArxNrNZ9Tce9iNsTPgctppv2GeLbZJ9NItMPnctfquqzzEviEx2PQ/vk?=
 =?us-ascii?Q?1xXeqKOK/O4h4c81BEa4mccstB6shSdreZMQNxIiv1B+Noh5dQdj+8D+6TqL?=
 =?us-ascii?Q?WokArQzI/ofkz9L4LbwNdDnEgPre08TEjVnbT8YgBpBrQHa159ll6CHf7PKD?=
 =?us-ascii?Q?fpE1BUjdyoYx6uX4rbRBLWFtBGmpPHFKMjAX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gKgehDN8FAB9kJQl738UD+uW4ZWbf6h+lWpQT5t175WvSi1x0SyZlybXMt8l?=
 =?us-ascii?Q?0L/EbpTXt5rCAd+6pP5VRmPHjd5/KV6fj5Wiwr/MKMA+N4MKICE9dxnCRUmB?=
 =?us-ascii?Q?L4w3QIpUjzpZbm3YMK7bDudaevu5j97HOqlaFVrnsUYn0wEcEdhOjn8wAZkn?=
 =?us-ascii?Q?kVjTzlKv3PkOPLQWBAZbcv9WM2jYsqBcWWANw9VW/QstbZdjj9q9SJuXQPG6?=
 =?us-ascii?Q?Tpz+vxZiwaoygsyTJYHouOCmjsWJjDq890f4mcxmmB+rirPR3RlxO4FK/QvT?=
 =?us-ascii?Q?0geYTSDd/64IY3XEnK79d8dWuXwYALWf8Vvpm0N7TaH3Jo46EcCWXBsEE3wc?=
 =?us-ascii?Q?JGAH4ACQ180/+Wz0lZS8mHtN7H0VUWjvpi63r8ToIXG1KMzZ+6Pui92Ykesz?=
 =?us-ascii?Q?6hnn0hOo1umathXY2krg+KC6hlg0/w0JxmDlfTLIuqS9OcdDYOdqkh1qoIQx?=
 =?us-ascii?Q?N1faHdXmciUe+SXXoS+Yzj+rYzwaOxe+Qi5ndjiAJWsLy6frJZOVPsSLz7dZ?=
 =?us-ascii?Q?ZPLpDwA5UbJ0oZJENFxuNKwgCfbnDBEGsoacbiFt6wfbgDkfvYaB07CZ8snS?=
 =?us-ascii?Q?Y8e99oRSVXF6SQsqliNsQtp04AVTKE6B8uczjQfe9a5GiwiyeFU9upch8wVn?=
 =?us-ascii?Q?VYMIpMms/ndQDNmolan+85ElXK8aw4FlTxRVsnIQRqeoqJFKmEKEmdtMtEKV?=
 =?us-ascii?Q?r8QBYEWcqgDGfqdF2QsIMDgl6kX0O0pIIj4VtczIOAy1QZ/u+gynOTCGW1f1?=
 =?us-ascii?Q?rMlvcAaI6q1/8LWM9/83XK9yjuZZvaSC1XVKD/LhVkarcTKSgY0Vuyzv2CvP?=
 =?us-ascii?Q?w6FKfVU03V8quN9GLwsWtudWu34D+04olDp5KX4tzqJiW0l4JRL0QXxk/ooU?=
 =?us-ascii?Q?3B5XlWEDlgdpD2IN6p0tAD9xffNOC85aWdHZslM2S8jbihGPvmbhwSY5X4WX?=
 =?us-ascii?Q?tvVk/p+lN/nXUWJrV3yey3Z909fHJmryabu415kyXg3HebtbCeISfXg/Ls7n?=
 =?us-ascii?Q?LMqa+DAmMwWGTg1pIYVLt17ZGUuK+cg+tKHkgzQyve4fIDUCZEvN4JSpmqOS?=
 =?us-ascii?Q?72XLB+OoR8BaeKk8zbr1sVCdrtS7EuUCHEa1tW3vYBuV59G6xIPvRSlnlyQx?=
 =?us-ascii?Q?e1PPGk6UuDnjp4A3fZ5VM0XygoEHwfDQhar+4B0dfwOhzFOR1Ds1+fUn3vKW?=
 =?us-ascii?Q?M9Ojn2fImItvfxOg0exrunTFMTken3Cbg3jByO5T7QdMct941rjSlbYBVCI3?=
 =?us-ascii?Q?0QG11tXW1xrGCyl3dTKrP2Ss3TGHLd5RA+mGDzHw78NwziS0UYdEg4dNPhtW?=
 =?us-ascii?Q?YhUM5DrKA6mBhgbrRdrxoOiJN1HmZNuBJaBPH/i+5yQ3ikvQsfk4In2S3S8z?=
 =?us-ascii?Q?mh/Cw6SCRzEqR8JV1ZcpHpw1tYPP596Fd7OZmReaFLF2S603ukPRP9gF41Wo?=
 =?us-ascii?Q?LdqaYy+BSJu3PDk4o9lpzHUS+J2Ujun45v91ctfY5+0ceTBWR4B24Sj7dLGo?=
 =?us-ascii?Q?+QfS+IY+jGBXDn2cc0fCC3USWpXDjyYcAOUFBqnYsPnDCXushEF3hSodYdCE?=
 =?us-ascii?Q?bCSrGLMFN9PrS1Hqx/hBryRpRPh+dtNDekr1Ezq1LDTOF9oE3NTWZ2bXj0jI?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4173ba32-1184-41be-da1e-08de12ede61e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:10:11.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7xI8dTrAMvWGs7h363wDiEUHJTspuBwB6N7OdbO5genx6GuMM6wmDb3axQ8SJMUgCVvtTSVxu74zxdHJJ0DmrSyeUCGP+749tyRwfnIUf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8403
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDA5OSBTYWx0ZWRfXzsTQg9fvrO1h
 bdRspsnqgNIJsAJCnl6c3/2Gk1uMYXH7bjH27KXrAJ8ieGHgI1SZv+6PX6Wc5ILNqVkSw7stxaL
 xxH50lAnuETlLjc6PK35BqY/T60n2rLMos7A/dPdJln6z/EFfoKNxCQPloz0TZff1cOdkLUl0HE
 /7/hgmN1MX3jK5EgPF9z0WcIuPpXdKMoIQuzxw+FfVQRNaupR9iZpDBesoKOzKy39YLzLh3QBuQ
 zIlMFKtO4M6+xEjO7ZyvtJgkVUjjmaItFgswncJ/o2XZiwKCfaY3Eu0ogx9dt7qmw49Zzn9j6Ym
 F+BG8BZhJks+fZMLSotmwQ30dHtrR7jBgdLB3wHxb1ek65U16ZsEtAzYcKoRsSSDhhPZPUtzFc4
 vBSXcltIwKgdcnvk1Sbp8Fx89LLmiQ==
X-Proofpoint-ORIG-GUID: Vlk55jijttWhenEA518eMXlKe-cIV8SV
X-Proofpoint-GUID: Vlk55jijttWhenEA518eMXlKe-cIV8SV
X-Authority-Analysis: v=2.4 cv=N/8k1m9B c=1 sm=1 tr=0 ts=68fb5e95 cx=c_pps
 a=cgmL7KMsZDthlzKGM6UXqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=tUg6EFNUFFAtlYByzcIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510240099
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 11:10:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2391

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

In Yocto, there is only one Python interpreter (python3), and the
auto-generated "fail2ban-python" symlink is not used. To ensure
all installed scripts can run correctly, replace the shebang line
from "#!/usr/bin/env fail2ban-python" to "#!/usr/bin/env python3"
during installation.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 74e35bd58a6e..6d30cb560eb2 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -44,6 +44,7 @@ do_install:append () {
 
     chown -R root:root ${D}/${bindir}
     rm -rf ${D}/run
+    find ${D}${sysconfdir} -type f -exec sed -i '1s/env fail2ban-python/env python3/' {} +
 }
 
 do_install_ptest:append () {
@@ -61,6 +62,8 @@ do_install_ptest:append () {
     install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
     sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
             ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+    find ${D}${PYTHON_SITEPACKAGES_DIR} -type f -exec sed -i \
+            '1s/env fail2ban-python/env python3/' {} +
 }
 
 INITSCRIPT_PACKAGES = "${PN}"
-- 
2.34.1


