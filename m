Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F678C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 09:44:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.45835.1740044659188674001
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 01:44:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=41465756f6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5w5fl014354;
	Thu, 20 Feb 2025 01:44:18 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44w00kt6wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 01:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDyDc7/WOru6XAPbHWhv75Q4Oy6ajEIUr09tutHei0DzE8D3lFfTGarLFJkYsqR6Vv5BqsxTp/kCCV6arxMjGIZZ7MmrIXua/WX/nBfeTxemmABhetVA9UmztmiXxzNLqalnneJxBSzflWO/1j86qRoAhv+tQDWPdO3bHtsDsANpriEVUo8KjR/fk8rw9Go6T8IXo5Sy70YhJ9G/XOl/OF0kXOVWZegmi0vFlfzGByGla2yLr63UsiITpImHIJ3n+Rdp7VTIJB3tYlHYrv2617IRhzBbY3Fnoz87E8ld4TxTy+F7cLRyJ04Ob7krtV5PpfCY4uEcLa5W+0MMA1TqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Rgvdsq2YOAmi2yPx+xoZDqIVGTY6KdXHHuAjtxPhSY=;
 b=oXRpjShG1F3N+Bvj70D6HMtus6QGvibMuTx6CoU61ckdbrwybYfqHHHqergbuYHKCP5ScR/SxpVDPypp5Vti4rDw1fxwxbMnxS30FFACHV8zpTyA4gs7XNY7f8MdIHzyyB4qhvHP6JJ4dR6+1MKgFHoptYKOVUlsISeM3Y4iUFUhT1iEEY6Mxn4mUw7BjcYTxm1mRAxbNOZ7W0qAhxGouhZwLF5e1kRVP72HTxaJiFTjo5/0/WOjBdPousx6qaFjP87OnC9FLjqT5OKx3UGedx6U8dnHuo370BtZRk/mg7pOLh0BrIWqkiz/wO3RuaYBYd0FgsQVm+cCnTYuH2rdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:44:15 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:44:15 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/3] setools: inherit cython class
Date: Thu, 20 Feb 2025 17:43:43 +0800
Message-Id: <20250220094345.1119650-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9871741f-bab7-48a1-d7a7-08dd51932348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ABQMFd9KCiEGB93FY7/Pue6XC6AttzJdsBizTDygpLl5m8Itb1NCYBp2G+ml?=
 =?us-ascii?Q?5UDCBLL5qNpW6MXpEb71o1M07ark6xx2lieDjWWFjNnTXPmz7ArDcNOx6Pg7?=
 =?us-ascii?Q?hSjLsFBOJNdXIOqwftz56QcL2PIUrEx9H3+zbdNWBDJy66f/CfLGEDOSyh/c?=
 =?us-ascii?Q?8SYvy5RooVLN39+lZpZqpogV0qhi2yUhzdaXb6Y+RUuWUx1QY7lBZUZh3qz3?=
 =?us-ascii?Q?8mtrbh5mzBQ8yq7UK8BWrtTgYh0TztIKGUYdx+1gcP/bBV/zhdRMYEXadOek?=
 =?us-ascii?Q?UogI++s7JmzMuF3u6cFpc5wA4PvVelOyHfH1dmZ3/JoquJ6LHaLnrstEW+ls?=
 =?us-ascii?Q?Zx90R8SBRKgrO3fkDLnB2zH3pSbe3Z8iqTGWOCAYKo/9fSQJM8cgeC0VStqD?=
 =?us-ascii?Q?zLVFfiwZZsHhoYAvl41H/y2lF2kjifHbBTj7xllt2ql16lqpYq7I0qSgeLuB?=
 =?us-ascii?Q?yWOIQsLEJEs7URNNji3BGOMOav7GDjzDzigI/f1TGTxp9LG+WbzCXIMyv//q?=
 =?us-ascii?Q?TJEpRQVobfiXrHZxNHR1lYiJu0PRPi4Dkxa+6llNb0cAWcCAOy9uwhSDsOj3?=
 =?us-ascii?Q?IWvnhppHB5rI+dSRVvySWsqDp4GVoh2ikUYz0qnbMUh2sHbCC69pJ/qGL85u?=
 =?us-ascii?Q?t/p9dCb3wVSpIFnqO2Xzt0mr6ymCqpwFjYJ1LPiatBt66N9Uc0mEmpKZVL34?=
 =?us-ascii?Q?GMxodU0RMx1Hf7jDNUBMhyRhTrPQKTumb3OsU2RWhV3Lmuniqv324Pm4079I?=
 =?us-ascii?Q?nuXznNGo/390LFMk0gccjtMG5GS8RYoT8Yb4tDK8LP9NqYMd1Jwjer+5c4hE?=
 =?us-ascii?Q?mFjF1dBQNHmfWROOI5WKh0PDi3T5Yi5nUM/IuNmIX8gGyIf+RU0MJEvVJLeC?=
 =?us-ascii?Q?uXpv+IEHlY25XW7UynjOQgCyWVzUN0JXCLn4GpXxiEU9XiiZXFlBswPhcVoN?=
 =?us-ascii?Q?CMYdTIQWtYZo5iRn1mU6icolAu3LabBRTNbruedND/LoP663bUX7CG62PZrw?=
 =?us-ascii?Q?AfF3WrhZr+X+wMACa2fjFqBezi85zTLRV4UKWun9a6+Hoa6bohjSAcNANBWv?=
 =?us-ascii?Q?GP2uGJTRFk354Oi6m5JWC0Uwz1UeZ+t0Yn5h/A8XaZIEjebYRfF4NWARNyS0?=
 =?us-ascii?Q?vHJohE5nR8L6j1K+KAAdOkDcB0jlCc4Eea/vqp2LA8UXVBuzg0HUAc9zmfTw?=
 =?us-ascii?Q?PzqJryxOhM+xYnFLeFs+WWOLYrPgFLVHk7iNukhTAX1v42jiYuCIxkCkjsGz?=
 =?us-ascii?Q?8QplGmBG059CswRZTOEmG+s3tY6RCOQ78HrNh16K2y1L5oeEHdHG/SnlCr1B?=
 =?us-ascii?Q?PWBAIfkyWQdPGm4UzfyWszd8w1xMP2qHdermzmtPxAsKHHRkhHN11mV0CdYd?=
 =?us-ascii?Q?qWBUMJ7Pqkre3Rza2WSrEg+56VGbD0lc8wyZvX21QPth62tYxqD+ClPguOTd?=
 =?us-ascii?Q?B4EGk8JTSaQuL3M+N5K+/VAgy4bXrG1u?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zMzOeLBtzcmithgS0WLObryg+4O0/lIw7K4w8/5yvjSh+Pi8RwpiT1lovN6+?=
 =?us-ascii?Q?YJzj3sgilP16x1m8gny+PooR+dlXPzZei7QUWV8qWRFQwZxaJVtBYPWMX8hT?=
 =?us-ascii?Q?z1478orPdmOGMNkK4K9qKvN6Q/UfYiyxEznDQxSWWmIg3WHm37i1WLkUHYWt?=
 =?us-ascii?Q?/MVvf8cP+jjx1dHXB3kYLTANiDVkUaiyOTuWNqc0rqkhWBu6Mv31OZV0bwir?=
 =?us-ascii?Q?ScPmSJudEhTXfI+645JzNmfKcBFDG7oNRNUsIxJIp391AB6MS2H0kiBcJAvZ?=
 =?us-ascii?Q?fheu5yfEIBI0NSuB0fYi7XcOJmppXRgqTdpOVnB0nnw8Amfd56+VF804DWw/?=
 =?us-ascii?Q?6TvfnWbsC5Z+IrszaStIDJLLa85YOjDbpnu3UGVwFenHdOXl5gXppfkS8U4z?=
 =?us-ascii?Q?2nPMLVUTp1O7HKngsGqvdXv6sg81k82GNKTKpN+AuVW7HwrRoINWiMCd3UsY?=
 =?us-ascii?Q?JpASAb0Ijhn6XFj5PQHIPDEaPXxfBCOFQBNc9byyZBgxMai3FRkdFssLWVK9?=
 =?us-ascii?Q?9Zs3jff7QsEi2cnn8y8VnGqn3zMjarg3XVUabOAgeFj5JXt8YA49lWvn2KdH?=
 =?us-ascii?Q?GxV7GOIeLl+h1+0xkVyKUYBRvVJa7giFCoKagK9mSiq7SdgAl8meO8CdXopz?=
 =?us-ascii?Q?wN4kT0AVFQr4uXcOX1blUOMqFW/Pcl4e7C4NIUk913/7G/AfTGA40hLrV115?=
 =?us-ascii?Q?vAMeKDfgq1QPjwP2rGiREe7wJSIv13EAbo1uB5GknSw5vdudDZrVOo1rWobQ?=
 =?us-ascii?Q?GJ9SL9O3Jc3GD3DbkyOCkD3BaZtNoA6DIA+9r7BDP3Jpw4g1MN1769zlCjb+?=
 =?us-ascii?Q?ijK63IU+jBzrYsZ5LchdCNk7hDm0ALtMx+HzZ8t1J0pKqG1mWHYPD5b4Uy5H?=
 =?us-ascii?Q?0zCRdtSTbk5xz51V/wjXEDU7s4zm/cNCpsQ6gZQIHyDLKEyA3KbSlcAA7In2?=
 =?us-ascii?Q?qs7sMo++DasArfJz/DAoYXqa5qseY514xIP1PamkAUzFXjFrnNJu9PvqVjgd?=
 =?us-ascii?Q?isfZQ0ndrWem2TibU2YoRtThIhTCJRV603pVCWGdMDxZsl1ereRcaraupyMl?=
 =?us-ascii?Q?8nXDSOpOD3jGVwQZn5jF+eq2xSJY8C3Pjh2571il4Pp5bBAwYEpjhu/Hqh93?=
 =?us-ascii?Q?/MI/CehWkfToGPq564x5+WITPUpSjJ8yBpmB7sQncpYHnbj2/txicdPYDg2H?=
 =?us-ascii?Q?HQn1r9N5fGj22zTprQhdfFJ8QU3RBJ+25sUOmoXdqPgdYdLVlZ3r4vezedZ/?=
 =?us-ascii?Q?NvoSpIBDB5Rx8Bxj22MoasDmJqgqwUSh8PYRUNeTvPoXGglNxr0zesHuZoFZ?=
 =?us-ascii?Q?9UHfeNOjo9m08FrSFdxaf+jacCVnEdQzXliO0RJX7ZqQMHEBUycOCadjEkp3?=
 =?us-ascii?Q?VYnswDRtLi06IcMHa/HjbV9g1gBxy7kCWmiMe4tmZTSemeLIz7Ul2ZQQJKuE?=
 =?us-ascii?Q?44kmCxCG+JOW2HlnTXSunr89ipgKn6+9K7q16xg7beLY2K/u1ss2qcokzkoj?=
 =?us-ascii?Q?ILA5KUBbYvODBEOIg8p+hcGt0Cfu4MuIRiDJF4cSRqg4ybe4I8mNAQRZ2Zus?=
 =?us-ascii?Q?UAuu/OHm4y1xp36rtyyzkmihB8I0QYLgrDCRwKTO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9871741f-bab7-48a1-d7a7-08dd51932348
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:44:15.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gOtSmoXquRf3BfujB2OtNopcX/q4SL5aHZjmG3ukf54INehNQLeV3enFfQIYRwbwPgbd7IqFjwePKLuuQ/iSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-Proofpoint-GUID: 5UHrVHPFJarmA4Pt9uhpNGYCZkS-0va6
X-Proofpoint-ORIG-GUID: 5UHrVHPFJarmA4Pt9uhpNGYCZkS-0va6
X-Authority-Analysis: v=2.4 cv=Ao8U3P9P c=1 sm=1 tr=0 ts=67b6f971 cx=c_pps a=7lEIVCGJCL/qymYIH7Lzhw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=t7CeM3EgAAAA:8 a=hTR_DVrNJsjELbYIYI4A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 impostorscore=0 mlxlogscore=667 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502200071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 09:44:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1097

Use the new cython class to avoid duplicated fixup code to remove build
paths.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/setools/setools_4.5.1.bb | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index 9b6745e..723eeb0 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -16,17 +16,13 @@ LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=69a7b68f0a4a570d7c0c43465333ecbc \
 
 S = "${WORKDIR}/git"
 
-DEPENDS = "python3-cython-native libsepol libselinux"
+DEPENDS = "libsepol libselinux"
 
 RDEPENDS:${PN} = "python3-networkx python3-logging libselinux-python"
 
 RPROVIDES:${PN} = "${PN}-console"
 
-inherit python_setuptools_build_meta
-
-do_install:prepend() {
-    sed -i -e 's:${RECIPE_SYSROOT}::g' ${S}/setools/policyrep.c
-}
+inherit python_setuptools_build_meta cython
 
 do_install:append() {
     # Need PyQt6 support, disable gui tools
-- 
2.25.1


