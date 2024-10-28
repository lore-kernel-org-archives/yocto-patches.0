Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B13D13570
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 10:02:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.48271.1730109768926481069
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Oct 2024 03:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1031b70bd9=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SA2knc022560
	for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 10:02:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42gqd8j2qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 10:02:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EytsIickbW5PQwx162zc2FpH3bBlw+hyVMPXJ2kmPQna5jsBGpHVKAwQDghAdifuc4gpKiugOzqh7zAe3wG1zNn7IYmZoIAFGNPH3m8HvvX0SISf42m36gsDDEB0wmxgCbGoethSIOXNq5VaxucA/MLso9ouiMjh0xRMcNEQPVzgQ8+G9iu2O2zITVTt1YHZg6Remu0Cl4ULGl9FRj0+zDYfhsq3WS12CriC9IwiD2lcz22mDN5b89Ml19VwuZGkHPbrdTIDeUZWsC0egsAxQrBSAbUHG/7znSn/mWwnd1+jF6mAvGPCxSZXpLXkszWCYb+y9Mzn5IW1OX6BEKTIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GGoVlMRS5H5euoKwvj6XrUzMhRT0dyfgVxLKM5yEGk=;
 b=fEYVcfp3zBg9nPcMBYcGb5GsPvpUTqj7EgOV7kKx5tOJNO8pttiSz6uPh40egEM6MdVaKZr+anGNtuEMMx/DO9zKxo6uorF01cOqnbP85vM2qTGIC2suKkVY4OxLsmzW4aWmLAX4pkm/rBe/syJCHhZJc2hWzKkpZWAgOH2PpyCfmaUXQlvjVoJxpV/qggxBXSPmA8+Yv6z6cVEjnJBLR3Ymx+EQ5lOpDDR8+LZrasG2bRaEdpynBGGpb9U9LT1LDSEkviJLC8WacDFptEpAegRodW9gZpywnegMdjgLBGFy6JAXRg9D4WEUaC7Z7L45tDhpVW2bWCwTis2tFQrtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Mon, 28 Oct 2024 10:02:45 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 10:02:45 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] dm-verity-image-initramfs: drop lvm2-udevrules
Date: Mon, 28 Oct 2024 18:02:34 +0800
Message-Id: <20241028100234.1469405-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::25) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BL1PR11MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d637095-db00-4c85-ee46-08dcf737ab3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cdqTLX3Y926ZLQYv8tLot3SwqsK8yVeJB0s05ZVgUKy8WboJF6ebNP6GsW2B?=
 =?us-ascii?Q?le60fdyw+sByJAFmrXn2B0RCH3oIh4aO0xydeMYQq5qyowRIHP9E3b9wNdXc?=
 =?us-ascii?Q?S1OXZuaXhnpdJAemvFtxRxY0SwE3+NebxivsyEamiSM1iLLSRCgX3tOKXW1Q?=
 =?us-ascii?Q?KhipI5EhWr53nJ1CuF+UdvXLJm3FnjHGrHe9F1shfw5UXFZ31//PJ+hf5X6k?=
 =?us-ascii?Q?dkvH0hluGqpleFW7sVLhUxLW5yLlB+JWrFKaW/DaJsj43GOWHONhwYwOpjiW?=
 =?us-ascii?Q?kDmsbXnebpXKicY4dVzef4g1uvp3tlgsurBgi3p8+BagpP47BCDhZhpMq5SQ?=
 =?us-ascii?Q?Dl549ybTdtU/zC3HwMHen+AazJF4cQ9FL7j4/4YrY1HYUWU59/OFC9jj/1Bd?=
 =?us-ascii?Q?hcHP+HwCymE576UrJz6c6Zn5w9UOuZFMhM99ENgvg0PbNiRd9/2WZliOurIy?=
 =?us-ascii?Q?n/Y1bMUwMS1vaXzjCG0KIpKGt8YgqVvOrH+UNDPRkhfcdLYNfL8StHfbct29?=
 =?us-ascii?Q?Wwu4U2wH14wC5PCXEsGhbgSD6LziVuSk3oAlSp0pOmvWWgUO44YKepiFL4SP?=
 =?us-ascii?Q?YZb3P5RF2YftFzKHza9RKTBFwoWTmduMwD9eWrBEDtl0AfW06bx+oPirTt3y?=
 =?us-ascii?Q?lmTbtVkqzn8mZkPCTqLdTGyE1rEGYwap1H7cTWPq+Mz8sbs2kyPTV7ktPF3j?=
 =?us-ascii?Q?HBUJSoQvEaCoy3LmO8gZMMfmZG0ROv/7xCuUph5GomEE8EiQDfaXAGbP//5S?=
 =?us-ascii?Q?XD3nUfRsqH7anE+RaTKgFj6ewdKRBeNMbVq3FpAcqnSExMpgGUwE6vB4MZeJ?=
 =?us-ascii?Q?BEeSte0S1l0/BB530mN2l3wBYA022Wn5xgPQ/RQBdofiFZafaXeTa2z7w79i?=
 =?us-ascii?Q?wDoRtwrYD/DL1WDVzmrkTguNAesk3XXenQuuHI5qsZWvoK5Kf7TDA2MrZLk3?=
 =?us-ascii?Q?Bscw0vRcZ2uNKXIroMZ5P4mPzqal1673O/u5e9u3L/zLd5YYNuinuM/Ux4BO?=
 =?us-ascii?Q?v90iOVuRCVoIvyllpIigGgsOHjb2as+Fg6pPbRC/x+ygqsHy2W80sIm1MeKK?=
 =?us-ascii?Q?cCAGVV3mqhaJSQ2lCUxn1IZ/WLi0vMROM/l6L9gw6kqMEBCODu7xVFKyQuaS?=
 =?us-ascii?Q?BHN77WBz22gxVJGMkKfwu46UHisqU39/OSoDZAZw5enZCje0yCeDXiuWLhTG?=
 =?us-ascii?Q?yARLvACHsFkIgb1QhHdfkhGbIy6VSTuFotnGLoq8ZGXxqt0kGuFcMtHjNBpm?=
 =?us-ascii?Q?71zNOMLCNGDLDuA1nbtElF2x8TOgGikYNq2wxQ7Gql4rrCI8TykwtWYpsGFN?=
 =?us-ascii?Q?qRqlgLwOA3P0Pj3kyNFJGgnx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5xjG/rutEeIT43F6nQLANqGHTINnPViX0oZlMrs3Ttuw0HIWDWQPOxKY28lf?=
 =?us-ascii?Q?4XvdyL/bQ5aWx3Eoxw4w8S72EUO2/Hdye5mcUlFp3vTRa9TR+aHc4OfLH2wc?=
 =?us-ascii?Q?cif0347UGKcQk6VeXR0I3XhnKCSJd+7DpqNiX7WBqeipZTtSddmLlJ3xLwWM?=
 =?us-ascii?Q?5eJtqItXthAlNs1CsBs7AZCKpiKtaAd7POfPp3CQF1TcP2tt0WjpC7JpMhsD?=
 =?us-ascii?Q?+4xTvzrgGWMrLBu6pbbtMzCZ0jGR8tv9uIUhs7m1zUT6JbsHBxc8AkpvUsYH?=
 =?us-ascii?Q?jWWR0mRxQ/Wu8NovG2YP9a2HjWvJfpHZqCLnu4vyxWXQOuKqMB+BWZW1aR+7?=
 =?us-ascii?Q?X5YsKrNQQfYBN+v8tBmKNHSN+8LUuPyTQWhsP4M44lam8qh2W4VOxcfE4CnS?=
 =?us-ascii?Q?AL/2cMd0DLZTo2LHh8Q2iQW5GYaXQQ5oSY0bh5agKWGkN+bSnrA+9H8r3GUL?=
 =?us-ascii?Q?zjG+wcZecKlQv+AG/8q+/1LNrl7p31xN9Q3iu4fUH40gWXZetH5J17ugYq8l?=
 =?us-ascii?Q?8bSLlwwFi0IzMZEeQuHvsH+/ymVvIqpL6oaQ0BhVFiDUh3gWnFvW+cnOKogn?=
 =?us-ascii?Q?6x25O3i8v5+62sJVaOoG0MUaFQO1GWfIZqMJ9p+NFaqxYbAQDRoyiDORFCJ0?=
 =?us-ascii?Q?flvZpl3NH2pHlkfRgiCRbRyhufp16zfnEFNUdvC/JPeSSCgY/lpwJZaa2x2X?=
 =?us-ascii?Q?/Bo3SvmQposEnRQtiBzwvLMnJZ4yeU2K5RQN0f3ZZ3+IRXDc1YOHMOxjGwIh?=
 =?us-ascii?Q?u4w2hnihIeh5jZbAzRNmJOixXiDAVApGLiyT5KVDwsgHUqVAFTx+62dSTzkx?=
 =?us-ascii?Q?LtpQ/dOcrVMj/Kg5MVWM9AiDRgQ2zYjHPENl6UEyrWngB27K9cQZmVazrbhB?=
 =?us-ascii?Q?IH09tKMQ9gyo+rv6MCtqgX+PJP4J+efHsHux8k/hLCj+GiaudQaQtI3ELexT?=
 =?us-ascii?Q?HU4DilzO/xx3bw2ITg+qK/5bN7dDNQf8h7DnpD6K30QffnuUewH3xRvljy/r?=
 =?us-ascii?Q?pU4Ds/NZNy4S/eQkLpNFLB5k3VtV7icDqgeRhCKjkX00OQAUcQVwiTPMaLKn?=
 =?us-ascii?Q?/A1O/bK9S8ncEMtJ6PeLrCCa1a7FIOEnZOAC2yEeTNSJcHJm4lOPAHZXHEtJ?=
 =?us-ascii?Q?i+zr9u/H1eu93EgXYy1ohfWfB570qPzK2Rbqb1lwqxkVaiTBd0C6FnrNLnXu?=
 =?us-ascii?Q?NNK5ETekxk4Koqw9f+6BHODGJSfR0D9G9RX5uaEHL7Td3o1q3CQuGXKrA43D?=
 =?us-ascii?Q?LSvSmVcraMX0vBWSwHP7uXPbzGiH6wAd6mKqh4GebGpFpEwcUjopEWS0xtvO?=
 =?us-ascii?Q?196WO8DhY3AZ3zWU7TCvrYZZkUMoV5dNlCot/XfYE5qQBNk/FLElsJa7xO7F?=
 =?us-ascii?Q?02MKBC5jrEAdg/VenpGDC/ADl7SOMrRXNgpxP5tLpcMYsUXUoO6Bq76WW/Yy?=
 =?us-ascii?Q?GpPRIh/woC8Jw94CgOeo9ZO5vh9bMtf3edJXPlf2/EjHMz8qyygqU4J846wf?=
 =?us-ascii?Q?ycmgvc7WL/ZnytvdgOA8i53uadIqfVHduYNwu5772y4eFVs1Qo+//6UgeHkT?=
 =?us-ascii?Q?eVoRbmRkT5hrGgCk23hAtLHG/j7Ik1Q0wW8kPx6m?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d637095-db00-4c85-ee46-08dcf737ab3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 10:02:45.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWHg4J2qUZx/e8DJBZlyDKHZuwq+B+htEeIxHZNnwjOPXWcAH9jj1vzSJyQJyGPm9rCV+YN2FovHDK6AB8CacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-Proofpoint-ORIG-GUID: Z_FDu-mWxfVX6VZDf_F9E8ADjynInp_w
X-Authority-Analysis: v=2.4 cv=dKj0m/Zb c=1 sm=1 tr=0 ts=671f6148 cx=c_pps a=gHjWyi4SN+6fNgZLRl0D7Q==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=ZHjNn76KpIB3JTGPxKgA:9
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Z_FDu-mWxfVX6VZDf_F9E8ADjynInp_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_01,2024-10-28_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=862
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410280081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 10:02:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/764

Drop lvm2-udevrules as it has been removed in meta-openembedded
commit[1].

[1] https://git.openembedded.org/meta-openembedded/commit/?h=master&id=c37c867e1adddd6fa39cf3f3d4c6688ea6dc825a

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-core/images/dm-verity-image-initramfs.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/recipes-core/images/dm-verity-image-initramfs.bb
index 4256e19..7ed83dc 100644
--- a/recipes-core/images/dm-verity-image-initramfs.bb
+++ b/recipes-core/images/dm-verity-image-initramfs.bb
@@ -9,7 +9,7 @@ PACKAGE_INSTALL = " \
     cryptsetup \
     initramfs-module-dmverity \
     initramfs-module-udev \
-    lvm2-udevrules \
+    lvm2 \
     udev \
     util-linux-mount \
 "
-- 
2.25.1


