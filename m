Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2989FFD0637
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:38 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15105.1773211714539244658
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XqxVA5YC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B6LsO03029391;
	Tue, 10 Mar 2026 23:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=; b=
	XqxVA5YCGM+MEthjz6daOdskAlmobr1VL1P5ncJCVUTrRWy8bc2XpqNQUuIkour1
	YV6x4NUOTAtWT3dnxBBu0z3bZ+EzJtYYpinQ2zLx1H6c77JFxVL1fxfUZpnQBRjI
	S3zTwCriCmiYKCWc3CaI54Ert7T+D3WZ6wnhK+APVfVPOBwrA/Qujh6aDwgbLuNQ
	mexAnxG/vnkVbJAipQGQzFm9b80pHENc6unIT484uWRJ2xQrZsBJ+tfSlcPt9QDW
	RDxy4V6tqhp9bh8QJkDMSvy/8t8iRr2ZrPS2hBOAQh5mT6GfeqRWjVaomnZBcr/H
	IXPNrQ9DyeGpMQnw+30JSQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty53075k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmHacZbAJpH+5n3fvajmz5TArj5K6bi1dFNGMZzA7s+IIHJ2V2IvMTphE9RERnN+YGM0jw5IrRhw4U9qP22B/pWG1xdwJpxUz/Wto+T2p3T6W5BHJnpDo95xROuMOLB/POyYYpWabvtzcuWck/tDpMSSbX8OWq5YegifZgxpublml8fUQkNvSF5zJ6swOrPEZS4CTrgL3CSl2pEVp8LyBxtN7K55syElp4UdKkeJa6l70Cdi1V6LDLiVMov4xh/4uSN39QIQKUcorFtHpe+7WmYr53rAQdKWwF8AkWR//en5VWTtW2f0i02Qw3gUfrLI/IN5D0Qv89HUGNmYvguSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQzkIjCgzkTVwKfm5g924gkn1Q2bpMAGA8/c2aoWNGY=;
 b=lvvuCRWmqqCcYksmOTgP6C8VYwe10Sm8zO6TIRDAUCNSs1tcaJ1DUBtePTJrpgD4AP/BYt/G/idI9ubs9sgT1WC+2YnjgdG24WYjeQWSE/7oYaggohf3hsrnYU/YK32vos/3+/p/Bpce3iKxIPFq2BTs/3U+5CBdLyz4SIVvChO8cc2VgmpAiIMGl88ptgK8DpyXeRlrJJ71cMRHjiyuvBpiNN+C8Gi5iviuHJFnWAjGTpDrvhzxS6i1H//ysojab1hnW7uRm9CAGeBklm4LtzAreVrBdeUqOaoWvWtxdfVmujeqJKqIWYPCQZkJ71QsiyhZTpAIR9NJqLnA6fM8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:31 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:31 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 03/12] requirements.txt: remove as it makes no sense
Date: Wed, 11 Mar 2026 14:48:04 +0800
Message-Id: <20260311064813.619683-3-Qi.Chen@windriver.com>
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
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: fa500b0f-3c5f-4ac5-050f-08de7f3a353f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	OCNtjffpOXd9cyHaUSJLJijmQdtRYVcDCW4BndOgpgYDh09wlmYOkCCHiOsTArDmUwA+h6OPTnTbuV7dxiVIW1hM1RTUC1HIoZmqqiQ5V73ANLPFAKz2vn4nh26yKAtWsYO1SD+Z44ok5nby82snvz0CVN4/jwovK5yq9OMsootnfRHuyVT8u7pj3WNnKDhKj1vnsy7rrUfVrrlIln2qdbPavzvD/rSoIBlr78Kt4dOFSQH9/jwus+XJbsNM2rId6TY2v0Iyce3iL8coTWEnUfz/chd1dGTJYoPeBt2I+HsBTM3nywuqyFr9snFqvm/ojGUoZzi0iY52+Di7D7ehJGGtW0Rls7pb3rAWHNrSe9ew7mlWHECAoORrkBmIDYM6GubpHpacKMfB4VyWoIHMlP/aGkmY937weTxJpO3h8OBMxRYU/3QEe8KKVFsRkY+pwLHj73Ml06znTdgKLRAHaL/PzfqBsmQIZDpB+UBbg84G7gkVulGin6LXHSBwZfX103PncyiCsXTvdTQgqQNjRrNA4ry6WlYb4kQzhX9SNYRjfSMSe9sxXQjAWlZuERPPnk6+YQYxauV+wmm9k16vPJ2SyDRYNhonO8o4p0eozMkNPg8e3FBb/8o8aGruqzG3AWZoQJUlpEuqNcYz5cpVQMmB9bludW1QZLl/jhArYEPk/n1/1IzuyxLMkh7UdZe8uj7umL3x1O8sqM7Tiz0qqHVl4dTPwa2qKC3g5qySGj1hL0QYynXBLQdtXqlCVLGSaMWNuto6gCItw7B2eibKD1mhLNj/Q12yl9vCzWDBZik=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uQpScaag1HxDYPmmYEigT640st827GWI9y0fr0KgTrcNsrA3B7UaZeFh9wFg?=
 =?us-ascii?Q?Mc/Nu2f5Br5OlofuIsCfKQZ0vtqB4mSCHGaqjxBxHgNUDpYZGYpDVnoiwN4/?=
 =?us-ascii?Q?/46FG44vw09E8atxL0iAYiccTlCXM2lqbtwH2w6fMSHeJxBtx78HapiW2lCK?=
 =?us-ascii?Q?gU5+Cz/8zuLfQerSm82kF/9CmbKEnwLM5yfvQcDGbBJsPaSt8WDay3iaaxgM?=
 =?us-ascii?Q?KW16UGWPjLg6ppNImQwqaLIOXpFMl1IdwhRSUPUe2VtJr3+JE1oGGmfZfYUH?=
 =?us-ascii?Q?qt6oOIAHetLSdgmX+W0qLtpkk+NvSFBMYgUrqkvHbqb73gKZo2DkWbmfWpjk?=
 =?us-ascii?Q?TEfwO2ukVVeF9Fvvu7/pgG8YBDgmwhAf3pTErcLP0syeTa01OjXbxsoYe0VO?=
 =?us-ascii?Q?Kg94ut2uOsDaMjKlwKlbZcn3SbvzlLhPp6tiyMsMr31wcGuLxbfUBx2FdKud?=
 =?us-ascii?Q?rQxrsAHU9EfqC3WBvnP2S68eFDyeFixq81fRGWlvKUcnvIT7lIfXyFqvcokB?=
 =?us-ascii?Q?axV3BPuG85NPtfV78w91e40GlYYksxon4gwBO9/3iQi3tlcFjH4ElBzmZFdV?=
 =?us-ascii?Q?oKeIQKpovPei8vQVKfQ3x28W+5aEIOIOLEs8wuE2UB0+x9VK36HoLYI5dHkb?=
 =?us-ascii?Q?rxmN1ew1nchUalwONeBgAIPOx/n7M59wrfJHhxK81kB8lBHzlWMO47XZW1hR?=
 =?us-ascii?Q?252V89TbGw0uesDJnnGpXQqUDMjqJyg2VRYdSeOU7/S/s4CXs6/kuCXzoObJ?=
 =?us-ascii?Q?i9dqWB6O0bSQRwGobsPoAzGsvV+SwAaBhlcFXCDl2F+nQNnDX9eOF4Ex7kjl?=
 =?us-ascii?Q?aelQya4pHielg6U7FNTLlW5CJFI9SEkD+J/44r1Hv7RYXay+FRZxBafQfdLr?=
 =?us-ascii?Q?Iv2OLw5y5Z1EchLu5vuy9m75ByYKXvrQ8MfrNy8OiMI7fD8D0XZmjoVOOrDC?=
 =?us-ascii?Q?S2hSy/QDfV3YMT8TiIF7CixTk1wSxYF6ZNzD201ZOOAPBfvk+xjX7ehTn8PD?=
 =?us-ascii?Q?bTN1w0+yUVzB18eXK0OBLqgYhxmusOaE3L4pIMEmVoZ5ADmOuigDD1dZsb4a?=
 =?us-ascii?Q?yxdfHiro89EIpv0BrAYXHyr86W+xuQBNjir++wi68F+4lZvqE8b5wLx19QW0?=
 =?us-ascii?Q?hjlASMulcvcuQ/c2Yysfl+RO5mn10FN+dTs3ZZtPzdnvUhcNcFY6cB9tGNwH?=
 =?us-ascii?Q?h44JUK+RzR5n/O0ZwH+5nCE184yj93Ri1EszhMGCv9BVGsGaAWz5avMJ33Ru?=
 =?us-ascii?Q?/nGmqYPQ4fZgNYrsxgMI2PkZx7yp09wk4IG9k/39vP76c2Rsnh577o/bI0mJ?=
 =?us-ascii?Q?cdanKTp2iJHGwCthWFurlDjO7Z8FD6nA0R9G4HLIXvAMPjWKlptUmId0LcYf?=
 =?us-ascii?Q?UJR35Q6eCB22rDfmq6/kTZ/FKwRZQn/5mwDuGuI//HeYlqpIlSee+jyxrCzz?=
 =?us-ascii?Q?LfZGLC6lvPRXEZz6LiSUYWU92/iEFdOuRJT7JGmq5YSEjMRLGzZmCLst2CU4?=
 =?us-ascii?Q?t2hpqs/dRdYJKjQ3vxu89FCM3Kj2T6YnXU6x9tpk3ru5e6m5o0Xp8NoHlA9i?=
 =?us-ascii?Q?u4lGts445FQSr8NREo0+728XtEnSRAeX6DVC2fuzg/c9HL1bhHCQHU+TQRYG?=
 =?us-ascii?Q?FXheZ7ymxh8a2t2wi4FsGoH4pmDTfkcBtt3/cZgCzUkuAXh70GRczAAKIPvR?=
 =?us-ascii?Q?cEYFfPxQMVwdW8enVLz4x1r7x5A4cn3YdJEHlWJX9dGU3xI1AZIzYNACnsOH?=
 =?us-ascii?Q?gRiWG2xTLQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	EaGnvySXUl+Vaa88XfmopY0ASyMV3isDbjOI0HUTi9XCVU8CY9eX3cV24RrFTY2p4q2JRSz7h586CKGqAryFLeQw5BWrB8xJStfjLukD1YD9OhKBcs3/3d90B0GMssnOI9U7nKDJus7ImGsXKaxg2pwCFkwvfp/96dvRR9WVslLIWfeofkoPE4Y0EV7JfOT7Gn5mXlbjzeHZ3qnHt5XfzUe1gnKZnIf9Wfm6OE2HY7U36fw5l/vFRIG7N2GCYLBm4+FT4/Yv1MMXLBZHbRqQvl6D1XbMze17G7F566ghgn3Ck3gffzNfxZEpa78lqrkkYsgoG89vYRkW8nfwkEgq3A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa500b0f-3c5f-4ac5-050f-08de7f3a353f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:31.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDWDxf/sLgj9HK5hU4rI2pKWDOAGKFWjE0p3Cf2/+z4DeSikhDmXn8TVqMykXHIGWNEFOHdinpGcoGmlNqAIoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfX2Ox8f2tM9uYF
 xXWciedH3WE/X6ec/yo78g27lUQY4KmYW26WkrR9uguVgNqKSm+iC6mzHshMyGhuto/qPHuHGqP
 k8FDqPaVJO9a4eD0cOlru1bAdcra6NHpzOpH6wUsZXr7lIg1rg3S3Za+5mIFozAWjMrEL9xOvE3
 ZcoP9ZPJoZODNqd1J+d4QzFzbmSKwqTP9UbHyBKGzz0Wa0+XIbK+kEXk+wU3jbdbqpyZJpoQImH
 awypVxBbg22P7DzdOjfS5KFkxGcDDg3XrqsGQaO9PmgX34MOHv3p/0MZ7aUkE6aQY9m602QmU+r
 hQYOj0F2a6tKhLCGqGF8tV3BAIn2h9103jUuAeglbRxDnQjr4MqvPZQU+cxoz20440WKbnn//aC
 5d8qRHKgAOfdkmI96D8PDrdlRQxFmCSfhHinwVXeL8WDvlpZqQtJrpogrLSVVsk57KN5RrDUz/R
 IrTnG9eUfrkstXjwMzg==
X-Authority-Analysis: v=2.4 cv=PvWergM3 c=1 sm=1 tr=0 ts=69b11041 cx=c_pps
 a=8eAlC+B4wJl04ff18yArKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=KdazThy4EY_gBvstyO4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Qbv_HVu3-W6Cw392R8g4xWPpIq6jXcOI
X-Proofpoint-ORIG-GUID: Qbv_HVu3-W6Cw392R8g4xWPpIq6jXcOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3416

From: Chen Qi <Qi.Chen@windriver.com>

AUH is not using GitPython, it's using 'git' command directly.
This requirements.txt makes no sense.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 requirements.txt | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 requirements.txt

diff --git a/requirements.txt b/requirements.txt
deleted file mode 100644
index 64b1ada..0000000
--- a/requirements.txt
+++ /dev/null
@@ -1 +0,0 @@
-GitPython
-- 
2.34.1


