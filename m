Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93876FED2CA
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14143.1773287569151015539
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cqkQ3dkq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C1U7BQ712252;
	Thu, 12 Mar 2026 03:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=00UEt0Nu1bqRApT+CGyZjkb5O+lMDotL/BKI1uqpUvM=; b=
	cqkQ3dkqZGIOXASezMEUluRQnVleR2xix/IAox40id+H0ROJiJYanTYBHSZyeYO7
	WKgFNR2p1EE/yFs/9pMJWhcDYJGmEMl/BIfJpzhJ+oGiAem9amlwxRh9URBmF3xH
	T9JfvuMBK6uPni0Pi+1XxwiewYjZJc4UYiUSjNPoZdI6GrZrtZGjROdO0LAwdVRU
	xcm6ihaGGXMe7yqMOWLZstGyOSpqgbzUpm1wBF0x5fmCRVgxYIdSxwwX+Y8EBWL6
	RMYRAmd9zPQhWBqChDQmAAkuPbGu2ry5LyMI38yUMLSQN4lCQ6huvLsjotDlw1mb
	l7/NNU02zS5VXWshup2YUA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6t879h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHbAtgsH3bLqdG8Glq7Nx+AwfsAbLbp/lJnQYsGuD/lEaWxxMCHl6XM0e/pcB5dtNkptElhlGiExsRKRSFSDIe9FWZxfcWYNQhpAGy2JIXmbsrtBZDCQyEdF2Ac7s7aEXCMgykogRf11j+wrYXkmdTntNJFbt4lziZlC0nKT1GTpLGO5Rpu08KrRR+z/02+KxEGAI/M6tJikGarVqvdNLN/kO2MntPhXQU0YCj0dBwsCd9kjGe1Z0XCWu+GzqiPbOew8JadIdyP1hFZudNcjRlma34iVZfkHGfhNnORItfQ9Z0ISE0OPB/teGCUxeETzAaSdF2aWz/UFEtiE6+kPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00UEt0Nu1bqRApT+CGyZjkb5O+lMDotL/BKI1uqpUvM=;
 b=cqjDo+n11rhPxGjl1SxjQP4lueqWIDrF+6fv6wn5c/H3PCymACQZD41UPVsIfexecP8TnQfWcwYcwqTghFeboMz8EMBnTVpN2UDxPFL0BFhLWl449AEduqVSr6gnAN512N5TkdSPaGAMyns7YMUDD1wH7gFiyZI8gMpkvbuZyEIR2++gKXXfU1touRzKoJ4s5CHMZ0iQv0XrrrBOQVmB5j+4sLpVxB0vO4ZIwgsGJk6OWHYL5zZLcChlgEail+OOvUqjhQvmJXuQlMvd8Gs6pyuYzBQ1UrSnJcvqIX2kbqqrvTpyL/hiY63SrPbQiguxNKRAi9/0eceMUHoem3/f2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:45 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 11/11] upgrade-helper.py: respect recipe parameter from command line in case of layer mode
Date: Thu, 12 Mar 2026 11:52:11 +0800
Message-Id: <20260312035211.745546-11-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 240ffbd0-c0d1-442a-c690-08de7fead1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	38G7HI44kojKsl+LivaXmNq4Ebxi3Rxn7KVSTyGhr8xKb/f7CyBHVagdEc93WeNJNpDckLOaA2Ztg5sDBTrlq2s4Zxv3NQFy6NqxpZf0X//ytHoxTXMON/Eb/r4t4wHzjbUN2Uo7RULlvGFaCaGlrucm5wSOR4M3NTGafG67rZ7Km/mMaZIZwF9itKTHFKmlRfCVdwe76iaFj+7AMYZRX71Jcrd9FzLXvE+RaFMcGQkkmWMr5har6E3RxmfkP72cz53Lk38HyLLGSnIuu8J90IykPJ8w9XB4v4gIiow0nkCmE1Yv+unMRc0k3fPkdd6rzT6nSTn5kv1y2tDuBxT5zrQju/Zxwd6FZDU5pVziOfVqBHAAM5Y2VAX5VB2CV1DyTb067zvEmUNsSaFQlX62nC0/PCu6dshbx7bV92aFRw1Cm0HU+rO0/esb3YZyYSVdJhnG1rz3EUfRvPwH1gqhW3j7EsHlTrhHNzIznBuJLPZMPOvdT/ezar+WOFcbHmT2xMbq1ie4He2CLHffh2i5Uo+OgscsTXHe3IwZeHdFKlwP/3CZkLcrrQ4tsYU1+zcSMt1o6kJ6ERC7A5Ms/eBVtrWKRpB0AB5PCl3z5I3gKfdHMAZ/ttGav4Qi+nv0Nplwcjirodt7cKSw1TPAQ1KBs1ObQSwa+2VHUQdnOU1ZiSPBV2Odv7GqYqQb8Ioed59IJcJsUVH/4UksqvErbSbYOa+C0xRL3nez2kFesSl0xGTj85EwvXQwnFVuFKsDKe9hN8j63sa+Nk1rrw3EodtrRTFDMnscSoNOnSRISoPKTng=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e/PKuGqm/XG9gC2hM+sxQ9JNTYJSD/ZQ9QHYf7PEO83RN1nx7DVut5Bl1INu?=
 =?us-ascii?Q?o+eVdr5QeY+8rTsKBsw69kK5TH2irmnVlNsmliHgF6T4AHDh7FhFUuLrmELQ?=
 =?us-ascii?Q?e1/Y9IqjLUgnZSQ5VIES7uxQs5lW6mEApZGLfAegPPX2sYG+xa4crtUr55+I?=
 =?us-ascii?Q?ePpPQUKQbjPBYRNk3Dq1nB2TWiVGS3V0KK+Qk3PMkHeCeWKQc2ex/5ECfDCI?=
 =?us-ascii?Q?Z+nDn1KgqYgA89hY5X+YNdc2ZJIent5YToumwutC42O/7sDZA6hC2wtb25+Z?=
 =?us-ascii?Q?xxN9T7ZxL9aiqGDn26p+f7kbLRDAyFEqNLX0vxfZvq3pcIutMiGhTyV2zBfg?=
 =?us-ascii?Q?8l/8OCroNTh9YCnudj31KrXwtdmlElxe9r+mkvKl2TwDCdHKr7hH1KtiD2j6?=
 =?us-ascii?Q?vAfPYQ+xfhbbAipDWDtBYl/K5Cwug+DvuUzB+0F3TDG3WRyU9srjyemSupAM?=
 =?us-ascii?Q?sV99fUdcvCm5wOWi4InoREYIGCpUajxXIdaH1N/qHjUISUT+Ge+YU/m/4Te6?=
 =?us-ascii?Q?oLAl2Ss6GJ/7YsTO8NJD5gEKfBK04SsEFD7A5mpAxWW4ifGoCr/pEvnO1U63?=
 =?us-ascii?Q?mJpo9uHwr+s5jaDzmlnb/OdtblcbZfj267Ef9bPPA/z84WkpwdU0gaviS1WL?=
 =?us-ascii?Q?80Fv2OmLEmFmXB7eMS0AAClxWuB3/ZIHUENSYQGQNlKNWX1th3HmpUrYnHTN?=
 =?us-ascii?Q?wm2sEDnadeEuznzk9UooauxiI7lA6BcSkgiOSXlGkSsN1yRfn0mCcnxVtVet?=
 =?us-ascii?Q?CB6uw8pWdOsjRH5IuHeBrtlVEfWaz8+xp/XpyZEvz2o2lCpcJC5L8wdDFDXW?=
 =?us-ascii?Q?iy0Pi0V/SMlZp8gdJy0QxQm6dWl0yRjktPIkITtzcvMiQoNWQIB1NZLojbXM?=
 =?us-ascii?Q?mdCyQ3UZXWSzqN9w/ojVkkgCfJ4OpMV8xbFQw0JoaswZQkVgslAS0ikjVCU0?=
 =?us-ascii?Q?BrLDPxQphwfR5pvOGU9FdjPfgu7d+dwvX6tiqVbFmsKd56vvtROixOS+AVxC?=
 =?us-ascii?Q?EcGZxYNHHXXtNzy1qcaSB4/RT8yUOaJxkWX0HSOVL6EA38cwPKUyup24kg1P?=
 =?us-ascii?Q?DOgK4eZTjQ56v1s+T7Au5EcaFVdyMHB/JY7bdsCmuF7f3klpi74XPi7Ogtq9?=
 =?us-ascii?Q?C4ce9VgUaM1+two6dDNvSRdCFQ5lQ3ho9KwoOYiGegjzHEXz/dLVNE7KWvY1?=
 =?us-ascii?Q?B0yGlXUPHgZJWPaM6GHZJkg9nZmmcbvD//gwpiyVmpe9FEQnCqY33SQv9zHo?=
 =?us-ascii?Q?m3p+z7yB6H7BjEK1Fwe5D6+DyhsOBDClILFdnWv96trSJuBSL86bDTEQVlYv?=
 =?us-ascii?Q?PcBSaqKarRJ1bjayDzMUjPu1YQTGwPX/zdUZj0L2CRdoHH+zJnkXEpmz78Xp?=
 =?us-ascii?Q?g8blQ6CLwRU4Zkrs4Dp4vFY+erFRTZDNBHVRBlwmHDtGXIlPzXH7zCfw9qyT?=
 =?us-ascii?Q?z8DYI5e+YgDcQYi0G1I1sQE9tlRI1uI5CZlgnTwRslKy5WLnGu6bmE/g5Zd1?=
 =?us-ascii?Q?rmYdodxshRTre3I39fFfmMPeho5ofrj7wN+0DnXhoP4gQabAPZXfMPXqCkNE?=
 =?us-ascii?Q?sscQDwhnWRRhqzXsrj6xe/vDiEiGrUZxYlCTq6XFPzScrnF+sAETosRo5CN+?=
 =?us-ascii?Q?aRktF1bfV2zbSHEAXzZhA2ToI0xR456pZnqyPAtsnzz/MrcX3Ka6EE28tLGx?=
 =?us-ascii?Q?76JCZ7n77lVQqsvjUOv6YHuw1NIkDCg0XHnE6ls5qR4YmB6F1nSFaiwDzQJB?=
 =?us-ascii?Q?FQX0uTad4g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	YsMFJPnrC0h1HoS0n8TLB0x5Ak7j+n2uh4EilIJtpeQderLaoqBDUx++nIWcNTR1WtTt8MSLhsog2Ewc0Sck+z1aSJO1U/4Ji+5HSxZdZas6vXzhJC8qdv69NppAc4sZ99U0xiuPy89AXL+w1BWZze7icK3gu8KB2WL+3cqXYqByz0x/Vwap+e2KLIYe/856d/hhTGZFEIuv3P4/PoiqyOagrsR4ZCKG7ChEFuoUcDLW3Av+eftBifWcumUO+c75AJq3RebyO7vBGcym+0Xsy8C8tz/cac5UB1zeRVbNGuor0IlM3PYPM3cEEoadBmEt2ZONQ95plop0P1SIfBMTbw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240ffbd0-c0d1-442a-c690-08de7fead1bd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:45.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6u+nYOMQUidE378D4XtlRwwNhcKOHhNg2G5TssNtsh/0yZUXOe0mrJ2X9vT6weXxH2SgG1EGVQuDZ5I4CwTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX1Ao2HgdDskL7
 ZF/eN0Ce3AUg+3hYj1yvi7gTfivh0vkuMi61evGblsmF+BnQyavEZc4ahJIc+G/j+ZDoW7LCsa/
 qAZoJCgSccE33ZPQ8LQvJKu9Qv3MPs6ermgCL+5r5aZeL3+9SS8WUXeOOEI7CuOotrXrQNwoFPc
 iDSXoNhR22TdFnySWHi6pBzhxwhANKn8MqKMhTRT6HNi8jIv8Rnt7EA66WZ8igZo++oEI/tefu5
 o4oPMlDfqM0EFin+GPBCTg8EsDPaJSO7/ILk22BoRk9Kzbz0ND+pWFyDcR5cYIDadRtrydL+eGL
 UM1QFY8NLwKDyOISJyoFiJHgmtogYO22vzRnXvBPg6HIY5yYGPBkBeJ/QczTuW7SWG3LCvbSdur
 O+tXDSGwdRUxhh621Y3kJOFdti2e+0+1Hn1WB9GOm+poZmYVUPtEbj9LF+zNBHJ5z51q4IF8Lo5
 Htdw7f6DnS10ys2tYZA==
X-Authority-Analysis: v=2.4 cv=LYoxKzfi c=1 sm=1 tr=0 ts=69b2388f cx=c_pps
 a=bYEXqv4PBJnnT5HxTb2zpg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=CvGONfRsh-EIfvXJZ3kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: z8dOUIFKTpgCR9m07vnSwzIKCb8fHMjD
X-Proofpoint-GUID: z8dOUIFKTpgCR9m07vnSwzIKCb8fHMjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3448

From: Chen Qi <Qi.Chen@windriver.com>

The recipe parameter in command line is not respected. For example,
upgrade-helper.py --config-file upgrade-helper/upgrade-helper.meta-python.conf python3-sqlparse
This command still tries to upgrade all recipes from meta-python instead
of just python3-sqlparse.

This is a regression introduced by the following commit:
ff1c2aa0d2 upgrade-helper.py: Add layer command line option

Fix this regression by adding a filtering mechanism.

Note that 'all' is handled specially and it means upgrading all recipes
in the specific layer.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 7edb6da..40f31c4 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -595,12 +595,15 @@ class UniverseUpdater(Updater):
         if len(args.recipe) == 1 and args.recipe[0] == "all" and self.opts['layer_mode'] != 'yes':
             self.recipes = [('', [])]
         elif self.opts['layer_mode'] == 'yes':
-            # when layer mode is enabled and no recipes are specified
+            # layer mode is enabled
             # we need to figure out what recipes are provided by the
-            # layer to try upgrade
+            # layer and filter it recipes provided
             self.recipes = []
             for layer in self.opts['layer_name'].split(' '):
-                recipes_for_layer = self._get_recipes_by_layer(layer)
+                if args.recipe[0] != "all":
+                    recipes_for_layer = args.recipe
+                else:
+                    recipes_for_layer = self._get_recipes_by_layer(layer)
                 I("layer %s => Recipes %s", layer, recipes_for_layer)
                 self.recipes.append((layer, recipes_for_layer))
         else:
-- 
2.34.1


