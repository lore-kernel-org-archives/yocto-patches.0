Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B069CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 06:27:44 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3460.1762324054681679025
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 22:27:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nVYAT4Xz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34043ea9ca=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A55MJc21576270
	for <yocto-patches@lists.yoctoproject.org>; Tue, 4 Nov 2025 22:27:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=AiF1XBLpdopwXCuExTnx
	koxmTVmuPInEcXeb4OfikpA=; b=nVYAT4XzYZBPlyNlXfs9ug/z+tf0MPkvPYhZ
	0v1EXQYZ30Ggg0aWYNT0qXwGF87avHf9K0+vVqk+mEvv/OUYKZ2u0ECn/aTkvPc/
	iveiZJG5ttpXGCb3B2shEmWwHYy9oB7PiWPhDerSaeUx7SKsfc0jOv7NXrOHYaTW
	wNdWwtvIyNIU4GmEzahxbhyOE/dOuU//n8Qv1wyTItySSzglebLurmQ5mIXsj12C
	g3Mquy2kgnbTtMpE8FZN3qQjMp6yTOc7hXCbaAssO1nwRFtOZZti2bR4qpELBBks
	I9eL9Ad1gxyvNBipS+P5vk969H72johpDjiwVdpgwZapj+0r2A==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a7wd7g5he-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 22:27:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIjn8/SKROEUBA+hjR5yOE648wm2cZiVKKEEGmDV1YGrP88RgvQSl+tf0jTlpU4zPO+y0/4hG1O4HaFkKUtaODI2A5djLdy6mZ9OD4YBJZbemdyIQA8SBpD2MNMdt7uWl6xQg5YGnLiubZII4xqb/eqOE6Ms7WQbtu638SSx87ld8GHKdf70TIkvKOw6JKmgWdfeMuxS4uY1SViDEnZq8Albs+fZcI6JTGzXgYrgfr0zBUYIT9D4kNbcnsqmuJPTbQHVsCnARxSXrJidwP455hu7ilxwQAIfJDhG26o1nIMEVkKXM1L1DsiQ69FOSFducbXvl5loh5J4PcaUfeSrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiF1XBLpdopwXCuExTnxkoxmTVmuPInEcXeb4OfikpA=;
 b=tPuSeUKbmYk2sEzYxmiZbIE3C6fOVrskTcJEztFF68/Q2TfgFslbWLMAgDQBrFgz5bah6fIw/0JTVNPZSe4Md53y9Xkz1NoLwGUn4J2l80P0d/mmGbMlMyeD8Fg1nHwpnA/8S/gc/PEexJUj5ax3ayvCcB3GBzOjTj646/Q9vI/QmZtywv2utKG1GRlCr6wC1fmy5SY0YOrkA16KVg/iJBgjyVpY/ydfgS/HuFy8eaHnDYvWXZ1lmHo59P+BcbDVBb9F2n1Kqyh07IepYs2LndKACQvIR8zxHiALW5El0wIbbusceaqz/9bMxB1+sad5HRHasF/F4NAqWUEv+5Ur/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 06:27:31 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 06:27:31 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Wed,  5 Nov 2025 14:27:13 +0800
Message-Id: <20251105062713.3930500-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab55274-f70b-4a05-31af-08de1c346622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dbcGi2ez90tmz60sd7QqM4r1Q4k4qh9QAG4OUuzXcgZ3TsCpvZNLWOo/17c1?=
 =?us-ascii?Q?FkmK9QbqRjrW+c/MOFyg8118P3715Vt3Tiujo2dVBeQCmZ0Fo5ym9+EW8tVf?=
 =?us-ascii?Q?EfhgHEr/ZzvqblTAkfGKEqmF7iHK2NCXe7H9D7EletvR6QtHYsdpwJHnzJEI?=
 =?us-ascii?Q?KDN/tmrapYixL5aLKqTUFk02y4tWctpPOqBwxJZlEwBR6DeD/8p8TcAq3cfm?=
 =?us-ascii?Q?kCa+6vDM0IRTg8qjBiUoZBBeCBrxBjofbsLrJRr1LOzYr02yhrOGzt1V8MCA?=
 =?us-ascii?Q?X0gkHx0IBViLTIwH7lOOHwX1SzANc4FSbRBxb81Bx+G2yL/kcvOxMyk7WSa8?=
 =?us-ascii?Q?YMZPmtJYNu2+FqWXYBSLFmIFFPpIXj/tqhuY9C3JTHF76CZRi3ZY6BftD4MM?=
 =?us-ascii?Q?UhDwx2fwUMo2jQpm9Lr/a0e9s6ekj81zof6ZGwfWUNmS2xV10pNx9AhEROPk?=
 =?us-ascii?Q?12Hv3RzK1pkUG6fW8+n4g/rnzyrbnakPmc1/XtQCPZwHJb0SoXEIY1QFHT23?=
 =?us-ascii?Q?4lEGK7Ros8PHZ9OuX9HN3ttY+hXI7saPEh9y1jcnX+DdTFJo/4nH/rT/T4G9?=
 =?us-ascii?Q?GhdMo4lpoYfo80oL3DMzUm2Zb0xmNUxBG2EyJDeWFU0OfNKpnooEea6Qdrdd?=
 =?us-ascii?Q?HQKHdFkI7uFieDi3A3CHEVIHU/X+wLv9PbSRECafeBPACsY5NopTh5XFYb2O?=
 =?us-ascii?Q?9a3q3jhFXfTi8oSPjRKsb8+U/Afwdi9sUDoQqx4cfOcUVCST2fGIMIHgNK/T?=
 =?us-ascii?Q?aVpg3PNAwH2E/N5ThnbVKtwdVYJG7XJGBSrS82BZLYpxzr6iTjdaSeEMIMRi?=
 =?us-ascii?Q?Hvhz6AqJsNo7NapC7Hv1ozKujvi+UTKnveg/BwpUacIYeX4jnwZcMjv8epNb?=
 =?us-ascii?Q?5SqBnbeF/dHecYtxQhArq0+psbdf4yJKqWN8DxGo765seMSqsYC3UkC60k6g?=
 =?us-ascii?Q?fVW3zDvM74NT5XoaBpKQZLVYHjbWcdYFkd00ZbWrB2cEwvqKymsCK82ZeKLL?=
 =?us-ascii?Q?E0IqgN2Go5jBegWHGAvgiuKf9OCP4G861TZfflvnVfhxn3uwkwL8hmtavUMV?=
 =?us-ascii?Q?XJ+i2Kv/PahjohfkBW+0hAsBkefLTM+NR84Gkp93ehKlnaxwkuUifOc77AI5?=
 =?us-ascii?Q?Q6XAYF3nvOK++O1D0gJgy1jMVE4N/PEYQi+fb8yQwiWKZzE3Xa0HqRngilNY?=
 =?us-ascii?Q?mZ3I+9RffeP4QAyD9Qz9vUaU9Ek7MsKKRqd5N2eQrvFfTuCZ1Za2NoMhXM4C?=
 =?us-ascii?Q?VDj3N6frwepq9snvZF8dtaFmyd9l5F/abckGaAESY659oOjOgzuyFr9zqy7R?=
 =?us-ascii?Q?sp7wEzYXrX1dZ5vIJwtP8czeZXS5hvrxmEJ7/d7pfOUw1/GI027/AagrU5Ew?=
 =?us-ascii?Q?J68POE1a1vJ/CaYPPNxsNjyBNKVZ9lv3McN4k9mqY0lU8GDks6YBHWWIjP00?=
 =?us-ascii?Q?bk8nMNfvrTb9luwZwgQEW28Y1mw9w2RITm07XcxSHEONn8kv9TCzttRK9Qvw?=
 =?us-ascii?Q?MmXBq5npOpa+N6G0EA/xP+TbPpk/eosVr36h?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JcgP9De0K75DXQN2+qHgcyBVo3OuAMn6syUiJVVDKHfKvCkyquw8P1OkUVZn?=
 =?us-ascii?Q?2uAR1/O+OahjzEVVh5xSAf1xj5gC/aBY8Dpidpv1jTgnsNPSxv+vT29C3Iiw?=
 =?us-ascii?Q?0ogqRMzD/Q9aeanDQw5Cah87emtKIoLIPEonglh1Oo7ZYF10n3CLoBVR3Zc1?=
 =?us-ascii?Q?tjKiI90VnQPgS/dQhPQ07EaUb7hVUwHg6CCIptwkbhn9pX5c0SN49cEWHAOP?=
 =?us-ascii?Q?F5yVku4WlR0HaiqInoSD5tJW36CMi+b/p7RUOzkbWeEfALEux4ITtE6gIhAs?=
 =?us-ascii?Q?KjS/H2CoU67d17LvQIEQ3gGeAUopyh/czUp2QjfRRKu5Za15H8fZ1xr+n48S?=
 =?us-ascii?Q?G7/adccX24f3rtuABVn8A8tGotbqjO2h+AuNh5F1y/gmHdez95R62z2WpONu?=
 =?us-ascii?Q?ATPxclbl8urE09l+zDyKdzVuWxPIAJZ/9yVFQL0JfMUSS53heouZc1D64ois?=
 =?us-ascii?Q?VBLi//uXRsd2bgtqcyBfVZcMvjy0UlzJaWI7aZ6JrL/yEhC3kDn05ozLYic+?=
 =?us-ascii?Q?wRc/BovHptsUkifrCGyoyi1vkuqvzJSlU/bySCXTov4eWz75M63kWenRj2RL?=
 =?us-ascii?Q?iKJs/azq5MyzkG09efQAIEL/eSMFfy3Shw52ai0lxVc7ekw20jQ0WMfilV72?=
 =?us-ascii?Q?/1+l2gpS6RVMTSxlfTFF1J20PkEUalxF5SCSUndg1PDyno6bksJw+5fYmKTX?=
 =?us-ascii?Q?YH1E/4Ol71hXy4x13iDLnGcDMh19knjcCgCTYILYliyVUPv6Px5zpz8+J9Fh?=
 =?us-ascii?Q?ADJt/e9Y9pMyYCfHceWkS4Qg6cBGNXREileopTvoZc2bYPXULh3QzMcNNcN1?=
 =?us-ascii?Q?Z407v1G9TzS0W6dyNk7P/wS2QDtTk9E8JCVFyw2zp3h+T3CF8voi5GGl8H21?=
 =?us-ascii?Q?6hrC060eUKFvNGkkd4ouqM1Ae4VLUPfLNoT9N4I1xTjOtE6Sqp8dw1FEcbw+?=
 =?us-ascii?Q?Bj+HWZ3y1fKrVNn3RBI4GEreyRbnXxHlP/5W5ZrGRJbwoifswWJ4U+PRoCft?=
 =?us-ascii?Q?nnh+Ogbm7Sn9XKiEW0pXMdFCkH/YrjA7kxxcIu1NZcYP1bFm+Fm4ocnzeSzH?=
 =?us-ascii?Q?p6T9ijYSsbgVu1c3k1IrKxmMhI7ApiauoGtQZv7yf6zWuvOU4ivS/b/J/Ekw?=
 =?us-ascii?Q?A0xVSwhlTs+pTOq4Gr8F4LtFLhRTHB7l2ccfigQ70e9TCZ79tJPpwDjI0QIO?=
 =?us-ascii?Q?UYM+iiaciNOsSyQCJyWtwHehKCqgG1PmR0PPFwpc9T17kAX6JMZeW5Wi6b3T?=
 =?us-ascii?Q?IgBl4YDHrXdgRbjONOxnyCpj+GvNevF4NcM3ssO+HnGl1TMvTY0eZHGIS0Vd?=
 =?us-ascii?Q?MNYz4x0n0eoNUDdd94+XRw4ANhQ3Ih/j/NOYXoWyp5lpxlZiUbjMAHJG42Ci?=
 =?us-ascii?Q?fGIezTCHHe36M9mRCjv3pszlk23uq0aXndkWmwrorbirhuKzuKijkZlnqItN?=
 =?us-ascii?Q?ynZXUWJLgwJ6IaVld3GBYS8p0fQ+kUvb3bBv6VvW20uSU3NJqAru2Phg+8AC?=
 =?us-ascii?Q?3RM2h1AvF2R0t+3w9hxc8CLzGXg7jRyx7mn0DbuXN4Oc403CYCjWJCODdOgU?=
 =?us-ascii?Q?D2a644jD3SRkVVoQu3l/YYFBgONeupNMLriFEQNq?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab55274-f70b-4a05-31af-08de1c346622
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:27:31.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHrwUKx0MWoeDXJT3Vc4TgHlRWjdjihqri/R+p+cv69+KP8oVdds11TDWwHISXK0LYG1/QlBWigmnHOy2dTzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
X-Proofpoint-GUID: W7P41Lb_IwsqcVP5EG-8S4VlBU8u9qFa
X-Authority-Analysis: v=2.4 cv=Dacaa/tW c=1 sm=1 tr=0 ts=690aee56 cx=c_pps
 a=UyUtkpB65yKBl9uddpDweA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8 a=NEAV23lmAAAA:8 a=ORAoVs6636_yPgT3hb4A:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-ORIG-GUID: W7P41Lb_IwsqcVP5EG-8S4VlBU8u9qFa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA0NSBTYWx0ZWRfXysOKpWhBGTEI
 okFGYEOf7d2dFg2pyE4n/UH14y9Tz1Vw1nyMApL79GpJX1yBv4Ucifuh9GPNh4BAHtflmvI4+IV
 njGzmvAzanSlBPmfZI7BXPq6rag3osP40qQlG3Qe9L2FTTPAvcvF0KOwVED0OZwHVAC7o+i3Qyz
 2qsBTiI6XrLtjz4eJFvdOWsQVH2FZzsZKcOAC4WrZIUT0xNmMWrFdA1qj1aew515lKVi/Oh+DSy
 CstnnNO+Dj0urkudjwnAYnitl3ZK9PQMmL3QafVk8C5hzHZMHEJ2/VXhAddT7K3KIbqPq01T7ao
 6k5znQX9oyc8X34jKsj0POnu/0/d/5s3f8k8noYgWpfi/nOnjCOO+vcX0s0GauqybEvpa5yiBY5
 3F61Dy7fGXHa3AC8s1jYG5hgitSprA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050045
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Nov 2025 06:27:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2421

* 739ee699b portage: grant compile domains getattr on chr_files in /dev
* 7de9ae015 ssh: set file context for default locations of split binaries
* 4af789c43 check_fc_files.py: Add a version suffix match
* e93b0cf5e devices: Add iio write and rw interfaces

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../0013-fc-fstools-fix-real-path-for-fstools.patch | 13 +++++++------
 recipes-security/refpolicy/refpolicy_git.inc        |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 3463350..5cde88d 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 1249ee744695066f00978af709e637dcf450efa9 Mon Sep 17 00:00:00 2001
+From 284638aff460da4730009afe994175ce2f4d184f Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -10,11 +10,11 @@ Signed-off-by: Shrikant Bobade <shrikant_bobade@mentor.com>
 Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/system/fstools.fc | 10 ++++++++++
- 1 file changed, 10 insertions(+)
+ policy/modules/system/fstools.fc | 11 +++++++++++
+ 1 file changed, 11 insertions(+)
 
 diff --git a/policy/modules/system/fstools.fc b/policy/modules/system/fstools.fc
-index f12c3515b..e719d7a04 100644
+index f12c3515b..500acfb23 100644
 --- a/policy/modules/system/fstools.fc
 +++ b/policy/modules/system/fstools.fc
 @@ -55,7 +55,9 @@
@@ -27,7 +27,7 @@ index f12c3515b..e719d7a04 100644
  /usr/sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/delpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -68,23 +70,29 @@
+@@ -68,23 +70,30 @@
  /usr/sbin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -35,6 +35,7 @@ index f12c3515b..e719d7a04 100644
  /usr/sbin/findfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/findfs\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fstrim		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/sbin/fstrim\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fsck.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/gdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/hdparm		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -57,7 +58,7 @@ index f12c3515b..e719d7a04 100644
  /usr/sbin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -93,8 +101,10 @@
+@@ -93,8 +102,10 @@
  /usr/sbin/sfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 40fca83..c5f9ae1 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20250923+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "004ca3252282b52f525c24f3c874bf7ecf724be1"
+SRCREV_refpolicy = "0deb7170f8e5466a39c95468959321c2c28a5f33"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


