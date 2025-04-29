Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12946C369D9
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 02:25:53 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4830.1745893543335905918
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 19:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7214951ce6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T2Lmqs014662
	for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 19:25:42 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468ts3seup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 19:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9FeaLSg3BBVmfb/d2+Fe9kj2Pqop1GmuYGMMeSy5SrL73XIYLphzmADD1N+7n8+pQTS4WlZuTXsJYiSOeZiflYEEkXu2H1fNkq4qv7W0nyJ+lsquNLPeu2Coqb727cYonzhhMzZN0+4wcCU0+VYun6i1/U1mRO89b9Hg4H5UKtQN8FzpnNnnpcc2+tVZbRamIwfWrSxSM4B/vsh5yVhxr4ateTGNMxmXMeMyZx251ml87nIMlUhVSRWph9gsKnq3IBHJYvGsGPy54qd0mU/4T/iTp6ANNouyloZ4NX8nAJqcQZ5j/oL++o5k+Ig+RSQq0t4o9T0xZDHXYdR9out/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X11uKjA6vr4SHDCN7fU5WBV1NkoWpMu76n4HJdHyHk=;
 b=el0A0z6Zyw8roPoIcNL0x/Zbzb4TLGO7q7ZBwll5hruFnD6x+90sapH4RvC9uh3YqgEk9FJSZJG/iQ6kmXfM3ZmZjlidzimRG0puqItjx+WxLFEpkNHam8XP9hwaEpq8Mv0CAfpeglYWA6EynpviW4+hZud0jRz4HhqS0hyD8HI7/X7iI4m37SJQVQdlB3gclvfO01pF7iY36uKOnha/KWLF1YjlJRAXihCWJk0PS6h7PuuMDoc1x8JAZA4peg6plBEI7fcYtXzR8w4jDW1Pg2hX70mdVBaBueoz60NxJSLUtGGkSsdwY4i74mPh/LsxrYN2/iGkAVrepLlIqETppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 02:25:40 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 02:25:40 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [libmatchbox][PATCH] configure.ac: update version to match the tag version
Date: Tue, 29 Apr 2025 10:25:29 +0800
Message-Id: <20250429022529.1508502-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:404:a::16) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c4a843-dc34-4b69-0fab-08dd86c5224b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+SYxlxIlshZVtxQyT8xedW6UGZsmxhelgzWA3dNHkxWPEjcst/Xstth6S90w?=
 =?us-ascii?Q?J0oL+RqXbZyBItJ9c7PilCFFxUDPEXSdHsG2Wjz/BmREU6X/2LkcoJnJJqyk?=
 =?us-ascii?Q?tl37YmjFOs0m3urFfH/cI8eXy9sp0gaeaMW8sHeI6yfeUFxeiekI9YJuA+F2?=
 =?us-ascii?Q?VwrdvFV7/Y0obo4y4aOtpHuUXO0gklaG3vyEy0bxQrqHvpJmjSeaFwNjfnT/?=
 =?us-ascii?Q?ZPA2CkvatBGTc5M36CJHf4LvQLKezqaoHFgI1IX6FSd1dahF0YUnhwGQs04o?=
 =?us-ascii?Q?Trjxj6S6bLZU+i9hZtErcRbmGe6LawW4xXyxl/6fI+25+RXWiU1/ulqwmv60?=
 =?us-ascii?Q?jwkeHoTCOgk+Nw9K2GqTl4p+Yg/NvC2p1Td7IuC9CRIRibdB4Ni3h9nKTVpT?=
 =?us-ascii?Q?Ak8+2foCJZ5sJGLDhfKafJ7uvCStAd6RQjrW/BV+FWAlj1N/aNAPlcMR2dmC?=
 =?us-ascii?Q?MqYUDBogde7EDMwS5RAM1mx6RgA9PY3bbdPVhWx+ebDp1IEtN45I0yYoRrg6?=
 =?us-ascii?Q?ncETVUoRJjxwGfHYiYV1TXFrAdoibvWX/LVgbw2L968XIscuXZioVIfL0prM?=
 =?us-ascii?Q?TA8GpDoKhkDUlEUZuYVF7+FnNQHu7G8jHRqvuGJ3y6NxG8AL14rU0n03FJ8B?=
 =?us-ascii?Q?SAy4uOlPPH3w0gRvq+vEQH1kpNa5LgXw1bfe6eVXN93WWURt5KuLfQH1I3aX?=
 =?us-ascii?Q?k5vQ41E1Gqm4tEt6tGlvMC+h+U2SoXw74BoEnV4qTzKJimMoLhiR+/f0hHIn?=
 =?us-ascii?Q?P3fgWtstrBlhSJPWIH6RnKuBskPI8X2BXwqSZwv6Gf1OwpXccwZNZqfXlFDS?=
 =?us-ascii?Q?chjKZwCM5yAIeMmDvC/H8o26qRTBD/FgYo+ZM6wdxJ4rc7mDB2kU7rWMycAo?=
 =?us-ascii?Q?fyTFOIbGwp/2KO7etp3V3/xwaKZeqlJ/F4OZFrRgXId4aLtM5lImdiU/XQUb?=
 =?us-ascii?Q?NObbVn5/mlaD+NxB2d24bPu2gR3pGU/X9w8P0ZkIv9/7/B/hKBpse8RsVUgQ?=
 =?us-ascii?Q?9RRnFAHdTLo65Q9JezRXkCmHh3scWzQPkQnD94dtZ3yysSsQkO67KYgq9TD8?=
 =?us-ascii?Q?4elltKVN/iDmJV4op8Vj9CzHRus27d3lvcFRylauggQk+i8ZK8bDrALeCvwg?=
 =?us-ascii?Q?UDJ9G22oJP2st+uB6GA8+/xbKFTJS1hQJkwpaEAR/Z17X+Rd6sc2LwGaHYav?=
 =?us-ascii?Q?IBLyiJK173gUqJ1C/TI07rhD/esjQopB4SLejPRfzML2cSoZYu9aTU2xpEF7?=
 =?us-ascii?Q?DO3FXDzK7wFa0mpEORcrM4G2ZbkJZhJMalphnuRUAzozq9dP1xO6D6nBkxYV?=
 =?us-ascii?Q?c3XP+AwDYbtRplV94uiYab3pcG6M2AaeQjgl14v91qxq2TqnsvZvny6jLeYc?=
 =?us-ascii?Q?Vaeowa1pCs6eZPgX/5SAHVg25MSdAgRl29D6emWtzcnntXgc22n/z+mxHQL3?=
 =?us-ascii?Q?frXqdiR/mCCbyifbhJM6t3c/QgJDvwmnwl+s+FldZ6tHK58cUfsJjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8Ma9F0Y/770fBJX2MCxL6wkmCGS/PJ8r1bCI6UW9U0hklHAZRmKa0ySbsSOX?=
 =?us-ascii?Q?j8/unknHmaBJ9MW5HjZJXLd+7OOfI3Ji1vzCuySgS7CgHftjmvx2sRlL5kl9?=
 =?us-ascii?Q?HvsZfL4kLFAMMWH2H5+hgZFDRbnZ38Bw0rnDazooyPGL7vBIjcLY+j876Ig5?=
 =?us-ascii?Q?v1uR4h3ZbHgY0ClHnLkXnaF1dKtjtecKkk6qRsr49qgoFJnRVuZnRhbdo/ys?=
 =?us-ascii?Q?pvLmPFRT1N1iVwftePkY1djT1NVOgrHOCzaAc5qZlrUbu3m8yNYGk0C3+u98?=
 =?us-ascii?Q?f6aEAuxlykpv/2qHg2lgHX0qI1uiBtn+OqgeOa91bgcd7tD3tCz4LxlWfsna?=
 =?us-ascii?Q?FZakDRGCHGVYnqxUykuuwEn+WkZ0BB5PRnGnDPsGeU8oP34SgVuzTo3yvkgx?=
 =?us-ascii?Q?oxvwEiEo43m4HtxMfVzqmUxdMnWZcIAWH2MBpTTxk3Is6VQVO2pBkFk+WseE?=
 =?us-ascii?Q?+kL+s/SyYGUCbJ+m4b1Gt02TGsLhkVXRMHCJPi2BOyL0+u+g7NsDRwe/nf1L?=
 =?us-ascii?Q?4vIIC68hIIwUcUIWgCrEOJBMLh93KI+vZpsx9FZpm30ACBO9iLVWsAKtEjeb?=
 =?us-ascii?Q?zmsLDAd5SJ9V+FrZaRFhgaYYAIt0rqhbzPaXFGff2udtpUrvxu7E0JAo099T?=
 =?us-ascii?Q?8PDcPTAEdc10wV9C6RLz1CaKAg7xsIJcq0zFSqZz9t4jz7W9nldrqUdsWnL+?=
 =?us-ascii?Q?fLBtC1mhWnSvN1Sfkd0bGejbR9/gXjWusowB2knsylpFftVVEpD3jU16uB66?=
 =?us-ascii?Q?aK9kEVHM6IC1bpoorR3PcVfl4YYRPo1xeEpYGJ74mQO3gyFCj2LCtzaNhoVZ?=
 =?us-ascii?Q?hAfD7ZA+22bZibDtrVjAOjLKyWvPMuG7aJq+YdZMF0OdRJEAPIJpY446rb6Y?=
 =?us-ascii?Q?81OqWRtmUGn3GxTlMdEMInFnu56eJUZHy0kW14Av5yUbFPF6ULflSnzwaaPz?=
 =?us-ascii?Q?+F1N6+hUgyxgiRdjAEmexuk6R+2g9nHNyKUcfPg9aONgbTZsbz2BjCCzInoV?=
 =?us-ascii?Q?YrrJk4RGM3fZ/fqZQxH66h5Y1iWdv9yzY2v0j/4h7M+AmigeG19WREz3EoUI?=
 =?us-ascii?Q?xB9rMeukrrGJmcWjyMIkohlWeIUrFoGw6vwxdrFammJDzFqiWGhKhxy9yt6k?=
 =?us-ascii?Q?WkxQUZgu0Mr9R90Mi5U9cpxcwrzRRL2pvB6il3iiPYEWvLOXU9JgDgNod22H?=
 =?us-ascii?Q?CkDk/Q6mnUejXZom5CHgaGYYXaxVJgd6ds6zX2hxsLXkf0PwxETlX7Mz1iDX?=
 =?us-ascii?Q?kc59hYnCO9H9zReNsnGb8+vV1FAehOdPlDcWTPVRwyb8vnCcRawgHxxePgic?=
 =?us-ascii?Q?dGWDzOkTqkzabKgy4OkYz0OeEl9Aj3SFovdd0YsKFt4E3KgDotVmRVawlKZZ?=
 =?us-ascii?Q?auUlHGC9tgIMUY5/cE/g0DJ5q70xSlrnKtGkcP8faYHMb6CF4wHw6uUO0yl2?=
 =?us-ascii?Q?jeNWlXNykG9DiMcLWn1jiz5z2q30ppDUCHBBCFhQQFKTv3388RScS4rHq1dB?=
 =?us-ascii?Q?yzyZaglXT9f0TFStRQerFxJIAAfuWx299oYMMUaXfaGEL5GGY93QpiQ+Ok8V?=
 =?us-ascii?Q?YAtc8U4G2lrumyo5DlVszWyBrpbA21AVdxZ586IR?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c4a843-dc34-4b69-0fab-08dd86c5224b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 02:25:40.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK3Q8kdExyc2diS3t+R6d/m0s8yakmRzDnj47MNVrDSSYy40bIbt547AVIvSus85vY3PWE+3y8eAmpLIIWjOfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAxNiBTYWx0ZWRfX2W/FyRwDkLkS gprBVcAbANEduBq/PIoxgv+mo8YCzzlmaZ1Ki6HsXeuaPsvXdfAEvlbrGqToiehbZ4sYbmm1P9t u0qOtfynsQDy5uE8ezHN/O+LywpiilzQrLk4tKBFpuC3hm6YHtfUuLHilNYLXBXelVD5LspV0/h
 MOAK+v1PBMnO5E6AsHpoBcApqO9thooDR9/BoZKJgHE6kuwDThAQjo6wYAFKSSs0WvdxOBtMeWl H8FBHLDgj0oF/kDpfbgzmmaimkGPLyFV3NuSdwqhsN62kaWPMhbUHQXTLoMfY5bSmOQGpcYyYXr IBss53yW0JlQdc4G2mb6YAZaKjPcpL0/mJyJj4pdfi+apArCTyIGtj53H8sNoXDh1GtI0WBmnGx
 v5BVROQ8n05E8KOlHGr2nuVNnFtNY5HHDpJgdSWMUAqqeFVbe0l9LB+4SGxxatNv0ApVH+YX
X-Proofpoint-GUID: Gs0rzPD5YL30tuA1abzfvsgDGz5XIOLS
X-Proofpoint-ORIG-GUID: Gs0rzPD5YL30tuA1abzfvsgDGz5XIOLS
X-Authority-Analysis: v=2.4 cv=YJifyQGx c=1 sm=1 tr=0 ts=681038a6 cx=c_pps a=NZTPE88KBhpz0z3fOSYQ1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=iGHA9ds3AAAA:8 a=V1BzPAuW63oiCzHOoCcA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=922 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2504070000 definitions=main-2504290016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 02:25:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1413

Update version to 1.13 to match the current tag.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ab9f60f..0ef4977 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 AC_PREREQ(2.53)
-AC_INIT([libmatchbox], 1.12, [yocto@yoctoproject.org])
+AC_INIT([libmatchbox], 1.13, [yocto@yoctoproject.org])
 AC_CONFIG_SRCDIR([libmb/mbtray.c])
 
 AC_CONFIG_AUX_DIR(.)
-- 
2.34.1


