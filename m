Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C65C30653
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 08:43:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5864.1720082619772713758
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jul 2024 01:43:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7915407677=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4646L9Eg006559
	for <yocto-patches@lists.yoctoproject.org>; Thu, 4 Jul 2024 08:43:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 405jrsg9ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 08:43:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCyWKxTMvpub6QqkeBc/PgeEkt6v85h66VRpKIXIlapaoFWyToYqrE7wGAzntRnNMwVO1tZt5XkmmuBuLYKlRPeuGAKjZcZv3GzGIFTuYGYzeUi2Nt4CC+elNUQKEb8/+hkkVfGIWcBZo1VIHfaA9mqS2/ttPtboYY4hlaDJ8cWBwdvB9MesuTc4yxALQqSrsBMiyz/7Y+8OygfftEiqvfs9I6mOBUUv2PAOtsFh+3UHHXh3BIIPfhGYmYg9/aNO9ndwoydRN6vbp7NizS/RM5YnyWgaxVhydhJ3VMi2uQi2q7/PQk4Bi1PM22Y9kvZcx6OInnTiaTPxNVUjRTPvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiqPAQ9VQ6wEwPdA987YDnpiz5XYU/VrKzUyAhV0ai0=;
 b=THjSHIq0E0MjUsvjak/SEw+iXQkD1YTVZjy1QDw12ML2EFhuDZLK+dCtLazfSu4pXsTLAL+GHq74J/bFCeS3lNI0BItts0Mu9OyIe5+4s06bU9AzApjArUGkPdU0eWDL9a7gnjTA+uvY0BF9K8HggWfYcul3GInW3CGha6bnnVxqyX1A4tSdXOxDbGRMvCLRJO2JjHExB5mz1ZZW5ER0qx8pPg+r+tKkEMhXvGbg7Fa60DCXP4t0Sh87JjNMWZJlm4ICwgESTR611jjjxnTAXEF9HGAADvUkpJvFLBVmhpssTarFpHLlO8uxrZulrAj5UDphVgZbtpDgmpDF3buh+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Thu, 4 Jul
 2024 08:43:35 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%7]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 08:43:35 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-patches][meta-raspberrypi][PATCH] parselogs_rpi.py: remove empty and problematic case
Date: Thu,  4 Jul 2024 01:43:26 -0700
Message-ID: <20240704084326.3899266-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.45.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 1576edfe-1d60-409f-492c-08dc9c05644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tj/8Cnzk94qtyFET1mfmEh0wd+Ck/r/3RbusRiqn5NuYlTI8bA2GcLFwgeGo?=
 =?us-ascii?Q?gGJDj8gWpOJd8gVsH2U6TkOfmw/eBdK66oasDEi/iS545kmeB6auVnNAeBQY?=
 =?us-ascii?Q?rpozHc1G7V1XfTxk6vjXfRb8rAjpaO+omqaRTl8TYaTHTZYd2E/6pTM4BEtJ?=
 =?us-ascii?Q?JOTO7mLcOa+YA+PnEeQkhHSf9lfkGTMHSSLDzYeCykwdk+WSS7d4upuVjreK?=
 =?us-ascii?Q?0B/chg8RO6Po6v38rWu25MDDW6jm9pDOV3fgSek9SYsgSt18XDzafHbhDlY+?=
 =?us-ascii?Q?9q5LLG7sA77gnKquzvVVNPsP2m9EmMuuZLAAqsmipXT2TWxMBmstiaXwreJm?=
 =?us-ascii?Q?cCJSdUh5I9u35OPXodShEJEgeJdrvyET9/tkk6sxcLXZNe7/gg7bis57GD5j?=
 =?us-ascii?Q?Vb7qiHOZoTQfa1zkrEziTzkm+HbiU0IPIt6NuPgwoUDY1kebFq1Y2YR8QzcH?=
 =?us-ascii?Q?EgiCs+PdNU8GQjWo9595jYq/Ty5Ok2/t8rV/CvSBJgXAgjlnTmKQK/AO6IMm?=
 =?us-ascii?Q?Jmpz6kP3s4HZeF/91aP/7+JhIXQKRokHS7hkzo6r7tU5W9MrPUREqo+6HSrC?=
 =?us-ascii?Q?ax7MRHrt+G47yX4dr4SJmRRkKSoFtcRwl/DfZIydMzJKsnzXp0701r/GDH3R?=
 =?us-ascii?Q?GTcEy3f8P9kkiuhXFwZCu32IBQRMCAzelqZxm0P2KgricCBO8Irv13+TzTTA?=
 =?us-ascii?Q?98vyLVlIHKU20MuaVVToT+d0cftFuPpwbjh58VfAd4au+KZVQdmuaiuh9yRh?=
 =?us-ascii?Q?JDZrnT6m32EeDDkFneFQ65nGlRwQM9JGlxWNdhlyvR/peQDzfbwmATmySHjw?=
 =?us-ascii?Q?me50YrQGN0z4hUZXO1FunWlvuQyN/I3W8AVkM8YacsYgo1r5L27TP3qX3nEB?=
 =?us-ascii?Q?HG6ke7FqbMWFKZMF2zLdd6A0b5BHiibazpK7LEzy9/8n/BeE+3rNyJnAohQ/?=
 =?us-ascii?Q?NR/h/N4gMZu0ptmwjYZvRBPRbKwnuoaTSFryYTIVpmG6BubQUnJUho9JPeIM?=
 =?us-ascii?Q?r7HfpWiubqBkch9ZapOrggeGtK6/G3P+NGZXyocEQ3X4kml6txOii2Z7nqkH?=
 =?us-ascii?Q?JLGR4yj+mztYEf5FawYQPNQqBT2J94qLXsURxshuIUUGeUlDLa1MTsnI2pLq?=
 =?us-ascii?Q?E4bX1fQKL1AOBKoLW+XWfy1g//tH1SotZq6IMP8m+oo5z9OKWT94gnb32Xue?=
 =?us-ascii?Q?k1taNiyvJgzArOUJrm/M5Dmk13jPbl5LBdLJrXRJGjAGSvSLRTpuaWNJ3RUv?=
 =?us-ascii?Q?R7YrVD79Jo5XG+itlZYtQthUbyXxMvAtVq55h2YAAHLx+SCPbM2oH9z4HH+H?=
 =?us-ascii?Q?85r7n2vglU929ghamOREqUJ0CnhHSvt+OTzoImcm/tXogxHESJCM0gSas5a+?=
 =?us-ascii?Q?yDN6KUz74g/bGU3rx3FtR/FkuPcRvFv842GoSNXPmjTQwNyeeQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JyOQIVNDXPFzxmQBIUs0LPnuzS2/MohHv7SNiGxnq70TFgLvaTHdtsrZM9uU?=
 =?us-ascii?Q?5oeeKIMRwcE5rQh3dgPjKawH04uIWxO2bSfixU3NyTPaOlRCtfgH+D/QuUB7?=
 =?us-ascii?Q?YbLv39+ZcWxeLPFuORFgE2FbV7h1+ZrJpmmw5OQlDRwVQF4mE83m8qGUH2Es?=
 =?us-ascii?Q?PYqIgGl20W3kzoMC29gqPBQwKbN34SV4RTKZoL3Wbon7xf0leBKjhM/Bb24V?=
 =?us-ascii?Q?HmPV8Y3SnZx3/asj13zItqF9RTnZ3LE+l4obDx5nGnwYPHh84BE6+2Awxl0b?=
 =?us-ascii?Q?xFHWxkWPT/SeCZLxfU4aHwdm7KybQFBcXKRWD4VMb06e0P82FhxGl+2I3PpI?=
 =?us-ascii?Q?kl+6whVf2rXH5ovF8K/piptSGTHArR2LzDp8jcudSoofRrH6ucJN2hqxHn83?=
 =?us-ascii?Q?w9VHNsjwK24vlV9ecOh6uu3IrXdP5CzLNSZCTMR02P82eO8YNoLkpxdGgrC8?=
 =?us-ascii?Q?L/oN8SN8HXwF7SnGyv+iH+L02E2trOc8/BMCDkFApMnQGAIc2+EvGKFgLjTx?=
 =?us-ascii?Q?t6Xv98tpuQpq65w19Fhl5TIW691wKCzxk/e/aq9JTAW5RsU3egeWNAVCx+Id?=
 =?us-ascii?Q?VreGarPf1hy/n+INkX/+QnAQsy7iGpfbbwCeoIaf4TQwr4onzXt3d60bcEHg?=
 =?us-ascii?Q?ndXodEwclVctXWI5h6I+yOyS36Q4JTpb9ZBf8izdcLGg4GNZEr5r9QDkxsIJ?=
 =?us-ascii?Q?jBC6LzhEe1I3O+SOHwKPZrH2nxqY1SqVozd2UQDei+DLrNzBG657LVA8jRjQ?=
 =?us-ascii?Q?sTI5ZyxPpr+on65wZhmp3WA4Lcgh4InBMH4NUoQj8L90tAgIDvquh4h8V9QF?=
 =?us-ascii?Q?Vqka1dvwMo7Y6VHT+kqMgJEyP9odWY4YzKVwcjOAlm0brwIPr25tm+cE51g2?=
 =?us-ascii?Q?RxS/q2YqECJf761RVuI+0NQtbubsSS4Mo2k+7He5/pivwTPvA34YXy3Hbwnp?=
 =?us-ascii?Q?o7nbvH46gpGIKtc822geBiInu/f9KEUKp+Lt8RUacRqBjtiNLo7nl0xoGX9Z?=
 =?us-ascii?Q?MhfL0CCEhBkOYdxAaxLBmAklo4/NPsikW12ITcuyBS9GemzYN7TzlcSePuwU?=
 =?us-ascii?Q?5A9kJTpGKMHvtCMKRMxPMbdRw/TpO1zS62JGHala3t68ZoXQg6TWlbBAa77y?=
 =?us-ascii?Q?PHP50gVNyYu+wtaDS5W3BY99O3CF4Wnyc4L0ewV1N838C9+nL/VqpABtMtFW?=
 =?us-ascii?Q?uHkdLqGn1F554HGiX2SDnWWwFBiMRB9Ki1oyaqoWI5ttGadkT4xtaIEvu6nU?=
 =?us-ascii?Q?Wi8SOQ6hLPy9jypNP7P5Sg/gEgRQ22uPqncRONyqMGcO75VD/CWaZjmWUexk?=
 =?us-ascii?Q?oO4US3oMyEY7S8ZHrt/mxsYvIeqFoS2ixgrIT8RcYkhDcB/H12HjwJJkXVML?=
 =?us-ascii?Q?Q5czJV5U5zk1lqnxrzs7Oakxt8Qbh53yFkBNoqj2PdpVLXVY5NMW9lWMEGDo?=
 =?us-ascii?Q?e7XR+rP/57muByF5Cr++11IVNV2HbUvzuj765t3uvdGv+GU7R2ZvtezIVI2P?=
 =?us-ascii?Q?I9E1igdTUR4Et2Qhie01f0XdvU6sGYD4d/4uGNdU4vGxJjqQfhDUfI1bCc5J?=
 =?us-ascii?Q?CMhK4GpY+U80qffQk/MjOOrncvN6ZjXjxll5tRkhmkybqQUp7QkRoikAC6q7?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1576edfe-1d60-409f-492c-08dc9c05644e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:43:35.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvBjG2V88F8MhF3Bi+KJl8867yK/b7TqTsYqPJy9NZIDlIIdyTB8TwYCpFJukv963vnBZV3klZzkJ6EXe3oQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-Proofpoint-GUID: 6Ot0YchYarzN0GLbcd1eKhNKwpbUW1RF
X-Proofpoint-ORIG-GUID: 6Ot0YchYarzN0GLbcd1eKhNKwpbUW1RF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_05,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=915 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2406140001
 definitions=main-2407040061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jul 2024 08:43:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/411

From: Chen Qi <Qi.Chen@windriver.com>

This test case now is basically empty. And due to the change in
oe-core's parselogs case, this case is now problematic. Because
there's no common_errors any more. This means when this layer is
in BBLAYERS, any 'bitbake xxx -c testimage' will error out.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 lib/oeqa/runtime/cases/parselogs_rpi.py | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 lib/oeqa/runtime/cases/parselogs_rpi.py

diff --git a/lib/oeqa/runtime/cases/parselogs_rpi.py b/lib/oeqa/runtime/cases/parselogs_rpi.py
deleted file mode 100644
index 49226ae..0000000
--- a/lib/oeqa/runtime/cases/parselogs_rpi.py
+++ /dev/null
@@ -1,12 +0,0 @@
-from oeqa.runtime.cases.parselogs import *
-
-rpi_errors = [
-]
-
-ignore_errors['raspberrypi4'] = rpi_errors + common_errors
-ignore_errors['raspberrypi4-64'] = rpi_errors + common_errors
-ignore_errors['raspberrypi3'] = rpi_errors + common_errors
-ignore_errors['raspberrypi3-64'] = rpi_errors + common_errors
-
-class ParseLogsTestRpi(ParseLogsTest):
-    pass
-- 
2.45.1


