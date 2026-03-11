Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC38FD0636
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15109.1773211725256688378
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=q4fFj+gx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4suLh2787197;
	Wed, 11 Mar 2026 06:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=; b=
	q4fFj+gxWrRAkDj3g/B3+qyl5zW/HdwavQCmPbLUUMoUmkVmxKB/d/orQrSR/k+S
	UE3MDZLfBPpfGH2J1pWNRqLItcoHNR7GtYZaBc65LrYuqWut7fqVCFG7/ufWiWe1
	jabh9zLgchS43ovSqFnlR+hvtF3khhEbeZXQXnlV40ID3H+vIeUoi4ODtPEqQ2U8
	bMcpZfIeKukXSdojKNb2M561dr5pNosOVmsYeIFJZrAVBFxcR6J8KHRA5on+dFlL
	19qxFRBvQ967TUlaEkMejxCJjItnWlzKzoy0hy1xItQuDPPlu9xkGV7N4DzqGcFb
	mVAR7gdYEbkD9kohTQVh3Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r7gp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:48:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxMAL3B9UAMH7p6vXfwOy/BStj4Piczx8MpDqUfzS53v7/mmQVBnsAs6FecsDEH1TnCcJqdATeJeYT3aEl+W/CwMP2I5jBn8+arj+IKJ1ACE6+6r9+Ow+Op5bPxZJBSQpXUdTbZPTeefYy2ooxzqKLBOsVXPS6d7ZPBT0FgVOqr4kPKDEu4csmRCGjF1V3kYz4MG9uUDlGaXRzraYak+sncvZxrjAtGVePSWE2XELm5YSuILmd9Pb/OAxuBf6JmLuGWglGnKTEr68jRC+kalnIqd70kfU2VE95MAQmgA+RSnFo5upok2c1/Cl8AXF9MG35MISWyUY6t/ksdF5426dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFtNsDXT1K24bs3pRfrSaayXlAaRyTMOoI2jebRkNVM=;
 b=oJVv/DGPPHvErZdOrF2cx0wfX5WTa4Jr1V+qTAiAKHjZvgBhGrkWHIH3r0r+wSM9xOlT3qzMlydvWwI1cwc0ixQJJcAz7X55QvFXvf3PMVvVBgTdWZpY862Zi7jQjEh6EQbkj8HEYKrZa13GoFEaTQj54Qw69EmQgqJ+dhHhHBSg3bv5vBlXLuMb7Fzr/Qy9QYwZOBdVQVMcXRdVQ1IJVWpcdeHKREL3toITUsyQxs8yco1hoCvaWnke3PPQBgwMw8nRA5tIF06i+7wAk38nf4/kQkqZMPSLJYoghNwwvALFKps1e/aTHU8j2G9nv4NsoH/Mkn8GkiSKa1Ys13Qg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:48:41 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:40 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 09/12] upgrade-helper.conf: remove layer_machines from reference config file
Date: Wed, 11 Mar 2026 14:48:10 +0800
Message-Id: <20260311064813.619683-9-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e4d0ecb-8424-40e2-81ba-08de7f3a3acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	TaCS5f/MHbdDeSJEEoFKopED0E+9M6O6c/va2pC7H0qRRsRgpu37rerRQOhO+D5/s9yr7dEYntH8jRaMR7J4jENe87eX3+XtrZM503IHlvQWol6wEzjHoZZdKSDNYIKNuu7Nbx54XALGn8L3S7hgJ+FPPsG9Qd+WG6n3DwhM3KWBG/fcvZ3mZWoVM9o817b/q+8oTyLlUFwHE7nzfainrtvlIug8ZnBozZN3K29H+zMp1onppyyeY5t2sPbav7gLY8jbioxGCeC1x4EAyxHt32ctdz7NwxP6Dj01iNO9vHcsidyehyx8KSMU0RdalLEiZKmAHCXBZn/fU1tnczLGN9QuYs7qhfMfZfMdawGsSopOL5KBzKk7/uuUS7j3DDGenMFnyKbMNk4V8BPJc2AFL2dfpYrZmuzzgNmxL9t2b2Z3RHrGbnClNcu+ZNJ7bTgZZUeHcRoftb3nnyo6GP8RV8CHL9uquNignDuTeZb48erdt8gI/0Ob/pEP3qxPfIZp9JTcVlsLLXq1beVe1pIrgwIBKJjIvcQ2bB7C5wwfxfH4SoI5P2LGV7BIuxFZn5dQIvhVoUQIc4rXAQ6H4CnInhT3ZY8NNkj53l2heYF24+x4B0XoOVAXCnTUuH4UBOIrjjqV1CtH7Md8Sz8CwhzNzOl4JwyP42/9R2eadE16fW9fHZhLN8/5AhaQZ6WWk0MqtI+QYbUclCQavhTQSv/Xq0JaKa0byq2ZGZQahaII2hZew/SOtRjL/2ShG+8i3g66w+pM4RBG2wpIAUsxaKkgI4DGeKUl8c+TBnFO+RPce80=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LVjX43kJ/PobnpD6EB5oL8NpQmWOaM6jEVo8SEbH1YmQObiI+Yh9kTar1/27?=
 =?us-ascii?Q?nAO8gbzjplMkAFoBbNcNZm6wLE+Vl6LYfPFGY4fNjqYBR7D1tWW88Wpl8LIv?=
 =?us-ascii?Q?VmtsRfmSynI6J7n9SvMBcfKOrQvx6kDig3O5KJ6Bl7+pPrsgyVRMQkzjyWYF?=
 =?us-ascii?Q?VBumFU/5uJllWyb52lHBbewZNhHKbvtdIJNNcwhFObSPmnpOrIcDXPrrFoZL?=
 =?us-ascii?Q?Ou4IEEcDqs72PZKG6OFwgw5yl7OqGIUBlfCr3B4r2OvCgucNgimnMtxwBgfe?=
 =?us-ascii?Q?bxuUDWsye1Pu/VAakFTjj2xPFgWWKp7OY1yvetDKwFM15urLjIJcdpGR+h0T?=
 =?us-ascii?Q?zzoGpz6SEAHCK1zY4XOvGd3g3WVeTFC4HScne2UBRaq1XH9Xhymd0lMQjx6b?=
 =?us-ascii?Q?AqagZf6bMR5CeIP9jhqZYJ1sC9laFDMgdM0lrFxHpYq9yfSqnmr/hSnK472i?=
 =?us-ascii?Q?uYKS1SudPY/9aRRegL40LLVKrovnAoBccXaNkfh60rGm7i0JiMSBQZx93/P6?=
 =?us-ascii?Q?PaIe9wMWcNjxo4VvzkoXR2kjsOrHdIV85yRjE/pdDAgUraEOGbyeKAe+oWfa?=
 =?us-ascii?Q?9rVoqpvohVXY8r2dK5u5fL+8TGPyZncocWPCC1LdnNGlTK1xQ3WRSEznNDMB?=
 =?us-ascii?Q?PfCXlbfS1NGEvgsQgtU/WDtfuIYdzU9bg2xZDb7+HVDO5dbIkcJyh198/sz8?=
 =?us-ascii?Q?jLiCtUsYpUXPZwGgUslV1Np37kD0mzS7bnd/nQ6FrhfsA9Sf1+EJJnvZQkHp?=
 =?us-ascii?Q?rN4f80r0kDwhcCQiksm2jkY2BCxK9ZyfqN2i1JYpDmLvg6DQ82kmPqREWqAd?=
 =?us-ascii?Q?pb1DaQtndM0puYuzpRhSbCEAZnWaTHLk9ZqKog+snPQtrydxwmh/edUeCLHg?=
 =?us-ascii?Q?CMOeaTeuV+qDwW8ECMLdI6kPXagluAr46q8bKOmJ5m1c7hUBJaQyM0+y7Fvp?=
 =?us-ascii?Q?1hAXbxU4rKZzvdXIb4HIhSKdQtyu7OuPOPyyh7zoxYoZTfrEkwBtpH0VRHYY?=
 =?us-ascii?Q?SiXNjxhpHe2F7qb9fmROUIrzdQ6Q07PHV5QAHQ0/BMQYHcJkFtqSot1rBBIs?=
 =?us-ascii?Q?+JFUMcayUzvNaSf4WEWnZ8cT2iWZWTrkwJ1UMUq5tZlavmAJqnIzrf/EJDvx?=
 =?us-ascii?Q?hersqpLgayJ2jAjOn/kHomkUM6LAS2r34v8AbRXdYkXor3YlEhezM8pqUeG8?=
 =?us-ascii?Q?NNyvjL4Uz2D5V9hcmCTqqDro49bPSiwKKFw2hdMCH34owtxKaoZ2NvyJwb6a?=
 =?us-ascii?Q?Ai0lKGoS18sZthkd6q6KzE4ouy+3ouLFzYChrezBGhtWmSIwxLclEFyX0Flr?=
 =?us-ascii?Q?SPyrZi0XnI/Bj0INw1qdNuoa7Ogs104kFAaieh78np23cdrZrWWan6/lTGjs?=
 =?us-ascii?Q?oAHgOCHE7Dcykcse9EXp6jIIRdHm4mSfeUU03jwACc8RuGOeBhX2drAbDOPW?=
 =?us-ascii?Q?JGTerYq7F1Hw+IYBB0lhkjsulpLwtRiHDbb0a5f0xOJI78mpaCXrhQU/x2f+?=
 =?us-ascii?Q?H8xGptzqFCdvMo0AUmwQIzn9baZHscnBCZa736bGnN+m8L+v9LfHB4OcWKXR?=
 =?us-ascii?Q?o5lcobyB6xuAp/KHlt1eTlUuLdCf7YMMvdwXcDAZANRQ7J+U/VCf+/vTuNNI?=
 =?us-ascii?Q?ki54isBH0zCBw1WvnHiay7DCNoQ6ODLe0h2gHqsbKKQiKOYU4yRCA8PQvX2g?=
 =?us-ascii?Q?FZUEIQNzhAi/NeCFxerVUyW4Zl8kZ9YASe2AHHchZoEr+T53XN7LQvnbe9x3?=
 =?us-ascii?Q?9E/GWh1VfQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	uHW+xtbbYvjc6hK4X9hpJv/pPL5EqWgUSlonmjtoxcEUQBlI/vPoE80oodDDnTlYKN/aDYQRSdNA1cLfNBHlzS1GiuHGMm4+gZNTZnPfd7BF4s68doQ08PlG8Wa1Vl6yCmf7C9+gb8/BzoJayqwFbAupniNnq8Zo+jOZ34mPNCZIkLGaNGT1d7+a/DPzntnpRogSxNDmZGchMO9lqkmN4j9ydGdLwCQAPr15+ofPfMeV/LGjxdhFe72cx/dtks3rybw7o5GxntHsgqm9mRtmNzqYgrrkgv7282Ptoi83uSxeLm0yJFozHSTBiCgXSVtO/U12NcMrH9URq51ffO0LyA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4d0ecb-8424-40e2-81ba-08de7f3a3acc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:40.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmjTcWIfWrq3hT/lDg/J4Jl73rYiIIK1shYeQTuyXslZs+B1lB29zxwxcmqhbnLIgrhoojZFf8fGIjS1z+7d6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b1104c cx=c_pps
 a=ikWRpWbkSoEIfbFFe8At+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=ieWZEeq6gUxmCoMFNBsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: J4SLv5FsKN-A9T75WJWWFgzE5j5Rimdn
X-Proofpoint-GUID: J4SLv5FsKN-A9T75WJWWFgzE5j5Rimdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX2Vkd4strpr/p
 tIusiit2x+JcZvhfh9kuMvlDNhV7SxL2kHiZll3+E0cM9n36pQYePyT5G8YmG5x3afS6kgUPZNq
 dsMMj0f2hgrvVkgwKEbNf5RPnBElRir8qrN0ExiJDxl/uOxfv1ecD9MjxTtExlDHzIBShn4XGPQ
 khKnck/ZkfjjzQFXz23x6YNQqa9u7pXYAM9cyR5BcfhNNFRoHWwcnQ+BK2GQb84LJj7zA7XkoJA
 GGSLEL5LXQiwGNNrHfkQ8Bij/ZzfIPP7uGo3+tgq5fO0PI6BnwVk7622z/DagzmvflCWjDHVCfK
 CzdZaRyKx8uRpNTHIXVF/79YnjBrFlMvyLk5jfFpg0fAFRu7NZ0aucIulRoq0WJKV0KTfwqiDwn
 Ot4i2jhYpXbmpu+5dBXuNw/R4322fjuKuNbPD+womMGa5QPjVVxO6Pebc2i0LeKMjkxNhUV42Pa
 fh/0YT/jLyLCTxM//bA==
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3422

From: Chen Qi <Qi.Chen@windriver.com>

The layer_machines has been dropped by the following commit:
0ea93cb upgrade-helper: Drop layer_machines

Let's also remove it from the reference configuration file to
reflect the current status.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.conf | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 251c36a..269bde3 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -116,9 +116,8 @@
 # This can be used to upgrade recipes in a specific layer,
 # for example meta-intel, instead of upgrading oe-core recipes.
 #
-# When layer_mode is enabled, layer_name, layer_dir and layer_machines are
+# When layer_mode is enabled, layer_name, layer_dir are
 # mandatory. 'blacklist' setting does not apply when in layer_mode.
 #layer_mode=no
 #layer_name=meta-intel
 #layer_dir=DIR/meta-intel
-#layer_machines=intel-core2-32 intel-corei7-64 intel-quark
-- 
2.34.1


