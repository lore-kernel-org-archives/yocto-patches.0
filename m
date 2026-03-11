Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E898FD063C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:58 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14800.1773211728424795759
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=BfASf96g;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4pLli2782713;
	Wed, 11 Mar 2026 06:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=00UEt0Nu1bqRApT+CGyZjkb5O+lMDotL/BKI1uqpUvM=; b=
	BfASf96guiMdY1HavxEr1e0jgs0h9Ha1Rsm0k86sCnncivOtLfWXBzgkmy5kCoTG
	ZS8ikITzq9LAFftoOSBCWXqh74yexaFb2QOpw9zWTxAw5sQHi6DP+r/CMAQVLncD
	V1AlZMBOkA3iH0Ra2O3B0F2U3JXib7j/Y5D74FE8vCh3104FOpb6O0/1xXTA2lXI
	LM7GAGTAWXhoykhKi8qNNavRudskNCraK932qzCwKjQ+qdSc9y4V2x+aj4JRPhae
	zytnDRk7jVpUX1x4PryGj14IdymPdUhNiKGTz6XLOR065wJYwWeC++s+KX0xG+xR
	iFi/JupMb5Dp0k1FA4RwSw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r7gw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:48:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgPXF9ZcGcx8MDaZBFGhui0qCpQi8ci4pEFLrGSe1uYNLfYZOrQCgGttzZwAVD/XnbtT330yyiTVjQF4GR/2d4+qAS54nsJwtqv+qI19eT9chmcgG7VcjTkxwzjAs0YXQPc8s14YnsoKMY8v5KeLGFgVZWqKjONzayd3c3m9TyAQgwM66Za/1WYyQy1oFxYZm+3UKj+bZ343wpF6jmgWyzHyPV+/YXz7CefXFrzFMA+q40ZJU3KpYcqj5dOLS8mJLKA9VIKJ02QIR6yj3Qg6DOiLkHuarlxNb1AMVV/76pRuqZA0sKdUqSgKDkXsdBWKOKmbYobDHUoxJbPsMV9WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00UEt0Nu1bqRApT+CGyZjkb5O+lMDotL/BKI1uqpUvM=;
 b=MwiBcmZTX8XUOJN4jLBB36TJ831zaLXFoimSAjOlL6+hG0AMbc2aOj/H5GgMyc5c+qhndchRjeQaEhGhFNvw7v2O+DUQUg52eM6reOXf8tQRRX4xSkHxHo0FIO7xCfNpgJI5eypwEED226M83i4Bl/7uPz35uLPOchiVFB6s7LnD5t25r/GyciBvV9IvmGtbobtK7ETLMUY1W0gaJQOZefDxoxRIhsO+hAQBjRuCpf95mL7/qmP7LnkobfoM7PFid3Xt8BVQx9i3dDnmp1ZlnMMw//tGLL8KWEHDp+R83EoTy6IjD00MQ+1tBeyA1eAjMJhC91XpsNxqZXJ8g4O8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:48:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:45 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 12/12] upgrade-helper.py: respect recipe parameter from command line in case of layer mode
Date: Wed, 11 Mar 2026 14:48:13 +0800
Message-Id: <20260311064813.619683-12-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPFD01EAC3BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 4114d33d-3579-4c42-4ec0-08de7f3a3dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	yIC+iAiUr/FAZrlw+P0R5gJIOlmoBYM2zC/Ym8GrGtDWuFHTS5PUZp0m8eR3aEcR1p2n6xvbEOk6VF7pXOxgxuispkXrjRrQjE9qbrOz1UVangCrrmk4M2a/dt99xWEIH2YryOVJagO9C6rElR+WORimdepb0bixY+2n1DPe3cZD+A0hVbuhXnMZoUC0abfsJtuotWetz+3dz7Xc98G6mVDQ7b+tvxvqx4Rsd33JnDkjnu0vyp7E9xMIBTs7/sxgFxsSd4Vfz1fvW+FD7dNJjn3g3pCybStdl6kkgk+5qRvB4YusIjtrmecxwJ1/PwNezk/sKbSiYAJUcF/vPzkFBzVA3jcC6MEmpAQv8+Fg+jWQdZ7pBTy9Ln1BmfNeD5YLT6U6jFqIw3yf1poZTnhhT9O7at9oS7hZgsU9iDK2qou0hz1MpSV6D4nUOBitplaWZOisNmL+N6DBhsNkZ4vEDL06p/zK0owx/YmxOcu8mqjm2wWn3OHZ5jZzARK6egM9lOVagiScYKNvHAgCP1lvs9F2KQhWdLatQJRyU1SDPranT22xwHplGths80I/LlQd6IwE6vMC6IsAnn7zfgRJtNVre/fOdb4KxDrjdgwJbNzgMEGMm21F1OEfEhojbBtgCslKWRhySpuJnj+BfHcdYlyYwoOx02GmpGM2L7iCui37vjLalGRO2quq4N09856zyy9DRc03XouOC0MzoFIS8b5jJthGo3M3z/bqoLUr9B+qEoWEPmrjjYVn94FIkpV3iFndGuKnKUId0QkGY8EI+Auv0b8bAHu3jAmfJcoIrEM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ElsIs2bBSyuxBA+eKeDsPexgytMEXAFEVbSYcG+UQuG49aO8PWt90bD4R67f?=
 =?us-ascii?Q?lzgfhj7JFmvZAJtqvmOG7BvDpq6OyNjTlh+yOD3tReJje94zjiVFWX8WKALg?=
 =?us-ascii?Q?veNzNfI4X4tdOFcp8e9o8/aTE+2FqY+WGvJTinBy1ONFXXF/uXpNMJ13KwfO?=
 =?us-ascii?Q?mRzkM1F8hAk4s3T3nBaahINtPj0UHLKabOSIksJ4Jh8n/XB3mvcrQ/zWt/qi?=
 =?us-ascii?Q?8aW2TV87VSUIe2qm+IVf/CD1C3I4uXiTtw6qblfa2uJWrbpvp+VOyqwOiUhB?=
 =?us-ascii?Q?GzDFjEURHT7Zmplgjmg18iuaZea3okknC8iHErMCguGa58xWCU2mXL5/zE0M?=
 =?us-ascii?Q?rksXQEmdXcrFAKvDLdnRwxyca9m9Z+hkV6rtJZExiNiiz5O+ln/tC8BE5vb5?=
 =?us-ascii?Q?CKSnjjHGQryuv7+Ir+maARiB5FfX6OGVRVWJE6x/FfkInbXBu4d7Xxl0GOvS?=
 =?us-ascii?Q?bod3wS+aypVGbhlBqDMuZnMR6qqNitb9RW0VX9BAMv45cFLqapQtfAoI9SWd?=
 =?us-ascii?Q?BYgCx24g/tAWEQUv0z5SLQA7kNby0yXOXs2pe2YT/X9f1aZIGozIUiMPnilt?=
 =?us-ascii?Q?hekAXyxZAZjjOtuTAvHSU1dk1IB7OcBTBfgETIWqri7l8EKVcYlA2GPbxKJ/?=
 =?us-ascii?Q?qFVtSPnA0sUa3/BDkACvoChgvC57HPubIoDC+bbDMt0SAmqSGrA5Ijp5C2vx?=
 =?us-ascii?Q?/D1rIe0Zs6+OS5jrPN+s5Gah+spWeE7SylkU+SSX+QOJPMdfTEe3vXDMUkOI?=
 =?us-ascii?Q?3GxP+Dc7kEauM6WZ3yJBSYrnBNB37pcI+93hWqEL28DqHceOBT1CISiwZq7M?=
 =?us-ascii?Q?1FSCwlLoX+OqzwzBL6TvcLqi5RhT9IXbpNSs0BoI/HaRO01fsHnttFPkgIxZ?=
 =?us-ascii?Q?8Pw16I81Wk09dKIcmS+wO4V7DIWq1yKV0YxGeewzytJv/S6r8LKzq9ox3xwC?=
 =?us-ascii?Q?bcoU5auj6c2z+cs7y1Iic3SWsQyZhu/bE1DfKy3gnDLoTtYf7Z9XoTijTpse?=
 =?us-ascii?Q?0/4bQ48O967BizjexzJVxnWNhl8886sjTuumfxl80B1aqSFSZ52xPJA9BGHH?=
 =?us-ascii?Q?i6hnna0Lz+x7yFjo+mkknmn9CfLwcIO0PyykXcvaK5HLs6i7qaElCNeGjREb?=
 =?us-ascii?Q?BTUMe5Yy+0QrClBq+1O3TGr9WgrAZMZw277feSSGcZtmvWy5Ldpd+ZM4EemF?=
 =?us-ascii?Q?t2fH/ztCKuwjhv2gcWTNFjIfMMJp3TjnmsvXDrxIstZaGBrFf70u7KoCeHlE?=
 =?us-ascii?Q?XiOUdh5pfbvG3ON6jC2V8kXaFU3mA/ako1seOfXu9yIWiOG8vTlhVFgUNdXH?=
 =?us-ascii?Q?NTadt3+PikQvOzH0ARaea6ou/5Dw9gtJ1uiiSYFZNZDz/KdZ062LA3wRuUsC?=
 =?us-ascii?Q?jCQzjuxelXIjQ6b49/8jk6gyB93Rn0KXmJAQdxZOT6FU+Lh2yrP67qEZLn7K?=
 =?us-ascii?Q?UVV+G3HRKudkY0RhTHLelIF21+8SVXaBq2WlvO2o+c8/7jDXUAr85oSd8gHq?=
 =?us-ascii?Q?caC8vhysO17MEQIaMDUmf9GDbFH825inKfcqpTkMARhgIK3NmJTPWVan9ceJ?=
 =?us-ascii?Q?X0QYla+5aGsbQRIxe7KKrQ6a3MkUuY0AYsGrTD6f6qzXNGzk12hM0hWxvR0W?=
 =?us-ascii?Q?WsijZ43B/U04f+OprqQw1AZsumECkQiG4Cah1GxdatstXaaLIf5PC0XkgrJm?=
 =?us-ascii?Q?XhsI++rYjHiF9HpMw42Tiz9RxIV4n4eFJr4R3M1BFvdzFcqwLAM3wX/EIZQE?=
 =?us-ascii?Q?LdXzODe7xQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Ns6Urk88rQkWzv3jE7KY5zJ2IRTOpzxTGkdstJhkkxlRESnX05vZB4/dytL0M+ADB5OmKzV0ijljDwsPwkuZGQjs4qtFulry4s0B8HEAYNH5wUB0uQ1K+fh1VVdvtL8BUCXziEDs8K/QPlOtfyts5L+bdcLXGdR1eZfQHH0JH47Dwx+zOBR9PfDP6jq1FZWPCF5oHS70QeYINFzP4nLehnRKvYVXBN6N4Btj2RVegzime7292cwflAjGGxxL8CqlVU+gGX7ECaPit6e4pkVKZ8nDpvPvgF3ctpeaf1lbv554iFwoUB1imbd8iZAEKEMgaGYPzN2fggAMFsFb31E+IA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4114d33d-3579-4c42-4ec0-08de7f3a3dd5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:45.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPe6niD4vozSCEzwQ1Ju9aWX275Df7jDUCi3o0B+BUpXSr7svSg0zG0+xoLbdoEwv29TzFiT65/0/K2NeuBiuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b1104f cx=c_pps
 a=KM6hcDErBpdSH7DPVcpu/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=CvGONfRsh-EIfvXJZ3kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: pUnx3n7ZBs2hXRRUHROFaD_o6iKWYlOj
X-Proofpoint-GUID: pUnx3n7ZBs2hXRRUHROFaD_o6iKWYlOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX4083L2bNDEtT
 TUGPlJpiWMsW2lMvFlKMWtjwvIznz1jet5RCilkmFrtTdI7A45+Made/7JoSEBd+6xmKrxDuOYk
 HAsJxQ4frdBg/QQZA8QHqWg8vI9HAz7dZn/JI4W5uZBDHcGE+AYGv9EuNcYWaQqg8PQ3v66EBqy
 1ahaUy3HNIlpDHGmLKSz5CAvKU+zsw6C7JxEdNk5IWrXRC764hkg9KvWEhJXvJYanKeAgQIYsIH
 +QmgVAFvtgHIkTIWXXfvMOD1FgbNoiC8TDID3f1oXi+RRMw87fohYTVfqhBYvfjD/6XnUfsL+l2
 7qdrTDrK71ky9SA4Zd3LoD4O32wD2jlHU+o/93vRCaEIwbsdOrtCYFU47GKm1cb/hwCMoJvlnm2
 8GjnPBqvqgGahvunUIcmUilxkJMUeGCyz0nSOY7y9JGCuaJKBA2tuzpKd47Ag4kE/36JNZsMuCk
 RDZGfC82zRm9jvDfm7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3425

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


