Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAC4C87FC9
	for <webhook@archiver.kernel.org>; Sat,  2 Aug 2025 04:53:12 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.958.1754110383465515725
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Aug 2025 21:53:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=030952ecad=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5724HCoW1135936
	for <yocto-patches@lists.yoctoproject.org>; Fri, 1 Aug 2025 21:53:02 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 484ta1y557-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 01 Aug 2025 21:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABvOOt2prXdAj3h0/1Y4iUuxPQQ8A1HzJExH1x1kHki23lwVW2seIICONU6Xlhmv7+tsNh3tn8SysOZxbIGji0QwV5iHrpDYehChA2cCfrg0NILRvrKA1MsP7wauvjyk73qOTwiTGmCo/ypaDADtc5LzflcyC0N4Ax9AbNuenUzGG5K74T74zY4Fn9FFEwW3pima4v5Bq0F4eIcuxM8mUhp/amCQLOVYFN3iBQavHHg9sLmJ9NbNb+y+YZjIDaADZXKuyYvWMqcgiq9ahfrwsOwPVAveRNwlUcfGkyqxtaClipukoD7V0IF8JvZ1+1MLaOXiYRUs/OCj00mQjGJXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiyrwYbpVI5sBGVPWrbT/oQt8JCRnOpaGF/1wOjpjIo=;
 b=eKp6XgQT/lfpdOj7EWh3AgmSAekL250gy5eEWqdm3ux/JBFPLRk8ofnVCb66/iN7uzamvDv1BxA8YHdu1xBkH+9NKJ36m8tnJoqQUaBSxwtXL7t8bz4FfGQM3i3si1P0n0fQX7pUXrVSkZLfCsgOrw4FlTU08Lh69ndG8veVO2JQxRCMH1sX98Fe1lDsdxTdOwpDz1TO6OpWjxyUbMwHBfvwYkIS4CGzagLZQkZ1UVIpRbxewGUO9+mDFNn9NU+t3Vs4pZo1WIZeGBewcB0RG9/GEXfSit1mlyS7PBGAvlhXF8I+2XfjZlIaT/sOfn14B/DxGJ6R7c0e1LmTqbmYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Sat, 2 Aug
 2025 04:52:58 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.8989.010; Sat, 2 Aug 2025
 04:52:58 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] selinux: upgrade 3.8.1 -> 3.9
Date: Sat,  2 Aug 2025 12:52:42 +0800
Message-Id: <20250802045242.2612241-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH8PR11MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e714b7-10cb-4dda-47b6-08ddd18073a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8AN6xEOpFz5MhF2MeqHBPCiGLBo/meOyd5vvLXDqtqhx2eNkGvWTlx8XmMaC?=
 =?us-ascii?Q?d0GTIIkfbXvIfv02kr1vx6B9I2Xok3QXQvTyXm5pH4/xt4RgdiYcr2HYaaZ6?=
 =?us-ascii?Q?/n3vJ7kWz8yaPsEkLyH83zyjVMCIrbCrCzC3IVGPy/7lAmOrEdCHQV3EQkg8?=
 =?us-ascii?Q?zTdRYUAHIhJUyk7Z4VeSLRcRJfR/o1FJ3SD193uMLYx5ItTT2pGDNqSzHkYR?=
 =?us-ascii?Q?a2epSGYl0d4mbXcY8Mq1/fdgfMNNfIMUCEgBmgw4NEshDTrSiQXO1avDrDOo?=
 =?us-ascii?Q?QkcSvJbPDdCUDRI1IFN6hQTyhZSXWtK8kXkoYUIhseiBUGN31s821lcRf5Tb?=
 =?us-ascii?Q?gMEni0EO/IsKdvq4pwM8aSP3S/qtngvwBKUgidORZQck2bGQCxX7xOTtdW06?=
 =?us-ascii?Q?iDQ9qpgeGjENjQgbTQs8xCEgitZx6CCoh7Sr9bZmB0oUx1kOGGWQGM73UDdd?=
 =?us-ascii?Q?uOMJzx+iWcDJjEBrcIZbw/0+MUEAlZGW4IHEH6RsWOIaql6/KjndzHGN3XMl?=
 =?us-ascii?Q?wHNM1p4HqNOA8j5tL2DPHKbFNWgR/Q62sIdoFrXrHIG/ISk8v2MrGuA5ceM6?=
 =?us-ascii?Q?zTY3NeRx6zlbWTpMxgVgOq9SiH2BvXeYno4RfdZvxwtmcno4NybrEol9uu2K?=
 =?us-ascii?Q?QsiAhqMyRWc24GaXGIbBpk8gs8bEzdh6P90g9Fh8mhZqmUcZWxo6epakEdpU?=
 =?us-ascii?Q?x4jDm6AxglNGUkLhMfhd1eoW4Wml4yhvMi1HkVk1uFXzfvY71yGrKD7trNai?=
 =?us-ascii?Q?ALNY9sKRE8VPOKFNO6onXzxzfUKRDp5gDT9+K1ObvRJfjiEo2zktVerDFlwr?=
 =?us-ascii?Q?d42/uWlOSoY6CFuxiChYDVr2pDSB/YUNmf1LcFoju9TqFeZXYIeE8W9+mnTt?=
 =?us-ascii?Q?KXwZQxX7RhsWghnkjY3tdWrlizaB8iK59QdajM2RMoJrw8/q9wYyhaAILfNk?=
 =?us-ascii?Q?RcsUy9vtNd2A+brauxCqqotBDm6j7jJf9/KEgM7HLaRjOluyKEhT/tgBQCNo?=
 =?us-ascii?Q?wuHIZbwGgNk2w8EtdtSbn+wLTIMfU+dPWO7VrVtys6rVwpzKl5Ia8uCoDVaU?=
 =?us-ascii?Q?WdqLf1vjT+sBnehVAIDe9eTwhgbTnEnBxM73Av+89/qpzOCg4cmjTqielkm9?=
 =?us-ascii?Q?TQlHHRed4o7Pg9L1Yg7P6+p2ONknZx/hs0/+yZxK2WYsdOnu8LxmQNpxDT65?=
 =?us-ascii?Q?wiA9sbJy7lUyfuvy3VRu0WXc7iFwFmVY49yIkIyXnLKmA1a3bilG/1MWMit9?=
 =?us-ascii?Q?YFKJhTLY3jRXaetg/ohpRTyESVfD5p6vVQM8V3F1FaJ1xEHRzLqMIQPTMBhH?=
 =?us-ascii?Q?1+Ip+qZAsD1ZJl6jjlTeIFHHAtuDxs0VMpSffuoVbmZY/KwqBplx4fL1G7Q9?=
 =?us-ascii?Q?+HwiBFPc17EqkwhPkZSuzVcsjH++O28SdjoBtha1jvdiafuWfmuv6yRRMLsV?=
 =?us-ascii?Q?ic4hXkse/+PShHXkirbmubos3FFUEhbUXHUYCeLHU4SzaqyigR14Lg+jL5Mm?=
 =?us-ascii?Q?SugVa5M+gmd1lmQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NFRxMSklwKeE1Q/ZcELfzMO5brwPaxdjpmesdP+hI2FU9CY2aBw9KVlQvFMA?=
 =?us-ascii?Q?tUC4dpb+5Uvfb0eQCPakGeQCeMynAHbDSSHBlLR+ZJD/ENmLofUjoS/dLYDM?=
 =?us-ascii?Q?qTxa2sox2KCDv8AYs8MH8HokC6FQZqeBNo3jCUC6s9OuYmULepnhnETuEH/T?=
 =?us-ascii?Q?z1TwbmSuBU2i7/KtXjvOB2rfSensZDp79gHK028cVWd7GbecMZJdSB8zFyS6?=
 =?us-ascii?Q?H7XEtOHb41IOPUoUIcGPK5nUhsSxWzRNJn3mbaKizcwPNOnDIV+Hxmj4A+bM?=
 =?us-ascii?Q?SKslWDDPKU1++ByuVMJPvFT77IpmbdLL9O4DkQ1OLM3pyMKqZMp6t6ofJD+K?=
 =?us-ascii?Q?SIeMxkWEVE2ITa7+hvjtmFdVml4KS1OMBC/NYjjQsPYp+ETSQR3UpACQ5+9j?=
 =?us-ascii?Q?/GdHfXA7uDDV4TCNEPekswkGiILa0I/zzlIraf8S0wRiAoP/V+3COG5aPA2Y?=
 =?us-ascii?Q?+wr4DUNyMBr8Abb7KaltGXT6IMxZMOUl0Xvx8PwS3jPw4zGDmBFdZLpSwQie?=
 =?us-ascii?Q?2vKbo98rBc3HgQKMI3ZrIc4JOCHH3WUe89djtFK0c5U7T/BhzgqO8YdZ35Sk?=
 =?us-ascii?Q?+XqIM8hg8VsBj4duCL99Lnmx4gLZ9dmTStSqbouTse6aalN6elamAAs+t8Fl?=
 =?us-ascii?Q?U95SkwdPTj5/w8L1LpjkIRZDZW5gyGTB0Rk2wFhzloFYTI8sW3N7BbcJoA0f?=
 =?us-ascii?Q?pYp+GSgmWCDtHg8sM0a65GIFysXlFe0b2ImFTKH0hf1XaLGyolf838bua8MQ?=
 =?us-ascii?Q?/QiTLqyB+mNC7Q0zlkU8ZcKuI6GSQNWWcmXfZXQw758s7I+dNT0wotm0wzrg?=
 =?us-ascii?Q?wh1KA8Rm+NLEp/C8ugyKyZReJIVCXx6Y/8pXXGd8Flq5Y3usoTBZXUd/qjIh?=
 =?us-ascii?Q?EpK2/HqnB8BKTji9xPT9cX7X+ZQC7x8KtYXif+Fj1wUJWJBYDpy3ryVfBiKF?=
 =?us-ascii?Q?ralkSi5vqQ5e+lznOoFQ3YE7QznUvr3+GXMw/s3uksBAVRoq/DjM8LPpkhyM?=
 =?us-ascii?Q?hNSyB4TaFKaVxE77tUbnW7AuJ3l+OskXWzp4JRKeC2vgBZrN+/9HCOUPqJtr?=
 =?us-ascii?Q?i0EK9q88KaHvB0oMrJ+T8bZkK4JtMPwwJwWc11L1YWgQaL1t8sx+sN5G7DIO?=
 =?us-ascii?Q?xlLyCsyOpOf82H9YBQIIj9uC7t5yqVBKo301V6ScHqW1Q9NoV1G1RIj/swcD?=
 =?us-ascii?Q?rKVLC7/qsOEbB6VBw5rgN5NkwBldLvM1B0EzjLLbikOBomSsKPArChE9MsFj?=
 =?us-ascii?Q?ahmOj1IQxSmGuJ4xOtAJ7r2Vv62IF1ZP+BP6Yr6Jf2R9fBEvquoCVpcep4yj?=
 =?us-ascii?Q?cRJ/tEQhFMRANkANEDXj5popHgFMF2+fQb2o/x73+MsHoxBOIwtKdGcwy+vx?=
 =?us-ascii?Q?zgJUf27qA2sL9+9rAzYgqYz8mwkmbqNHIW9M49lca6m482TjGPySeMsm8xCi?=
 =?us-ascii?Q?r23PZQIsbGOpGbzt+CHL6KajE1rao8WZN+56gAwM9abFx2sBbA+k3w0NlXYC?=
 =?us-ascii?Q?L5clk9kujZY7YBc7v4l5jIWP0F/SqBrJygWvKGe6OV46JfRbrHtXJwJeN3F/?=
 =?us-ascii?Q?gaezV2KvRXDio5qHknE5WIrC0vnFid3LP2HgvG/l?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e714b7-10cb-4dda-47b6-08ddd18073a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 04:52:58.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9UA2cMwlT4CdYNVJQv3CekrtQOkSdJRoSIWRQPnuQTgHIHpMCfC2JI2628X3HSenn6vMYQagBj9Usvco/u2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-Proofpoint-ORIG-GUID: y-6-qYGABvMspKduX7eJpg8vDZ0Gmg_V
X-Proofpoint-GUID: y-6-qYGABvMspKduX7eJpg8vDZ0Gmg_V
X-Authority-Analysis: v=2.4 cv=OYOYDgTY c=1 sm=1 tr=0 ts=688d99ad cx=c_pps
 a=cuPJWEzJpmcHvA/7N1z2Ww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=PWLdgz7EAAAA:8 a=t7CeM3EgAAAA:8 a=P-IC7800AAAA:8 a=9pIZn19CAAAA:8
 a=KR5XLSZxAAAA:8 a=9Wbp7B8dAAAA:8 a=RjGu0NdU_UGHvzLhC8cA:9
 a=ssoTE2sswLiHqYLQ-bqU:22 a=FdTzh2GWekK77mhwV6Dw:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=8RSB8XlrRKoi1kmjPpsj:22 a=KKIIu8bCiOnaXtcgZrz_:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDAzOSBTYWx0ZWRfX3s1sTBrSqOPe
 JuIthpMsR39Czn/m8xJ7jmScUWUxRP5kLLgKHpbwSDRPunS44ECBJ8Pqqc6VKqNWc6qpoVZGS/1
 jiP+sTUmjb4f8IIle67GYHEjiYZOVurLvZuhiat5jIWb59lJsBlG5NJMhTqN4rWYzTZBTCGnh9I
 j3YM17pYEgwi3SlC8mnOPMQoY9xra1p3VSlr6XXBXhYZ/PCbTqBlrzIAGvx9tvxdcJNE4gtCt6E
 9uUTkA2tt4gG2F45/VqVt5/uy1nWPIOKCHxPT/y9tvlqMTABS20nNsIsEurHAjFFC+RHFzUzLrs
 n+4DyRsSaLl09Fq2uxR8ZHfnE3bNdg4rGVlyvazYUFVzSi9FWqhvHqd6qJKgkfuWsOMtxQ/8aSl
 4eJ1/ORI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507260059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 02 Aug 2025 04:53:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1881

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.9

* Support static-only builds with DISABLE_SHARED=y
* Add restore option to modify user and role portions
* setfiles: Add -U option to modify user and role portions
* semanage.conf: Add relabel_store config option
* semodule: Add [-g PATH |--config=PATH] for an alternate path for the
  semanage config
* libselinux: Fix local literal fcontext definitions priority
* libselinux: Fix order for path substitutions
* libsepol: Add new 'netif_wildcard' policy capability
* checkpolicy: Add support for wildcard netifcon names
* libsepol: Allow multiple policycap statements
* libsepol: Support genfs_seclabel_wildcard
* Replace all links to selinuxproject.org
* Bug fixes

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...heckpolicy_3.8.1.bb => checkpolicy_3.9.bb} |  0
 ...thon_3.8.1.bb => libselinux-python_3.9.bb} |  6 +--
 ...hon-modules-install-path-for-multili.patch | 18 ++++-----
 ...T-and-rely-on-the-installed-file-nam.patch | 16 ++++----
 ...re-drop-the-obsolete-LSF-transitiona.patch | 18 ++++-----
 ...{libselinux_3.8.1.bb => libselinux_3.9.bb} |  2 +-
 ...anage-Fix-execve-segfaults-on-Ubuntu.patch | 14 +++----
 ...anage-allow-to-disable-audit-support.patch | 40 +++++++++----------
 ...-disable-expand-check-on-policy-load.patch | 14 +++----
 ...ibsemanage_3.8.1.bb => libsemanage_3.9.bb} |  6 +--
 .../{libsepol_3.8.1.bb => libsepol_3.9.bb}    |  0
 .../mcstrans/mcstrans-de-bashify.patch        | 14 +++----
 .../mcstrans-fix-the-init-script.patch        | 14 +++----
 .../{mcstrans_3.8.1.bb => mcstrans_3.9.bb}    |  4 +-
 .../policycoreutils-fixfiles-de-bashify.patch | 14 +++----
 ...eutils_3.8.1.bb => policycoreutils_3.9.bb} |  6 ++-
 ...estorecond_3.8.1.bb => restorecond_3.9.bb} |  0
 .../{secilc_3.8.1.bb => secilc_3.9.bb}        |  0
 ...inux-dbus_3.8.1.bb => selinux-dbus_3.9.bb} |  0
 ...elinux-gui_3.8.1.bb => selinux-gui_3.9.bb} |  0
 ...tall-path-for-new-pymodule-sepolicy.patch} | 14 +++----
 ....substitutions-releasever-to-empty-.patch} | 14 +++----
 ...-python_3.8.1.bb => selinux-python_3.9.bb} |  4 +-
 .../selinux-sandbox/sandbox-de-bashify.patch  | 24 +++++------
 ...andbox_3.8.1.bb => selinux-sandbox_3.9.bb} |  2 +-
 recipes-security/selinux/selinux_common.inc   |  2 +-
 ...e-utils_3.8.1.bb => semodule-utils_3.9.bb} |  0
 27 files changed, 124 insertions(+), 122 deletions(-)
 rename recipes-security/selinux/{checkpolicy_3.8.1.bb => checkpolicy_3.9.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.8.1.bb => libselinux-python_3.9.bb} (95%)
 rename recipes-security/selinux/{libselinux_3.8.1.bb => libselinux_3.9.bb} (97%)
 rename recipes-security/selinux/{libsemanage_3.8.1.bb => libsemanage_3.9.bb} (96%)
 rename recipes-security/selinux/{libsepol_3.8.1.bb => libsepol_3.9.bb} (100%)
 rename recipes-security/selinux/{mcstrans_3.8.1.bb => mcstrans_3.9.bb} (93%)
 rename recipes-security/selinux/{policycoreutils_3.8.1.bb => policycoreutils_3.9.bb} (95%)
 rename recipes-security/selinux/{restorecond_3.8.1.bb => restorecond_3.9.bb} (100%)
 rename recipes-security/selinux/{secilc_3.8.1.bb => secilc_3.9.bb} (100%)
 rename recipes-security/selinux/{selinux-dbus_3.8.1.bb => selinux-dbus_3.9.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.8.1.bb => selinux-gui_3.9.bb} (100%)
 rename recipes-security/selinux/selinux-python/{fix-sepolicy-install-path.patch => 0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch} (77%)
 rename recipes-security/selinux/selinux-python/{0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch => 0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch} (88%)
 rename recipes-security/selinux/{selinux-python_3.8.1.bb => selinux-python_3.9.bb} (94%)
 rename recipes-security/selinux/{selinux-sandbox_3.8.1.bb => selinux-sandbox_3.9.bb} (93%)
 rename recipes-security/selinux/{semodule-utils_3.8.1.bb => semodule-utils_3.9.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.8.1.bb b/recipes-security/selinux/checkpolicy_3.9.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.8.1.bb
rename to recipes-security/selinux/checkpolicy_3.9.bb
diff --git a/recipes-security/selinux/libselinux-python_3.8.1.bb b/recipes-security/selinux/libselinux-python_3.9.bb
similarity index 95%
rename from recipes-security/selinux/libselinux-python_3.8.1.bb
rename to recipes-security/selinux/libselinux-python_3.9.bb
index 582edf6..8431ca1 100644
--- a/recipes-security/selinux/libselinux-python_3.8.1.bb
+++ b/recipes-security/selinux/libselinux-python_3.9.bb
@@ -12,9 +12,9 @@ inherit python3targetconfig pkgconfig
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/libselinux:"
 SRC_URI += "\
-        file://0001-Makefile-fix-python-modules-install-path-for-multili.patch \
-        file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch \
-        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch \
+        file://0001-Makefile-fix-python-modules-install-path-for-multili.patch;patchdir=.. \
+        file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch;patchdir=.. \
+        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch;patchdir=.. \
         "
 
 S = "${UNPACKDIR}/${BP}/libselinux"
diff --git a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
index 28a2cc0..9bb9acb 100644
--- a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
+++ b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
@@ -1,4 +1,4 @@
-From 626d07afcb8e8b3a68158e8a3ea1654620769644 Mon Sep 17 00:00:00 2001
+From 985a3e50fe2f80f47e3ee71ad74b72f3b4ecf7c6 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 13 Apr 2020 12:44:23 +0800
 Subject: [PATCH] Makefile: fix python modules install path for multilib
@@ -7,15 +7,15 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- src/Makefile | 2 +-
+ libselinux/src/Makefile | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
-diff --git a/src/Makefile b/src/Makefile
-index 213c7d3..92227cb 100644
---- a/src/Makefile
-+++ b/src/Makefile
-@@ -193,7 +193,7 @@ install: all
- 	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
+diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
+index 261c22d4..edb3ca06 100644
+--- a/libselinux/src/Makefile
++++ b/libselinux/src/Makefile
+@@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
+ endif
  
  install-pywrap: pywrap
 -	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
@@ -24,5 +24,5 @@ index 213c7d3..92227cb 100644
  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
index ae0da8b..1af4435 100644
--- a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
+++ b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
@@ -1,4 +1,4 @@
-From 1048b80be8fe800fa343f26db833a6e89b5ba9ab Mon Sep 17 00:00:00 2001
+From 1bb35bc277129c976bb480a05de91dab346c84c9 Mon Sep 17 00:00:00 2001
 From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 Date: Fri, 25 Oct 2019 13:37:14 +0200
 Subject: [PATCH] Do not use PYCEXT, and rely on the installed file name
@@ -23,13 +23,13 @@ Upstream-Status: Denied [https://patchwork.kernel.org/patch/11212405/]
 [Refreshed for 3.0]
 Signed-off-by: Changqing Li <changqing.li@windriver.com>
 ---
- src/Makefile | 3 +--
+ libselinux/src/Makefile | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)
 
-diff --git a/src/Makefile b/src/Makefile
-index 92227cb..7c71c65 100644
---- a/src/Makefile
-+++ b/src/Makefile
+diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
+index edb3ca06..8da3f542 100644
+--- a/libselinux/src/Makefile
++++ b/libselinux/src/Makefile
 @@ -15,7 +15,6 @@ INCLUDEDIR ?= $(PREFIX)/include
  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
@@ -38,7 +38,7 @@ index 92227cb..7c71c65 100644
  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-@@ -195,7 +194,7 @@ install: all
+@@ -200,7 +199,7 @@ endif
  install-pywrap: pywrap
  	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
@@ -48,5 +48,5 @@ index 92227cb..7c71c65 100644
  install-rubywrap: rubywrap
  	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
index 39edb6c..5dad436 100644
--- a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
+++ b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
@@ -1,4 +1,4 @@
-From f33b426680492629d3d8ed664049cbe584f26f18 Mon Sep 17 00:00:00 2001
+From d555e83f8ca2482c673981250d72fbc4ce29c44c Mon Sep 17 00:00:00 2001
 From: Renato Caldas <renato@calgera.com>
 Date: Thu, 29 Jun 2023 13:59:11 +0100
 Subject: [PATCH] libselinux: restore: drop the obsolete LSF transitional API.
@@ -10,14 +10,14 @@ Upstream-Status: Submitted [https://github.com/SELinuxProject/selinux/pull/401]
 
 Signed-off-by: Renato Caldas <renato@calgera.com>
 ---
- src/selinux_restorecon.c | 4 ++--
+ libselinux/src/selinux_restorecon.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
-diff --git a/src/selinux_restorecon.c b/src/selinux_restorecon.c
-index bc6ed93..3bc0d8d 100644
---- a/src/selinux_restorecon.c
-+++ b/src/selinux_restorecon.c
-@@ -438,7 +438,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
+diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
+index 39eabeb9..128aff4b 100644
+--- a/libselinux/src/selinux_restorecon.c
++++ b/libselinux/src/selinux_restorecon.c
+@@ -439,7 +439,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
  	file_spec_t *prevfl, *fl;
  	uint32_t h;
  	int ret;
@@ -26,7 +26,7 @@ index bc6ed93..3bc0d8d 100644
  
  	__pthread_mutex_lock(&fl_mutex);
  
-@@ -452,7 +452,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
+@@ -453,7 +453,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
  	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
  	     prevfl = fl, fl = fl->next) {
  		if (ino == fl->ino) {
@@ -36,5 +36,5 @@ index bc6ed93..3bc0d8d 100644
  				freecon(fl->con);
  				free(fl->file);
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libselinux_3.8.1.bb b/recipes-security/selinux/libselinux_3.9.bb
similarity index 97%
rename from recipes-security/selinux/libselinux_3.8.1.bb
rename to recipes-security/selinux/libselinux_3.9.bb
index d58d646..9cfcf65 100644
--- a/recipes-security/selinux/libselinux_3.8.1.bb
+++ b/recipes-security/selinux/libselinux_3.9.bb
@@ -12,7 +12,7 @@ inherit lib_package pkgconfig
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/libselinux:"
 SRC_URI += "\
-        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch \
+        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch;patchdir=.. \
         "
 
 DEPENDS = "libsepol libpcre2"
diff --git a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch b/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
index 3cab867..2ec8a62 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
@@ -1,4 +1,4 @@
-From 418a2736fd7da15758ab84f9448e7517e3ad82c1 Mon Sep 17 00:00:00 2001
+From 6ab4a37bca66674e9535a7e838c2b4680849e2ba Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 26 Mar 2012 15:15:16 +0800
 Subject: [PATCH] libsemanage: Fix execve segfaults on Ubuntu.
@@ -13,13 +13,13 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- src/semanage_store.c | 2 +-
+ libsemanage/src/semanage_store.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
-diff --git a/src/semanage_store.c b/src/semanage_store.c
-index 2ca2e90..914d720 100644
---- a/src/semanage_store.c
-+++ b/src/semanage_store.c
+diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
+index 1731c5e8..c6ace295 100644
+--- a/libsemanage/src/semanage_store.c
++++ b/libsemanage/src/semanage_store.c
 @@ -1445,7 +1445,7 @@ static int semanage_exec_prog(semanage_handle_t * sh,
  	if (forkval == 0) {
  		/* child process.  file descriptors will be closed
@@ -30,5 +30,5 @@ index 2ca2e90..914d720 100644
  	}
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch b/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
index 8abf847..30d2afb 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
@@ -1,4 +1,4 @@
-From 0fddb654b4193e91b8534cbbeaa5fd9b6aa1ead2 Mon Sep 17 00:00:00 2001
+From beb674e585126fbcc803299ff14feec9bf736873 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 20 Jan 2014 03:53:48 -0500
 Subject: [PATCH] libsemanage: allow to disable audit support
@@ -7,15 +7,15 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 ---
- src/Makefile        | 10 +++++++++-
- src/seusers_local.c | 13 +++++++++++++
- tests/Makefile      | 10 +++++++++-
+ libsemanage/src/Makefile        | 10 +++++++++-
+ libsemanage/src/seusers_local.c | 13 +++++++++++++
+ libsemanage/tests/Makefile      | 10 +++++++++-
  3 files changed, 31 insertions(+), 2 deletions(-)
 
-diff --git a/src/Makefile b/src/Makefile
-index 8dfbd76..4012f28 100644
---- a/src/Makefile
-+++ b/src/Makefile
+diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
+index fa3449fb..66c3010f 100644
+--- a/libsemanage/src/Makefile
++++ b/libsemanage/src/Makefile
 @@ -27,6 +27,14 @@ ifeq ($(DEBUG),1)
  	export LDFLAGS ?= -g
  endif
@@ -31,19 +31,19 @@ index 8dfbd76..4012f28 100644
  LEX = flex
  LFLAGS = -s
  YACC = bison
-@@ -90,7 +98,7 @@ $(LIBA): $(OBJS)
+@@ -93,7 +101,7 @@ $(LIBA): $(OBJS)
  	$(RANLIB) $@
  
  $(LIBSO): $(LOBJS)
--	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
-+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol $(LIBAUDIT) -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
++	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinux/src -lsepol $(LIBAUDIT) -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
  	ln -sf $@ $(TARGET)
  
  $(LIBPC): $(LIBPC).in ../VERSION
-diff --git a/src/seusers_local.c b/src/seusers_local.c
-index eb3f82b..45da825 100644
---- a/src/seusers_local.c
-+++ b/src/seusers_local.c
+diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
+index eb3f82bc..45da8257 100644
+--- a/libsemanage/src/seusers_local.c
++++ b/libsemanage/src/seusers_local.c
 @@ -8,7 +8,11 @@ typedef struct semanage_seuser record_t;
  
  #include <sepol/policydb.h>
@@ -97,10 +97,10 @@ index eb3f82b..45da825 100644
  	if (seuser)
  		semanage_seuser_free(seuser);
  	return rc;
-diff --git a/tests/Makefile b/tests/Makefile
-index 241ff17..fa03fb6 100644
---- a/tests/Makefile
-+++ b/tests/Makefile
+diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
+index 241ff17a..fa03fb66 100644
+--- a/libsemanage/tests/Makefile
++++ b/libsemanage/tests/Makefile
 @@ -4,10 +4,18 @@ CILS = $(sort $(wildcard *.cil))
  
  ###########################################################################
@@ -122,5 +122,5 @@ index 241ff17..fa03fb6 100644
  OBJECTS = $(SOURCES:.c=.o)
  POLICIES = $(CILS:.cil=.policy)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libsemanage/libsemanage-disable-expand-check-on-policy-load.patch b/recipes-security/selinux/libsemanage/libsemanage-disable-expand-check-on-policy-load.patch
index 4b1d3cc..604a2a3 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-disable-expand-check-on-policy-load.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-disable-expand-check-on-policy-load.patch
@@ -1,4 +1,4 @@
-From af4948d5a1cfb41338a7539dcd80735b5c250e58 Mon Sep 17 00:00:00 2001
+From deeb4536309e53478650a2b4d1c01f01422fa75f Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe@deserted.net>
 Date: Wed, 7 May 2014 11:36:27 -0400
 Subject: [PATCH] libsemanage: disable expand-check on policy load
@@ -13,13 +13,13 @@ Upstream-Status: Denied [upstream developers want to preserve the default
 
 Signed-off-by: Joe MacDonald <joe@deserted.net>
 ---
- src/semanage.conf | 4 ++++
+ libsemanage/src/semanage.conf | 4 ++++
  1 file changed, 4 insertions(+)
 
-diff --git a/src/semanage.conf b/src/semanage.conf
-index 98d769b..708fa8c 100644
---- a/src/semanage.conf
-+++ b/src/semanage.conf
+diff --git a/libsemanage/src/semanage.conf b/libsemanage/src/semanage.conf
+index 98d769b5..708fa8cb 100644
+--- a/libsemanage/src/semanage.conf
++++ b/libsemanage/src/semanage.conf
 @@ -40,3 +40,7 @@ module-store = direct
  # By default, semanage will generate policies for the SELinux target.
  # To build policies for Xen, uncomment the following line.
@@ -29,5 +29,5 @@ index 98d769b..708fa8c 100644
 +# module.  This results in a significant speed-up in policy loading.
 +expand-check=0
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/libsemanage_3.8.1.bb b/recipes-security/selinux/libsemanage_3.9.bb
similarity index 96%
rename from recipes-security/selinux/libsemanage_3.8.1.bb
rename to recipes-security/selinux/libsemanage_3.9.bb
index 9f825cd..4d2568d 100644
--- a/recipes-security/selinux/libsemanage_3.8.1.bb
+++ b/recipes-security/selinux/libsemanage_3.9.bb
@@ -11,9 +11,9 @@ require selinux_common.inc
 
 inherit lib_package python3native
 
-SRC_URI += "file://libsemanage-Fix-execve-segfaults-on-Ubuntu.patch \
-            file://libsemanage-allow-to-disable-audit-support.patch \
-            file://libsemanage-disable-expand-check-on-policy-load.patch \
+SRC_URI += "file://libsemanage-Fix-execve-segfaults-on-Ubuntu.patch;patchdir=.. \
+            file://libsemanage-allow-to-disable-audit-support.patch;patchdir=.. \
+            file://libsemanage-disable-expand-check-on-policy-load.patch;patchdir=.. \
            "
 
 DEPENDS = "libsepol libselinux python3 bison-native swig-native"
diff --git a/recipes-security/selinux/libsepol_3.8.1.bb b/recipes-security/selinux/libsepol_3.9.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.8.1.bb
rename to recipes-security/selinux/libsepol_3.9.bb
diff --git a/recipes-security/selinux/mcstrans/mcstrans-de-bashify.patch b/recipes-security/selinux/mcstrans/mcstrans-de-bashify.patch
index 74ae879..38db9e3 100644
--- a/recipes-security/selinux/mcstrans/mcstrans-de-bashify.patch
+++ b/recipes-security/selinux/mcstrans/mcstrans-de-bashify.patch
@@ -1,4 +1,4 @@
-From 580a625e9e1266d92c248a5e3f471d12d42c149b Mon Sep 17 00:00:00 2001
+From fb739bb565978ec896739daf758c2f6328e48b75 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 7 Aug 2015 15:16:45 -0400
 Subject: [PATCH] mcstrans: remove dependency on bash in initscript
@@ -13,13 +13,13 @@ Upstream-Status: Inappropriate [embedded specific]
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- src/mcstrans.init | 2 +-
+ mcstrans/src/mcstrans.init | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
-diff --git a/src/mcstrans.init b/src/mcstrans.init
-index 2804ec0..8b4737d 100644
---- a/src/mcstrans.init
-+++ b/src/mcstrans.init
+diff --git a/mcstrans/src/mcstrans.init b/mcstrans/src/mcstrans.init
+index 2804ec0a..8b4737d0 100644
+--- a/mcstrans/src/mcstrans.init
++++ b/mcstrans/src/mcstrans.init
 @@ -1,4 +1,4 @@
 -#!/bin/bash
 +#!/bin/sh
@@ -27,5 +27,5 @@ index 2804ec0..8b4737d 100644
  # mcstransd        This starts and stops mcstransd
  #
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/mcstrans/mcstrans-fix-the-init-script.patch b/recipes-security/selinux/mcstrans/mcstrans-fix-the-init-script.patch
index a560722..db7c03d 100644
--- a/recipes-security/selinux/mcstrans/mcstrans-fix-the-init-script.patch
+++ b/recipes-security/selinux/mcstrans/mcstrans-fix-the-init-script.patch
@@ -1,4 +1,4 @@
-From 123d5b6413905bfad535a072ff0ab5a495cb2a2a Mon Sep 17 00:00:00 2001
+From 99895a7d84e3e132a3d3d44152a99c7379dbd9f4 Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Wed, 6 Nov 2019 22:13:33 +0800
 Subject: [PATCH] mcstrans: fix the init script
@@ -11,13 +11,13 @@ Signed-off-by: Roy Li <rongqing.li@windriver.com>
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- src/mcstrans.init | 2 +-
+ mcstrans/src/mcstrans.init | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
-diff --git a/src/mcstrans.init b/src/mcstrans.init
-index 8b4737d..86c89ea 100644
---- a/src/mcstrans.init
-+++ b/src/mcstrans.init
+diff --git a/mcstrans/src/mcstrans.init b/mcstrans/src/mcstrans.init
+index 8b4737d0..86c89ea2 100644
+--- a/mcstrans/src/mcstrans.init
++++ b/mcstrans/src/mcstrans.init
 @@ -51,7 +51,7 @@ start(){
  	fi
  
@@ -28,5 +28,5 @@ index 8b4737d..86c89ea 100644
  	echo
  	if test $RETVAL = 0 ; then
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/mcstrans_3.8.1.bb b/recipes-security/selinux/mcstrans_3.9.bb
similarity index 93%
rename from recipes-security/selinux/mcstrans_3.8.1.bb
rename to recipes-security/selinux/mcstrans_3.9.bb
index 964a566..7cceeb6 100644
--- a/recipes-security/selinux/mcstrans_3.8.1.bb
+++ b/recipes-security/selinux/mcstrans_3.9.bb
@@ -11,8 +11,8 @@ require selinux_common.inc
 
 inherit pkgconfig systemd update-rc.d
 
-SRC_URI += "file://mcstrans-de-bashify.patch \
-            file://mcstrans-fix-the-init-script.patch \
+SRC_URI += "file://mcstrans-de-bashify.patch;patchdir=.. \
+            file://mcstrans-fix-the-init-script.patch;patchdir=.. \
            "
 
 DEPENDS = "libsepol libselinux libcap"
diff --git a/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch b/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
index 5dcb5e4..9b94353 100644
--- a/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
+++ b/recipes-security/selinux/policycoreutils/policycoreutils-fixfiles-de-bashify.patch
@@ -1,4 +1,4 @@
-From 624d6231ca9daf494e33352d562ff97cb0219f2d Mon Sep 17 00:00:00 2001
+From c0675c5dc7e59b345cbd62fd134ef950f3474c22 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 20 Feb 2015 17:00:19 -0500
 Subject: [PATCH] fixfiles: de-bashify
@@ -15,13 +15,13 @@ Upstream-Status: Inappropriate [embedded specific]
 Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 ---
- scripts/fixfiles | 23 ++++++++++++++---------
+ policycoreutils/scripts/fixfiles | 23 ++++++++++++++---------
  1 file changed, 14 insertions(+), 9 deletions(-)
 
-diff --git a/scripts/fixfiles b/scripts/fixfiles
-index 166af6f..a23cdc6 100755
---- a/scripts/fixfiles
-+++ b/scripts/fixfiles
+diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
+index b7cd765c..38497765 100755
+--- a/policycoreutils/scripts/fixfiles
++++ b/policycoreutils/scripts/fixfiles
 @@ -1,4 +1,4 @@
 -#!/bin/bash
 +#!/bin/sh
@@ -85,5 +85,5 @@ index 166af6f..a23cdc6 100755
  	return
      fi
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/policycoreutils_3.8.1.bb b/recipes-security/selinux/policycoreutils_3.9.bb
similarity index 95%
rename from recipes-security/selinux/policycoreutils_3.8.1.bb
rename to recipes-security/selinux/policycoreutils_3.9.bb
index 5a67c3b..443e18b 100644
--- a/recipes-security/selinux/policycoreutils_3.8.1.bb
+++ b/recipes-security/selinux/policycoreutils_3.9.bb
@@ -11,7 +11,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
 require selinux_common.inc
 
 SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'pam', '${PAM_SRC_URI}', '', d)} \
-            file://policycoreutils-fixfiles-de-bashify.patch \
+            file://policycoreutils-fixfiles-de-bashify.patch;patchdir=.. \
            "
 
 PAM_SRC_URI = "file://pam.d/newrole \
@@ -21,7 +21,7 @@ PAM_SRC_URI = "file://pam.d/newrole \
 DEPENDS = "libsepol libselinux libsemanage gettext-native"
 DEPENDS:append:class-target = " libcap-ng"
 
-inherit selinux python3native
+inherit selinux python3native pkgconfig
 
 RDEPENDS:${PN}-fixfiles = "\
     ${PN}-setfiles \
@@ -139,6 +139,8 @@ do_compile:prepend() {
 }
 
 do_compile:class-native() {
+    export LIBSELINUX_LDLIBS="-lselinux"
+    export LIBSEMANAGE_LDLIBS="-lsemanage"
     for PCU_CMD in ${PCU_NATIVE_CMDS} ; do
         oe_runmake -C $PCU_CMD \
             INCLUDEDIR='${STAGING_INCDIR}' \
diff --git a/recipes-security/selinux/restorecond_3.8.1.bb b/recipes-security/selinux/restorecond_3.9.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.8.1.bb
rename to recipes-security/selinux/restorecond_3.9.bb
diff --git a/recipes-security/selinux/secilc_3.8.1.bb b/recipes-security/selinux/secilc_3.9.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.8.1.bb
rename to recipes-security/selinux/secilc_3.9.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.8.1.bb b/recipes-security/selinux/selinux-dbus_3.9.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.8.1.bb
rename to recipes-security/selinux/selinux-dbus_3.9.bb
diff --git a/recipes-security/selinux/selinux-gui_3.8.1.bb b/recipes-security/selinux/selinux-gui_3.9.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.8.1.bb
rename to recipes-security/selinux/selinux-gui_3.9.bb
diff --git a/recipes-security/selinux/selinux-python/fix-sepolicy-install-path.patch b/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
similarity index 77%
rename from recipes-security/selinux/selinux-python/fix-sepolicy-install-path.patch
rename to recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
index bc048c1..0e8354b 100644
--- a/recipes-security/selinux/selinux-python/fix-sepolicy-install-path.patch
+++ b/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
@@ -1,4 +1,4 @@
-From fb449373ae92a05c324895cd7daee1461a0f0349 Mon Sep 17 00:00:00 2001
+From d7e063d1a41d45cd76a242377b0ee15df37e2520 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 23 Sep 2013 21:17:59 +0800
 Subject: [PATCH] sepolicy: fix install path for new pymodule sepolicy
@@ -9,13 +9,13 @@ Signed-off-by: Xin Ouyang <Xin.Ouyang@windriver.com>
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- sepolicy/Makefile | 2 +-
+ python/sepolicy/Makefile | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
-diff --git a/sepolicy/Makefile b/sepolicy/Makefile
-index 1a26cfd..6e40691 100644
---- a/sepolicy/Makefile
-+++ b/sepolicy/Makefile
+diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
+index 1a26cfdc..6e40691d 100644
+--- a/python/sepolicy/Makefile
++++ b/python/sepolicy/Makefile
 @@ -27,7 +27,7 @@ test:
  	@$(PYTHON) test_sepolicy.py -v
  
@@ -26,5 +26,5 @@ index 1a26cfd..6e40691 100644
  	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
  	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch b/recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
similarity index 88%
rename from recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
rename to recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
index 5c744d7..e816be7 100644
--- a/recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
+++ b/recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
@@ -1,4 +1,4 @@
-From 70187651a2239d5d8d70130e82c6f108eee77aa1 Mon Sep 17 00:00:00 2001
+From 845f081ba3dab6c27aeac12ab20a45250fd9a8e6 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 24 Sep 2024 14:07:41 +0800
 Subject: [PATCH] sepolicy: set conf.substitutions['releasever'] to empty str
@@ -39,13 +39,13 @@ Upstream-Status: Submitted [https://github.com/SELinuxProject/selinux/pull/444]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- sepolicy/sepolicy/generate.py | 3 +++
+ python/sepolicy/sepolicy/generate.py | 3 +++
  1 file changed, 3 insertions(+)
 
-diff --git a/sepolicy/sepolicy/generate.py b/sepolicy/sepolicy/generate.py
-index adf65f2..56923dc 100644
---- a/sepolicy/sepolicy/generate.py
-+++ b/sepolicy/sepolicy/generate.py
+diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
+index adf65f27..56923dc4 100644
+--- a/python/sepolicy/sepolicy/generate.py
++++ b/python/sepolicy/sepolicy/generate.py
 @@ -1265,6 +1265,9 @@ allow %s_t %s_t:%s_socket name_%s;
          import dnf
  
@@ -57,5 +57,5 @@ index adf65f2..56923dc 100644
              base.fill_sack(load_system_repo=True)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/selinux-python_3.8.1.bb b/recipes-security/selinux/selinux-python_3.9.bb
similarity index 94%
rename from recipes-security/selinux/selinux-python_3.8.1.bb
rename to recipes-security/selinux/selinux-python_3.9.bb
index 5a4e2d6..b452887 100644
--- a/recipes-security/selinux/selinux-python_3.8.1.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -10,8 +10,8 @@ require selinux_common.inc
 
 inherit python3targetconfig
 
-SRC_URI += "file://fix-sepolicy-install-path.patch \
-            file://0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch \
+SRC_URI += "file://0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch;patchdir=.. \
+            file://0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch;patchdir=.. \
            "
 
 S = "${UNPACKDIR}/${BP}/python"
diff --git a/recipes-security/selinux/selinux-sandbox/sandbox-de-bashify.patch b/recipes-security/selinux/selinux-sandbox/sandbox-de-bashify.patch
index 6258b7c..5692e0f 100644
--- a/recipes-security/selinux/selinux-sandbox/sandbox-de-bashify.patch
+++ b/recipes-security/selinux/selinux-sandbox/sandbox-de-bashify.patch
@@ -1,4 +1,4 @@
-From d592d59eb4e7dbf8ce6dc84b3f4c0026fd7cc60c Mon Sep 17 00:00:00 2001
+From 1bfa95fac4e32cecec452d0c48c191ab05d7d038 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 20 Feb 2015 21:07:47 -0500
 Subject: [PATCH] sandbox: de-bashify
@@ -12,24 +12,24 @@ Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- sandbox.init | 2 +-
- sandboxX.sh  | 2 +-
+ sandbox/sandbox.init | 2 +-
+ sandbox/sandboxX.sh  | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)
 
-diff --git a/sandbox.init b/sandbox.init
-index b3979bf..1893dc8 100644
---- a/sandbox.init
-+++ b/sandbox.init
+diff --git a/sandbox/sandbox.init b/sandbox/sandbox.init
+index b3979bf5..1893dc87 100644
+--- a/sandbox/sandbox.init
++++ b/sandbox/sandbox.init
 @@ -1,4 +1,4 @@
 -#!/bin/bash
 +#!/bin/sh
  ## BEGIN INIT INFO
  # Provides: sandbox
  # Default-Start: 3 4 5
-diff --git a/sandboxX.sh b/sandboxX.sh
-index eaa500d..8755d75 100644
---- a/sandboxX.sh
-+++ b/sandboxX.sh
+diff --git a/sandbox/sandboxX.sh b/sandbox/sandboxX.sh
+index 28169182..1af61824 100644
+--- a/sandbox/sandboxX.sh
++++ b/sandbox/sandboxX.sh
 @@ -1,4 +1,4 @@
 -#!/bin/bash
 +#!/bin/sh
@@ -37,5 +37,5 @@ index eaa500d..8755d75 100644
  context=`id -Z | secon -t -l -P`
  export TITLE="Sandbox $context -- `grep ^#TITLE: ~/.sandboxrc | /usr/bin/cut -b8-80`"
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/selinux/selinux-sandbox_3.8.1.bb b/recipes-security/selinux/selinux-sandbox_3.9.bb
similarity index 93%
rename from recipes-security/selinux/selinux-sandbox_3.8.1.bb
rename to recipes-security/selinux/selinux-sandbox_3.9.bb
index d0db69b..d29cd88 100644
--- a/recipes-security/selinux/selinux-sandbox_3.8.1.bb
+++ b/recipes-security/selinux/selinux-sandbox_3.9.bb
@@ -9,7 +9,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
 
 require selinux_common.inc
 
-SRC_URI += "file://sandbox-de-bashify.patch \
+SRC_URI += "file://sandbox-de-bashify.patch;patchdir=.. \
            "
 
 S = "${UNPACKDIR}/${BP}/sandbox"
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index c2aa3b8..1c5e158 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE = "https://github.com/SELinuxProject"
 
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
-SRCREV = "8e9157bbeea1899b7b8b257e7eaa71efef3fffed"
+SRCREV = "919e9e64cc4b20f5a1e4df1e38cce1bfe15aff09"
 
 S = "${UNPACKDIR}/${BP}/${BPN}"
 
diff --git a/recipes-security/selinux/semodule-utils_3.8.1.bb b/recipes-security/selinux/semodule-utils_3.9.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.8.1.bb
rename to recipes-security/selinux/semodule-utils_3.9.bb
-- 
2.34.1


