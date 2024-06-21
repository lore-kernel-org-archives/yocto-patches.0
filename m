Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC81AC2BBCA
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 13:34:10 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.73181.1718976845606627860
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 06:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=69022a9133=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBuAdQ017100;
	Fri, 21 Jun 2024 06:33:04 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmq8v78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 06:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPHlVBEaj/uSyN/QdVPFE9I407+usOZwR01LX+uiploJCYHPYL2eODCZUXVM49nP8oMWLIE40d8LP/vuTeuUSLdMnhuhfX0UvUXoUsof9sgRLUmlEOo5ltaooIFzzIg02VWThLFFjvXD/oK/H0030JPHPXOskhxThVRRgOqXHw5SIL63anARjd2OeCe4u1DepqBuMBOEBsKf5GEw32IFAGCcPcUofXh4ovWhji+XAOx1VzcMLlOyaBa83J+a0fJR/zS2hielGPKfWfqkiTIp7fa6tstrCuHllNyTJ4PRKNCtFrOFlprAyxYkzaCtGQ0aPCJixopvbqOW0LBi+OoN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKlvVveGh665ibijmq5/RTXa9I2TLymf8Chy2fMeGm8=;
 b=LH1CpvB+HTXpz3nT5LoQg/g4tKpLSjoHNJ3x/QMyFB3ETw2rVsx5Wr1RBKvzsBx5yT+3vf/V+45yGq5Qaj7yg2dVKFFaOZyBbFZO7qYLSat1w/mBr9EYupJAsZwVzdsm5NcBJUAkfc+GFKzhW8UdmsmCAv5j29M7pLiwEnreyuZgLsn4cDfqBHlkXSTrtWXdYB1o4DKSgTCnENVEvLSq4Pt1matdQvL/D5gGjd0Dfttk8SMNPyCpr/gAPUo7NE09Ttz9J+I//CRNY+qyB2aZsTj6FSdL2R7EfivSVPHIBWtq4EBFn9BmLPr+Id6dSg5lMjFkfnXgOwE07qXGshPveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Fri, 21 Jun 2024 13:33:01 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 13:33:01 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com, Joe_MacDonald@mentor.com
Subject: [meta-selinux][PATCH] packagegroup-selinux-minimal: add missing runtime dependency selinux-autorelabel
Date: Fri, 21 Jun 2024 21:32:48 +0800
Message-Id: <20240621133248.2932427-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA1PR11MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c0dde3-23cb-457a-66a0-08dc91f6ac03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230037|52116011|1800799021|366013|376011|38350700011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fQ0WHcuw5d2SzvW+rFQObB1PJ0bHx5lmT9Sorg1IZ5muEgYXYz/3Iy+1ytdT?=
 =?us-ascii?Q?XIpCZqKCgAEAq8EWqGTogackqd1HjEG9ojzNMBCw/Q2cudHJKTcFrPk8W2zZ?=
 =?us-ascii?Q?lLcKOBpBKFvq947ql2pIKHd+mxq3COct46R5Vnl+X0SpR0xlLwYXNgJslPaq?=
 =?us-ascii?Q?HXvhJci00b+Gw5gNBiajNYxHzQa9Ov7M7RuYlTxl5CyhIqcL6SCdr5X2ixCE?=
 =?us-ascii?Q?EtYfIoCWODvPLkAvGmql9d5FRH8UrVkSrij8otEU9b3JcVsw18NfTs0j7aGQ?=
 =?us-ascii?Q?FnaFL+bfnYCm1wjjlMbG5/EFFvsJ/bstIo+liSeBmakZPtKAyCS5qh9XE8cQ?=
 =?us-ascii?Q?yzzaITQx7YY8QvKdQtZzn7pDcpqF/i7EVlo5sUKNnlBs7UU0GBKyDDZZTC7f?=
 =?us-ascii?Q?utRZTmlh74Hz3I/ZgxFMKTZ9yL/B6BXjCd/Bwcv/ogAMFJTkMx0DKIL+B7Kv?=
 =?us-ascii?Q?EccXpyNWB/9RMeqqjlr/Hddb1aMEVQ2d77iAX127tnwf2bNRoUf8rPb51/Lp?=
 =?us-ascii?Q?UxKsHBUSJA5PnPbosBlhGHE8wJtu4tZvEeR9qm9uNZua39deywewOCE+3xM9?=
 =?us-ascii?Q?zvV7y7MTj8jiWNV0FvGX0XWqtx7ltscYhcSBrLfHOymxAnahbbAKgDlFLIwt?=
 =?us-ascii?Q?GiXxTcRRTGiBNlxZvtQzh2mvibzPN2UiU/hvEU4WE5dYK/CGnmiZzFZV2tNY?=
 =?us-ascii?Q?YqzuxPa717UsLdovYchHglBFSwen8wFGoT+5NiQINAd2VkQE2TLxQacZBcbB?=
 =?us-ascii?Q?z3arJu8Z0CDwg9FYRz33+P0NxGODc9QCPzOIAZRvJ/YrpaWnnOqZjhMZISIE?=
 =?us-ascii?Q?n5/KQ7wRddu1ZR30f3ejgoB1f4SGMC6avRZul/m6KPlYz7e711OgN7vGqQAw?=
 =?us-ascii?Q?r9Gr+7tpcLl+h90szqFhhfz3Ohcx7nGQmUhzgfo174YRWwH1luqafhFpkDVQ?=
 =?us-ascii?Q?F3+aa0aBhvAPWxkW8xS/AEateOsTpv31+m1ytMoTRtiLLoDW/znmn7AF11bY?=
 =?us-ascii?Q?WTKovG519//5rPkWuGAMsUwrtoFoJ8euY8uLNQR5nARRc7pJjj5oZ1ulZWvv?=
 =?us-ascii?Q?HeYx4qabbkhuDLdi6RZL6hBfYH2ngYKgm4WZ21sZYF7VKxUyWZw4WLndRtQl?=
 =?us-ascii?Q?X/TE13Au+HxQEWzNnswko1v+cJFJiQvWCTBlatCTVBvyipTPqfDedRYkWjTg?=
 =?us-ascii?Q?xijjTvBh7izmAjUFTgnKEn7joev4TlH/hb+Q+8N0oAI/z4p5JZKHGHPNuiWk?=
 =?us-ascii?Q?ymfiLCfxdo7KQ+xPgk9mD/eaESQY719q2BUy4yJEKAHUoL5fX0RTKQUjRz4r?=
 =?us-ascii?Q?bSNQkKZcTryYHckijzEbju13tWgiXehGGc4Yy+n2yo/c1zxy7zB51lhWLkAZ?=
 =?us-ascii?Q?E4bQIXU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(1800799021)(366013)(376011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UL5YhvTw4pPaqCAh+/io2dSd3nNUZnoqj0TEDQrObQRXmLtkOa/aRXptVw3v?=
 =?us-ascii?Q?Cl0dA2QUVdNJF8ANc3R69czmri2+NGZIE4dr3MiMWVqpmCTmoNXZmxwKdC5O?=
 =?us-ascii?Q?Bb9pkKphGQDORpU59c10+N3UrnZKfnqU0zRjZeFa5JcdiHofJAdkUjLMEvoH?=
 =?us-ascii?Q?6yoGvdneN9DNuBwWe1JASSF+5O1NmckjjnJXgztw6IhfemHpURulcm8i4MDY?=
 =?us-ascii?Q?Ns6arhQVaVbflUxNY7+gMhKs19vLUCNi/Ygb2mWK+E/9TF7dRIIt1DW/yEIJ?=
 =?us-ascii?Q?nTEMWUzyYS44Lsx0YoGq+IbMnB65TmQoVTRWMvrVXCBDWVqbkViX6YKhW+ZR?=
 =?us-ascii?Q?bZaHHxL8vQnz8evSYcRl5XZzOrz1kUcpQq2XXGWo+6z5phktRB6+2K1E617l?=
 =?us-ascii?Q?+wE89d33EwtpwJfDh9oZoykCcRoTd2W7Be2PwbKZr6PCOjfaAMH917AH6N5D?=
 =?us-ascii?Q?y9veCbb0kFPWPwoSoMMs8tlC3J/Tc3mCIwDt8aAz7/ePnS1cNucIK5JD2Ly4?=
 =?us-ascii?Q?P1CX3XwZ6wReA+oeXZw+lybqfXAYJtSseP6L9Fk0k2Z4S/ji/HsCj/+uExbA?=
 =?us-ascii?Q?PFVlUpKY4x7Cgo77QLTt9T7CIgljVkpIXdmTHISTGDzxsfBY5o/4+sdtTJ1e?=
 =?us-ascii?Q?MUAzmqqlzd+jBvY9czCPzb+XWECRxNNTChH021glGHe46p9FcnJgHVdg5JDR?=
 =?us-ascii?Q?d4v0ok3Xx49cvIRq2Ac5SVet0BVXKfSKRRQP2dzhre5ImTDhKfhoIxtQB/6v?=
 =?us-ascii?Q?TIPV40U2thWAd7s3glXWa1pz3Away8OuoVh4yoiQ8KV3eeAVq4ePH20arvFj?=
 =?us-ascii?Q?tg3PlibIpMzVFMaYKLbMV/ZhSPY8HHWmWBmNdYujc6Q7foDayfmMgJlVIu9U?=
 =?us-ascii?Q?ZtClT7v3tCro8EQbCAUKkqHHdc+qclKZKUz5kRrKHmF3WnfcdyA2MFYKoIM3?=
 =?us-ascii?Q?Rec0RQbcEtiV1rVFxkEyvZ7VpuK1JOHeFEuJ06wDGIM9VKNnI6DHLdRFK1c2?=
 =?us-ascii?Q?agyGv3VNCs6zbeeO5J4QTIES+pklLZs+kannEdN0XjUrBqPh7Vn9ipl+/nVz?=
 =?us-ascii?Q?9M9WVNwKl2Asmcc8cZ8te7dzB88mroAoVgQkbBnsaFn6+eP0DPp4pyK0kJJk?=
 =?us-ascii?Q?/e5e4fNPNxEEvdDJNzTtDQtgSVvlpCSYsCjFfKkZ1Ji5awc5by7rOcR9wTpA?=
 =?us-ascii?Q?qR2n+gjO2zel5k6Z4+O+2xQ06d/uVGUgK7u3QpESGBxdlY5Olw/EKTFAbGNj?=
 =?us-ascii?Q?k2pORjD5tGArNt9BSmqWhSQ2nJsfEsfjBgbws0oo7oaBWzpA/YT9jR/uSIrF?=
 =?us-ascii?Q?UFPhkQVzFRMsQTVNApawO1NQJvEA1DhE6Yg7hIwgoD82VQosIhUApKxxlyQh?=
 =?us-ascii?Q?cyuD9yPMGbBw3ufIR8Su6mo0sBIwNtd1Ip5+qKBqDdpgqJXc8thZzgM4EEl/?=
 =?us-ascii?Q?qrSDp/TGevsb/uHbqIODqElJdTePTw1D9FdRPTfUpjzRhEHotQokueu4tlqx?=
 =?us-ascii?Q?KbTEb+4B17iif62sbdE3Wmwxh3uNviimNtxjLS7Uix5Y0QL00tjcvqdl0ONZ?=
 =?us-ascii?Q?ZaQQH7/lDwhZUtI4iy/R/ItrE62e1/+kgDQ+mkt1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c0dde3-23cb-457a-66a0-08dc91f6ac03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:33:01.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1zz0CvbVZmHVHWhPcwFezORIOuj4y0Foq9C0KwZ11C9kJNib1OuHTWgfNaDoM7Lhue7aa38B+8WI4k6R6JkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-Proofpoint-ORIG-GUID: FyJOdVGOzJe2QC3jEhdt3owHWoWCxhFt
X-Proofpoint-GUID: FyJOdVGOzJe2QC3jEhdt3owHWoWCxhFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_05,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=930 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406210100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 13:34:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/364

Add selinux-autorelabel to reset the SELinux label on the root
filesystem at boot time.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/packagegroups/packagegroup-selinux-minimal.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
index 0f9abae..f06b183 100644
--- a/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
+++ b/recipes-security/packagegroups/packagegroup-selinux-minimal.bb
@@ -19,6 +19,7 @@ RDEPENDS:${PN} = "\
 	policycoreutils-semodule \
 	policycoreutils-sestatus \
 	policycoreutils-setfiles \
+	selinux-autorelabel \
 	selinux-init \
 	selinux-labeldev \
 	refpolicy \
-- 
2.25.1


