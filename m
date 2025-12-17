Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A06D64079
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 06:36:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8455.1765953375610407139
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 22:36:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=foLo7Ckh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=444693418e=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH5RiQI1116634;
	Tue, 16 Dec 2025 22:36:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=J56XZ2zgCZG7ExpMiOD/
	eTRO6i+2WKEwaARj/4ScwyA=; b=foLo7CkhcRNER54NjrkDq9606rAtYAa9pDDT
	Wc5dDwNANluV1rzjLTYxuA5bm4HpXzq209ApVE02hXm3nBASjCcHbgM02X3Rm73i
	cZtrdmonfe72elRmxVQUfzrRW3at6qW+i93M5D01zN7hL16BCeJozPLTPyDD9hmF
	nuuJOe1FI/sAcJpQe1UtGPhBpkM06jUX0rPy5DRoji7fGrhDPJ0pMoQc8KbzrZxK
	bGjdAZP+FLjjwBJgnxhw1Nd1v+5owHeLwlIgmcmg2HMK99B1shqCE2MnZ4QJ6FjD
	l4FPG8vzSWtSrrXlHXa0uBpJMuH8J2xeo8Mh6M+WY33V03wKdQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b3k6j06nn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 22:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBwKnGBfO+n0tsvIwDBwzLGmw4nBs7T9J3z3bWgORO3wW/ViEkdLGfaK7HX/ghVg6CU7sO4wK9rbO8AlexaZKwzYQuVTk/N4F3l0t5Uu9lUDCebm8mk8bMJBEWXnl7gbFgRoP6+O/ez9uadfe8bsOOUtuDCKMIZPCOewPiFZQJLKU3kW5Ii/Ko0YUH0KBjclLRBD1d8ToHdRXXl0g1liAGFlWQb9FcDSc33HONRgmpjXgRMo43ceCvJxhvDfSzyJnzo9wshHpKElzgfJOsY5Szaay/S7oHxqOIcDncaAPRvel20IyCzxFqDgu13/SBi/Tr+dFbqpRHKQknBxiatWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J56XZ2zgCZG7ExpMiOD/eTRO6i+2WKEwaARj/4ScwyA=;
 b=PnbvQs0s2WzSu2lRck5Ph8HE5o2tCdGZ9Fm8hQ8XDjzB88HMaff/FKHadiYbnPrtTRfDrsn/3R7SWElRxqLwsMawqbzi962CBiV+HuRves6mw40fJTnUox6gVt9B8OhFfcnmsgVfCMrvXB7E3Hd9GapUvnxdioiDqJmHEyLqkj8cOzeAEqmtdHbUAeJLGSkI7ysZ/2yuWuXdSPaUBFMtfCkECSVbcEt2HGT4LAX8V3vyvUByprX1qjKrdfHHosogH+PzNX9jkrvcKT0hY5tmNuRGGZYnVBWq9K1evyx3ui+9CYGO8YnWRVDzKmoOEKEJoZ2R46jcov2m6VF7IKCzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:36:10 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:36:09 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [PATCH] dpdk: Remove 22.11 due to end-of-life
Date: Wed, 17 Dec 2025 14:35:59 +0800
Message-ID: <20251217063559.40717-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f505be4-b847-4453-df18-08de3d36909a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZuRuIl8j0L65TeZNXEKv4pH+477uWVd5jQC7ztZCmkDJfGRFUhWRUEZMutxo?=
 =?us-ascii?Q?VG4kdE9HK8mEWRmr+xTUXdtQtYcPd0YaQldQJmOyLJX7cNYpGwfiR8r7k7IH?=
 =?us-ascii?Q?tCx88tsgRMzuJUuXUK0G4yO5+EhD1aHh3525Vqy4Paj0dl8O/nD2T9CEMHSG?=
 =?us-ascii?Q?dyzAyCop5jNPwjn76MjUtPSWCwnRo5L6ZM+DrO1EvXrVCgS7nFJt3gm5S1vl?=
 =?us-ascii?Q?7/RLquK1qn4fcJBT1DdAVejmSAucaYnBy8na1HMmQQRUy47Wo6NWYMNpYTSk?=
 =?us-ascii?Q?EvUe8hKpp3Xo9aIj1bXWST9N++YRsLddN3a9Xu1qJ5xI72eennGOZjEmohk3?=
 =?us-ascii?Q?YQzB3jPHbX7PPtYHugHOWNOKRY1WC19xqtFRwEbql3IaaRxK6X7Kxh4InH8R?=
 =?us-ascii?Q?Jp72TUGmAetf21hmVs5il73DQrCGAG5N3f7frcMAccrhgTcRLlhJM331D59g?=
 =?us-ascii?Q?Wr5mjjHGKFgT82IwggnNkzajtIS2NH/Qtio3M4x+g7RXmZ4GuHKA3G+FNN9c?=
 =?us-ascii?Q?bwNYVOhdD5ee/SaZGeFnBRCuGqgm1a8a72WtzHbuunHEyFYBrOziAi86+cMA?=
 =?us-ascii?Q?NfMeg9caxeogMrlQe0LaPOMMTUctx3DgNR3+cgbYgUC/+5uFZBsQZpxrC26m?=
 =?us-ascii?Q?pJZoAlJpMPCx8Xmt3AuZ8TR7Y+RFf83lJLnOX8WHWjda2TkRiZMvNh6H4ptM?=
 =?us-ascii?Q?lr8Sinffk+Ix7Beny2ipK05Js3AywuKkk7Oh0IPzTEXsLslQ7ffJCJm6lxOV?=
 =?us-ascii?Q?LyzmTw4ndmSX4jfY2f5oHL5V9Vn/Dd0o1WNarNDuce5scmDxXrfWZgDDs5JJ?=
 =?us-ascii?Q?Ejj4hB2JgaabODStbCfO1Oc+ZiFVyVDZcihuHZcKWV8DPYZMWxmjftg2j9N1?=
 =?us-ascii?Q?r0+5tkUfL55ucmhxQt+C+CL0M+A4JutlB2nB7LYqiYwVnL/oIYql+mZMyZdE?=
 =?us-ascii?Q?DiXnmspRiv5I5gsn1UWNYaGCQW4zfDx/ehgMw7f6zPzsb/7SSVw0MdL57BgY?=
 =?us-ascii?Q?JDUlY3d34cqsJFFWXqO073aua5c1yb8GUhd4/oMth/uas/BHfxvpJnSQgn65?=
 =?us-ascii?Q?is2+Di6TBd2TCdGWYsJoDfpdIIU1VeEM4r6bGk+gRLVVFMtwkOffQPLj8dB7?=
 =?us-ascii?Q?yqqsBkA9QNklSKnGZZV+6+HvNG5VkAhtIVoWuaPWb0s/G8XwL35CFm3phSoE?=
 =?us-ascii?Q?19s4dPyA8veRKHdRFCWxfi2FalMENZ7jV56dWuCOy8B46L+JaZwPLtqont/p?=
 =?us-ascii?Q?JnYnuEnAkL5s9w7vmvTP2f7rdF29xj485Aahs/dHsEAzTHrc9Mx0OHjrqVmB?=
 =?us-ascii?Q?E/P73/w6FeVIAufq5Ol2T5y4/yXfnoRCqVkAUkmXGvBBtBrE4w7cYJLyJ1/1?=
 =?us-ascii?Q?IbxiQS+lm/UC9MTuDkWgSXsKQqrBdDBbfzHKUe4ga5RLfsdCFu0soUWyV/fD?=
 =?us-ascii?Q?CRO7v87HSjYcJ1Y9fszKwvqM4/yygKYkm7nwOD82lVVzi4Pz/sy3fUkeUEwW?=
 =?us-ascii?Q?0Y+PKN6FuqEBeXh7ldQgCPAxDmYa4lryv5aw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3S4L6EdjC+klyms1R3sAfX49f+tP5KNVFNr3dEGlKTmKpL+H0tUpvO6Pm6Ta?=
 =?us-ascii?Q?WBE8v0+l3/WrGYqlebqo0sTr+li0oSxvHeqstsYEhbvxaKRlnzTNOcQeNz2M?=
 =?us-ascii?Q?5FwnLnCBnspvnyepZzq/rIh1r8hzzvfqOzAFC5ijvReoD1VY3ZJ8KhCfH/jq?=
 =?us-ascii?Q?ByqNLG6ZYn4/jk0UR0+5XlJXVhNfWQdly0QtGpnrS0yYXrpW5lbTgqWiezv2?=
 =?us-ascii?Q?U5bhG/XuBnTMCwcvePXF/eP0Q7JkBARkDEcL5G8TotsExzrtxX7m4dTWRg8F?=
 =?us-ascii?Q?MC/BYJvBsKdtfHYQokiCCI8/BS4G15hblcIj2F+/bmhiHWSLI4QZCdliu7po?=
 =?us-ascii?Q?ArLBoGybVvnRTmJ3kFKyLz0KcFaOIf34Doqr1JMStEhP/UOkCSlVVYHqfw8L?=
 =?us-ascii?Q?YO0wHmFmPLzf+X3vU4ZDPJl4xVcHAEBxEhmiPuDbIiHLQ25A9k4K5eD95+C0?=
 =?us-ascii?Q?JRk8hNp1JCZU1A8DjLWnYqN9FpOi0onFE7CVWqFyFbNDUMfQ4WLtlZ0t0MC+?=
 =?us-ascii?Q?V8NVXY/ZmP9mz9JGi8MUFosvZuxnrQ4ISBx2IgbuqZKcNmOPQZbznWA2hj08?=
 =?us-ascii?Q?v5vF7fMu9D78DaQHj91W4R4ZncpRz0/ZkiR1I+lGWv9gzKHOm8+Ucy0GNMPI?=
 =?us-ascii?Q?UZs6clV3ecOk2/eZbmYXpwZ9+7pvWdJrNwOAH2hrtU1WURzCFJMWMeVE5zMr?=
 =?us-ascii?Q?Bu8R5RU+7Yz4+YJrVIS/s0W8bzFgwyXGIRGkd9quN5+y1vLIrmwB6itKFEGK?=
 =?us-ascii?Q?Ra7HnY6TLq7JRnbb5YL6IEHf+UUeHzsUOVdrV05jzT+JqrCsPbFtgeibQwRO?=
 =?us-ascii?Q?o6sr+PIkBr5ZT9jt07X0dECrmJsgZsL7wCZ8PQzulUHsUIasidcm3cr01lyg?=
 =?us-ascii?Q?quFgURaLSq6p0MlZ0cggHPacmE6F3NHo/gqWJSl3PYf0oRWllkmfCFMBocfT?=
 =?us-ascii?Q?e0949s1r7A+wZ7hwr7NkuMQ13lvnr4imuQDnIrcxKActc1BLeS4RCJfOKPo8?=
 =?us-ascii?Q?fHGnN/VUgtgZ60+5zFnzlGinxhpzOSDPjiGWY8CFSRGvfFbva9f2125eOVJD?=
 =?us-ascii?Q?rL2c0Vbv1wv+YINK6SjxTv9LACXA6Kr52l13yGfOB2jYHO/iJUVbtKbzKq1M?=
 =?us-ascii?Q?gRFTlm7pLzapNF4llhqtHCnIP1UnYglMCyTQ0CxQL4zir56NUvwghjboc6Dg?=
 =?us-ascii?Q?+oNFv7GLHLVive5A7SZjHo0JrN/itXHxtQIaT56pYArvNsSOEVpbkzX2WnQy?=
 =?us-ascii?Q?4eFsyHp2L3f9hwGjBGU+r0Bw87P+5HE9nv+FwS3KVdlwCAl+zYjZzqL7E+Na?=
 =?us-ascii?Q?B2pnY6CbupDl3HVmNoeA9SaTQcjp+n1cQjLsStiULOWchy+FZSuU9c8ZTPE/?=
 =?us-ascii?Q?6jN0GPTbMqADXy4l0OPq4KCVIM78btgDf0/n/r1ztql2hbI2uiISe2+jVudb?=
 =?us-ascii?Q?qyVewu9nBOBlb4wg8MdtPEHVeRQ+nQbCKFYxq7RLPSe1mRsj0nIIv/dr7INT?=
 =?us-ascii?Q?IvVOEd8klS/6NJJ2eh4rDlTTHlJE3K1nUf1ZhWZaD7gkkNmaHLvrQ3JeWSzg?=
 =?us-ascii?Q?wuK9O9KqbaJ4ylKipGqqK54+tAE7pdwKT5JUBTUmMMAeeJw3dIlEEB+hJp/3?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f505be4-b847-4453-df18-08de3d36909a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 06:36:09.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojIBTVvbm9VegwFlvP3TZI/Mzp9kWxOfe11bjOyYWjQAhcqy5UKu+p6jt5zPLsQ4ZlUi4WP4xkRTNQg9eFId97GZtCFqA8NTg6GwN/EYiQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-Authority-Analysis: v=2.4 cv=ErvfbCcA c=1 sm=1 tr=0 ts=69424f5f cx=c_pps
 a=qX5DP9EEIf1faxnBSU0rOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=xNf9USuDAAAA:8 a=nzjS3KwODS20eyGiZVoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: M6yjo99VDjVXn30SNlaa5u4PGLhxQ5sA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA1MSBTYWx0ZWRfX2hXcbIC4ogtB
 tkUZ0jbnve6/ZoH99Odpvj7AziVRzS2k2+04QH0eJJ/qokq1m8wrwm9sI1xCNGqvWt3vmJvXa58
 5mN1slnhniGnATcgagkOKISVo88qi9c1moEWEGPdAvXZr3439g097jKppgALUlT9bGMwFL4e8kq
 IJwgO8oax39o79HBHhcsRT7UGcqW6pEt/imBCONGBzWKdME85By0Fw3T3p2EhPJUgFsTijOA7EU
 5peo4I9Jj0CS99qVTQsW5P4KrnG2f88MJnDia2UTqfOYYjOSN8B3lumPfn1ju1CXzXLosajqrii
 Mf2YtuV4LnMpXzyLqUSmKwNkBIUYaE3wpBbznqYsdbY+T2ZYSLrcAOg4wg9/xEv8JWesM+W5ldh
 kAG1nfCMZY5OqBMcdKWEF0910DUnEA==
X-Proofpoint-ORIG-GUID: M6yjo99VDjVXn30SNlaa5u4PGLhxQ5sA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170051
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 06:36:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2810

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

DPDK 22.11 is approaching end-of-life status. Remove the bb files
and related patches to maintain only supported versions.

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 recipes-extended/dpdk/dpdk-module_22.11.7.bb  | 49 ------------
 .../dpdk/0001-Makefile-add-makefile.patch     | 75 -------------------
 recipes-extended/dpdk/dpdk_22.11.7.bb         | 67 -----------------
 3 files changed, 191 deletions(-)
 delete mode 100644 recipes-extended/dpdk/dpdk-module_22.11.7.bb
 delete mode 100644 recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
 delete mode 100644 recipes-extended/dpdk/dpdk_22.11.7.bb

diff --git a/recipes-extended/dpdk/dpdk-module_22.11.7.bb b/recipes-extended/dpdk/dpdk-module_22.11.7.bb
deleted file mode 100644
index 1ce396c..0000000
--- a/recipes-extended/dpdk/dpdk-module_22.11.7.bb
+++ /dev/null
@@ -1,49 +0,0 @@
-include dpdk.inc
-
-FILESEXTRAPATHS:prepend := "${THISDIR}/dpdk:"
-
-SRC_URI += " \
-            file://0001-Makefile-add-makefile.patch \
-"
-STABLE = "-stable"
-BRANCH = "22.11"
-SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
-
-inherit module
-
-#kernel module needs 'rte_build_config.h', which is generated at buid time
-DEPENDS += "dpdk"
-
-COMPATIBLE_MACHINE = "null"
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-COMPATIBLE_HOST:linux-gnux32 = "null"
-
-export S
-export STAGING_KERNEL_DIR
-export STAGING_INCDIR
-export INSTALL_MOD_DIR = "dpdk"
-
-do_configure[noexec] = "1"
-
-do_compile() {
-    cd ${S}/kernel/linux/kni
-    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
-    oe_runmake KERNEL_PATH=${STAGING_KERNEL_DIR}   \
-           KERNEL_VERSION=${KERNEL_VERSION}    \
-           CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
-           AR="${KERNEL_AR}" \
-               O=${STAGING_KERNEL_BUILDDIR} \
-           KBUILD_EXTRA_SYMBOLS="${KBUILD_EXTRA_SYMBOLS}" \
-           ${MAKE_TARGETS}
-}
-
-do_install() {
-    cd ${S}/kernel/linux/kni
-    unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS
-    oe_runmake DEPMOD=echo MODLIB="${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}" \
-               INSTALL_FW_PATH="${D}${nonarch_base_libdir}/firmware" \
-               CC="${KERNEL_CC}" LD="${KERNEL_LD}" \
-               O=${STAGING_KERNEL_BUILDDIR} \
-               ${MODULES_INSTALL_TARGET}
-}
-
diff --git a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch b/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
deleted file mode 100644
index 0fc849b..0000000
--- a/recipes-extended/dpdk/dpdk/0001-Makefile-add-makefile.patch
+++ /dev/null
@@ -1,75 +0,0 @@
-From 768cef60957d5e840071d1d6514d4add3f3c2904 Mon Sep 17 00:00:00 2001
-From: Naveen Saini <naveen.kumar.saini@intel.com>
-Date: Wed, 14 Apr 2021 17:25:53 +0800
-Subject: [PATCH] Makefile: add makefile
-
-Current meson build for kernel module build does not fit in Yocto.
-So added Makefile to build rte_kni.ko
-
-Upstream-Status: Inappropriate
-
-Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
----
- kernel/linux/kni/Kbuild   |  6 ------
- kernel/linux/kni/Makefile | 35 +++++++++++++++++++++++++++++++++++
- 2 files changed, 35 insertions(+), 6 deletions(-)
- delete mode 100644 kernel/linux/kni/Kbuild
- create mode 100644 kernel/linux/kni/Makefile
-
-diff --git a/kernel/linux/kni/Kbuild b/kernel/linux/kni/Kbuild
-deleted file mode 100644
-index e5452d6c00..0000000000
---- a/kernel/linux/kni/Kbuild
-+++ /dev/null
-@@ -1,6 +0,0 @@
--# SPDX-License-Identifier: BSD-3-Clause
--# Copyright(c) 2018 Luca Boccassi <bluca@debian.org>
--
--ccflags-y := $(MODULE_CFLAGS)
--obj-m := rte_kni.o
--rte_kni-y := $(patsubst $(src)/%.c,%.o,$(wildcard $(src)/*.c))
-diff --git a/kernel/linux/kni/Makefile b/kernel/linux/kni/Makefile
-new file mode 100644
-index 0000000000..19897ee06e
---- /dev/null
-+++ b/kernel/linux/kni/Makefile
-@@ -0,0 +1,35 @@
-+#
-+# Makefile for building rte_kni.ko
-+#
-+MODULE_CFLAGS += -include $(S)/config/rte_config.h
-+MODULE_CFLAGS += -I$(S)/lib/librte_eal/include
-+MODULE_CFLAGS += -I$(S)/lib/librte_kni
-+MODULE_CFLAGS += -I$(S)/kernel/linux/kni
-+MODULE_CFLAGS += -I$(S)/lib/kni
-+MODULE_CFLAGS += -I$(S)
-+MODULE_CFLAGS += -I$(STAGING_INCDIR)
-+
-+rte_kni-objs = kni_misc.o kni_net.o
-+
-+ccflags-y := $(MODULE_CFLAGS)
-+cflags-y := $(MODULE_CFLAGS)
-+obj-m := rte_kni.o
-+
-+
-+KERNEL_MAKE_OPTS := -C $(STAGING_KERNEL_DIR) M=$(CURDIR)
-+ifneq ($(ARCH),)
-+KERNEL_MAKE_OPTS += ARCH=$(ARCH)
-+endif
-+ifneq ($(CROSS_COMPILE),)
-+KERNEL_MAKE_OPTS += CROSS_COMPILE=$(CROSS_COMPILE)
-+endif
-+
-+build:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) modules
-+
-+install: modules_install
-+
-+modules_install:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) modules_install
-+
-+clean:
-+	$(MAKE) $(KERNEL_MAKE_OPTS) clean
--- 
-2.17.1
-
diff --git a/recipes-extended/dpdk/dpdk_22.11.7.bb b/recipes-extended/dpdk/dpdk_22.11.7.bb
deleted file mode 100644
index e69a2df..0000000
--- a/recipes-extended/dpdk/dpdk_22.11.7.bb
+++ /dev/null
@@ -1,67 +0,0 @@
-include dpdk.inc
-
-SRC_URI += " \
-            file://0001-meson.build-march-and-mcpu-already-passed-by-Yocto-21.11.patch \
-"
-
-STABLE = "-stable"
-BRANCH = "22.11"
-SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
-
-# kernel module is provide by dpdk-module recipe, so disable here
-EXTRA_OEMESON = " -Denable_kmods=false \
-                -Dexamples=all \
-"
-
-COMPATIBLE_MACHINE = "null"
-COMPATIBLE_HOST:libc-musl:class-target = "null"
-COMPATIBLE_HOST:linux-gnux32 = "null"
-
-PACKAGECONFIG ??= " "
-PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
-PACKAGECONFIG[libvirt] = ",,libvirt"
-
-RDEPENDS:${PN} += "pciutils python3-core"
-RDEPENDS:${PN}-examples += "bash"
-DEPENDS = "numactl python3-pyelftools-native"
-
-inherit meson pkgconfig
-
-INSTALL_PATH = "${prefix}/share/dpdk"
-
-do_install:append(){
-    # remove  source files
-    rm -rf ${D}/${INSTALL_PATH}/examples/*
-
-    # Install examples
-    install -m 0755 -d ${D}/${INSTALL_PATH}/examples/
-    for dirname in ${B}/examples/dpdk-*
-    do
-        if [ ! -d ${dirname} ] && [ -x ${dirname} ]; then
-            install -m 0755 ${dirname} ${D}/${INSTALL_PATH}/examples/
-        fi
-    done
-
-}
-
-PACKAGES =+ "${PN}-examples ${PN}-tools"
-
-FILES:${PN} += " ${bindir}/dpdk-testpmd \
-		 ${bindir}/dpdk-proc-info \
-		 ${libdir}/*.so* \
-		 ${libdir}/dpdk/pmds-23.0/*.so* \
-		 "
-FILES:${PN}-examples = " \
-	${prefix}/share/dpdk/examples/* \
-	"
-
-FILES:${PN}-tools = " \
-    ${bindir}/dpdk-pdump \
-    ${bindir}/dpdk-test \
-    ${bindir}/dpdk-test-* \
-    ${bindir}/dpdk-*.py \
-    "
-
-CVE_PRODUCT = "data_plane_development_kit"
-
-INSANE_SKIP:${PN} = "dev-so"
-- 
2.46.2


