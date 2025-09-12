Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89862CA101F
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 14:48:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.18728.1757688526217346248
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Sep 2025 07:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=MZfpX8E1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1350451926=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58C7Qt3H1080672
	for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Sep 2025 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=5ok9qJfyYepjKnKEZfzb
	hcSLnoW5CEY8NrQcibyq5Wo=; b=MZfpX8E1lcJZ9pGr4bsyEzYnuAUkVSPLR9Mn
	xRU+BuwXD/TH3QIUXMtn6bDT/cTLIbIsmu7A/wffqBlexLtSaAPxrIN0M+svqHC+
	tw07Jm2Xoo1n+XkGQrp0fvJ3LryFVgnP3ZhGB3aBxrrG6QULq4l6ArfHy8qabLei
	sKMdQJq60IpR8lgXXmsKl0lWKj41z9MVFTDUN/VCG1b9QcpmhbRRXUPh895ish2I
	GWIc/2UAZYRYWIPzY2lOcPGsycSzsWCUYepNElQVdOo1qhWImU8SQsKVPfMnZGDb
	7eAXUL3w6eWUpgNwvR2HmvuCA2n3vAVECkM8iBaE3LOkDrTl0w==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 490a5w7xt8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 12 Sep 2025 14:48:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBQw2rQc67tVYSqTi2sNx+jAMoneItD9XlWVH6a5eNY3GhgFNvnvIkiGjaQZkv1CIvEu1fICv1mzce/OxInTzOaUJcVn1OseMlv4v1+i0iyWbFeYBAuIUXK+vVJKeKFlzLRacWlOIXOi5+CvFs9PBfKvsI3BMfhs5Vt+qGb0ZhFxLCEUQf3sCwtdomTzUr5wNnUDr5GnSA6IwDIjAaJG175PFidyjG1ovGUgzp8WFvjMkvwmdj+GJJNB122sU43pbdtUERts1LBe3iMS7y96BNbWisX6EXq3EEjL7ft3vi99g4KCK/rS25XWnZQI/zcbpH5RZEBGyHPLd97BeBY2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ok9qJfyYepjKnKEZfzbhcSLnoW5CEY8NrQcibyq5Wo=;
 b=WWOM5VcN9sbjW0Gs59+XNLBF66Yz2O0RUi5MOVGcdwz0KQ/h1KfTMqvpDEI058dotZ3ONRtsmpU4zJbUDP27d/HQJGj3cVB30TgNl0bL9MZKRg5UW3fR1bSQqDLBW5s7TeohFoGyvCIu4zd3lmLwwNoHSR2c6jsrYSYJNXO/ZU2f3RDQZd1Q0kAqbzvtbIC6nWn8C8Ii99SWQ5t48QXQunChSII5CT1bzjZXa0lo9IYSTjYNlvYnsJFzrCSgvzPxHcZvotfUg+fAEjxTEsQZ+6bez9DcTFst+IAIJKtuBZiQ3I1e3t6iqkVxS2+DQNFaatIdCIyR60gt4xgZLSHnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:48:43 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:48:43 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] linux-yocto: drop CONFIG_REISERFS_FS_SECURITY
Date: Fri, 12 Sep 2025 22:48:26 +0800
Message-Id: <20250912144826.3286933-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0100.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::7) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b60882-c8a1-4745-5501-08ddf20b7794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lF4y8sSmxqNZXGHkPOypa1tkBet7LnuwBBf4bw/AAc6FvXOu0ltgf4oNNN8Y?=
 =?us-ascii?Q?KEeAfFeaT2blGxK5n34TJRlF40LVf54+hYDpluHTMmLiR+hS8tEqmOp/fx6a?=
 =?us-ascii?Q?YGbEIsS0eA/z57SUNSu1KCjcCczVgWsaV1VfIR8VyXLqzymcgxhZU99AlFI4?=
 =?us-ascii?Q?4C3xan18qQ/GiYEdwgLnG7RD1si/MdSq4C3P7mzvRJtvCJKw36dBeJROK6QE?=
 =?us-ascii?Q?DewG241kqg2RPBaBNL84e0Or+HZT4IxC6XoubxaCxKzA9CButwmHgzmMaPGs?=
 =?us-ascii?Q?Yd+jP5eHRZfbzYq9gWWn8H5ivtYH9eDC4EmQDs4d9zcJDINP9pxZtDB3g4IE?=
 =?us-ascii?Q?GVIA9XMU2xOsGLDxHRtj15GmVfm0qnoEE4e2hW8uWKAQ93rJQPnManlowIaZ?=
 =?us-ascii?Q?Y0Qx1Pln8LmOeSRsjAHBbyrtAonfelBaS6K26rB5XPUNEatPVL38aZuumxh6?=
 =?us-ascii?Q?XANyYYe0FLfrdsESliA3WAL12y8BQYrg17gqN8CCf0fsS+8VCxkQZ2c6uj+Q?=
 =?us-ascii?Q?kWng/GcLnPzxZqC9J3/VGZeiZP4Ef6zj0EixRzf6N09Z9UDJvbLot4SseBEd?=
 =?us-ascii?Q?zCTnCtdNvQJCP0iXehnmk5RG00Ir51BVvJVRjqBq/XxpkQyp4T9RsR+HhBZg?=
 =?us-ascii?Q?3PbxB3lXmzthHqp2foEI0NLNHgW38/nhkjxWOfA0XV9ZUMcfuxelHLHyVuPe?=
 =?us-ascii?Q?uVx9iaEFaaFBgY7F1c5n96tGRbNf5J99xVq7IMV96AHBEMI/qdVzJcqFH1Hh?=
 =?us-ascii?Q?fkkfC6UEwXGG0hKxxWY28fnmS7tW4oPbiaK5NdPddG+hofdimMR3163imNS0?=
 =?us-ascii?Q?TgnyE1Z1gCpt1UWc4RY0QrbtMioupOzayEHwHvG7hCKmx/0nml6UnsFwLVqH?=
 =?us-ascii?Q?5NGLZRhz1IT8c10wJXN1gseWSZCWO2BEnW438/ghcoecOvuZ1EVC9aGi61CU?=
 =?us-ascii?Q?Zqhr56ucxf2PsHDsrgrhzb0Vxoy1BWJc9CnU/MAA3p6IUHxC4ngQ+TKwH6ou?=
 =?us-ascii?Q?SxfC2qti/9HUkaRo57JDIiQkCH53N52pyKpIGJgriVWcZLsYM3UNHYic6YSv?=
 =?us-ascii?Q?fFI7rvHHu+faCgq8bYrq7aIYGAcjGH2aN9cyaUcPWlPomymL7bWAE3k/b715?=
 =?us-ascii?Q?DMVPnA9t9HiJNEXl9MnS59DlRPIKFrqFBsvv/nXrCZQGJGQ9MHLDQy3h486W?=
 =?us-ascii?Q?eg6uffSS0xdrKie86yAjkHdml3Eu8wHsRUrWIgAQ8cIMwRwOsB4mrhoCYpZJ?=
 =?us-ascii?Q?wnrQk/ETViPRip1sLNNKTrmx2JhazG72yyQSCUUdjs/+5kqZS4ekZhtfZIPX?=
 =?us-ascii?Q?q/a8u/Qay8FeY739OGAHkPNmVC7SrzG4DTzSvL2UBIsJIaJA731ESmSXB8Af?=
 =?us-ascii?Q?GmQRTBG7Y+TT/gr+HNbSkQlS61K9I0nhQFQ9Aq2FDXMd6u1eO5CkQ7P+mrbB?=
 =?us-ascii?Q?E9dqC960pU9qg6hmGt88vaV2/RnkotL8u2AbnpKPOE4h79KRe1i4Eg5Nrjng?=
 =?us-ascii?Q?2sLOJbSbasH8z+8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M5U2tbKvtExLbbQewkERUhYEhdQBmT3zRJgeYlXmEJHh5eeMOKTQztDL7H4M?=
 =?us-ascii?Q?3KoN1DbmzMVcVMOsjrWXz2HLv0h6FAI5MB9z6ykb0wz1sF/U8bkB+9WWoJdA?=
 =?us-ascii?Q?etjg+xWRPB7su9lEDwBewKJS7hY9G+Wq3A2M4IY+JYNIyHOJRl2YsEyk0R0r?=
 =?us-ascii?Q?ItBIsO5AEDAIcj6NN8fTLPF4Opie1YYCcC8UTIU1HhWbVW4eRK4GzDLRhY5M?=
 =?us-ascii?Q?vBcbJ9Zf9TWxZDNS9dY2/Bw74q47V3i8BS3x5Gkan4+HboXTHW6cmzcoMVv0?=
 =?us-ascii?Q?UwuiZkv27UK5CQkEVaX4B9V/A2DFG80am2JnNF6GP9BcIRfVyXqUPrlGg6LR?=
 =?us-ascii?Q?MN7dFt1yq4/K/Lp6g0tcewCR59H7YXZ0F3YK//dbFaLC4oWvN2e8vls9l+4L?=
 =?us-ascii?Q?zeLc6QMaXc84ZGXYz5O680HQhUe/bTCe+3vJsjlsKKI4zF10wmE1VmuaMaCh?=
 =?us-ascii?Q?tV2523dOIXu2yNtAp13AZNI1Phquq7yKW52KbbRrvGSJGthUmpcFzkr3Ogp1?=
 =?us-ascii?Q?qhHlqsr618odpZgolIv0YbAx8Te9UsDYKnoE44LYAoJMkXWr7VLQpt9ts3Ti?=
 =?us-ascii?Q?EutyRN2WkrWAIMxVsvbhXqFRfC5C1PpUYL0ozVmOIAJz2PQ7eviUGm3qDjRO?=
 =?us-ascii?Q?I+Cd4lDTfZVb+hIDsBvoQhFEmYj3flceyIUx7tqyXn7z+zzcwHBCYYNAhs5L?=
 =?us-ascii?Q?JETafrFSsAPu0FR7p+rYSkWlNAV8XEyn9zI7iEwu2ekERsEJ9yWCvsaHWQIz?=
 =?us-ascii?Q?yDBlkm29MHGnVhyou3QVG53pCnesB0ygTkvRP5V4dzKETmT+ZDdVOmgAxkcM?=
 =?us-ascii?Q?73RcrXrYV6JyYWj2qaxCyt0Dz6wr1MnvhVFFT3tG6Wgl7MBmjeMuvPmqz5lD?=
 =?us-ascii?Q?uRxMiL2YxdZQM5hBmK1uR/TCv5yOx6wBuqLjZOdaFyKAzJvVaao+aRpe3a2s?=
 =?us-ascii?Q?V9SoydfUI52cpz4XEfZ/e2CMzILTO5OoBYHjXgPILlgHxBHmiY8U3VXpWMW0?=
 =?us-ascii?Q?WVfjwaWc6VPUpW3cR8C72kqivr5w9YpbZcR+Lu17ZUM8oi+yREv4xN4SI8G4?=
 =?us-ascii?Q?1ZatY536fz5l4sVcacF/ljVP2axkohqn4/7hFTlS5DLQEytwzzWXnB4OsA2l?=
 =?us-ascii?Q?B5fxj8uD34JJjUo7QQBZ2TXKH/s3Bm/3rkfxTb7RxtC3YuzogsQbK346JdfD?=
 =?us-ascii?Q?xpTgq+dLBjSNAOHyLB0At0bLlyP0rE+8ucj2B2M0/y4GQWpCgnK/KvRGlFiL?=
 =?us-ascii?Q?nzrtWdnytmFOlQrSP0mcM4wONNi9/kqk472o9L47csRVxgybjgYLBOw+nDp8?=
 =?us-ascii?Q?hG0rYsa9kbMnqwxofN81JCMCyI0n5P33/vXkiNt914lhhKgjGCkuvchnp0t0?=
 =?us-ascii?Q?6QOHDk07Q70r3dTpVi1VSIzJiryghnX9LClAeLyC26vG9+X0khZS+VjHIEi7?=
 =?us-ascii?Q?w2ZHoWGaSSicfG8zLYC0RsmPQnTi6HsoUeFq289Bai4u3IF2L+eseD4JWw5g?=
 =?us-ascii?Q?9YyKPAJKQeqFGumR7ojvv9lzP3EAjwwxbkOIPRJtKCYTUmnchm3vMfA6W/yD?=
 =?us-ascii?Q?APKuAgZ1Uq7vjE5wOjQjCl2/bozzteXqh04ENNtb?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b60882-c8a1-4745-5501-08ddf20b7794
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:48:42.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOpxi78JSrgQjEh0zoRp4MNB1jdxQnkROvc3uf+hFd00eJYLVi6FkhR+GZUksX3zSrC/g9iIQN+QEgNqnLqIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-Proofpoint-GUID: XbxesGsATqhUUooYVs0EueKvUbwtfx8z
X-Proofpoint-ORIG-GUID: XbxesGsATqhUUooYVs0EueKvUbwtfx8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEzOCBTYWx0ZWRfX70T5B9DgK2l9
 ymI3KSAymRLLvJQzedJAe0oQ5m0G//Gpx/2/BJFvmQ4QHyG7B3F0G+4E/VmELPbhLgsGHIdGyOn
 HmeGWFzS0X0P5jH/rh5+85JYC95xPx4FIxhwNLbU4BpzrUK9snsSxfzt52TZVETAi/RH/eYPKuS
 4K/mpy3h+AZZsTZ9S91GY2mLJw4WOQ2v9WaA5dov57G7lhBI4Y93LIyesEUNt3B1+1J1hWlqxFk
 4WYqG9pbPQMu+IrCeClxHBM/TYiUeRCcb9hwtDcd4RgFxOB+Q/oaXqSaQIjkP/NLNqzGMrvyCj1
 5/VoR7e1bDWdvbDwew6/pdSPKEDaLk1q3BdT7EbQczEsxR12LjYLNnbzKMZUJM=
X-Authority-Analysis: v=2.4 cv=AMtZH25w c=1 sm=1 tr=0 ts=68c432cd cx=c_pps
 a=FMzp8OqCp2tFekhue/BAgg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=MTtcyb2QTigsdxIEa_8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Sep 2025 14:48:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2185

CONFIG_REISERFS_FS_SECURITY has been removed since kernel 6.13[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fb6f20ecb121cef4d7946f834a6ee867c4e21b4a

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-kernel/linux/files/selinux.cfg | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-kernel/linux/files/selinux.cfg b/recipes-kernel/linux/files/selinux.cfg
index 8333a05..bbbb180 100644
--- a/recipes-kernel/linux/files/selinux.cfg
+++ b/recipes-kernel/linux/files/selinux.cfg
@@ -16,7 +16,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_SECURITY=y
-CONFIG_REISERFS_FS_SECURITY=y
 CONFIG_JFFS2_FS_SECURITY=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
-- 
2.34.1


