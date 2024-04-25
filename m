Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E898C10F15
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 13:44:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.17403.1714052652946994795
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 06:44:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=L+3qWvFM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4845da66b3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6jYmw007264
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=YxEDdA9PLEt/zObOZj
	YuuHlQyl52EiQpvCP0z618eAI=; b=L+3qWvFMue467WzW8uJOAVkKHQwwvZ3OBd
	OVK2jSWeYFqJyGEGtU+z6r6BcFYyKKCrAuWHIccih/lW7bF9ez9kCaaE2vi45jZo
	1hm/ds9Ir3ecY3jyHOvNA+3Nzozy2hUxMQL1Lsjq+fmkt/4COj48/GfuHxPcReHD
	0fbJ/hqHGa6c5ANvnh5VGY9J7IRw+qFfnUBKd3S4bNwb1n02UWglvZ/uoUiX1LBp
	2er8pL0NRf2hVxLQro7Fny8/g6+z51EqpOXKz8ATmu7XuxGspuTatTVOTqi1E+kf
	UKLMfYBfztqCUP7hU5ZyQVHUGxlLaDvXPo36K0knNH244+OfWyBA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm900whub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ3eHD4STKyNoE8Grl/jDI00bS1wGE+YAG+3TVd3w4sqACdOFyiQp1vg+9q8D2Gn9PMM2Nnxl0sqtjcbJO3CSgMDYDsjEJma1V63MpdzOfjsN+nV/0DBBopElzgwFSMJE1d71EQhqbdEsJcV6XEWdURX/9dll8oLGRoNQRq4QbrK1anVPMGV9WdsTJnne+1xsL+d9H/X5Ztgziw/vhquedfSNltWO1yzb4IMbULAFI5tAcU2tJ5L+hByFZzHsAEz/AMJLLwroGZviotdBEz5ayf9g/fLh9o7Z/Z3d9Lndnjp7Yjim4ppn6t774FAXyn8idQCfXlzux/UN6jvv3Tpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxEDdA9PLEt/zObOZjYuuHlQyl52EiQpvCP0z618eAI=;
 b=E8taeqHre0Ir/KKsqdY3NqqzgRUpJ7LmHyj+2eIhtfBK/dwy+JUYcpyPWC8jQfJfOAg7V6Lry97ZlnWo3HR0V/Prt7Fbp6lF/tExdTrloPYoc/0DJr8jDPPl2CGN7IdjZ1+AQefBkXeVal12roEQt1IsYGGQZGu3Z+jYvYueleDmlPlqWfq54T7rwyhaluvlqYgd1v31+57/xxzSVJpZfUUAn4TXBq9KnL6GLf6hBEmXTeBrNHuo2mex8vsg+QIxThcmiMJDSkSugS2mm5QnnlRa13MzDDSfju+aOKtCagbshv7B8MF9d82/BklVy3R+Aa2cojhpmbwMZnEbFUyd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by PH0PR11MB7587.namprd11.prod.outlook.com (2603:10b6:510:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Thu, 25 Apr
 2024 13:44:10 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 13:44:10 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] openscap: upgrade 1.3.9 -> 1.3.10
Date: Thu, 25 Apr 2024 21:43:58 +0800
Message-ID: <20240425134359.455795-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|PH0PR11MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: c71a8412-0e3e-4d55-f480-08dc652dc8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tKk7hBKxrAYYlWsQGDA+rgQZxDU3mrcSVrpqMR8r6ZGkj0ztoZ0IMCB3jX7Y?=
 =?us-ascii?Q?BMID8UE0iEXcUkM6LrHBYPfyxPUcf3aYNiD+JuxseIhJiocJBr84ktTy6xh7?=
 =?us-ascii?Q?1WKTvnYeo1vEn/u/GwCYuu1Zc0lLLdpmM+q0Nj9MYXv7ifc1vre9CZRXRaRG?=
 =?us-ascii?Q?s+g/H0V1fsZHY6xdmd/Cs7eUu59+H1IZhUMx+MUoDCVyFCQWE6UgeMgrv6To?=
 =?us-ascii?Q?6jBzKPnkfV8bkAMuKp9rMTDnxtL+lagzLVq82UlqaEg38WFiw9KmGpWCJOYB?=
 =?us-ascii?Q?X/hNjgcz7NaMs0j0N7AMIJG6iDiBKHmr58FyWbXH65s1FjZ6ZyGZWdjRab9R?=
 =?us-ascii?Q?R6pzTfjtVrwQkJ8wRZXsZGD99fQLoja8HlJnv0VZrGzbsAmGAxNdb+P7km6Y?=
 =?us-ascii?Q?4Tmj9/YUrUtlnV7CkPwvUxwl8cGFUGDGtR5FROgAAxSkyL6kuO7S1RkCv2Oz?=
 =?us-ascii?Q?4hTtlTp/LMvLFvj426GcA+A47Yr/4DZ3M0a80t0WFAFqjS51nsjNwdy/ED6B?=
 =?us-ascii?Q?oNZnxM7IKf/AAbFZTMfm7H7LPdfcqV8NenKcOQn0Lp8pXXELiL90QDSpcP5j?=
 =?us-ascii?Q?72JFTVwILmHIw+HX4CZZwKjBcIAR/D8eXPhMKptYBXfTia2ReBVj8jxC1oiU?=
 =?us-ascii?Q?qxBw6R0G6t7UOShX9sxA/e597ntfroc2qOo8l4Ezu2vhiGwVW200YHSLklLG?=
 =?us-ascii?Q?phcXTuJ6HTFsNOKBiaIjoV62vPehk00z7aAI/AaPRJ0EIdy7wNUQtIeNnTba?=
 =?us-ascii?Q?3pFxR/fXSqCWpkkpVoNxumDzb2oYR3ls0E1oii/4rwT2O/oh4Yjni19gNYwp?=
 =?us-ascii?Q?lUHsEr8VvcKW7oN/V3pHPFS3UHcGhFCVNN7iM2BK+wcJJLCktie+Y5Y166La?=
 =?us-ascii?Q?jCtlk4lZ6Zy0Niy/a/xYVaw3sz4lQS8QDsCCzRInrICgP67Qycb1Z/NQfnYN?=
 =?us-ascii?Q?t1pyMtYhusen24tc9YxRHvnLia5+ZeJWA3otGDoXQbeYKFtmkx1+SXmdeRlp?=
 =?us-ascii?Q?FRELO6zKOh56k2JdzSUqsDHmbCJ8gP30DZ1MVydu0yVuJKghB0Bs+xZ431uu?=
 =?us-ascii?Q?JpgOtM2NQmLYsmoAST4vEA0FZrrPpl2HT7M3WIFb7SI8Ov+9zQ6+z4jLNVGu?=
 =?us-ascii?Q?rwpHloJUoHpy9XVYvrjue6wtMMKCoOjF1+xLCnScfMNCbAdiCRr9ZC4yIkk/?=
 =?us-ascii?Q?6Cnb/wkTclzK007Uy9zjt3gxSYT3t7u7yj9sCB7HlObYNeJsPj7538p4ED8U?=
 =?us-ascii?Q?mqcIdC410TRnwphZG/RX015Oqfpto+6ObYoTpJsXOfp9fn2Lsxr5PfSVUdXi?=
 =?us-ascii?Q?QyNhuZsY79q195L2rkwtCzZoetMw1B3TRnPfRuaXc88Isw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fl4E4/h43AP2elAcicUD5LR4maT/8JmW0jGg3hvmxAFfxHRUZYZHk28TGr/I?=
 =?us-ascii?Q?kJ6ZeGT4EfYTWJdRUL4cQ8tZKf6zlWegNf3PLc1H2Dpvz95a0kaF46KjP1SU?=
 =?us-ascii?Q?EM1kwg9QYW7zoyhBImV2VQ/X7sDdTU9X5f7d7JdSxBO6i62rsEdeihmAKISM?=
 =?us-ascii?Q?usvuupzroRaTITRxG8tbFHrwvoJz8QV83zfanBuIV3g22edoUHRV+hBrUipf?=
 =?us-ascii?Q?HVFPTtYIm8e+egYKXenUq+lsMp8Vr5uDCtODZrvMftE1KEk7QAx2QrKw/r7s?=
 =?us-ascii?Q?dNh5fQpCI4XcPLS0xmVHhUxW4RrGscL9p1qkXMT8RNzucZAHe8wvZ/S6cWK6?=
 =?us-ascii?Q?XgWpJaq6wnoN5X10h+KXODTQikswDGf18J17c/dUJfjQelaJypUunFUBDeOq?=
 =?us-ascii?Q?Zdg6bYGtWOslRVmDp3M+gUxdQvdHvm0UX35EddBb9Eu4UIp41F1v9KlvQuGt?=
 =?us-ascii?Q?MMJZknYw09q4BqAaRvy1IIyfrxwiHk7YnUT95WtBQw3nnQummCcUzFiTPL0Z?=
 =?us-ascii?Q?tt/CC/3WQLacEuBrxfnI3HwmhxXZJGs977rUDXi1flUvtcuwOEjO7mZbiRP8?=
 =?us-ascii?Q?e/MifPBNPueQc9TnWS7XRnfSV9C3pDbqxZBfWyhVWdHwY2xZWL0eGnJkjeFY?=
 =?us-ascii?Q?GzdUx8bno4H6nAhdvZ2YXjtWt3seZdN2nLVwhrkX4sAMk78xvY3TFlPe2wHu?=
 =?us-ascii?Q?y8kTDNGrg5QSewhxJjPTpkqdtaoa28D+lnyO5hBqQgvVJHTxwQoCGv1PEXYV?=
 =?us-ascii?Q?g8S7jh8fpJY8rsGrWGzJT3K34GpBy3yLoxHsTS2/lieGUx/Xz35SRHqiZQv6?=
 =?us-ascii?Q?YPkXgId8bXcAeT60M8XvkncIf62H3G88WGS43NAzdL7erP/XzoLpIqnkpmqK?=
 =?us-ascii?Q?4JJLwYqGlbwfoTkpOb6zYE0/7awb52TihmrD6m87f+WvuJLtfmaFAOKS7OK7?=
 =?us-ascii?Q?9iThWY27nZM3DzGOHV9oiZldo0suwTu0S+K2xjPXtgfKY61MREcH+VSim/QS?=
 =?us-ascii?Q?mAYSjUiH0sIe9Mt89/KPDhDSEENMrkVnUc49FD2tefXb6jpaq1rENbGkYx4i?=
 =?us-ascii?Q?+3Ievg/lqtlBfgXhyyGNG0SwvtCeZFfr9W+NvuzfaPqOYWsPNdUJWOYQEg2C?=
 =?us-ascii?Q?Fhd85UGshCIP+Xlb6AYr/mK830JJAqDyPE55Dz7ABmV+kV7Kaxn6FbbSrQjt?=
 =?us-ascii?Q?UiXbgDWoXTZRxB3M2oj7iQI6Xiq+AZ0hFVoEZHFxUVaMtM4Y8u0XOWm0QcTz?=
 =?us-ascii?Q?zJPU+49awphjVNhf9LJhCUOlLJv+ZgetdZ0Nhr4WZzxg8u7kH+WpWIXir5bi?=
 =?us-ascii?Q?I6yo8sR9Mw0x8Qt2VaROHR7E+R8i3t+Kzt/0EIXvpqCZinQJUBlbhCyRZSLL?=
 =?us-ascii?Q?OGn7Hpzj9ODrlGPziFPPVt+QZce2qlO9ZXtymxCJz0R04x9R2q/cIifKBSSh?=
 =?us-ascii?Q?GCcsrSh2Xnl5s0RvS4+vr/aIWgxUNQGMeWch5vJ6qpf6rpXJIbWuR21eHGlL?=
 =?us-ascii?Q?en/hSPJ0pu8+foFub9TgbPHYmVikn6rYcuECzYC5FfBPF3xnkXdZtdFzH7cu?=
 =?us-ascii?Q?MKwCjMHdKhy7BLc4IsMTCaKJpvVQ94UAmDiI2VyP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71a8412-0e3e-4d55-f480-08dc652dc8fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:44:10.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5As5KhZ0NceSaXAGHKnerQyLSRPbWR9LOreG1sxAPTCaaPK0gz+GiX1wDe6ko5Pp5mEAI5o3RbLL0gIweglEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7587
X-Proofpoint-GUID: kh-s_jZaoYa_XmnOyRm-ZZ9iLk5-vnfp
X-Proofpoint-ORIG-GUID: kh-s_jZaoYa_XmnOyRm-ZZ9iLk5-vnfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250099
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 13:44:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/65
Message-ID: <20240425134358.1mg4WngvpIooUGZ6PkqhdRIM_I8HNkucyT8AGkkU6Vw@z>

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.3.10

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.3.9.bb => openscap_1.3.10.bb}          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/openscap/{openscap_1.3.9.bb => openscap_1.3.10.bb} (98%)

diff --git a/recipes-compliance/openscap/openscap_1.3.9.bb b/recipes-compliance/openscap/openscap_1.3.10.bb
similarity index 98%
rename from recipes-compliance/openscap/openscap_1.3.9.bb
rename to recipes-compliance/openscap/openscap_1.3.10.bb
index b35ce9f..d3e44a8 100644
--- a/recipes-compliance/openscap/openscap_1.3.9.bb
+++ b/recipes-compliance/openscap/openscap_1.3.10.bb
@@ -10,7 +10,7 @@ DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swi
 DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
 
 #March 18th, 2024
-SRCREV = "0e7f654570971c1acee6dd3f34b17121372d6152"
+SRCREV = "6d008616978306ce5e68997dce554a1683064f8f"
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https "
 
 S = "${WORKDIR}/git"
-- 
2.25.1


