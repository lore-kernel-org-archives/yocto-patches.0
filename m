Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4A7C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 13:44:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.17451.1714052653740137519
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 06:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=c7PyOO/j;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4845da66b3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P4s5je020682
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	PPS06212021; bh=WtKNvQ2wZAh4Uk1DK0ys4l8MnSAu2Q75gO++x5AIpV4=; b=
	c7PyOO/jzuKMp/175mufHH5YCMOkazxvs/0uYDkVYGPhdalFAANULINXqAlQOJgg
	CyT/9Lh1C/4oK/X9/ZVbSMO6Qehn96mMnJDczdSJLV7uNs4wn3cw/Y35henITcCo
	8A1SO8CiGc34daztTTQF/aQHtIu920rGu6bEp5MberxkGN8tsEP4HOm3KrVEJQ/x
	G8CeqC1UKL/BPu5k+C63tH3fdz3Igc44lIJGKmjAW3G7YciL7LF23ngSwwauxbKC
	e7ikHuZdoh4+zMmzDvmiftqs2a8q2IIaLoixHb+3e3ts3N1wLM0pEo6Son9nvh3z
	Gprf82y1sVCcNJL+nrY4Dw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xm900whuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 06:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXQ4AiwmUqKJRT3d2uFxW54TfN3J2H8edQjGTL3RnYnGKlKAnFP0Z7l/UtvcwcS+exXF9QvUa6RF6EJfvRacF6d9g6/U7gOignjRcSXnOQn83HHuQ7gdfV0EBIZshpF+3vdS0Oimy2JC7pXcgQbrNerJYgLkVJpxQ5mgRt1UAk1S3iS9fPeBusn/MPxbJYd01ZGsjaS6OcVc90+gaMaiEVSWcJEzxBbahnXejDzrwFJ1+eqBby7vEU7UhPBicPcJza24+8fyRTDhycUw2fIDNXo5rlQ0wZyR+Cy32r73gb9trtG881ia5aUT2B9MfPiru41PUySO8Y9U5n/NhX5VJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtKNvQ2wZAh4Uk1DK0ys4l8MnSAu2Q75gO++x5AIpV4=;
 b=JX+zEyq2oXEx/XzFX4y7OYNNG3VTDdmsgHRxjlbKkEL0qGi8yjz83rw0/ZY8BqB1HBf0+lzhxlNU0PH0U3+hm8i/lAhuDWwO08jMvmo0if+8iuZ7FHHjU3qxQkmNHYbodvoV5yQGkeyN/gJWKOYW8mxeoiFLtFNae4pYRLyM3uXxQMZVu8cWGVrN6B769i7OkCXn/wzLkvK70OdJSfthM6hg2Ss40UrICZTfo0N+ALXcA481bA1JyoUGFeOa10PR7pm1daH6ZWTLShrVyZvia3Se+Is5FbwIkfl4hgW7yonOpTApzXwSs6LzPnSl34YDI37b3tvzE7LEVjXMpB4ryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by PH0PR11MB7587.namprd11.prod.outlook.com (2603:10b6:510:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Thu, 25 Apr
 2024 13:44:11 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::97da:833f:8511:a558%6]) with mapi id 15.20.7519.020; Thu, 25 Apr 2024
 13:44:11 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] scap-security-guide: upgrade 0.1.71 -> 0.1.72
Date: Thu, 25 Apr 2024 21:43:59 +0800
Message-ID: <20240425134359.455795-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425134359.455795-1-yi.zhao@windriver.com>
References: <20240425134359.455795-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|PH0PR11MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 6724db31-631e-404c-ec8e-08dc652dc9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U9OcmnPuZBt6A8O6gnlpYfQlZWvNKOwWIdamj9dPuiG62sHKWm/FY/KMQ27g?=
 =?us-ascii?Q?B2ZgdRFeRBwUvqMFkntOeN6tq9VoVXSOmsH3uGuRaR512/R+t8LnpZLjsZWA?=
 =?us-ascii?Q?7D67k+YJaQgAH8ebVM0Wkwd2JeTEdFu0xVzcOI6PSyaBfBHvNrnHlG54RjpY?=
 =?us-ascii?Q?6upAtdVQmVpSmkrAk30gLl23DN2D09wTI2a4FIRi+mFu1kDYhT/LMgDs4xji?=
 =?us-ascii?Q?nG0Jlysk+nRxHdgHOtI5974cgX+WXr6wz+CsWXgEBL7uWJ5CSrA3ygDb/U1d?=
 =?us-ascii?Q?droYPQuZnjtUhUrMnk7lelGnvN9ELyq+/3qpC5On4/90D8IKv5frn3IgXuig?=
 =?us-ascii?Q?XLWNK07rDtOs5gdtuGf7UDxGVVQd9fmVUl4hSUnJSY8C2ziPzXohhDrVOPUv?=
 =?us-ascii?Q?4AWisdQrkdtI/cACmAI7oh6NCV/SFdwhTjCBPa+QVacnkVM1ClDJK5qU5KsD?=
 =?us-ascii?Q?8X4zvhDYNtq7zEsgKOOz373N1JXa4NqJrJKhEPBaIM8VVsuwQhR117GWgip/?=
 =?us-ascii?Q?nVX/IJFTliAFQhY1Z8B1D9wYEEIM2xygjB9iWYCzevr1NbNWntV4/qGgtcfC?=
 =?us-ascii?Q?ut1AXRNsH2zGI3QCns5bmFta2e3+qQOQ6goQvIzrP98ZHVxmheHd0n3L7boU?=
 =?us-ascii?Q?kJMBEDBcrfg3CsdWT1+2637GJvkE+Zh9XHx5Pw1B40nfaYTkgzKdGSOQtd+3?=
 =?us-ascii?Q?ZeCgddn819kIFl0VLtahNJ1I2K9x444l1PpoH/iEnvf5Ui/tYMvFph+ucr1J?=
 =?us-ascii?Q?Jk48tJzmG+PwJ4ZLQECqfJnPBrtQtkX66/98tB/d77Y6238bWSUjSdluePIa?=
 =?us-ascii?Q?W8C+YyAMUIx3IgjoDrtu8lKs6bREmL9lFuxsfjLn6HGM1Pi1UCH52sy9k4mw?=
 =?us-ascii?Q?dLHyboQmxa3OSTScptLafeD30d7QSOP9NAyPem7i/eZJgAcUyYLK3h4EOdEu?=
 =?us-ascii?Q?zC7CSvzpeyAXMjqPGoqSKKV4H2QN4w9mNKYDijVcPr2SqqWyVec+DRvGaxS/?=
 =?us-ascii?Q?zsDPZpDmeoMU39UY7GHYeLrKHRnKD8KJC6eyE6K2IHVkBBWcvDauuBS6s/P8?=
 =?us-ascii?Q?p1HO8PJ+WGGoVbP6o5GwLAjHrkhfGDOAQ73m3Q/67yDxCrkH4P32FiLS1Ikj?=
 =?us-ascii?Q?IrtrGe/DhBe5ZWM4CSTdrjpeVEl9Lu1Allam+C/nx544sMvWKBYpQoYdeeGS?=
 =?us-ascii?Q?YqNvYukbqPtRLZkuD6ltaUe/8HpnEBsU7T18L2+P6ar06Sbp7dKRudjxnQKR?=
 =?us-ascii?Q?0zNxJzN4jw/X3qxrkqSFVFPru6Nn9ca2VTCCIKkSSw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gDdXKSHWO+jyND15qpdNzHmSjP5M1uXG/dYvq/jH1U0HqSp3NBioTrLXDu8M?=
 =?us-ascii?Q?SQAbI8yGkotfVIxEl24ChdgI+4MdHSONLs8GjKnaza/yUTNCEHJ4LIlxQ9dj?=
 =?us-ascii?Q?WgSzej+brtmQY/bFEocQ75QmxBge5Tsw/r44r9vWWuAkob0/uzc7CJxg27OP?=
 =?us-ascii?Q?2tKN9jb0Es6+k1TUI2PZyLCKHp0Sm4/Zmj2vY8zpEe7HxUHnAEwKOSXr7rYy?=
 =?us-ascii?Q?QXp170Ia1Zs3lFUFZQxWTVuI78Zvm+Qy6dcRrDKBCHfRsnfBIZmppBnlngzU?=
 =?us-ascii?Q?k0qTPiH/C2+7eO4Zm+Ak/J3MK494X8By7+Xmf3p4msn4GSKwAfSWDYIeOepC?=
 =?us-ascii?Q?p+cXN7eUgXyiYksIbhKOa3qSEEbrHufiZ1uUIcWckAqh0gd4IGmFwkIIhbOU?=
 =?us-ascii?Q?c/GVso5kK5vB9vZP7KPAjxztEajiz1qVTotRyxdO3z66HxE46UEzMqSh8dKd?=
 =?us-ascii?Q?CZu5nm/WQUSsIc6OGZJgydP/zVlsFdzPjolHiCu/Jc/IMIvswrhCYLoRDBwE?=
 =?us-ascii?Q?0Ln+evwe5OPmiMEzMUnMJsgcbsouyK8zWl/wciROrOAV5OJgTHqlP/BKVCbV?=
 =?us-ascii?Q?nflztPxcS7+3EVSyWQk0XtEnSQ9N9cwWj2McZavrpnEr8lUnlKtvkZNXV8rr?=
 =?us-ascii?Q?5VplSW6L/i+qB5vAPUieirhkFtZNBoa8ZV/mrhicisp78Qteu/kEC6SpNM7c?=
 =?us-ascii?Q?djWy6rmnx4OGYgCHM2av1Z+7RosfKLSTkYU+A0NoNkuUWu2ppnUKnXX68M3K?=
 =?us-ascii?Q?qlNkiK68gFggu7Ydjz5AHr8TLQWW0FRuAj/YOMEZsGDE2BjFhKQF29xl7DUv?=
 =?us-ascii?Q?fCgpR6nl0+sZZgH32lCj8bNLapz7Ug+mjngnD7Ua8yOcOO1P2C3vJHKZqNJW?=
 =?us-ascii?Q?uP9rSDIA6sW+Bgy3fRr1DXtL7cIa4kL0NKT4OlYXGFOCG05QZ0M7CCx+6XYT?=
 =?us-ascii?Q?szzonYlePSmkk1FjSSpu6ZEpyH9wZVMzjBRZxZsaQAoSoLD9y36TB/6oFr9J?=
 =?us-ascii?Q?W0IshKgjKoFvvDvoxwKELY1/TWDwXb5rHpunZKS/7sCFcrIX/AFkg2Wg4lqa?=
 =?us-ascii?Q?MGSDKWXylH108UomaHcGuuwRXM7hlQyJ/YkGeyvh721+oodfw6rvh7dAyLhk?=
 =?us-ascii?Q?9sjtjBTrM3IW0Vjkflwt1DBMSiOAFmhYzGN3Bw3EReA0nK50gzDe5Zgl39FH?=
 =?us-ascii?Q?DANIeB3MkzfmW99bO6NIG6m70PGpFh4zTSAm41mL0xusPxmj0tRUnHf8Y5mU?=
 =?us-ascii?Q?i9sfXnC1aSzXLZO+lRQv4kiBafUNf0L8yitotHa/KcpRSEboZ8b2sj+Ter46?=
 =?us-ascii?Q?Sdc4iwbrjO+9ZDhiul53Bk2VdQpFnxNZU2XHJSTDxkWRkpUxXkSIHrR1Cfor?=
 =?us-ascii?Q?Y4OYq8mcapVZjNvpTANlvbk8u51kEX5dUW0IDtZa5E0kX/omdHDNNtvcVICw?=
 =?us-ascii?Q?o06J8NdMlkbcLhNEvVAtBgEJ3cFAtCpU2/Wk/VgzM7byjq9AGOu+tW8KFkDU?=
 =?us-ascii?Q?K+gorkVaF3kao9fOu4tEvk4Ow367lTX/usKCNcyVE2wimfKb443BWIodA8pw?=
 =?us-ascii?Q?dNRLwpu23O8dp96wAiIoHbF4yDFg2KfFpL/1dlRB?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6724db31-631e-404c-ec8e-08dc652dc9e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:44:11.8015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FonjOzPGrSwrtXJj9Q/CUagU60Fq4RZ5HhdZkxnb3XWQISn9ha7Kz3Tg17KIK9h69M8nWp9Hvtwfw6AOztLg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7587
X-Proofpoint-GUID: 0ZGzo8GWctLWJYERypNiphKkZBm6ICzf
X-Proofpoint-ORIG-GUID: 0ZGzo8GWctLWJYERypNiphKkZBm6ICzf
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/66
Message-ID: <20240425134359.hwW4_vMPNIvqReC5EO_ZHWhLpkPu-h1MT4CqR4Di5h8@z>

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.72

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.71.bb => scap-security-guide_0.1.72.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.71.bb => scap-security-guide_0.1.72.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
index 43c8b8d..549f04a 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "459f0abf2ac08d36e5fc4a2619bc75cff7000da9"
+SRCREV = "7fb44f78bf33232aad587e87a799afcf576f9b47"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1


