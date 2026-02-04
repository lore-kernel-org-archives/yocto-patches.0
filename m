Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C30E83EE9
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 07:49:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15026.1770191354239677928
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Feb 2026 23:49:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VlwfVL5n;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6495b72fc6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144t1aO974427
	for <yocto-patches@lists.yoctoproject.org>; Wed, 4 Feb 2026 07:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=MLEvbSgWK1w5omQKV3+c
	ffcyz5dyokueH4P7TSFhi5o=; b=VlwfVL5nq0DMQ91q3R5hoffiLnT+3TJUEmnX
	kCF4IcVsu7l9J5p/eMoZ0PBdj4lpqCr6iAO4stOMoxwEhwMjU5nUkSYUxK0heaK+
	uuim3ui0syjNhYBzeJHfn5kgr8dSq6R+nqaQLxjldjQ4yXr5gC0pqT5hUY2p9GkX
	E07yZOJ1xApem9Mmr9Pm+NGVOueKX0aPOJ4CatbkyAL5oJqoa5hhZSmdBfW/sWA1
	MaQadREQ5NCmrZbQeDgG8okAV1iQfSvI2KZuV1anMVfKAYe+rmtzNMys4BB/csAD
	XScgYRGyqvkepQMShXXVwwLppcSJ3g2/INz+2Mc9e3tvRCleqw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c3vc2r8ba-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 07:49:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqLviGpR7cifMGQsjTp9viQdSU+DUQy2iDyXgln7HWdfyNlSEK3ZckvMkoGiLckYFBGFmDz/UcyLHr8ur3m2BWxs+X8bM1ya3Tgn7onowQc64bSPdRwFNX2ATn4MWsujfWOd4BH/fdP3lYENM3Ru8uvRMd/rET0hce3+BcSHnQRUr7F1zksVO+hr6jbaQegiA1DyYxrT2m66luVs4BNP2UO+tuP4W6GRFC9JUrRCiVnJQ2f/wOb2J5aVnWAdf2q78GeD3SeEymesN/AwBKzOt4m14ZxSgVK03dicA4Za5oFcsBjmOHFSkXUwzkBHzS2bsYzyQDjMMLAOUBR9TNdjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLEvbSgWK1w5omQKV3+cffcyz5dyokueH4P7TSFhi5o=;
 b=S4RrmtHy2DzpIb7qO+5lcfwWIZ2SgAyv//+8eAUbtD/ZpLcRlgkyQ2f/sI7+GYHarYY9IRBI4bBGhyNmptF28OCoeCcdAzUHfqugXQaWlbfMgCIv66aydbw21haJhj/mfhMBd9B/9eShJl6aDzifiNRKojhwNnsRgtCRXHvc9g3mey5YG4Vs156y6V3polGMemyU0OiI4qtQXJ5x952KowxqWx0eBxs1aY0eC5wkEjLlnIVaSvEQlw+yR3gzPDNXPntkHkRQgYdVvzNvOKbKx1ixhmfqLFj4rgOAUCnqmXvuA3q5GC5p5HVx+ks2tcJtilDDBt2JwqTeQSN74YJm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB8061.namprd11.prod.outlook.com (2603:10b6:510:250::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 07:49:10 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 07:49:09 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] selinux: upgrade 3.9 -> 3.10
Date: Wed,  4 Feb 2026 15:48:54 +0800
Message-Id: <20260204074854.3080384-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 452f5652-ff28-4210-e026-08de63c1e184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K+lbfzZCddVQA4ddVCWcMN8jF4BshPCty+kVHAbTBAxOm8q4+bo2SmYYgfyN?=
 =?us-ascii?Q?KNzjJXDxxE4kp2vPf0Wddva/eIYJPuqH4IAOoIT33W8pcGhi9PaCFcn0IDCW?=
 =?us-ascii?Q?xGHauMYMglbhge/CWtOEupi4Cej1HDt9a+OB+oMuuwcg7JWJ5hBe/uICZrEQ?=
 =?us-ascii?Q?CzlnX/EI5WxN++sW3YFwAaCsYgAfPIk8dddkgD10wYwWjocUyUr30xJnxL4G?=
 =?us-ascii?Q?XGbsUyWMkhWjEwiu3KTXBje7vsdcTR0Y6JAQUMlrrYWBoXPRp8eYQR3wjwq2?=
 =?us-ascii?Q?qfSjZRQu72vQr3UxnCmJpa9Mg6J7/DZh+6LB85w2dVvWTPYYUVtnY2Tx4bpb?=
 =?us-ascii?Q?ZLFHjNt9gNDjQxIkzeeyHSXGK5ogX2K+OkqgoPsV9l41TUeLaQfw+QepNQ+h?=
 =?us-ascii?Q?zlXzZBmEHod2zhi1Bzj61kCcTiuDN71+1Y3TXg6VjBF3N1UmPK5gTslgnW6e?=
 =?us-ascii?Q?4eZIP9Tkq/+uZxvmrxGD+yryM9QF+x0ZwZlZRTS95etA9eMF92l+8UE/RyA3?=
 =?us-ascii?Q?lw35AaJ/STPbqrum7eUC4lllb+8XuSq4cayYkt745Gji7tSSYHvkGI6RfnT3?=
 =?us-ascii?Q?af8SGetGq02VNpN2HCOjQW+VhmYhXa8Fz7npyABeGdANOeQ4T5Zw/G2g+XZQ?=
 =?us-ascii?Q?WqTJ5rtP/kiFkUHLV4JvzNvce9+8v0rG/J8m0IzqwHwjz426c4rk3f8V4wGS?=
 =?us-ascii?Q?qQbP7cJEmEH3Bxzjvdacvb5kR/AwRkH5wb3MSoVz9o+tMGn+ym6etdTugpGs?=
 =?us-ascii?Q?UjM470Fn0uqdxXpaFF2t9wX5JLmlM1WMBPO7TL6GFGPibzK8dfFdMqJYBkwL?=
 =?us-ascii?Q?5n5TE1Q3qxs0tp2l0ixd0xzTd6sErpptPTEczG2ImGLrVfxAA2fIPTSdoJdS?=
 =?us-ascii?Q?yzxhTZPe1rvFBSyUN2TPTa19UJSBXuN/B5j/WunEhrpbZaFTKRS9cCNSWRNU?=
 =?us-ascii?Q?6I1a6AqqRp69sOlID0LhLmZG2PejpEnmHzNG2LHW/C30DqqWeTdWNuzlSWfW?=
 =?us-ascii?Q?h6nDQeF4Yu6YYnDYR578k13ngGh0kb81Lw9oNIf5MYouD4pVZSd3fbKo+86x?=
 =?us-ascii?Q?VU7Upo3l1MzoB/FCSUlhIiGVF1Z7DTIYoTdZ+dEv43ZQM00+AYuOAb/s40GR?=
 =?us-ascii?Q?oOi8iqOzmW9WS1N6X8qveLY8iYbladgFQgsFmq1y/s0MXxmWIEs+1WDwm3nH?=
 =?us-ascii?Q?51ZlAGHGTQxQyGvve5I0iH1jYX5QYI/P7zHjttOZx8dYTOxuWS5mR1qCV3i4?=
 =?us-ascii?Q?jDhHuCaiiGIE9j3IWVbKYmDFMOqCkvgY8uEQ8UAGJ7rSpYd1zempcSIAIsOU?=
 =?us-ascii?Q?ayy3R1zEGRh3N7xgUgM+jjGqgF+q8A24foCIMbeUgolDz8GmzQkMPQPT2wRJ?=
 =?us-ascii?Q?AAR1hsJBgujzuBoVP+tHbgfzTTLY48Kyj2x4xAeZCzv6ajyrc8/qcogWsM9X?=
 =?us-ascii?Q?WscEpNmW1pv19UZnFt7UVaKLDc+1dGVyCwyjiRr+QG2M1VKx1XgZCo0brOWn?=
 =?us-ascii?Q?zQZXm3gqrZhP7VhEHO+iOEXMx9/E7przwzfedSO/paFbC3KotniubLneZLva?=
 =?us-ascii?Q?Uvve77Lxsvehy8hG4PR0hF8GPhuDCDC+dwQbvak4S3+2xloq0h7F1Sl9tEkr?=
 =?us-ascii?Q?q89/P7jMJ2pMwXNs0EvbS/ofOAHuY+YG6U5j223NRBt9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qghzSMAlbefpId4a6xJfIZ6FkAKpevVsZCtirBSm6MJLQt1lOr05v14sWL9/?=
 =?us-ascii?Q?4D7t+6rv+rAF1015qCyO/gRhPPH3VLD0EkOSgOisaFeK6Nu0whZVZx7TYd9i?=
 =?us-ascii?Q?WzM6JZrvfCAAWE7/W58phuf4sZnZV8785hrUwxKQbWRnYwzFSGKL+1w2HVYF?=
 =?us-ascii?Q?AjAZJd5pCwuNS8eY3+Jbi8XBOshX6Zu4zd2tR8f+VWnCxqQnjikMl8ijY0Mt?=
 =?us-ascii?Q?fNBf493TtAGmnhoxDGLwfzxnbqRrxGElguiAdvmxEJGNBskTPqswKl5xszFU?=
 =?us-ascii?Q?w1n6t2FBmA8ADSgbYq8d06l/TtMbmh9uo/ZfoimjYPXNuXnVxM3dfmzIhKf6?=
 =?us-ascii?Q?W9s/0XPwxzLBaiGwkYUt105Vc9mQtnM4DVvcIOdqaPpE3bAF41POmz6oIX7R?=
 =?us-ascii?Q?4JcrgaSpQSLvsg8RqH61kEcq5ZuKsDVvb7WTtiTyma7hwHTJiFrmckbR0T73?=
 =?us-ascii?Q?S4RWYTuh7IUUk3XgCZx0D8LgnvDgySi8avITy8YR9ByKqcRYBa7vyN1S+PLr?=
 =?us-ascii?Q?8jYTvgEBM4CorcXcTysxlb5Yub1WoBeK4J1b/C/vxLOKsWJw3rNrZKPchk45?=
 =?us-ascii?Q?1WfW6gqWqR7fzZ7h7bQUkkTA5dPCCNe9zOTrklUq9pFYZU6R9SSsrllA0L3A?=
 =?us-ascii?Q?CuLgatrb2VQrQ6gfvJWYEG5FD9LVOJZO6lTD+4t7huyfUQnI+U12pVD46PjC?=
 =?us-ascii?Q?TBpgLy7gUBEDGOzv0j8UmEZVrtKX81RHhZUr99x77j3V1TQaX7uAec1hGObW?=
 =?us-ascii?Q?RAhfI4zPFxpUHj6joJYVKrTPM+fuP11m4Out4NNP4oAqAFuAwTzHkMPX8BQu?=
 =?us-ascii?Q?SN8hmyiQHHK4+NMymEeGAL5p7xD0EHnUuq3R/WuDxrQ04ybGbj3p9B6YOh4J?=
 =?us-ascii?Q?DXLHjU80tahNeFJ4S9KKif0j2U0YlZ8dxErWHJh+Rllhb9QufqkoQ4gdqRUs?=
 =?us-ascii?Q?6tD42oxiDblCh3seFsRA3j/13sAWMj6F/BOPXWo9HvY9ebHopMJXhmyGzYl7?=
 =?us-ascii?Q?aOquWhF/KjFP465mwvny4BzEncorhl6yM2G/QS2SRIZ99SWinLsWFBar+4rV?=
 =?us-ascii?Q?cMwOiXRGt3ywruMK3JK69PddAnj533N4kox2Md2+iwYnJJqbxxSzXBhSIPfD?=
 =?us-ascii?Q?JNwK+jSqo4o5IzZsJKdoCufCDFybkS3+/+USRSway/68iQDeIIgdkFlieyi2?=
 =?us-ascii?Q?CisRA9VYFyXRhbNrsBE+E8LIFipZTxZERLKg2+bUSjXUiP34ClwZn68ncOYZ?=
 =?us-ascii?Q?U18am42Y93X2QNvzYvszv6PITsGhicdVaNI4YNtACibKUB2xi6/3NBNbVunV?=
 =?us-ascii?Q?8bBj4zjlgQ6J0WDjhFHAv6ZmLvr9lbAQK+GdC7ZV7lUx5zAPGIeiXiRQaVHy?=
 =?us-ascii?Q?awVSODlqSVwG7Pifxm/j+ti/rnTxwGs7pdr53I+j4aRDRY5wr0in+RjmOfL/?=
 =?us-ascii?Q?ba9gO2LsQ7/Mz0LGh4nO+X2bkpdogIQt3ksl2Dh2m7IaerPqWXusxkrewxnt?=
 =?us-ascii?Q?IBc591ZFAWqOBGYTuwUOTiESVRMfW84Q1heBVLKVMX0NWKohpi1T2W+PvQW0?=
 =?us-ascii?Q?SxKuKjWJjs4PbjYNUe3rZYql4cu6UWTCkbnrVY7SkWy57R59eb3yqFik4W6Q?=
 =?us-ascii?Q?S5X8aOJfuFkJIjg2yTU0v3xh/GKZl7kJsy9DZ+Ouy6VrEOi2eqoEvXvWCXp1?=
 =?us-ascii?Q?cuBhF1Ogzz2oBbFtyHqLw55sFEyOj/U4N1XvyBy/KWiHLPMBjcTddKB5QLmh?=
 =?us-ascii?Q?bKbBtklc3g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452f5652-ff28-4210-e026-08de63c1e184
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 07:49:09.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNHtKiGmZOkQ6FzHvQ3G7lCIIvvDU78ptnvCPyurMcwOtiw1GHffEZr84fQtWFOMkRxOtHLnYtwqNouygmYgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA1NyBTYWx0ZWRfXzF2xpzkb9OCT
 igHFd92UFWwA+9vDDJAyh7L45TH7N52n3AMwvi//5TE8pTmHkfyt0wZfJ8WCN0VuyDHJltT0N+m
 aXvIkCWeGdVsjj3q6P7+3ParMdEvMmUht6IR9sqqg4k87p0Atojqa9b5xfQqi6dXIAaFwvsclnv
 0e/9xG5b1L2aPkemBLcKQ2s9W9iW8xsXPILkvHb3ciWZPBMGdHbhhGrhNbtQnBoAfw6uOHTbvNd
 f0eo5UYei5M/0XhLxrAMGGdFlejv/P+qF6EmAD1CgvXYwT8z6e9UZE/5pHzvZfF28Fc6gXxPK+w
 b7uoJ8vLxOrNrfLYVIlbl4CiGDrwp6McR/mwDWNd4BLio/7O5AyfqCNorDGMbh8S7WtS5yR0S1Z
 +yr9sMPkhWWT6KLwQQVbX+DZ1uwNRi9ZuLeJfuOBzi1O8yi6Da7hbWqlzUsKgkvCI4ZB2u5H2dK
 73RU1P/WT0beog4RUPQ==
X-Proofpoint-ORIG-GUID: VHEuzfjj0908k0Kgl4qvwciXeOFvqOTW
X-Proofpoint-GUID: VHEuzfjj0908k0Kgl4qvwciXeOFvqOTW
X-Authority-Analysis: v=2.4 cv=F8Zat6hN c=1 sm=1 tr=0 ts=6982f9f9 cx=c_pps
 a=vNEawcoOGvNHZjwsohOJ5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=P-IC7800AAAA:8 a=9pIZn19CAAAA:8
 a=yP_eYDbHNflaNDQR3wYA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=8RSB8XlrRKoi1kmjPpsj:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_01,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040057
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 07:49:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3180

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.10

* libsepol: fix TARGET and LIBSO on Darwin
* secilc: use correct long option name for -X
* Fix problem with bounds statements in optional blocks
* libsepol: Fix processing of levels for user rule in an optional block
* libsepol: Fix problem with handling type attributes in role-types rule
* libsepol: Fix expand_role_attributes_in_attributes()
* Allow type attributes to be associated with other type attributes
* libsepol: Support functionfs_seclabel policycap
* improve semanage man pages: Add examples for -r RANGE flag usage
* libselinux: fix parsing of the enforcing kernel cmdline parameter
* seunshare: always use translations when printing
* treewide: add .clang-format configuration file
* setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
* libsepol: add memfd_class capability
* semanage: Reset active value when deleting boolean customizations
* python/sepolicy: Add support for DNF5
* sandbox/seunshare: Replace system() with execv() to prevent shell
  injection
* libsepol: Tighten checks on MLS range and level when validating
* libsepol: Fix potential NULL dereference in policydb_read()
* libsepol: Fix potential use of an uninitialized value in link.c
* libsepol: add bpf_token_perms polcap
* libsepol: Fix possible use-after-free when expanding attributes
* libselinux/src/Makefile: build python module without isolation
* restorecon: Add option to count relabeled files
* Bug fixes

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../selinux/{checkpolicy_3.9.bb => checkpolicy_3.10.bb}   | 0
 ...libselinux-python_3.9.bb => libselinux-python_3.10.bb} | 0
 ...file-fix-python-modules-install-path-for-multili.patch | 8 ++++----
 ...ot-use-PYCEXT-and-rely-on-the-installed-file-nam.patch | 6 +++---
 ...elinux-restore-drop-the-obsolete-LSF-transitiona.patch | 8 ++++----
 .../selinux/{libselinux_3.9.bb => libselinux_3.10.bb}     | 0
 .../selinux/{libsemanage_3.9.bb => libsemanage_3.10.bb}   | 0
 .../selinux/{libsepol_3.9.bb => libsepol_3.10.bb}         | 0
 .../selinux/{mcstrans_3.9.bb => mcstrans_3.10.bb}         | 0
 .../{policycoreutils_3.9.bb => policycoreutils_3.10.bb}   | 0
 .../selinux/{restorecond_3.9.bb => restorecond_3.10.bb}   | 0
 .../selinux/{secilc_3.9.bb => secilc_3.10.bb}             | 0
 .../selinux/{selinux-dbus_3.9.bb => selinux-dbus_3.10.bb} | 0
 .../selinux/{selinux-gui_3.9.bb => selinux-gui_3.10.bb}   | 0
 .../{selinux-python_3.9.bb => selinux-python_3.10.bb}     | 0
 .../{selinux-sandbox_3.9.bb => selinux-sandbox_3.10.bb}   | 0
 recipes-security/selinux/selinux_common.inc               | 2 +-
 .../{semodule-utils_3.9.bb => semodule-utils_3.10.bb}     | 0
 18 files changed, 12 insertions(+), 12 deletions(-)
 rename recipes-security/selinux/{checkpolicy_3.9.bb => checkpolicy_3.10.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.9.bb => libselinux-python_3.10.bb} (100%)
 rename recipes-security/selinux/{libselinux_3.9.bb => libselinux_3.10.bb} (100%)
 rename recipes-security/selinux/{libsemanage_3.9.bb => libsemanage_3.10.bb} (100%)
 rename recipes-security/selinux/{libsepol_3.9.bb => libsepol_3.10.bb} (100%)
 rename recipes-security/selinux/{mcstrans_3.9.bb => mcstrans_3.10.bb} (100%)
 rename recipes-security/selinux/{policycoreutils_3.9.bb => policycoreutils_3.10.bb} (100%)
 rename recipes-security/selinux/{restorecond_3.9.bb => restorecond_3.10.bb} (100%)
 rename recipes-security/selinux/{secilc_3.9.bb => secilc_3.10.bb} (100%)
 rename recipes-security/selinux/{selinux-dbus_3.9.bb => selinux-dbus_3.10.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.9.bb => selinux-gui_3.10.bb} (100%)
 rename recipes-security/selinux/{selinux-python_3.9.bb => selinux-python_3.10.bb} (100%)
 rename recipes-security/selinux/{selinux-sandbox_3.9.bb => selinux-sandbox_3.10.bb} (100%)
 rename recipes-security/selinux/{semodule-utils_3.9.bb => semodule-utils_3.10.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.9.bb b/recipes-security/selinux/checkpolicy_3.10.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.9.bb
rename to recipes-security/selinux/checkpolicy_3.10.bb
diff --git a/recipes-security/selinux/libselinux-python_3.9.bb b/recipes-security/selinux/libselinux-python_3.10.bb
similarity index 100%
rename from recipes-security/selinux/libselinux-python_3.9.bb
rename to recipes-security/selinux/libselinux-python_3.10.bb
diff --git a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
index 9bb9acb..8002149 100644
--- a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
+++ b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
@@ -1,4 +1,4 @@
-From 985a3e50fe2f80f47e3ee71ad74b72f3b4ecf7c6 Mon Sep 17 00:00:00 2001
+From 644c2eb918d3a7f2281325e7dcb6d4e33266b91f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 13 Apr 2020 12:44:23 +0800
 Subject: [PATCH] Makefile: fix python modules install path for multilib
@@ -11,15 +11,15 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
-index 261c22d4..edb3ca06 100644
+index 0dbba7f4..d8011c99 100644
 --- a/libselinux/src/Makefile
 +++ b/libselinux/src/Makefile
 @@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
  endif
  
  install-pywrap: pywrap
--	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
-+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
+-	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
++	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
  
diff --git a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
index 1af4435..b6bd671 100644
--- a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
+++ b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
@@ -1,4 +1,4 @@
-From 1bb35bc277129c976bb480a05de91dab346c84c9 Mon Sep 17 00:00:00 2001
+From 9d62321214b87fd91f8aa5dcb4ca1768ed07a255 Mon Sep 17 00:00:00 2001
 From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 Date: Fri, 25 Oct 2019 13:37:14 +0200
 Subject: [PATCH] Do not use PYCEXT, and rely on the installed file name
@@ -27,7 +27,7 @@ Signed-off-by: Changqing Li <changqing.li@windriver.com>
  1 file changed, 1 insertion(+), 2 deletions(-)
 
 diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
-index edb3ca06..8da3f542 100644
+index d8011c99..c611422d 100644
 --- a/libselinux/src/Makefile
 +++ b/libselinux/src/Makefile
 @@ -15,7 +15,6 @@ INCLUDEDIR ?= $(PREFIX)/include
@@ -40,7 +40,7 @@ index edb3ca06..8da3f542 100644
  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 @@ -200,7 +199,7 @@ endif
  install-pywrap: pywrap
- 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
+ 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 -	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 +	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux*.so $(DESTDIR)$(PYTHONLIBDIR)/
diff --git a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
index 5dad436..2c7a70e 100644
--- a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
+++ b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
@@ -1,4 +1,4 @@
-From d555e83f8ca2482c673981250d72fbc4ce29c44c Mon Sep 17 00:00:00 2001
+From c4cb7a15e3f5c4081e3a459f15da3e58449cc4de Mon Sep 17 00:00:00 2001
 From: Renato Caldas <renato@calgera.com>
 Date: Thu, 29 Jun 2023 13:59:11 +0100
 Subject: [PATCH] libselinux: restore: drop the obsolete LSF transitional API.
@@ -14,10 +14,10 @@ Signed-off-by: Renato Caldas <renato@calgera.com>
  1 file changed, 2 insertions(+), 2 deletions(-)
 
 diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
-index 39eabeb9..128aff4b 100644
+index 8fadf4d2..f23bad0c 100644
 --- a/libselinux/src/selinux_restorecon.c
 +++ b/libselinux/src/selinux_restorecon.c
-@@ -439,7 +439,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
+@@ -443,7 +443,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
  	file_spec_t *prevfl, *fl;
  	uint32_t h;
  	int ret;
@@ -26,7 +26,7 @@ index 39eabeb9..128aff4b 100644
  
  	__pthread_mutex_lock(&fl_mutex);
  
-@@ -453,7 +453,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
+@@ -457,7 +457,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
  	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
  	     prevfl = fl, fl = fl->next) {
  		if (ino == fl->ino) {
diff --git a/recipes-security/selinux/libselinux_3.9.bb b/recipes-security/selinux/libselinux_3.10.bb
similarity index 100%
rename from recipes-security/selinux/libselinux_3.9.bb
rename to recipes-security/selinux/libselinux_3.10.bb
diff --git a/recipes-security/selinux/libsemanage_3.9.bb b/recipes-security/selinux/libsemanage_3.10.bb
similarity index 100%
rename from recipes-security/selinux/libsemanage_3.9.bb
rename to recipes-security/selinux/libsemanage_3.10.bb
diff --git a/recipes-security/selinux/libsepol_3.9.bb b/recipes-security/selinux/libsepol_3.10.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.9.bb
rename to recipes-security/selinux/libsepol_3.10.bb
diff --git a/recipes-security/selinux/mcstrans_3.9.bb b/recipes-security/selinux/mcstrans_3.10.bb
similarity index 100%
rename from recipes-security/selinux/mcstrans_3.9.bb
rename to recipes-security/selinux/mcstrans_3.10.bb
diff --git a/recipes-security/selinux/policycoreutils_3.9.bb b/recipes-security/selinux/policycoreutils_3.10.bb
similarity index 100%
rename from recipes-security/selinux/policycoreutils_3.9.bb
rename to recipes-security/selinux/policycoreutils_3.10.bb
diff --git a/recipes-security/selinux/restorecond_3.9.bb b/recipes-security/selinux/restorecond_3.10.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.9.bb
rename to recipes-security/selinux/restorecond_3.10.bb
diff --git a/recipes-security/selinux/secilc_3.9.bb b/recipes-security/selinux/secilc_3.10.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.9.bb
rename to recipes-security/selinux/secilc_3.10.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.9.bb b/recipes-security/selinux/selinux-dbus_3.10.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.9.bb
rename to recipes-security/selinux/selinux-dbus_3.10.bb
diff --git a/recipes-security/selinux/selinux-gui_3.9.bb b/recipes-security/selinux/selinux-gui_3.10.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.9.bb
rename to recipes-security/selinux/selinux-gui_3.10.bb
diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.10.bb
similarity index 100%
rename from recipes-security/selinux/selinux-python_3.9.bb
rename to recipes-security/selinux/selinux-python_3.10.bb
diff --git a/recipes-security/selinux/selinux-sandbox_3.9.bb b/recipes-security/selinux/selinux-sandbox_3.10.bb
similarity index 100%
rename from recipes-security/selinux/selinux-sandbox_3.9.bb
rename to recipes-security/selinux/selinux-sandbox_3.10.bb
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index 1c5e158..a7f704d 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE = "https://github.com/SELinuxProject"
 
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
-SRCREV = "919e9e64cc4b20f5a1e4df1e38cce1bfe15aff09"
+SRCREV = "ca10fc4204ed60540d41d2499127c18ad0643f9e"
 
 S = "${UNPACKDIR}/${BP}/${BPN}"
 
diff --git a/recipes-security/selinux/semodule-utils_3.9.bb b/recipes-security/selinux/semodule-utils_3.10.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.9.bb
rename to recipes-security/selinux/semodule-utils_3.10.bb
-- 
2.34.1


