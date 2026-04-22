Return-Path: <wenlin.kang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB7F9B608
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 10:08:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78839.1776852481661705099
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 03:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=VOEwB3E5;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8572b2aeae=wenlin.kang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M70EsI1077112
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 10:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=8l2latx8tKJ/rLIpC99Z
	OmUgjIuHBIabgTTI6k5dcbc=; b=VOEwB3E5CYgwar95G5fyVhGiwVhmbkCuvIrU
	5k74pFhw1DYMDWk262Lp5AkJgvwwHmAxxr/ht/QmhP4s05ltuDFCrubiakH14Dfz
	iI6SWKYDldH5vE13HRKLy7T5Pql6oWk7CmzGFfLL/lqAn3sLarVYHjAVelFoh6Ih
	XHTDKu/x39nlfi9CeVk4jg6YvqVd8XdOZpdx3NMSOjcLvSsbHgqJSpENMtpBv6n3
	4W/oLGOcI22YT06ahdwJK4gv6LIeiC1xzOqEBCEpQy+s1VZdE9Zka24VlfA8MFgR
	Geo/aA4AfENgm37iHuzsArT0OO2KNc4ccUoqzAKSL7Fhgw7slA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dpenv8rn5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 10:08:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh38EK1/JhpKc0Q/WjXoy1sIUM0Nby1ckpyJztTULMNtTW/8Ol3p4WJak5TV5FpnMZ1P2HlOxbJ5tF1wQ9KdvHjNchyzizqzjn7sFdiA/l/KQk2xkdQTUBSJMfNI/LAO28dKOW+mtC0KI//8AKfjFszy04oOm56m3pJvP/s02lqdgIHQKXM06JVdT/shCCJitjv+2/7uRbJEK6qWWruyYm3Wcm9B/6ipXxiiLhAOA574k4CkkOfAntWEj9cOOEL07qlYxWaE7PqrlrJwYJcV3kmLiNKV44kFrPPRKTYyg2fKAHfFcyOPqpqzYvZ1Cia+yGvpOiwqWBDOQrMqSSoNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l2latx8tKJ/rLIpC99ZOmUgjIuHBIabgTTI6k5dcbc=;
 b=d8/tvLb8g8HaTGtPqKxhm2Ql3btfNtIi3IAxNwcpbH+B6YygpMECr06R0CTsvZHpFtljCs4s2t72WJI77pfuyTnp8Yb/UmCXkLq3gQENuowMGplLl6PVxRbKgYkYauMoAViHTX+YEc44Yw44W++QKOGRL8zmMCB2D8tvgdjvgTBRbxSCFhYEhO7NuThs+UE4hqEjcx91mMxCbPGaLSkURXH7qkL/snZNIpOpCljBP6nZ2Q7Ktz7UQJIT4AF3/jAKZPhjF+yUCVAzTxzdWGrKU3vwzf19ODSIfRGSFVQ2LRall3kXC3JtlT8WW1YsEx6YnkIQZhWDwVJIYdxxrxsulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 10:07:57 +0000
Received: from MN0PR11MB6058.namprd11.prod.outlook.com
 ([fe80::afa6:26f8:72e8:6a11]) by MN0PR11MB6058.namprd11.prod.outlook.com
 ([fe80::afa6:26f8:72e8:6a11%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 10:07:57 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] krill: fix missing dollar sign in FILES
Date: Wed, 22 Apr 2026 18:07:46 +0800
Message-ID: <20260422100746.1757221-1-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To MN0PR11MB6058.namprd11.prod.outlook.com
 (2603:10b6:208:376::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6058:EE_|DS0PR11MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b42e5a3-81d2-44be-f15e-08dea0570715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	M6jNQ1biqgdC2WD+yYnx/OjRMZ3vTy3ejE4aAJc+3D0FsIeUZYykCE5MZF43+U6UmkA830DIRF8+U0MBMI0ECXVsVFMCwwjtZOiJUc7/1h6QYNBgZzjYUZ4hL1dymLgfbt6gGGas27sKQ/GCE+PKMQGDE0sqDk27c6TgMD3rgB0gR3QZco0CYQN6D01V7Jwiuwh/fRCqwRiuLWCS+nTjiAAv/4dmEm93mwugzLyMgyADtvTerp8ZXFijsa77faG3DFjokYiy8IQwG/gfrg6r7s6isiQ/4ObuR4TO+9i+WPIQj0/9Jnn/tsjhomwABGRl1UlFHRHnJE8EZQ141FrXYlTvxA7vPr+lNg7dbqDuHPR4vmtbv3Wb+ORIoVtolx6bQdUYIuGO4NJPEDhq+1IpWDEhVcPHpRCYC1288pwHD7NXqZ4Ssx3uU9zzNuHafnYsqBoYVRDnPkCKjbghQyoyugMh1I+AAR4uY18F+onke4Rixvjoh0Y8y/DkuNuPLzx5Q5zdOd8BWhXpRpED0NIFtZNPyJo7kIq7a5eTuA9Oh0aej8x8Mqi8qccRp5+811GIGArL7kU7p2bXBfzqYakC5EwpV7XW2EJcP0rPsDPu5ugb0amHtvYwFdx49BP96cPlxrUS2lWqH7Ra5DzPjN6DjUgVNJ8NnSngIcEwf2c+bK6oyvDdzIaBwHejr3GVKB9E+GUQrbMe9BzeCFRV1v/tJI+AQN9x4tPzvlthY8FTXATZHockQ0WnrdNZuoiGf2xpirHjwo9Z8yBNdIrElo7UK1wzQq4tJkP0tVVu0DISTRs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6058.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VuTmz9GrbqeUkBVoGeOajHkFQAQuY0KDftm2Z55iwetrW8Fqkuay3BeeSd40?=
 =?us-ascii?Q?T4Sez1C8UkeFpSEvAdX67h+tH1DdmmKrAC9swQ7PGrpx2nz6txt7OBagVgtm?=
 =?us-ascii?Q?aJWW/4VoYFwFQxzQSjhDrEi6oAHtMcbQDI3CYY82CQ+BbmI8herTOr1Evhih?=
 =?us-ascii?Q?9yXuMCF2ffBiC2m4CMX+6C6FW17ZJ9yzJNyY535b7q2JRA8rlJJSouEPakyy?=
 =?us-ascii?Q?mPCEOmjAMXfhbLd4hb847/ee8j5soqzWSl3ly/M91RE6MEonR9sB8Khort+G?=
 =?us-ascii?Q?e1vKILZbVuLFeo1jLPLzSxQdKtlV+YyACtGQXdsx20LCKNxeTOpkikfB77kr?=
 =?us-ascii?Q?G+IXfGkbxcD4/YeZZFX211n8oZaIXcXWIA4OEiVu9TrbBw1psEG/1HRKmMjL?=
 =?us-ascii?Q?zMJVp5bq6QOv4iZ6o3E4DKLHuuv3PzrWQXB4kifH7N40mTQB1CZ5yq7T67I7?=
 =?us-ascii?Q?6i7CBm1G5R3NGi3DFOdQOAnEcTeMCHdzEv96DW/OuGOv2BYsXNQdSarVszDz?=
 =?us-ascii?Q?uPPBIfSeJZKnvtklcCJ6IuztiiMP6nFCBCbUtyLXJSin4ojqiKLr2R7YpL9F?=
 =?us-ascii?Q?QdrM75lfCgcQ9mVZhPnexobWLpVsTtnQFyZLZAaP9ecv1dZULw9XZduGlV6C?=
 =?us-ascii?Q?8CMllfh19rW/gakx30+7bCcXfz9aAkWhAfoUpuRYr724tFFE2MoLRZZLwWFw?=
 =?us-ascii?Q?qkArgVN9N3dNUqTg6vZXM+BHFc2lbRsCKPgODImXpVNr5WAJ5I8XPc5B79uE?=
 =?us-ascii?Q?4UnVKj9EGElwEPJQSTBSUxCO0oUebaf64qiqP57m4zyFiROrrrfoiWjS2nZ/?=
 =?us-ascii?Q?9XWEwVTcSpJjdGOaNtRQUjkYAdNprRBSi1GyoI/d6exZb774UV213U5LZOZB?=
 =?us-ascii?Q?2Ufky03IVa/1l0D8BKDkYu2ZxX6j75xJL9+y3YA5/ISj4syMT/Ge9m2MFMb6?=
 =?us-ascii?Q?AZWSj+HSDgfPlMaWooZqDuGhqFcWSaRgPAkBilK6m4hhETvOiB9W2yM21nxF?=
 =?us-ascii?Q?UV7eZKpZRq8YSAYHRiEE3AzqYT9Hwpgs8ERZULDPR1ZbeSh/mY0RuWtvSlTY?=
 =?us-ascii?Q?FNmcMSNTVNyNoMkPekauJ7hLrt712CekAe4yGHkQUsTD6Z7g8uEr7A9eqPVu?=
 =?us-ascii?Q?srqwo0Ox+lL50Gcl0HZfN9uoVzKIE7A1jmmWYWb4SQpJsyx6pmHjjBQuVFj7?=
 =?us-ascii?Q?YaMXV1SiSrN3cztMjqorR2zXK/upnwOjiLna9y9e+fb+E2ZaoYjwk4X4NOfA?=
 =?us-ascii?Q?rRp7ejmfZH5ymm38+Mi3QLOyMsoAFOoarKdf7ThBeBesKzgN/ceEVVp1rj8O?=
 =?us-ascii?Q?TbA03RXR42eds1gl5aCGDQrA6NUcm/eJ9kcOSS1uhud6aPxxiAFuGjy45q1i?=
 =?us-ascii?Q?IEPNrMp0d4x4ldMJW/hfBMd6w3A//LPuBY6MvvN2szj/AFkClkx6Ol8Oq0Ea?=
 =?us-ascii?Q?0iCD+5THA9AsluFtPo+Hu15I/YCz4TJS/x7wFNmdr3uXhkUBUFCgXREsEd/e?=
 =?us-ascii?Q?E2lS1c26e8DUYzu6FSkSku3tLfahcTEV46RTeXI1S4mC/tzsz8SryLdzXRli?=
 =?us-ascii?Q?T69giaha7vsR8vnlTzgQ5Q9kyEfxmqtebIspklLClmAqfMaHlYFNNmP1JryU?=
 =?us-ascii?Q?M6WGXnamHQjBilg9t6ff0wzQpNQTku2o2wcXFQMzmH9HbpwfkehhAcn1AapN?=
 =?us-ascii?Q?EDaBWjkmVsFRqBAO2Mq43ftaT5YUjhXzr/n2qInwj8EmbZv8FhFCzA7SStdY?=
 =?us-ascii?Q?O58jjMWXuw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	pAobE3kTXwoqgLpUa5FGTCLJMTFDMGzUu69jtyyXP5V7keaqLqAH4DS1cO2KCALzIhKOlI8moyzJsXOeB0NsHTvDkJVpCxX+Fg+5MWIM8jDUg/d0O4ER0awBlsrU25kochCvN/IHdJ2dHCdlAhai89WWOQE3GjILO994SWnskvbAZkl55qAMWslyjHoP6GA4ngrH1AQhoIeyB40FB4ZkLG7LjsSL8bkLKkJh3ZqMkbeCzdO+/YZ/dIuDvtf8elEcBrks+6gRYhpmlIJ8y3jDt6RBsN+zmMmvr9CBHca3jhGzDvzj7pPPzLUGIWoyhGrYnJ/TMAXpVuWscVYdMdEKGQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b42e5a3-81d2-44be-f15e-08dea0570715
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6058.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 10:07:57.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWjK3b2dJ+j+7k0bl5eb1/fiKL5dy0m/d8QCCVIf5qye+2ZVqW2qBZGEhRkfoOepaQLY+xMeZQgqHjT65ezovfMaCWuD81wuwb0+SGzfrYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-Proofpoint-ORIG-GUID: n6-ybUGrIxBzJcZQHdLYlxUeG1nHYGss
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA5NiBTYWx0ZWRfX9EJ71Na0Eqj6
 Ktalhcx27uFMOpqQFp11GftQ6tJ2m8JSVu0YdeejoofTYEuSCdBQ4hbtMLsqtG6bHQbsrH1Rudj
 8yWIaKrITYtcCqNXo7ifZ7TeO7+1RTICTfoxXoE1kmg6qBRp5SlMmd3601mDeHQAYI7cd+UARA/
 KOqQtIjpJkAj5q98zd3GuSKOjOLltIR9coyzapArOobYerMkwlAAsTbejc2QRLf7r/E1FhO+prv
 mv1y6iBz8UXK/ZXM+g0TAN3dTll99DmdXYEJcCKQFOcOVlwxL3BgTNvGxpC0oQojAvL6iYhLS1n
 G5/wxIvAlIdXSaiKlvgBSDGRNQSTe654JbMeOXw6Lza3r2BxD+fqkrfSrIVaD545Sxq/THJKEA/
 v+utEUBwQQOE6jNeMVQc/JrQQfDjLtREX4kWoO5Wet6CNxgJl4NxvVuzjM2QoSLANn2GB/KiEtx
 qyUUKosfMLCWXegGA8A==
X-Authority-Analysis: v=2.4 cv=B9yJFutM c=1 sm=1 tr=0 ts=69e89e00 cx=c_pps
 a=F3cLoQkZAZJ9C40TIYDoAg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=36AIFRY_graJGeHPWcoA:9 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: n6-ybUGrIxBzJcZQHdLYlxUeG1nHYGss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220096
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 10:08:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3758

From: Wenlin Kang <wenlin.kang@windriver.com>

{sysconfdir} -> ${sysconfdir}

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 recipes-security/krill/krill_0.12.3.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.12.3.bb
index 472bac9..2a10584 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.12.3.bb
@@ -37,7 +37,7 @@ USERADD_PARAM:${PN} = "--system -g ${KRILL_GID} --home-dir  \
                        /var/lib/krill/ --no-create-home  \
                        --shell /sbin/nologin ${BPN}"
 
-FILES:${PN} += "{sysconfdir}/defaults ${datadir}"
+FILES:${PN} += "${sysconfdir}/defaults ${datadir}"
 INSANE_SKIP:${PN} = "already-stripped"
 
 COMPATIBLE_HOST = "(i.86|x86_64|aarch64).*-linux"
-- 
2.43.0


