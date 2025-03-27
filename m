Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8342C36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:23:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.49879.1743081827456507602
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 06:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5181a5ef2b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8knIt025090
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:47 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkdn2w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8Rnzjn7WsMF5a500UV8c9lLN96O0G6iSuc35U+CdCEynjUg/rVhWHLTT6haEdNu0JJM/sIK9oq4ZJBsq5oTwYRwLjkvNBr5aYDa24For8oSyqMMZlnnbjsJqKvT/KIabA9n9FroY8arxyeDmjWMXhQ+wkVmZKYNSEy+rr4P5DrmCNLD4CXDql1WdsKfbeHQWqgpdxrNytjHI9IurxAQjbVLiQTFkKjMl1tNPtUPMjkXA+stAqhwR2FHg2lNOWTK5r/rVfp/RsCyuE9fDbzCFndA5KlAE/hAcKpRLJSXf6j9aRoo1DLoXTufsmDuvCeuv5ysbVCSS3TeD16164V5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzuwar3azcAOvBs5roXscKfQ8jtwIzY9/HgwYSEHHvk=;
 b=nnegTHIYsHeiTwQULqDXcBTwgAWr8pvpzOpwYADqUHoQIWb6gefReWAEJ3+RG421ltoWpNWFpeXtaAbi/DchsqVj2rE96BGAXgDoND9uRx8u6GdeH7ogqw6A+NdTUmjFQUoCqzfqh6+iYXR04I6ozRCeuIV5sST7tZpXdNGMLKfUQP/WAh/tKkgZDnR07swI8p0UIFoN9jWtRYIVmTDJSmpVQQ0UQodKlSJJWabYutA1J1ibwf/v4M0WEeGcAHkU7tjUV+0tQcgHzsMeJ6s+eB3peRe4kWon3zI0N2tVHmEItyS+/6uM+uIUSQF9b2vc4TF0m6pMqgukvoep6wTAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:23:44 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:23:44 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/5] libgssglue: upgrade 0.8 -> 0.9
Date: Thu, 27 Mar 2025 21:23:24 +0800
Message-Id: <20250327132327.3477926-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327132327.3477926-1-yi.zhao@windriver.com>
References: <20250327132327.3477926-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: b6158995-cc5c-41ad-d260-08dd6d329960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iNLXVKuIqENjt7GWoeHxCsJGu6v1KhBXtD24HSCuiqMMdFIlYaH7T+Lg8+DI?=
 =?us-ascii?Q?/9J5Ccv1OR5DM6tiLh/3NpJyX8s5GzMYeuk7Gq9D91qFYzt/I8EMxezPKF6N?=
 =?us-ascii?Q?kd8wLhVZjSYvMvpam+UzC7VW9lksL7B9AK3Vxj0RZsxGjWcPn61ojhFwbYHc?=
 =?us-ascii?Q?QuuvjgKOQBnCn2b4TXF8ssSPIYKi9EK9TnlXIPIDa0CQ0Xd8PrLMR9tQvINH?=
 =?us-ascii?Q?Q8l98R09FmhD00+caDnUXCWXfH65MSN6dI3Jd5E74sdBcnmKztLu45uHlFsw?=
 =?us-ascii?Q?O4yulKk2HaM9RZ7ox/tv0H2YmTDx+twU8+8OuL6cY8WUjDEbuzz7vTWgqjwH?=
 =?us-ascii?Q?txDElm+Gk6uOmoX3zx4OZooRBTR1jnBhjC7BSoZ+pvjMBL4NGX/GcSTe5v5o?=
 =?us-ascii?Q?p8AlSZYR9cz5pKifj0dCU/UJpaDRUF8ziHhv+yN6ofxvyorXB3tUH48WeVPS?=
 =?us-ascii?Q?y1POYmtRr+EziaSMqjWoA23PPpJpR60VQXNQOrj/S5IQG6XXqHGyvnUsVxWN?=
 =?us-ascii?Q?/vXw4ygmaeiSjQ67zYQmZ25kEOuvhDWBMcyPgO41k4TxH/gqjdxjOtdv2sQi?=
 =?us-ascii?Q?bUOfpTAypJh63/Jvky2LGZTq55/YiXP/HJA6iZS90kQwcldbpk9Xl1PGSQmZ?=
 =?us-ascii?Q?S9VEbBBs2x/WG4YWEU+h3JefMjs12KFKhZQSg8b7i5vICml8MtxjULQ1hNPt?=
 =?us-ascii?Q?GR/tsMSSARFGyGIrEgPNfFt74RADNWOks8tvFobhbGpCKG+jNzHQLBKs6Mt1?=
 =?us-ascii?Q?5GxJxa0qG6eF0rX5aUVlTOdbMPhygQ78/PhZ6LhckxVMfAkfiI0kcZS3lpTo?=
 =?us-ascii?Q?T65WBdg5PRXtD2vLs/WiByW3D3TgHyet4aRdg+hWTdiDeP/fLFG66IDSqKr9?=
 =?us-ascii?Q?fsylan9anWZdfvU+9CE36ov2nSbyJltco3Lfxel92yekvRxF4fte4p1+zfiT?=
 =?us-ascii?Q?wJGXqZa7i4Mc2EUi/GrUsu8ye3UH9lERFVBrhs9Y39tjAaejR9VkQGQDun9L?=
 =?us-ascii?Q?iOL0F84CFmBaFPB2zQ+KJaVLt818msyhxZKQFH+hlNyXgVxUt0KiphIms+az?=
 =?us-ascii?Q?2Th7UAJNCR+jfHF1MvmQRVwTY8gaFYBOIIlz8D2G8m8G78fRiT6OFb0CSg7k?=
 =?us-ascii?Q?3jY4qZecOSYsHExElBRSMsnCxIti8/YpdVn/pD2nMOyRMFzU/oq2e4JvPQE0?=
 =?us-ascii?Q?ayuLUVwd7WYlvACo/huyB1ILtEVGnloKpugDIKW/QeCb0Gm3tv7zGe9qvDSW?=
 =?us-ascii?Q?T1T9CP2oX/ySVvGS8HPQMYzanoRv9MdNYLK9XICo3V2VFDvxk6vW/gfQQdI2?=
 =?us-ascii?Q?d9BVS3onmpQn1jwGbK8d4WHulZP6HzOuKlJ2X5O4wDsoy+v9bQhyt5m42d2V?=
 =?us-ascii?Q?GJOIIb/8/tAOj7KC6RsnfFKUfAdFoTtwPYTaKutQW8z+SdiWlOIk4XRbK+k4?=
 =?us-ascii?Q?xLRrxoQUKj3lqK4p+MCdR6eQ5804KcP2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wCdm3xbNi59nuyrDPMLVoWvy9nBIPXoKwmI8XSNL/wfdU7G2ey7dvkTZHGt8?=
 =?us-ascii?Q?GwWLjotkpuSEWAmmSxHI4G40pNir4jg+ahRHU7IaD+K4TgsT0W8rQXj1Bb+7?=
 =?us-ascii?Q?dZovaF5rW/Y5iP+JQjDzkWgueeI9AV26FQfX3utik7AdrmAgko8FLS5R5dfe?=
 =?us-ascii?Q?APD2wNiEHjiCcJV0/0riRotDwS1Qr6AjoATld2ygagF0H9+KA3bbK1YCF2+w?=
 =?us-ascii?Q?gE6AlDkBXvlfd2qah0mLB46oB7ww5x922YE0oJTE4WN2a3JBu2EjJVUT3AI4?=
 =?us-ascii?Q?HZNFf1cFOfuAGQFRDjtKT+l2D7yvDEDOjqK9wXt2/hJ5L5fncGcv51b55IxT?=
 =?us-ascii?Q?D9cFxu4RtBY/nDGyUOiDCHhAl+WmMlM4VArAfX3ZEWlsNfwK2uetWrJnCI3K?=
 =?us-ascii?Q?Rg+wVRBEVsEjddivD+Q3p0by4ZoNeZthc7If5x6c9WjEhejK81PkYgT3akFW?=
 =?us-ascii?Q?oLQ5aVi+MIcxmnShnrUreN75ipalIQFcdqZdBEPA8ah5vEiq+U5EQJqWFjB2?=
 =?us-ascii?Q?nUZi6G/AZhtqXv8mR+BVWblQODzcHV5qgty9QJ54JGovTH95WqnhSX6R2Bz1?=
 =?us-ascii?Q?wwbMnVJKcSME1QQfbLqg3HV6zQixLndkjT5ZtEac9Utph3HrvNuhKizAU9xW?=
 =?us-ascii?Q?+zb93ixbF+r9iMvIu2rMxi/ztmTcv3qyJirX+tZ7gjE4MCuu7WHRD4SjyjYQ?=
 =?us-ascii?Q?D0nmpNgvtwvVIGDS1ZektAL3jfO/zXfgP8Fb52ZMt/Z7Tc4IpniWmNVa6UW3?=
 =?us-ascii?Q?dbG86M81a9NutvmL8ECp+UNehbjAFc0AnFKggk/+JSdCYWohgcR4op5I7aYR?=
 =?us-ascii?Q?Lyq83pL2ubm/PlKhIZQLQSSaGMJe+IyMVL5aFnSlA60hWR46XKKRKrgLS6C0?=
 =?us-ascii?Q?5OKieZKuBkKV77qRkA6QLNXSJxbpR3w4A5qUiPQ050T5wKZjrprXuu/QUxaP?=
 =?us-ascii?Q?BxVuguoIJ5tj4ZZN/pDEmfpGDujFKnTD+ji4ux73VKypJZra9fGdGwDSkU7m?=
 =?us-ascii?Q?goX4vsrziCpGi/7qstACojdF1A43V5QTBca+N9ZpFi5veB0qtHO+8e7z56Q/?=
 =?us-ascii?Q?oSvrS9cBrm/At25usPFdiCXc3YziSNkBy1rOgNsUHbisIezsNZvKGD1uke4+?=
 =?us-ascii?Q?/BA/uy7WUXEhqYcN5dcrP48u7r/J3VZSswTwfVD4HNtBzJTZiALX3waDLGom?=
 =?us-ascii?Q?jWD8B2vPBg2nEz49/5sDOkWcGODvLzSvS4ZKqXsfGJm8pnnPaDQLb/Yl3oOF?=
 =?us-ascii?Q?ECjuU3s3vqlG0zssBVid2Hc+3BLXzFCLSZWNizaf/CPqQMk0hLmPfnJcu8gt?=
 =?us-ascii?Q?YnYk6YC8p3tQS+Owa/rJpePDPt0TMFAd5iJyqVza0Nmj18vqy3eva4r34vCO?=
 =?us-ascii?Q?F/1yaP5/1M6O3FCA1oynDixHiI8jNv7XtAQZ7HtLUf8mZssrlovq1JOTxkRA?=
 =?us-ascii?Q?JaEa6qjTZKBoCpYbDOR/XL/l1pyDVs6cyUgrZ6xTwWRRgXTAHNXEu2lhy7Ba?=
 =?us-ascii?Q?o4WnMjiJztGCdmikJJQrlgJNdqbP+ILIhQmYjt+zyej5Faip1d9WwXr63QkK?=
 =?us-ascii?Q?MkCPjpbc9J2y3bF9TmIbIwRfWammHTYDvoNRmpC5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6158995-cc5c-41ad-d260-08dd6d329960
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:23:44.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPH2qLL9Jvx8FXoDRrJ6n2ZVR/ObWPCiDw5DToNNbYlMNMnyfhJPu6g70TSkmy+zUPF1XndQuo+jomm3b/C9Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e55163 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=t7CeM3EgAAAA:8 a=p0WdMEafAAAA:8 a=D_8YXLKRlD7LT-XsMP4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: P4Ab87RvECRrJGJCG9iuEu5RO1Skc4Ng
X-Proofpoint-ORIG-GUID: P4Ab87RvECRrJGJCG9iuEu5RO1Skc4Ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=758 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1267

* Drop useless patch libgssglue-canon-name.patch

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../files/libgssglue-canon-name.patch         | 60 -------------------
 .../{libgssglue_0.8.bb => libgssglue_0.9.bb}  |  6 +-
 2 files changed, 2 insertions(+), 64 deletions(-)
 delete mode 100644 recipes-security/libgssglue/files/libgssglue-canon-name.patch
 rename recipes-security/libgssglue/{libgssglue_0.8.bb => libgssglue_0.9.bb} (94%)

diff --git a/recipes-security/libgssglue/files/libgssglue-canon-name.patch b/recipes-security/libgssglue/files/libgssglue-canon-name.patch
deleted file mode 100644
index cb7c47b..0000000
--- a/recipes-security/libgssglue/files/libgssglue-canon-name.patch
+++ /dev/null
@@ -1,60 +0,0 @@
-fix the bug:
-g_canon_name.c:125:5: warning: passing argument 2 of '__gss_copy_namebuf' from incompatible pointer type [enabled by default]
-
-the 2nd argument of __gss_copy_namebuf should be address of *gss_buffer_t, \
-but a *gss_buffer_t is assigned.
-
-what __gss_copy_namebuf does is to alloc memory for a gss_buffer_desc and \
-copy from src and return its address.
-
-if following code failed, gss_release_name will free \
-union_canon_name->external_name.value if it is not NULL.
-
-OM_uint32 __gss_copy_namebuf(src, dest)
-    gss_buffer_t   src;
-    gss_buffer_t   *dest;
-
-typedef struct gss_union_name_t {
-	gss_mechanism		gss_mech;
-	gss_OID			name_type;
-	gss_buffer_desc		external_name;
-	/*
-	 * These last two fields are only filled in for mechanism
-	 * names.
-	 */
-	gss_OID			mech_type;
-	gss_name_t		mech_name;
-} gss_union_name_desc, *gss_union_name_t;
-
-typedef struct gss_buffer_desc_struct {
-      size_t length;
-      void FAR *value;
-} gss_buffer_desc, FAR *gss_buffer_t;
-
-Upstream-Status: Pending
-Signed-off-by: Yao Zhao <yao.zhao@windriver.com>
-
---- a/src/g_canon_name.c
-+++ b/src/g_canon_name.c
-@@ -121,11 +121,17 @@ gss_canonicalize_name (OM_uint32 *minor_
- 
-     union_canon_name->mech_name = mech_name;
- 
--    status = __gss_copy_namebuf(&union_input_name->external_name,
--				&union_canon_name->external_name);
--    if (status != GSS_S_COMPLETE)
--	goto failure;
-+    union_canon_name->external_name.value = (void*) malloc(
-+                      union_input_name->external_name.length + 1);
-+    if (!union_canon_name->external_name.value)
-+        goto failure;
- 
-+    memcpy(union_canon_name->external_name.value, 
-+           union_input_name->external_name.value, 
-+           union_input_name->external_name.length);
-+    union_canon_name->external_name.length = 
-+                      union_input_name->external_name.length; 
-+   
-     if (union_input_name->name_type != GSS_C_NO_OID) {
- 	status = generic_gss_copy_oid(minor_status,
- 				      union_input_name->name_type,
diff --git a/recipes-security/libgssglue/libgssglue_0.8.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
similarity index 94%
rename from recipes-security/libgssglue/libgssglue_0.8.bb
rename to recipes-security/libgssglue/libgssglue_0.9.bb
index e534615..7e24450 100644
--- a/recipes-security/libgssglue/libgssglue_0.8.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -21,10 +21,8 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=56871e72a5c475289c0d5e4ba3f2ee3a \
                     file://src/oid_ops.c;beginline=378;endline=398;md5=72457a5cdc0354cb5c25c8b150326364\
 "
 
-SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
-           file://libgssglue-canon-name.patch  \
-"
-SRCREV = "c8b4b2936b854a7d4f7ef12e30d6f519b30dec87"
+SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master"
+SRCREV = "ada76bdaec665f70505f0b3aefe871b873e7c4b6"
 
 S = "${WORKDIR}/git"
 
-- 
2.34.1


