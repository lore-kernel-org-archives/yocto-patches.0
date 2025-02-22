Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED9EC021B2
	for <webhook@archiver.kernel.org>; Sat, 22 Feb 2025 12:18:32 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.45062.1740226709391478407
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 22 Feb 2025 04:18:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41482e5a84=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MC4BMa024268;
	Sat, 22 Feb 2025 12:18:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y3t2gdhx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 12:18:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLnZMon6E1/y21UOXj9ozqJ5jTI+Hqiea8jY7BblIrJP5HVfabPNKgklC4vtX027syImDFB+jWt7ps7wx8EQSkyXi9t5MiPeV07kGyXOyhrua6+cfjC/u296q0m8GcrYah7FpZgewZtiUjv5NOAFpbdyK/4jECSCuT0rGaxQkvkXd3Zrzj/A9C14rPE9idyWPKynt9QFqtb/Gj1M5mogCWum+hW2c3+y3P/ECyhAS8IAsJyI24Imvq7PpNU68wfMOo1/3Ajuihp+AZc+gxy/6F0g8ej3G8i3l5rddytY1A4MnbmZV2Af/v0Jm7jU5Of+KgnridJ81Nbh3yEBt6I41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMwqsjqxzbDVdiTG9RxcPkCuy0eYPvoTIKHESTzDgkE=;
 b=tAU+hd8XBzkqb4uvm20epvGhrPYct0XtvxO0pq2PLItea7sqHyUK7CLp5LbrdhQ9x0wQ/JKVgIrrh61404ow4L0hlkLvlljV1GVbfoq1xrbj5yFns75XnfLGlgyRf9sRb93WzgyVXGshMlVW73lRRavKzuK6w7FpmRoCI0gZEiloRw+ECIp5QBAroCy4XAEawnHhs4JNggQuEnDkcDMDzi55ixLcWSEupbRCmiFD/3nAhJkERQV9gPly3K7q8JAmv7ZH5DskZq1Dh2quUcGwcSZG5/7Ps2LpjGW0gcwaR/hfmXUoxOE9rOLPLmWqL2TuOCMDWZdahyTpH46tUyv7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.17; Sat, 22 Feb 2025 12:18:21 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 12:18:21 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, akuster808@gmail.com
Subject: [meta-security][PATCH 2/2] scap-security-guide: upgrade 0.1.74 -> 0.1.75
Date: Sat, 22 Feb 2025 20:18:01 +0800
Message-Id: <20250222121801.2828756-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250222121801.2828756-1-yi.zhao@windriver.com>
References: <20250222121801.2828756-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 2851e55a-7da5-4904-ec2f-08dd533afee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uFTro6Ffuca0aG4WU8ZJ9l0FnElj8MiwiFERl5zi7QUJo3hTDQ9nKuoN+b9j?=
 =?us-ascii?Q?8+rxmYT6/b9OGYT1z5YBGxWfoClYF+JQmgPFnDeCwMEypzWiEWQk41nKmVLY?=
 =?us-ascii?Q?Q7tPKe5GLk8e7a5JouoUjSPzNcjPFBW+JM2AsQfVMrfVPnyunw6GRbeTekuC?=
 =?us-ascii?Q?10FvWRBOO+RrP/rvs5FijrLqyixaUzgiflmXg/Ba8YbwO8z5/5SAVbaijiPR?=
 =?us-ascii?Q?Xqz6Fxkf3KltP3J+iRcA+r+N6NJryxtliFtmhlSoLrNKm8zZOEpSioY5kw62?=
 =?us-ascii?Q?50rEjgNQXAIgVgX1UvyZyRnAKc6EoyMdrc7xpdE8uHg28CQNQT3v0euNDbp6?=
 =?us-ascii?Q?w1r4DWCLnaF4GFQiVUlyyFxCGu9GJtFV9T7JvCdOzhiarXYrUvVwROHhXZSh?=
 =?us-ascii?Q?VZtO7UMnz1+unUIKzEjKdHpY6BQae8QNHdHESzw03fn4bzr2n0HdqBmn1uLs?=
 =?us-ascii?Q?d1EJ16xALY2k3ewCsjfl1oN+LOsgOgKAr9/tqM0GnMehFwUGIb6e8c+k9Yg5?=
 =?us-ascii?Q?5aVbg7gy23u8ODoScZ8DLJRxSdK71gAT1XVcSv9Wi/bP+O6Qv+2SW6OXsnhy?=
 =?us-ascii?Q?70yZbyonCxgGYhXgS/j6zuLvWVsILO5UVIAo3giSVONsRvpqZIVFN26ch+bS?=
 =?us-ascii?Q?wLONFcbiYMzqfU1Z0yzdvHPx/gjnhAE34APbf30EGromBfVNpcuWhTnBSTb3?=
 =?us-ascii?Q?frJEqfVv4+sjt/Eba2OIq7scUNrM9XOH/orP5hGJacKjViGd5Ulz/IIjrb6y?=
 =?us-ascii?Q?DH7lPaSs1FCZh5QPqr5pypKWhLecGz8oWLf1UbteVfHmt9AG0qf4fBMHimTe?=
 =?us-ascii?Q?LiDA5i5zp/IGTKDVJFHTQxfxburaBe3E+cN6JZX5S06yzx4wjpx7c1zeTlJB?=
 =?us-ascii?Q?nkkRcbLAgPQ3b0UruvjwHKVwavB6/tiy4Rhmb6oc9oIN/0hS8LdbbvkJe8kh?=
 =?us-ascii?Q?M6swIcurqpnYX+JANfsd5QPVrT8yg+WWJjQXLUu/ixqXrcG3kam+q5bFZbmW?=
 =?us-ascii?Q?TyldEsZshs/c4Xve1yb+kJQX2tODcKuVR7cruRYgk1R92w4ks7tDyqyE2/yw?=
 =?us-ascii?Q?ZDXDiMnVOYk8EYJfzYIHZad5/Pfo1CbtLv7P/ZnsetNW3eiRMHjzCN3eeJCc?=
 =?us-ascii?Q?7K+2LoYifgMPKpcYQItpKZwJ8NPYQYDlKAqYfzujTjcxFXU7H+bVt6rd6Ft9?=
 =?us-ascii?Q?MvItEW5F5v5znEauYEsq6SyxIUjou7YZwz1/OzduoTolbrsPSjfVCW7iiEUF?=
 =?us-ascii?Q?zUspclrRV3SI9dHG5MYoi8+CSzZgTARxuYy5x/hetvkSiZYcMvLCvB9apksO?=
 =?us-ascii?Q?abchbKhZGHH/JkIe5JU9YxTvmcM0OYpu1eJLaXgi5p/rpSt6Jr+X9XPrq2i0?=
 =?us-ascii?Q?lLg2TPmceXcUBsfty2UUWc2/4DYSrXZCpA54FOs4UArEezoFbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QTq/JG/P/E+8ea8fo9pDUPiUFSLyRh9LUAz3dpaoDhHb6H1borTy8AW3vXdN?=
 =?us-ascii?Q?+ZBtQsdBdjtAtYPla0/K25qt07Gt9Vq8Wm/tTXYEE/yRsM6V+84WWY26BXwN?=
 =?us-ascii?Q?mso5EySkbN95jZ/JoTXSnz3AmM5xG619hdyYZHdmdFJZItpXQ2iiUbXO0XV3?=
 =?us-ascii?Q?0OxWIwQEBEbdeUKnQet1e9a1kHJNuC+NNLPPld+uBhCeCE0ApJ4vmgRrUYsQ?=
 =?us-ascii?Q?W1nO06zCrGJVrHPocvfeKr+0pA/7OruHBdzfCPriGf0tdtKxZ/eS+PTPnOyB?=
 =?us-ascii?Q?7bMbxnbRJ2y28rsz1TeRK0JxChKJidlGZYBNUH8FfWjNXLuFrj9es3eDBDqJ?=
 =?us-ascii?Q?F9ZLNgSXG1KtQuRFwhxFrIgOEpQjMcAGNXFO/pZYXMtgMXXDyLygLy2Widzz?=
 =?us-ascii?Q?bppwvxHDMOrgp++3Fv10Wl017uzw/2X+4ezCqtcjMfaUW2aN1QsvUIpinIR1?=
 =?us-ascii?Q?NWlWQEVxolujWOHkJStes64FfKZiue0Sk9wRXqTH8HmXyV6rjgOX7o4khpJX?=
 =?us-ascii?Q?9oaQRzowOuwC3brWjDkg72mFTLewMuLiQPFZ6Piz1aD6J4WbfOiLNt5Qcgcb?=
 =?us-ascii?Q?GPCoFMU+AkBcu7/7ka4Vg6xUJPKIiO2meZgvswkwAShk+oU4YUwzmD2lyDXh?=
 =?us-ascii?Q?ID4GP6hHerG24/waxuYEvn0tMOZ7GwqpaA8Br/wrZkadSxIQWtiiQ3xB/Dh2?=
 =?us-ascii?Q?Z3K8+3w4XCq7VgKOovCyQKRfNA8Dpd9dtvL2rV4aTxjeARxutJNwje3dGEFl?=
 =?us-ascii?Q?KbYQ9ryHXbIneLKZdmRAoaSabMkHgSqe9aftxCOILmgyiDa+r07Ppl1iArjl?=
 =?us-ascii?Q?gY3er+hBKjUqshAz3tThx6Ky+OYt044HmrTSUnwO/M6St8QKXjIPVJnAnmYY?=
 =?us-ascii?Q?imDjlmJ4X/FkZcrVd3skP5M9VlguLiUzqJI9WQINAekrh5z4gWE/s4Y8E4Oz?=
 =?us-ascii?Q?vYKhK2c+OLfle5YuSBgcBVoPppTe9yXBjWifZa7Q4zpExB/7tXj+POjuxVXQ?=
 =?us-ascii?Q?Wad1kFLpVEd1bcAlebZO9a3rX32VT7iAbXhqv4ejatgqLRTM+ojsz1UH+pLo?=
 =?us-ascii?Q?xK5GL7j1uB+/8ZUG7Fug1YAAj9pf2mJwd5DiaX6ryoB3rDR36Y4AalXFa3/U?=
 =?us-ascii?Q?yY56uOgVrCQr5cdtzJxXx1e1EyW19r8pOQ1Qxziij3on71EnvV+B42UNysZB?=
 =?us-ascii?Q?FLgyCUI4hMnLjJwy7sF0HD3u9Gu2LBaAfV+sfro/8xV1F8lcDFV8pU0E6ij2?=
 =?us-ascii?Q?JbMm9JrM6GgCbBMrAcqaFIONXDq+rpGVxodFSyJpz7On+xVJHdV28OuogdzQ?=
 =?us-ascii?Q?hOKKosXe80ohPMNF3GkGQWsg8RBSMx4GU3UWaWC3nw1rFh6FhjWq/Q/jWRhT?=
 =?us-ascii?Q?4g9S7R+reD2Jp43PrngFCeW/y1tkfFoI08Nh3VJX6ghO1cOCGWeVaeKF5hGF?=
 =?us-ascii?Q?c/ZlTEqBZPtf9qklJjaGVcjisdKUwgJ21ZtaEEZdzBbYeM11rgoCX2HUBfNt?=
 =?us-ascii?Q?ArfQvK0gvujvBw3lXRwoqgA2oakX8n1lj0tfAxqz+/LEaME8qaJ4cz8VxJX0?=
 =?us-ascii?Q?5tNtZxutqfIHBIvhHa/WXs93irqWMFz+xUFOOgXK?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2851e55a-7da5-4904-ec2f-08dd533afee6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 12:18:20.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +go2d1hAWKNVb1pFfomBY/hWriR20GKGG6dzuAoHRjuT2MFlDjbtGH85fUpCcOWFgFHJEK94YGh/8xzXGkKezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-Authority-Analysis: v=2.4 cv=eoIlzppX c=1 sm=1 tr=0 ts=67b9c094 cx=c_pps a=1mby/iHf9ieL9308fKykyA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=NEAV23lmAAAA:8 a=5B1P-IGBAAAA:8
 a=t7CeM3EgAAAA:8 a=Ai-WRtp5E7ymXf1_8cQA:9 a=PcRJL-ISiCqaXG01ICqs:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: idSt510HkeXH7M9K9-NVFvnA3zZ6P2YS
X-Proofpoint-ORIG-GUID: idSt510HkeXH7M9K9-NVFvnA3zZ6P2YS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502220098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 22 Feb 2025 12:18:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1119

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.75

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.74.bb => scap-security-guide_0.1.75.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.74.bb => scap-security-guide_0.1.75.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb
index bd74cff..c67a608 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.74.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "1bf21b05fa9581e8ca44e104e741e13fad3551ef"
+SRCREV = "73a89fbfd70f4122e2253e4715a9ba6f4525a393"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1


