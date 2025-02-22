Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC23C021B5
	for <webhook@archiver.kernel.org>; Sat, 22 Feb 2025 12:18:32 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.45061.1740226709176785018
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 22 Feb 2025 04:18:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41482e5a84=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MC4BMZ024268;
	Sat, 22 Feb 2025 12:18:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44y3t2gdhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 12:18:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWxofaxq455cFcPwGOLkQijhedCB/VNyMfjhOaBCTt31UH2i3Cr0CkCONpKN6JT5Ck3T30HnHNw6aau76NsjL9QhVWaXhwZZ4rGCL5AxB5A87TvZV7MIms9r6zr3PzKhQXY2tA/Sj1jDYr/Bk4jM0YEzDqO+bH4UiBWF032dztVMYqt1wv6sMogd+vIGKYloC82agjWxSwBorw1K+AgT0Vy5U7IyKAvB7+t3ASg29PB/Gc8ulVhVWbpuq2qvtmxGINdQ4cQYh/GR2myu13G1G5TwyNG9s3GoYVYzRlNbmJ2U1PWBWOYEZphTl+eXneKHecfObZb7PEPcxgkC64F7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIdamfGje9iB3dZWmWqXcVVg5OWPJ3hI485oUQwUhyQ=;
 b=RVBd9Mlk6uOTqq9y/+5jZgJ7Iu771msF+vhDWDretwwdSbanUNfF3f5bqM6vnE1PfFrCF9aTxI83uTCq4ePK8C/eezwyY57hRlEN4rdvwMUagXueCwvogxNTO2mUXf10/DFDIRyJkDUEL+exv6Fnmtil88rOBGTZHv0Ok+iYzJc0sfrDqzs/3McP2Ptl7ZuBxuRrV0BXKuidvmcdnsNxHsY53uLTMXq3gjZBFj1Sfdn0OrDCxegupFMneP98ugudJedHVv7AzbxXStFFfWeLTh06ojIxePQqADym5slXtvu+FUJsiUxuO18OxxVmB9nl7j9c9ETaoxUwtj4g2nHcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.17; Sat, 22 Feb 2025 12:18:19 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 12:18:19 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, akuster808@gmail.com
Subject: [meta-security][PATCH 1/2] openscap: upgrade 1.4.0 -> 1.4.1
Date: Sat, 22 Feb 2025 20:18:00 +0800
Message-Id: <20250222121801.2828756-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: a170ab0b-c834-4f6a-5830-08dd533afdf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cSftW61gaJmpO6qup7FWVJj5yrx59jKOp0tXgOG4DAijjvugwgpfXpABiW9K?=
 =?us-ascii?Q?XNfkdPBAQ1YF4cQN9e+Q/HGoybue7y2Ec0ICVc1mO7X0HkBaScDdRkZbgqKn?=
 =?us-ascii?Q?rMaszjbKHHDZ5QFx/idu5QfjfOTp7nGpd0ib/5/zh2vqLRUJTL6gZvX6PbFe?=
 =?us-ascii?Q?G8Ol+rtxDW90bO+XzLAJ6nQnhK3Nv+qVXBLO7UvUpoIMwVsLzQBO7e1WOuhk?=
 =?us-ascii?Q?AsOArQlCq0laO/AGDsIEhTwMACFlZ1WBCf6rpf/48c8yffqkORSMBHx1nt/j?=
 =?us-ascii?Q?tLd0kCoTSSmxj61DR1aDZnqPEc6fN+TmyYBOc+SBAuNRDclWCQtzATZiFAXV?=
 =?us-ascii?Q?Ls3GeOjBo3TJNsy9JxIfQ1DkcK7n8ZweBbYc84m+4FKKnCQKm0P5xcCchgMp?=
 =?us-ascii?Q?bbPNOsx0IKnSuRKZ+D+wlzBGZL6fFwPdwbrMbVWMAJYCF2Z1BEQrB9ixXDXL?=
 =?us-ascii?Q?QzSwQGNtWrZeuVl0AMzlIqmBtA2GefWz6bGw6Lx7PSxmknbMqDxk8oRux6wX?=
 =?us-ascii?Q?pM7JppgJb+po4TQS/iVKaKH2RuNLpTxqsWQkCT0iuhGtliMF3LoF35PM1yJf?=
 =?us-ascii?Q?rgSOJnuHr42cBqqDCsKP+kXdXBxOcUqh/6L8mtB1tbTDv/zVESaahxW5zZo2?=
 =?us-ascii?Q?4yJVgDyQzQUxZc+dyaIsZC6kgGqRPcKWbOEm1gaWaGhhZGFgqxHxXhT9mp+R?=
 =?us-ascii?Q?Xq1Xj7MrL0sEAtLlJGpogpWh9O7RB+rNWAvsv9t7SgmQQPQlD3cGuqjQi0ej?=
 =?us-ascii?Q?eI9gC+WcPuZ9wAJo61XlZyaLD20fkzjoJaIb1wDNJA75RSq60O/OcnXpBdYP?=
 =?us-ascii?Q?Qk89feNIxegbU9O9AriUkn5kMRzQr9ERzYWFfqrxE1irdRuSB4kINvbcoD3e?=
 =?us-ascii?Q?T5cJItzXcyaaqwdcYueitNPyn2C0dxUNQsp0sWjmtGiM+EfnVgVL8NtoDyuD?=
 =?us-ascii?Q?QbMHnWS8sbdjYDkWfTZx4FGxNyQc8YQ/8WO1uLR5LiOUeSTwu9YCISIQjAKb?=
 =?us-ascii?Q?BiqIEyG418nxR+EPAEObecTP3UJjIExbDC4EUehvOEOY3ezJMW8MwQBtJ8MQ?=
 =?us-ascii?Q?/n+K8uNYadK4VWbHvM0NCqKbBW+JZS+RGQjTl7Xge2nQAKTQKWy08JCAScWP?=
 =?us-ascii?Q?Vrii6EpzaeAojsN0kWiIMTRZiYwkuHGUaTmN2PXGy1fJZS/nHu8NU8t6VH4U?=
 =?us-ascii?Q?bAq1fbjz3pGcEnl3Gnndu1y/SbAQ23/EqVsCBKT7mnJzO2aNslQiE0QvwPoG?=
 =?us-ascii?Q?O2BxASYNausnBy7EMiCbKMo8T84fTzN6Jja3iJxNtsmztUbBguWo77v5ykE5?=
 =?us-ascii?Q?6aybIYdc9oEJxtdyFiYpMfdolj5Bvd1n0TmO24H4S8bLn4chtr9jXwxYtg4v?=
 =?us-ascii?Q?W4jmk9gQ0JqPAsmJ2JBCnehfLFCIL0Y0cyxdey8hactpz7l9tVTsPfBOPGZy?=
 =?us-ascii?Q?mCcn+nAEb4eMvN8J7Clod1DHAqn0frSI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qeBTuXhkL9gbsW3OZL2KiZChU47NHSptXE81zZyCEbQda9cXjOx+HBSjnNlK?=
 =?us-ascii?Q?9a0RFpP5YAQA+FGmdQPdFUScJJ6bGX2bb1tWP9ndcGNqMhsp2PLfl9Xf+VkN?=
 =?us-ascii?Q?NcO7rQDinAv0NIotaE2HvAsiUsG52VysBuHGzzsczglwa+XzBnjrPS/ZGHi9?=
 =?us-ascii?Q?6DOhhb0fpQBsIQ9xV/RwCsYrnI5IwGGd6QogBqRtig/qhJcvOYo1eZHOFoSL?=
 =?us-ascii?Q?zjEtPRmTlkUKIK7TpK4zPKrM9DCRORGz67h/L36Q93LlJX2Y/vawOgYCJ12H?=
 =?us-ascii?Q?Q5ORRvFE22YhHvu4v9tdpCP/lEAEiSz0Eo/M5WEtp7Z4sGJyve0X6+sAC6sw?=
 =?us-ascii?Q?io6/Xd8LTutLVvqishV3cYa7BlxF+XpYIzJ2/lPXbWwUzCEO0rJfRbqBi0hK?=
 =?us-ascii?Q?BezHx6GVNe8fGpimpmG6bqp6Um+X27kTrm/6hg6W1IzXQLKNVF8y5ox8rCiG?=
 =?us-ascii?Q?i1csUjILWKOIhlweAy3//yw00uIjGP8g7AGDki+Io2XafT1qQM1p8TDFzTsy?=
 =?us-ascii?Q?mfO2DZKBjj6oAVE3xxZOyirBKpeRGMsiJAE3s9Myf47Iz0Hu6mNPlqvSmizM?=
 =?us-ascii?Q?zb80nHlv1TC9rcZPzho2x6W0fLursZ09zdQPtWtBzSPkDk/wrxu2PLrq7Y4M?=
 =?us-ascii?Q?oMlQtYVYoeViuBxWLK7JKnSNcLZRwfQXjiNachyR0A14fwWKGPv35XnNt7s8?=
 =?us-ascii?Q?JsL7m+ABVDvpw4NMTJgkTU3DlXb6G1koHHIDWFwPv5vJROS8A2sDNct5qBVW?=
 =?us-ascii?Q?NwtMml7MDBDBRMqJ0rSrapLWSmuq8iwmAkHl19xgmGt/N5WskPIH9qxi9mY7?=
 =?us-ascii?Q?6PuPdEKBy53N0eKWrv8kqqDMmqyVi0hyNBYohxaV0+A5OgLZYoZGZzesh1iz?=
 =?us-ascii?Q?7xVJsU9uuOFdC83jiB4zl5sYLJLqlsq+T2pi1NrNSInna9yZ5KIZoXhGCHyR?=
 =?us-ascii?Q?YWj5crhCVT/ds54lIfN39xvvcGZStwCiWLDvsOV4+/UmLs/eFr9IYgP7M40i?=
 =?us-ascii?Q?NRQi5lm/t0CcDO1rB3qgIPlQgmBWaewZq5pIoMRaIlGCtDDYAu//GvW/C9HL?=
 =?us-ascii?Q?UuH+r/lYJ6nK35a9vUM9pKfVE+O8sEgJ42zUVlkNnPNhXnct5UGdXSzoPD1o?=
 =?us-ascii?Q?N6rzQcB3VeqqFGq3U6DnA6yyFuMvPpwLb3Ui2AlAH1vSkG66JEhhZftgNL3l?=
 =?us-ascii?Q?WJf+8Oq+khelzyGw+QzNpO/Fj+E4lMwC+tVz3Jf4DO5z8JRNrVSQb44iizcC?=
 =?us-ascii?Q?AEbFBdrc0ZUX4ZkJ5ice2hiYDOymc1JgRkTsDnjuehksu4WNgXiQmALMxPJK?=
 =?us-ascii?Q?znbGhONtmmNr1J8Antfnt37DQFHxMxf/eqkD1Oy5zF/H2WqkmD9kJ8U9E5JY?=
 =?us-ascii?Q?mcaxgta1cOocWvVMfTG4mNwj3vueRNGuBv7IRAo+clCQ8eHpt6rKW5uJzjQr?=
 =?us-ascii?Q?jBSy1OJsQSNV937iUHgyBhwgyt7nfbj5c06TM8jmDqBtB4ip0pY3ZmJRBb95?=
 =?us-ascii?Q?BotyEizbe7t9/KjEIBX4mFv0f1EOT/YZheCB/w2gH9LNLdeVBb5ndXcAE7qH?=
 =?us-ascii?Q?4KPzmTdBm/LBP88XWa8+timJSI+4JJCRIU+R0SFD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a170ab0b-c834-4f6a-5830-08dd533afdf6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 12:18:19.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agXek7TuYl3Viq5vbk2E9zD6jpXMH6X2aChV+OHwsX4JHrSkmcRNZPwBy4BxqAph8rC2PP5DeO0BmtLUMbCMOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-Authority-Analysis: v=2.4 cv=eoIlzppX c=1 sm=1 tr=0 ts=67b9c093 cx=c_pps a=1mby/iHf9ieL9308fKykyA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=T7lYL6oMG6IHqWwzuNkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: dgiam8yG8kv0lrXEzDXlaClbOrH4qgwX
X-Proofpoint-ORIG-GUID: dgiam8yG8kv0lrXEzDXlaClbOrH4qgwX
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1118

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.1

* Introduce "oscap-im" - script that can be used in Containerfiles to
  build hardened bootable container images to run as Image Mode
  Operating System
* Add support for containers with no entrypoint/cmd in "oscap-docker"
* Stop printing useless component reference information in "oscap info"
* Fix missing declaration of PATH_MAX on Solaris
* Fix RPM database path in RPM probes (RHEL-55251, #2151)
* Fix issues reported by OpenScanHub after 1.4.0 release
* Fix failing test probes/filehash58/test_probes_filehash58.sh on s390x
  architecture
* Ensure xlink namespace exists (RHEL-34104)
* Minor fixes in test suite and CI

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.4.0.bb => openscap_1.4.1.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.4.0.bb => openscap_1.4.1.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.4.0.bb b/recipes-compliance/openscap/openscap_1.4.1.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.4.0.bb
rename to recipes-compliance/openscap/openscap_1.4.1.bb
index de56e9d..47034ad 100644
--- a/recipes-compliance/openscap/openscap_1.4.0.bb
+++ b/recipes-compliance/openscap/openscap_1.4.1.bb
@@ -13,7 +13,7 @@ SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
-SRCREV = "a01b5d6927c7bccf41d9c623fee0c5f7105db835"
+SRCREV = "23a8ea3de3c4fd6017db4067675a81287177166e"
 
 S = "${UNPACKDIR}/git"
 
-- 
2.25.1


