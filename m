Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C9EB64C5
	for <webhook@archiver.kernel.org>; Sat,  7 Sep 2024 11:31:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.5784.1725708690612871719
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Sep 2024 04:31:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=99806d0699=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487AsX6D024646
	for <yocto-patches@lists.yoctoproject.org>; Sat, 7 Sep 2024 11:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gdt8g8r9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 11:31:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXZ1Pgm+TDjmrC2h4gRxa5KXc3xdF4x3wNnvCt2C6vsFQqhybSE9xNHDEdWduQnurQZOvBW2VkK5/j+d8oo9pTu8yReptrcJ/L80M1CGZadYOM6iynbq2yM4REknzstADeSel75v64JTXzO6JdIEqKwcfHdZS0qH0XNEz/Rwqjdz21dw4ZA2MX5Ba7tVX1CF6BnXfsxWotjzA++63tPXJK66QTsHzauG/Pebp9922T0QzGRBqLKGNvOVyZJEZglrjCelR7U6yvXcC4uS4ATTe1E9PwzxiYnm+8el2UC/ZQj8X234QOvf1s1Q2B3HHwePkY9dXAGNi2kP+QBf7vhoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbJXt7GNXHM3URMNeYOWwQnlh75bUMf4xYrqWyqqCNM=;
 b=gz5azXXevt/MbzmnC62ss3OFZdJERp1mJe6rDf7qTe8FJ0EgPPKgFb9EGiPFaG4MKrprzTmr7uVvIsHX6UFT6D2L2HIZ4fwru3FalfP/01Ghb+OlwHwzKpZjWEXtKcKi0DD7Vg17/pw2i5yKagS2tjtNBPhbgAhj2XxYo4O+T1g+Vs4ffElocQR9FtE24jDC7+LPf35UySCWmGs8I2aDZ5PK0OXpDbvZbTZC6a8u5ipw3Ov/63MjsL60hmMKC6cDtAFpbvOdoMG7+OKHCs68jgim3CgWbDL6VMwc3BSEh4C3DuBe4ollUS4D6EymwgZ1aZKvS8JXFE/YG7+rUA0GCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 11:31:28 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7918.024; Sat, 7 Sep 2024
 11:31:28 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [layerindex-web][PATCH 2/2] rrs_upstream_email.py: fix email sending error
Date: Sat,  7 Sep 2024 19:31:14 +0800
Message-Id: <20240907113114.3361680-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240907113114.3361680-1-yi.zhao@windriver.com>
References: <20240907113114.3361680-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9fc860-f38c-42cb-e919-08dccf309cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Di7pkmnB7H7dc74NjOD9+Oca4h1uDCxPuAiHz7tHx/6+FAdKkYUUN/qdwy+L?=
 =?us-ascii?Q?nhixxCfxfAeZoA3MaH1XkA7nGIzAz/b5MeLfZTwiIUOvieqcTe0HBDdjGRLt?=
 =?us-ascii?Q?XBGov1MrZjqroE2m0S7rZaY9KgqZPL0/v0RNsVNxWGEAFAVPCXkIgrfVJ4JZ?=
 =?us-ascii?Q?+zTNJLzFBrNgLGFKKlYBsfKxsBxIpk7AR/hxsurkODZSvd/SPLROZYWLw+Jv?=
 =?us-ascii?Q?x29e5qDGRJMSym4S31P0xKweMsZFRpzNWccIMPsiaAbV67hhz0RJDqnF7e9e?=
 =?us-ascii?Q?SVceNABEyhO5O6SlpKYiKkrnKJho6ae5WtJkdcW0mfHk08+Zrf81JedJyqxk?=
 =?us-ascii?Q?UHN2pP+TCglSnsWYwPl/r264R+mGZhlJct75mg3FI82OB8e4AOKY7i91oH/o?=
 =?us-ascii?Q?Aysw4RpiC8XllQiKk/XdpSJza0HM6IyRntE59jeHXM//8LQuA6VRgJuclaIN?=
 =?us-ascii?Q?qyn3Ee2mMO1kWBti82wUcVjwyfOcFZTuRxPNlbQimyrTM2Nbm8xO5+5F5i5t?=
 =?us-ascii?Q?fqLegbwW78cODqgACZO9EUDDsumbPhapBFhbI5HqRS/NEf4z7cwYjksEYDfl?=
 =?us-ascii?Q?ugObbRRe4NOblOfq2D6FO19BnnQD52RnZljbkUdNtyxdC5EfCtFq1J+MecTl?=
 =?us-ascii?Q?77Bi2xGPVkj9os7eswfFfF6g+ZGMyjQdCVpfq0auW50Kv9ISqC4ANO5s4vwH?=
 =?us-ascii?Q?kcAFi9Lo6HZDRYoy1+CFBtzkpbyYkUdr4jOQWwJUrfQMcfUHVh/eYrnllzCt?=
 =?us-ascii?Q?RE1Xhaf1X8Igh2I03EsWo3IfYJ6iU8jGohgWJB7jxd/jS7LFio6V7ot3VYf7?=
 =?us-ascii?Q?VvA6l7ekMWx35Qdii2QM43wat9P7+OvdB09MFNATy3ODEGhxp35+XxEQjVbU?=
 =?us-ascii?Q?kuUvBgOJc50mvv9lehvPh/wk9EgUeGcFXeqW3+VaN8XUqXtx5eaIMDCSQqrR?=
 =?us-ascii?Q?RNDq8v+RWQMjzec3yeU5x5DgVTCprPumMJbSDa0kzm8t63pDccbgRFHPkKrO?=
 =?us-ascii?Q?jNDRnV/Xq/Fvqdiw85geT+5xXhBIjeqkzp9XicrzLyML2YJ+WOWrNarp1Dal?=
 =?us-ascii?Q?xqrEO/D2VuDfR/sbDs0cxwnuUxpIXoLWXI96wuGSY/Y8xocE8SyVWsUYH1ur?=
 =?us-ascii?Q?4jeuRoY8NLgmfwdliudwnznuihoMAnaoE3GMLhulibxNGTCZIQeh1hm2TrAx?=
 =?us-ascii?Q?a+QwytQTN0QvzV5NiveEktdOz1a4/93iwlxMEItbLU/s8xYvOkXe22mcBsnw?=
 =?us-ascii?Q?Cc47hHgCnw8zrUst80ZdU3Bi3i/tligmcv5gLQ34TCIEgThg5ZLGowHZa2Vl?=
 =?us-ascii?Q?p847xXV+eWQQecU2I99+9Uk1+yY7Da3n03In3PEnYoKXAhVodPoNRrGLOPT+?=
 =?us-ascii?Q?xgVsV6c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6fNK5sQdZUG6ATTa4PrlpbI///GM5yMRb9VX7pUSx5ZDnnb8t4vcR68xw5sO?=
 =?us-ascii?Q?gGIXVMwEEKBcf25t5g9MdSGslebTfZPS527+Yo+2LNwItB8vGi+FGAXj/WFc?=
 =?us-ascii?Q?9nEDHUhaTbPa0eUjfM67mNM7Fk56WNdFLI8QC1kUKD/YnIvg9wZnkkeEl4Me?=
 =?us-ascii?Q?BrtT4pN8Ae5IoQgEaMkdZKrUtCefL2jDhWO1V2BRoQAPXj1OaPIyDveZcgjs?=
 =?us-ascii?Q?bkf8xQwghCr524AGRSaDVJE+t83bsdEhb8hHR/Ark0mjYxoKreFUlW9Dyynr?=
 =?us-ascii?Q?6JAYdLKejDf3Hi2XGfI5b6wCWbTnULka36e3H5Zd7eMgvbxXLNw7vB07ft/O?=
 =?us-ascii?Q?Ve7ctP2Cx8++AcLr57YON0LXylzBdu/EymgpWxFnVUsURVetf8v5vsRRnkIi?=
 =?us-ascii?Q?CDYakaIlC48p9mmoFnL7DOyo+BCAjfcv1YCsnaFQ0cXhc9+zn1prhUlZFWTp?=
 =?us-ascii?Q?2og2gp3h1YuW2rfbh4DeHcoVyAN4DKZzNdNOqzmv7CoNhConCPYJbArP9jbe?=
 =?us-ascii?Q?bS4gIbAd2HgnLbi+7NPv1/zT7CpJ11r1/xZ9+Qipq/Gf6NHvaJnILmNDB6j8?=
 =?us-ascii?Q?u6RkQBEF1yttboxObYrNkDgwWlXsY4NQUM16nR4tfUw/fsl55y6up+xwB978?=
 =?us-ascii?Q?R7pg7ul26zFEkqZ1F62EOKM+4I5Vr9qTjjkt2Da7MkFOrWK/B+NfurZgc42T?=
 =?us-ascii?Q?90S2oQ0gzh2RgGfobIA4FoGAueFvtpLSi6WOgT8wvuoIVWOspKLUx3j27BaW?=
 =?us-ascii?Q?hN0PckGWsgqDjoWGflpsbkvd/7x7UcCdU5qc3OCxSKPOQs40XB3lZppiptPV?=
 =?us-ascii?Q?ItzNE0voRLs4gVIKdApgf92T6FfYX4ZAw5whLz2bEnv+4fo02kwq38Ko3nnM?=
 =?us-ascii?Q?eoDqT8+N3ICBMs68UWEIJGLVKR93FNcjtEhIjU5lwqlSwF9FJMF5Y/uC6evj?=
 =?us-ascii?Q?G3zqu+tGIZs70zld67oOdf3WMmZ93wt4ecqmG890Gow5tGH9Mhp9NvkWjWVs?=
 =?us-ascii?Q?HwffIHUalx/gyogL2Tzpat/EYShiddHTBmfaJCNqTteRr2uc+nM4cPeGZ3i6?=
 =?us-ascii?Q?kW054aKsDQzjHAjtYBJEeOcwdxXjiqOKgD5gv/2zfvvzey4IxS9Eh1LPsN6S?=
 =?us-ascii?Q?iDE1Hsn7aaoVysBSnbmIs5gboP4npt9IoToWmeRu90pdFXOAYoy6GuX+9rz5?=
 =?us-ascii?Q?cAQYvYrY0Lr99GdEkGv+ZVU2rlw5kUZOuDhcWJ5ecZ+wew2kn/HR7be0/tWC?=
 =?us-ascii?Q?dOSZZ90qQqDL+fT8Ax1/Gt+DtEeLZcM5AeQo/elBRyuWjXoKA5wX5qfYpVP8?=
 =?us-ascii?Q?NMRXOYMNYyZuMxogv+XBFF5c+an36sfFiBNwNI+38sOroGqJ2U+7tm98dZ8e?=
 =?us-ascii?Q?JCjoVrblWNS8UnpX5vky31De6pu3024MTu+JzU5SAxcp7NKv3D9MFolvXA17?=
 =?us-ascii?Q?AaQX42TxhTbX00lK3xVdUg9cAPaSPC9dkmvcBKQrJqviphpHi/JnX82xBCW3?=
 =?us-ascii?Q?n53gMNRGoet1tg144jssE2wXCB08BFAqcA9PTR1cRBUeKWKTW+GsX+rMtVZ5?=
 =?us-ascii?Q?oBOe2FuUSJxQvI3V3gTl4zPPHjup/tNjIPc3p1C7?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9fc860-f38c-42cb-e919-08dccf309cbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 11:31:27.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjk6zzvjKK/5Y/BHKfH9LVteVMaW3Xd8JRK9kZnc74UZmipgnOesN6G2fkV/2TrxOteH0BN4LtF75IeExrUnnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
X-Proofpoint-ORIG-GUID: Nt5DpO6QwqOn-BVEMZPdI_HdrYb2ekf_
X-Proofpoint-GUID: Nt5DpO6QwqOn-BVEMZPdI_HdrYb2ekf_
X-Authority-Analysis: v=2.4 cv=a+hi9lSF c=1 sm=1 tr=0 ts=66dc3991 cx=c_pps a=19K1aDEwnJ0RahI1emVHDw==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=ZkJFVibxZa0Yt-kD84EA:9
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=626
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409070094
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Sep 2024 11:31:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/620

According to commit [1], use recipesymbol instead of recipe to fix email
sending errors:

django.core.exceptions.FieldError: Cannot resolve keyword 'recipe' into
field. Choices are: history, history_id, id, maintainer, maintainer_id,
recipesymbol, recipesymbol_id

[1] https://git.yoctoproject.org/layerindex-web/commit/?id=c0b84391827840ef302b1172f7533e887af50a54

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 rrs/tools/rrs_upstream_email.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rrs/tools/rrs_upstream_email.py b/rrs/tools/rrs_upstream_email.py
index d87f791..9341333 100755
--- a/rrs/tools/rrs_upstream_email.py
+++ b/rrs/tools/rrs_upstream_email.py
@@ -174,13 +174,13 @@ def main():
                 sys.exit(1)
 
             for recipe in layerbranch.recipe_set.all():
-                recipe_upstream_query = RecipeUpstream.objects.filter(recipe =
-                        recipe, history = recipe_upstream_history)
+                recipe_upstream_query = RecipeUpstream.objects.filter(recipesymbol__pn =
+                        recipe.pn, history = recipe_upstream_history)
                 if recipe_upstream_query and recipe_upstream_query[0].status == 'N':
                     recipes[recipe] = {}
 
-                    recipe_maintainer = RecipeMaintainer.objects.filter(recipe =
-                            recipe, history = recipe_maintainer_history)[0]
+                    recipe_maintainer = RecipeMaintainer.objects.filter(recipesymbol__pn =
+                            recipe.pn, history = recipe_maintainer_history)[0]
                     recipes[recipe]['maintainer'] = recipe_maintainer
                     recipes[recipe]['upstream'] = recipe_upstream_query[0]
 
-- 
2.25.1


