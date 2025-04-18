Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9EFC369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 05:17:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.6183.1744953473266828738
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 17 Apr 2025 22:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6203b7563d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I5HqL0005175;
	Fri, 18 Apr 2025 05:17:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1qa3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 05:17:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld0ACUqrnLm2BLYI0SB6hewDirfYDjhxeT7oiLuEQvjWdl3Q6x13iXDcTx5khnrFjjHe4tAZrAGrr1522+MR7JcblN8pCY2kXTp3SMm/2glafT6YZYrzDj/OThwfTFl1P6Sg190jgBFrIHiu5pG6ftYSi18rNyyC3Egf8NORIvXqzAB/JDiz2N3N2XMLtjEm+19ui43JWDw2x5djGlaMLkCY4Y7zwnFthxBRC6ynFNqyQo5cVn71Bd8JaWeaXUsjKTBvJw8nFSuukggAys+Q3J9ioQIVZti/hWSQ1pdy+I5oFlPwZ1HSuP1kqweKz38ljKL60zML+6JttDOTSlDfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtUyeuttRCBDOgZ04hUiET9PBAaK45ik5D70voaeaf4=;
 b=rZ7k2a8aBP1GM5X3mGpIw/g2kptrWqFrR0CT+GmRFEmExpaqUTnFVTtCl6d8Ux4iIsv5RkAWufoo5Pnr6buNuzOc8O1Ix9VRNrHqORMmrQD5t+iVKk3r89JYA0czmFSnmnT83bez1ugJww05LiRbVDzHoDQdMY+9Cr8ec7CQxGKcDkZJxuVB3Gxp6cgTAWI5NKLK9HS/5KQYeIhRMpdq1ebn6XsvxlKrqjuo0qU3HsXdtwLB/eArBX9bQEAtkPYb20tT3gksrUW9SkOOr3MGK6EIQwsNywZ+zSC3IZCFBnMXM6kg+rVQVqIw9hrMXhmlTS5CctRb87qO3+LSRX+C0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 05:17:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8632.035; Fri, 18 Apr 2025
 05:17:49 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] scap-security-guide: disable ptest by default
Date: Fri, 18 Apr 2025 13:17:38 +0800
Message-Id: <20250418051738.2928980-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DS4PPF6915D992B:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e11bc41-c578-4e8f-cc3f-08dd7e385c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2lMv3RBDAwtgtB98aSNSGCA6f4p+8Mh+2o9S2AHjVpTReDl4H12Al3HPRIjK?=
 =?us-ascii?Q?/qwx4gl7FckZWw2RuTNNPWBua66xvLR1NiGSrrLRD0lhMokX/T0qztJNffWk?=
 =?us-ascii?Q?4w9dvGEHF7GPg+4Q8Ksv2oAuU/fb+5ojjJMDtVXxttKK/pJZyPPAuC03UVEW?=
 =?us-ascii?Q?b9H/HXP/duaEwryyT1HQWld0eTqGxWyTcEwuICEjN5LM96KHURjk0+/JK636?=
 =?us-ascii?Q?q4YM5rbSkvkF/GH7h/7iuXLduovYiiI42NnU9xMtIsyNv093smVI/rZiEBvj?=
 =?us-ascii?Q?iU69rk2yYP0eeuGT+OqtPrc8xgC8F7DPcewkKu5f8+x/S6zJAWZohS0/QC0T?=
 =?us-ascii?Q?rPnLobuv4Hwr670WuxcRSm+V9mk+Xj2SVTNCsrMVk7saPgrSwJcDQpXyB+74?=
 =?us-ascii?Q?1y6EzIH3qjXbaYcNm/HjJ+t7kyxHvj0uddfsoCNGMvbMR6sMRPrCCTn3DNq5?=
 =?us-ascii?Q?U5R6G7AQXUaKn380oljrnWtfHXwlXHhqap9qSSckFRu3ZSllzJqpBr+YefwK?=
 =?us-ascii?Q?67K2hzgFZVT2OYdjooZz9/bF9BlDC0ERakgyQtpvZ58iCCwLOtQJFp2br0b0?=
 =?us-ascii?Q?CPRVCV7VHh4aTQCYVH8gKm5p/FIa2IAf/J+HvKuxsewdkprKDfv1E1dP915C?=
 =?us-ascii?Q?h7K1KxaQkeg6IxuyNgSpB7vxWt75BrcMQ1lo9h1ZIwsF1UA4SbnboI+ryRIR?=
 =?us-ascii?Q?XfUDHrlGmUPa6T8LAlrlETFrLyKsARd+fYmQhdrwGivAU/3V9FUhJBrVDwH+?=
 =?us-ascii?Q?xjsurLfUnMoHlcJVM1S6wkAHj1jHEXdQXmfVs9JhTUvZ7oUUs5YYXPf5VpM/?=
 =?us-ascii?Q?UB9NVda9K36XjDh+y3HWTai2gSEcDciP3Qc91YKT7ezB3B+0DTZjEij5tMk6?=
 =?us-ascii?Q?l26Pikyk1zhnS7G7bMnZ5577abBRiNNICA5jldu8NPHlO5ILISy102TmIZGO?=
 =?us-ascii?Q?fjbo9By+eAaJzxRbAnw9iDfP73v6ZkQ/PyFzTed0FhOeMVkPKmRfc19FB0Qs?=
 =?us-ascii?Q?z1AqctBIA+9dzzFwDaDEQrgAVAYUP0iUsWVmpy5dPEPM/+eX28n9mwhBxXZC?=
 =?us-ascii?Q?JQC8+W++lX5YHJPdN3/8816d88Of5Kf4sUGSRfcy0N2WEOc7EOCx2clGCbbc?=
 =?us-ascii?Q?o8xlb2/B1z/csrcNR2juToqmxrHu0ui77wzC2kTEyycgN0Os2xM/jhEA4Wn3?=
 =?us-ascii?Q?XXqP5ahXpO2ajVZaIR+G67W6ou91rVz9NpsXThI40cWtiQRs1Ate5IDGjmpW?=
 =?us-ascii?Q?mBH68E9WmTpMoBmdfI6suVsImHESW0wxeEOCnivDnClkaUWNZYuQ16xzenRT?=
 =?us-ascii?Q?R2d7fMwwHBaJb2LC9nUVxP3+LIu0WtSaDmNpg2cAbgIjHtbWJUlu92KzN712?=
 =?us-ascii?Q?zQB65B9uDY0LMntraPf5Ein6V93QVtNCHkumBwbWMkOpOj2IWBAsg22K9ixM?=
 =?us-ascii?Q?Vhg6tBbLBp5UOI9Ug6lS1cjIJQumFLC9LlzHN4MOrXqra0bOp1dYCw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j5uXcVEd7e+ncFIJHNXs1kUMQHoHzScgxdq2M13rgJ3ZxigqnVZrNOtbMadd?=
 =?us-ascii?Q?G4U2dSO/BvF4fX0lOHx4SVXetQ/aRpdMM9zuDK06mSM4zqNj/BGPGIOPLRaY?=
 =?us-ascii?Q?ERRyonybp2W2l1uJnI9z/uElzk/N2yayOxUKLJUZSV8FXJJdGU/NcyIXhRkx?=
 =?us-ascii?Q?s7yRTM0rnNpPv+xrunAlPDNl63VJvSku91wuS2e478LPNqsbL9XIlsWDIRjt?=
 =?us-ascii?Q?aC43hyJfhp+b7GhK4qZBc0BK8FcrgRktw7+IJR6PdOc8YnWULLyR262oS8Pm?=
 =?us-ascii?Q?ekUSGMpvL1RiYEVUqw3JHdnJR3uE1kDwoocsBjDmip2UI30lGiM1h+6eiFPk?=
 =?us-ascii?Q?dW7dsrI2DP4JHa3dETVJeF5V8oCr7VukAZmRzJkEs62njTlkJ8a4JfIOdnxV?=
 =?us-ascii?Q?19iFN6q4eDeIF+oW6iNqxgeU3deaDzAdDw07oNptYjrJB49C320S7isfN7zf?=
 =?us-ascii?Q?XSIM8kGArdz+8Qzkc9Nghzool8Fhog96Q4HqCvUj53R0x0EPJGUWSSUZafNy?=
 =?us-ascii?Q?GV4aJWWe2smCPUGL4XQOlxOqa3QFsSs55orIAFAAvJf5D9kAdpgVk2tnc0LS?=
 =?us-ascii?Q?ZbRl6hgqNSui2S9oibV3QaNcOm7dwAXlir32C9jOjUjJVmoaiku8v86aoSgH?=
 =?us-ascii?Q?div+O1O57bVh6gxro0MgIgs4rpCZLBJ1lMAYUGfSqL/Uk6MGAWtx7maC5q8x?=
 =?us-ascii?Q?TFN1Ym6mvgZYbpMLlwSWuFADDwWAjGT2fbSty6FnH+vbzBvjbKor//NhTGo5?=
 =?us-ascii?Q?/ToB4Bkr6XRu/ePisJR+QdyNAi5S+teVKcQYagX5UXuE0YQRammHJBRoEy1K?=
 =?us-ascii?Q?yT8PKp8c6inINQRw+sY8Tl+vW3aMw6O3l7YxdiUmtj4+X6Rvu7TOUGfrB6Wf?=
 =?us-ascii?Q?shqPYZ4Vq2W5uqrH2JqnwGbrn1EDcmPfmt+wubK+tLjFRSOFzycALSPioQo6?=
 =?us-ascii?Q?988G1Mlcqo14NGeIRla3CoeQ/rBtfjFkfQaH631eD6IzTVKBeHhh/J5wJDzd?=
 =?us-ascii?Q?fJce2WWbd0ucICzO2fN/FMrQWfrMFOhv469L0f48Nz3QjC0PIzOFDyp2T4Gy?=
 =?us-ascii?Q?dE1ZkKOz+xhmtnwNTiM4mVgI2o837neh8wNvfw5Y1QzU5DLdRd8s6tWwsecv?=
 =?us-ascii?Q?ubPY+RBfblQNJmwGsTFvwGV08VaTAJvp/6jmySdyshZgHiuRhJ0G+gSznhWq?=
 =?us-ascii?Q?tvzWVONnwf8w0Isx32wOQddL6QoXyko5svmmPa8WdbaZ+cEQ6kO6xuuKAPl/?=
 =?us-ascii?Q?DTyR3BXthRfKQvAw04aLQCtp66ZiEqyjWbgHStSE0xky5EOLcS87GcCZHwk7?=
 =?us-ascii?Q?Dkcjfl4iIHvGjRgN7vT9oJ0DfulzbzESG33vLbLv+ZfZSQloZS9XI6aZkq96?=
 =?us-ascii?Q?Qly1OEel4Xd/ARxiV7rcx93JCHpI9BBvIF2byXrJYVLOUwSnQQ6h69yedb73?=
 =?us-ascii?Q?LxjaLxAZOYrh5rVFtWAv3vnL6+vqqZ3zXcSy97Yd9OuyRVZpfXlFmeH1GZuP?=
 =?us-ascii?Q?r5+JeL1ivLcFlF5QQGAMHfUgi2ttBfh4Ov4exoCR7drMN9LdegEekpk57wPT?=
 =?us-ascii?Q?LlGpGhHazi3SHyjG5SjjkFLUAPqFX9j1VylY/3RU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e11bc41-c578-4e8f-cc3f-08dd7e385c6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 05:17:49.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4fMIPI0MG4N6/lPv52DWQ1DyWExPp6Ggbwll/o6qf8IuAIAawjt9KtbSo69gpwP851JLXbh2zIK9AAz2PKeuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-Proofpoint-ORIG-GUID: hRueXNVlwBJ3gotj-bQ6_3AWYJPdvz0d
X-Proofpoint-GUID: hRueXNVlwBJ3gotj-bQ6_3AWYJPdvz0d
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=6801e080 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=9EVpTSRJU6vyofUetV8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=904 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180037
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 05:17:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1379

Enabling ptest will significantly increase build time. Additionally,
since the ptest distro_feature is enabled by default in poky distro,
build time can be very long, which is annoying.

On my build server:
Enable ptest:
$ time build scap-security-guide
real    266m41.257s
user    1m16.895s
sys     0m1.553s

Disable ptest:
$ time build scap-security-guide
real    1m29.228s
user    0m4.604s
sys     0m0.175s

Add a switch SSG_PTEST_ENABLED and set it to 0 to disable ptest by
default.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.76.bb         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index 73bd576..168af33 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -18,7 +18,9 @@ DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-n
 S = "${UNPACKDIR}/git"
 B = "${S}/build"
 
-inherit cmake pkgconfig python3native python3targetconfig ptest
+SSG_PTEST_ENABLED = "0"
+
+inherit cmake pkgconfig python3native python3targetconfig ${@bb.utils.contains('SSG_PTEST_ENABLED', '1', 'ptest', '', d)}
 
 STAGING_OSCAP_BUILDDIR = "${TMPDIR}/work-shared/openscap/oscap-build-artifacts"
 export OSCAP_CPE_PATH="${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
-- 
2.34.1


