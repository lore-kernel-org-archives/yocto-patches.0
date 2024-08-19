Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EFC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 23:45:06 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.7010.1724111096052785843
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Aug 2024 16:44:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=89611b77dd=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JNUn9g004857
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:44:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412j0xjbvv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:44:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LR5hkpp2/n22y+x7GgLDi4WpJmtDoxMHN6AXNhpFz8/qdzl9EhO8bU00jdHKqMpNphULZRYMCCjFv3fMsV5u077lalXPhiHHIKbsaQJOg2EQl3nYjBoEj6OTn2bYdqUZO4BOYbS140lvz7U0LDKbd5eAP69Pm0S7A/8VZKDxpNJQI6xPnS415Hypn+YwnKV5xEjW+1bQTbil7N1d2sQ0NtyErVJHZZgk272SeZGMSkHsC6dMtZL1Sk1z3R9j9xQd0CWZsrILNEDuwljcLHV2tFQgaAhyY0vNONFHuJZNvmTfX/RNmBJutgO5UNtl7r8JIcaesbUOaPjNWWDAhBEq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AhYtL9q6aRWp98pwOC43RmeEuBaKbrRWiVdqL1ixkE=;
 b=rtD/agiqjH6JKYf0FRal05WyoJ/bML82pdJp9bXUwWU/n3zUjbYxdpBhSWcVLvHt2XVuqpwvWPY4vxTRcrzK3CtrMZ1ZNoqPsL/iV5jpWY15ry0eedTq770lXLEJEBGK8kZ3ILtG6Eq1tP91z7QnmhA7ub9KTO4EIlIW2z10OjXzFCDJ8yiCzenViiYY7aAxK/S8laEIur9DhWD3TSSKi0rbTbE/k3zyF9Z/ZrpX5+NDQs4yR5ui2mAh82qjp+eitEL/beM6SCcPOGyILCVhMcJgzAT6h97O+RfN1kihPSLrpMvUlF2QW6F5r7IAjZbutIgCFhEVvWx3F9r5S6Yqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 23:44:53 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 23:44:53 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] scap-security-guide: upgrade 0.1.73 -> 0.1.74
Date: Tue, 20 Aug 2024 07:44:39 +0800
Message-Id: <20240819234439.1234836-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819234439.1234836-1-yi.zhao@windriver.com>
References: <20240819234439.1234836-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: d537887f-c6c0-40f2-0bb9-08dcc0a8ec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fftsmWkHKhQ77zQyn/8Qo2omUJu22PPS8cPy8JU3F1tJZgw/o89N+QXKEQnq?=
 =?us-ascii?Q?6lyXNrt1EFdrXVwrQqsk4lvPUJbMQEomSsmYB3R6KOlH4b8Bcv7vWexWNqZl?=
 =?us-ascii?Q?0IAvoTWx5SnNQTn7TA9cDebRMcTZLFHFO1gTsvl/v7jY4YBNWN6S+03J7+J6?=
 =?us-ascii?Q?xdOTqUscG8u+YK6aVoNK+RAF1/4TiPmdJFvPOtipPq7vpO748EhoFBr7VuaC?=
 =?us-ascii?Q?dW9hcNsBkzO8ZJ9N1ASHNZ4xe6JFiWYbxJzz4TC+ic7Z0XSv4tADnbnYavDY?=
 =?us-ascii?Q?sDdcpwiVi2HvZgq8lXxPx2HQFoepLxybCsE6cOrEqmaXigzTyh8kcuwTCTQ3?=
 =?us-ascii?Q?NO01UL+T6JrXU/kH4Ny6ViLsFRW4XhKuk1jBkXJQ7g73SbTiCE9J1d8nk7oN?=
 =?us-ascii?Q?qGR5h8LB86RBxOHcfCIojBv/8LUxcKiEkQ2PELFbCGbrKVRZgJjt2q+7Gumm?=
 =?us-ascii?Q?hkYlO9J4BTo4PDAtyNwck6687z+3x0A7Gb/i77VOqtSQU3kUZGh6R/HMG4q9?=
 =?us-ascii?Q?0KibPf6P2D/7RpXqGiwFRQoiiWQBccX8aDI12gYEituxbpOmG8sWxMAdi5mj?=
 =?us-ascii?Q?c13bVQBtXDFojHEHs8jacOqHwsefQpgjkCKGg0qKJ18WHoy65HBKWTvZBMhN?=
 =?us-ascii?Q?aLBvaYoBLIo75MH6QnFe3tYVaqzWRDKJwWlXbz+ocpkM4w9nkpcy7fnesK+/?=
 =?us-ascii?Q?oVdmZjF9KqRCO4kduZGeelAUve8mQTIQDgg3huvw8EOFTBx/+QDAeZAfxXmg?=
 =?us-ascii?Q?jh3JYnyKAh3D+EwHhNs5Dhn2sLLOA817UFw7ZB7b1RyTYLERahhXWyl7vHQR?=
 =?us-ascii?Q?BpNgq2Kedg6DXGy2tyQm26L8nNG3hzvrxqPhyV3zXbADbqirYi7PDm0mvVKy?=
 =?us-ascii?Q?X08Irk2Nuw+9wxKggwPqlZFE0JRvCTD6fXc67Z38U3l1UwyLw34zwNQktn9s?=
 =?us-ascii?Q?4KJavju32JxYvDQKcOitg660ZvH5SgH/637wfGnhPLMgaXFJ6X84fHf3Nwt0?=
 =?us-ascii?Q?hmp1hxvdLG1ZkzXoZ4dI7qfGnkZfpw6Cmy8WmlubYn0pezSsmq5aWYU/K+a/?=
 =?us-ascii?Q?Fn7OCedhd+02LdIiQTTGMIv7K6Uy5iCIbjQqc9HJ4SKAHHsbMVYPhNlAFqa+?=
 =?us-ascii?Q?2bT9rCtsNXU1K7H1cWYQI2EotaVAWBL2gq7up9dAtc4uWpdneqC1yuHyraaJ?=
 =?us-ascii?Q?l3P0xyUVc3UlL3hBFDr1D5nfk08C6ZhwVaqlmUMPjLuL4XTMn81gNYkyQFtB?=
 =?us-ascii?Q?Fvv5g6yGDuz9MmQb3I+wVHkQnNMHSWl/DMfJ9OPhKS2jWbmSje3jo5REJAJi?=
 =?us-ascii?Q?PJal0vv0KLjqRQMS8Hfa9lln/jCsMFSomnlg5jKlXj5WyBgoMeiLxgXzFJzD?=
 =?us-ascii?Q?NRAm6K8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6AKgC5VpYPEY1FLKzXPIiPQ2N8b71oAyJ5CsZsirIvLxO3UGvR+ygYxQRaDH?=
 =?us-ascii?Q?ULvSoPj7w7C49Xl4dEUab0bIlecTdJ3gSU7uLg9YW400Jx4Xz/ax1mTk/DGB?=
 =?us-ascii?Q?xDbVvpucik98Llb3XWbWXkYZwwzQhSvZDrOmqo1Ak+DHPln6PPa9qzNuNmQ2?=
 =?us-ascii?Q?O+dh2Mwp8WM8cRl5Y1SArQBRunT/RZHqpDU6hz9rtl55GGhaozt70PMVzyQf?=
 =?us-ascii?Q?nGp6hC0m2R26g7sfGebmA467pFCKJke79f37s/Ru/7dIVSiwQShtIB9NmKzz?=
 =?us-ascii?Q?pJNHZ/GW/HPHoUEyCm4gOJamNIPZWgt1wLhqBexEYz4SyBEG5Zr0A+J5Fcoj?=
 =?us-ascii?Q?iK+Z0ujTWaejxeRpeWI5vQhEqtcPggFsRi4YwKOd+2dKPHCOwOZ0gsxNwFeb?=
 =?us-ascii?Q?RpcuZGEcq3yflGbqMWcps+fTXNa6OeiDbSXfcAD+5cj7h00B1jVC338df9Yj?=
 =?us-ascii?Q?apZjwGnMbCaD1L/fAg+5YU14VDLJ+9KqFvxafmxu8vhTGn+QHf+jrvG3OgJ4?=
 =?us-ascii?Q?4wqpEd56Arx5AcEFWqzUzRLGDyOu2WZ/U3VvkmSFQYkeug4fu9ctZ8RHTSZL?=
 =?us-ascii?Q?AOVBCIMMgAta42v1JVSYZUcqE5VMHwyqfKnzfenHLnd66QuH4UIXSiP2Cn3H?=
 =?us-ascii?Q?XrdxEkYZCTRwyTitzlI1ZGFxjd5OVz12LMmhlZ+JynUvMNoTldJj9whO+Byf?=
 =?us-ascii?Q?+AdUK8KECEQxPGP3MQFLpaeDMvxu8FsFYJhdNadywuiEWZ7C8DoEVYEHa4gs?=
 =?us-ascii?Q?wRpP4+NZ2RwU+GY9UhaY4N6r4H/8fzkIsYn1QsRo+pqAsw2TOnCl8gWW1Cir?=
 =?us-ascii?Q?Rts1tW7d7ORc0KxRnILcx44hOhY4+4e82trXJbuFf0Becly7Kyg8rISGGuSI?=
 =?us-ascii?Q?hksN/+WjFAX3N3/trn7zida6GOUGf44/86grJ9oYUoP/2SUCMm2Kg/XFkTTS?=
 =?us-ascii?Q?MCEw4YcNLFdOIFToPUutC6BZHd4BRAf2+3hWCtAGFCvEW78dIY7EgLOMR/fY?=
 =?us-ascii?Q?LheNNxNRPDUVNNbGuFQ5Ja7d8x88A7elKNledIaMmAGKSFp1K9vbSkD4s2oF?=
 =?us-ascii?Q?VpJNUeysmlkSrAmuTsFmiVWFnHNlLSgAcrilkLPXxGv3cKMmuvaIPKLnC3I6?=
 =?us-ascii?Q?uKsVJ5IHy0ZAvwlps7p4mHFcWj0hbpBF2O0iqWhtqNkxPgwcmsaZU6QiS2ub?=
 =?us-ascii?Q?RgKC4YSuXYyMohfJn/hr9R6bTJIyNeiwsHUAHb4+r3P19g3XqYUuGwjU5DjJ?=
 =?us-ascii?Q?KWBQQQMu2CKKCQb00BWpjo7bjfWzPZVh6H/V5lqVKS2f8mr1syMpn5GidOv6?=
 =?us-ascii?Q?DgDwbLKi/+j0LqhVAW3xMslUf1azyt0GH21lxugVoCCR4VQ6jovggM5O4gm2?=
 =?us-ascii?Q?h3fL32bFSMgt7SHNyZ5ixw+/3EzUcHpd6q0K0cI5aEm8HKzRHrcze/LNixjV?=
 =?us-ascii?Q?t4UIa4cpHTODr75SitSwXoYYigAZveTSuaRXeR5cKgVWNQbOS0SCcMCypAcN?=
 =?us-ascii?Q?FkehatwGA3moImCmmr0lEUPDa5JQKwF8zpFTdZcXCNGvq4kgmDgGasiaNcku?=
 =?us-ascii?Q?gmXkZC4QKtCwWj1qryUBZ6yWERFmJsC65C4YmLbs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d537887f-c6c0-40f2-0bb9-08dcc0a8ec1d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 23:44:53.1261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAB5MzgdKB+ci4+26Wz1lkdr6H7adYnDyQJlNEmypwIXUm8Njb9Af50KknLjkZyQWlV+Qg3LzaW924fapXdwXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-Authority-Analysis: v=2.4 cv=PszBbBM3 c=1 sm=1 tr=0 ts=66c3d8f7 cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=5B1P-IGBAAAA:8
 a=0zhHlILBzbKeERqhNUMA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=PcRJL-ISiCqaXG01ICqs:22
X-Proofpoint-ORIG-GUID: 5N0Hu1w7nSsQD6gZA7hqRFCPvAwiCUvF
X-Proofpoint-GUID: 5N0Hu1w7nSsQD6gZA7hqRFCPvAwiCUvF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2407110000 definitions=main-2408190159
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:45:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/522

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.74

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.73.bb => scap-security-guide_0.1.74.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.73.bb => scap-security-guide_0.1.74.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb
index 0396b0f..23b1825 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
+SRCREV = "1bf21b05fa9581e8ca44e104e741e13fad3551ef"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1


