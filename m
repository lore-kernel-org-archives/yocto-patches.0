Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DFED262BC
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:52:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3917.1768963936468573293
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Jan 2026 18:52:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TPo0IIwv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548187962c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L2i521962318
	for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 02:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=Er8T1ZKx/dFI8ti4bdGt
	8GsoEvcnZ55XwVBq8h8uU2Y=; b=TPo0IIwvvS9HuhJUxswTLXisBpRWsq08ZNjh
	ICoU7ipdI9AKSaC1Pvy6TiNYJ6UOG/ziE5l4oPDbtgLYUfVgwJqCK9VHLplz18Hr
	UcWAvDYZaFRembn0DoWaUFVXaEyEVZJYM8k3HGP2TTA0KMWT0iQWWB9IqRadZuQv
	qvBLWGVO3FIrPNc1VTCaQ40280f4yyBUHjh6cvYm03cQnScjKlzQiwvYxyxm1uUZ
	STHjNzGtqQVpWMbebO++oMjdJps39EddzK1Cs1s+xEcVNddKwPY1SVnBBOC9veuX
	KjskzFPBIvPsdCP2pdmARaKlNeLIPU9uvcV9kSqMBv/UAAECdw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1nh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 02:52:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZXuavlBJDXrbV11IbvrjoEGGefnDY/st21vb40oh/uJrro7u3eu+tTyxhxlmAum3NMkVcmIzYnFcBx3zFuQzyCk0lJ0v8ugOW988gjD11uMJmuv8FG50FNg0uf98UzpcDE/xFFW23fNxK5qwJVOyl8ncLl+pkFgCyxCDqzRyt8T4RdjbJ7DPoSSstuAD37wfZQ0qYWKoFXhkvG9x/ksPJNBDGEp6vyjAsAqInuSX4qsO31/qjtcEB57I/fIT5ZIgqSwU8RRkMHgm9DygQEup7TVeem/3GLC+vPbji6icyeAUlBx49qEVs9Pk4jRES0CXvA5aEyh2tXwtUnCRgDp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er8T1ZKx/dFI8ti4bdGt8GsoEvcnZ55XwVBq8h8uU2Y=;
 b=cXZ6HpmPUhyGBCtzlOqvQ61XxA80gvjPed2pt+RNkUukXaDmKtd0BiZFJgl29XywqSsnQLuIG8UOGYL/1C80tcNuvz3Qy+tKzbriP9rfPvGU2BovAUT2BxIRcDLshwBCmtmPgDNJjMB0Blm17Rkqr+HW66VBIlci1mQKTFTSxCusoTZB6cerSY7xrn79WUIGN+ZRUxw2tE+BW+tKxbXAO6HEgRLF+BuYonoiVhs0OUz6oq55gt+gZBxEIE3C+07T6T6BtEWjjb5TIMx040HuDXUuD6puDDSiOK3Ffc8YzWHfXFPwmVSE2riqvfXmTlaL5xq+l/dfv2YZ+sU+alMG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 02:52:11 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 02:52:11 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] linux-yocto: drop CONFIG_EXT3_FS_SECURITY
Date: Wed, 21 Jan 2026 10:51:57 +0800
Message-Id: <20260121025157.1923729-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff096b7-bd73-4e25-e483-08de58981349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dIlWjRlwCn4TkIy4gbcricGuipxAGnn4fbmyhZIH3lMmhSmGZu+zt+IrLRx6?=
 =?us-ascii?Q?6apC/3UejLWygudUVCkycieRZ6jZafjDjIX5fe3HCpuhAA+b8qSy1rFjzHAU?=
 =?us-ascii?Q?mpzdvsypBP2D+HnlomtHg1mX5KWq7SL/J0p239I3z6Z/qy2T+UWZ0kjKEoP2?=
 =?us-ascii?Q?/h1X/1bDDyRZX3HDmxqo25cvnNO4aZlpaHMovDNAc0CI+uay1iA12XCWd5aQ?=
 =?us-ascii?Q?RdQXwr3Hq7FwUAtWERhCVEiy+3pr8iiYMEtNZGpSBrOBH6tHzrJgbYWSyf0N?=
 =?us-ascii?Q?/VAZcQF0RrDqDp92Vy/iPbkyJmzqUvvwHtEAhX4/VqMxSyR+WdE+wIqABJfU?=
 =?us-ascii?Q?fYZ4gcLHIr0eX4GR30NSmgoJcx62kcYtHD7KEaUK+efgpmplOVXP4naCnTmw?=
 =?us-ascii?Q?de49KgXZqubD8VWUSo83cSvCxL2yoKPcCTSkIhNB7N2DiCwrzMSS49WPryeH?=
 =?us-ascii?Q?sZbifyZGQUrI1fCUdysyf3xqcCpD5nrCKXpWeLF19m5tEyNNoPY1KZ1GBI7k?=
 =?us-ascii?Q?pZ3arZB0sENyTqFMIvg7pouCB/ao6FWmXPR3WewsKGTQEXN7OWN4NCqq4YiC?=
 =?us-ascii?Q?tLUSvhy1g+V7GvMkkHFQn8Uv/fe0muxFh0yuf68KyeTWR6AMRZE8wdsp2zvq?=
 =?us-ascii?Q?gGdbtRFkugowZ8zrJ+wUFR853E1QxFdSua3Lxj0LhU8FyREYuQKhds9mTmni?=
 =?us-ascii?Q?Ehkv7Nouf0mUuK5t3yl8mBdlEUi9XXaZSpcgKyJPV9JElE2sBaFHW0SRXvCA?=
 =?us-ascii?Q?glDD0yfFkPZSv+hNP/6ypl++cQTGXA2z+FwlKJuHfwv07bWIzbFdM7DTnSvB?=
 =?us-ascii?Q?eKs+fkYW7X8g3OT9G6cjagPXLp2ByTdQbMNQeyg0ZSkKvnvGPyPTAIiBKaoR?=
 =?us-ascii?Q?h7gIvXl0kmglM6c2c6ttEMdWK0k847VLA/6ulD+wSplaDGABaMMM7itK8rCK?=
 =?us-ascii?Q?AA8pf8wTAokrpcpG8yscCl0PGbncryvon4PyIlq4Y313DpCIHIvOOZvEw7ne?=
 =?us-ascii?Q?6xoRwLKwunzQkZUaNpxzoHt0ITaE5NOTY0E3FXtQ48yrfPXxAM1RXegLBglt?=
 =?us-ascii?Q?mjsFwhyotH4W8mkdaedSp5o8f3SruUg/xvfLxwxaMaXKG6+BZ9uAWdVSkhTW?=
 =?us-ascii?Q?O/D0/0bLwP3qGmK0Gdm9WDxAIV1EBT/F1ARJsaKjnhzWjd5stpvNt0W5NsQn?=
 =?us-ascii?Q?x0lehgXEdw9a7A4tkp7uwy0ERDXlGCffC7dLxmK6az3VW7gmhGt6oFGufBXC?=
 =?us-ascii?Q?YXhZAmD30RHyTUP5MPMe094ZP4Vznz87TNQWZ0VkE9+LFeD0Ut/mAyCsolCX?=
 =?us-ascii?Q?vBGJmjKV+eUNpiEkXB0KVTlVIlJpyo971FTu8qx9t9JR6iJklE7iYewgHaCE?=
 =?us-ascii?Q?D3LfYb0Cu4fIDfCV43p44gI+zgPuzD77DKDRPcZM8R8hpTGTO7cfEX+beYgQ?=
 =?us-ascii?Q?Z+DdbrNsf77HqcW2oNNjmQ6cPTfpC1/5lkS8yHwL71UuhJmoXc2DVzmRrasL?=
 =?us-ascii?Q?i/YqIyp2P9WtnpmrJKzkKtJIe7GEQsf0Va3Pk4Pe2OiT9Q9GMqZbU7Ic9sy7?=
 =?us-ascii?Q?90nDLeJFJHAq1M09KrYcMPz5LpG28RCsVboXaDXEJjJshO3PEsUnp48d3TGv?=
 =?us-ascii?Q?/RHFL6ukeI5s1uIE716USm0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YVHFxKnpwgXQlzFVgnZi7sSEFujV4Mmec04p+5xcPZ9OP23ooZeBp+/aix+/?=
 =?us-ascii?Q?P/b6cOnDfkcHZhI798Ge+fv04LVB53niKeCkmWZA7H5aqC+9q9CNOsUrF3Qf?=
 =?us-ascii?Q?VPg7EkMCo1LmssLbOK6oBst9lpB75GMzS90Jr0qd9h4G9dU8GXT51xM7DfDo?=
 =?us-ascii?Q?YBxBXTTNhrkEH99iz4Ug4bngb/pV1eU06fYyuqFs1JjxPqKopUevo6jBXiPK?=
 =?us-ascii?Q?p5CEvftcei+73dI4hQPX9T5gIlh3DjgQu9McMWdNdmXR1uaRJSzAKpSsJAPr?=
 =?us-ascii?Q?8OysB/T81viPT891KWIWmHgGp7kcIzohXJ41kdDlMip5+ARiXOTxdm+mktO3?=
 =?us-ascii?Q?t/TSszpMQsvHNVEo2iq9yitLtNnxkhQ3hoGQJvLz4uA2fJKyR/Ip7pftT6Xw?=
 =?us-ascii?Q?62ydCS7l5nbGkIq0Oa6/0EBiYduSblbCxEYauRQ24Z8GvqCoptttOpXFbRLQ?=
 =?us-ascii?Q?cvPGqZm+h0hdltyHDiEmI+YKr6/DyJB9jK4QlaoV53GPEwzfZUzYT/OyvyVU?=
 =?us-ascii?Q?+B84Dm7TBTVU81ySlWSBRy4bnUgKl6UaDGLeOaGEi68AFEoXLMu5ssdFMGR+?=
 =?us-ascii?Q?TsMHihtV7NRvkj7ETFXvbn5V+LIo9BuJeYvq5nPV7lkuC3FJJwMc/F77fEaa?=
 =?us-ascii?Q?ys6heBx3A2ks4uLMPisabiR85gCt3DW1OdJ9H00n95Fqk11wmlst/OaLzty0?=
 =?us-ascii?Q?JwGhKSDIeOXkY9N9If3Y1wdjIlXvpC9rP4POJbsuF9E1S65BBTuatDNjUH4E?=
 =?us-ascii?Q?7sPn684vVbYE8oR876GIq5CqIpza49WNqViDZha6EENQzaNsfX6O+wc3mSyw?=
 =?us-ascii?Q?3VIvnY0UVTi5h0iwWYyutjPHTEq4A3FMkGRV9nHVtJBIZB5N7niYP4OwGa7r?=
 =?us-ascii?Q?ghu/+2I6Reg2wWOKLICsg5lm2QmTpIVA9QWU2yEDwoky8PUGWwvFP+3N3oLN?=
 =?us-ascii?Q?CCykZxgPeXVwE5WcC9adUdbuNeZP81heAYeZZrKw9fO8cq8ArzZnIJwVrUui?=
 =?us-ascii?Q?4lTj/vWovs37AOG1c/EyB1zAB/A6kaJT9adHQcwLKjrgvNW033gET97xldeE?=
 =?us-ascii?Q?6sX7WaVnjqzwtY/BQgM0k49ra1k79NOLoI6FQSEDRGFSLrl9ZtSNmCWSXgUe?=
 =?us-ascii?Q?Kqu+WPPs31veuAJjlG0t84+fgN8g8bhq+PaA1XxtwHhMFY+V2SqQT2UDCdm7?=
 =?us-ascii?Q?WVBynAmkFY8jbu6gfoc/va2R/da69elmhi5nlXgGCs26YvrS0e1mTqLF49cl?=
 =?us-ascii?Q?xYkk4L+Eb/vrJb/5BDYIqE8jaL8jX3YD7PoH8jTK4Gj1W+K//fAQyIYz9YHs?=
 =?us-ascii?Q?9h0KsC1ekfROqJ1mUpAYI5RAlQB5bs5f+qlZAZOdYiNufSLPxkkBqXWdSIID?=
 =?us-ascii?Q?3x6mFDnGm450QXzNlkPJHsp28lILReLyt49RpuTzd4hlCpsRWAw1YYlJw1rE?=
 =?us-ascii?Q?GJHRft/BR73DMNtUEYGxuSJhAJTpUvRS0GyW+m7WMKuXFMx3e8XTENlNRP7f?=
 =?us-ascii?Q?5Ic043k6555F5QnMytI9tkNwdBQHnZ81Yp8N6llqfMdWgmnRI8HAW+gB0xF1?=
 =?us-ascii?Q?a5KyaYlk3J+EQxuGXR1l8ivcEi19eXxzHxq4yqsrAZ3Qh4xWP+rYTmTdEbl/?=
 =?us-ascii?Q?M4Zh0OSR83gkUd/A49WghqOW9GAH6Ih+vWJj/y9qM9VPVLOMAIjMi7yLfgNz?=
 =?us-ascii?Q?xCY8ajWwa80Rp1Rissx0M/iXJa6K6rbxRvrsFA64t4EUc1BQy7wtN62K+jdK?=
 =?us-ascii?Q?qLNtKQxLQg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff096b7-bd73-4e25-e483-08de58981349
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:52:11.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU6dcOi6AL80EnjAaQA7+ARmHdf/r9brXYiDld2YD4TYMdrOgun4f6tNImFUwqx957Jm3YK1ItpM4HD/COs40A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-Proofpoint-GUID: eQtM3vfTTksrGSuxlPpP-RIEGbJdFnnp
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703f5e cx=c_pps
 a=0Qqeoa/8LQ4SOC89qm8Uhg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=6iLotMsexHgM1SXKPasA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfXxjgxzOcVDKDk
 Wk6WyAXO3lWyD0ggqu8zb92QzT/gP4Lgs/x1kX9wN7J+pPpfwQsZZzIm10zxrmIDZaLOCvfs0jT
 MvczqgB0ICTF7YihXwylCNyn9/tGaXeUpEtWI4MrvT9NX66czz0LoxnZQ2iux+gUzStkYlhD6QA
 Cl4cCSHCKsiKUaNETcOKyqVL5G3JCGSqvKtAK3aqcjiU7zYoqjCfvHjOwWbe1WE9IQs6VNwk6rJ
 G8eZ28meQk/4LhBT0v5zOKy12/QQdwdn+2lAiIFgUcVwtze9Kij6sCA2oie0hoiRLRm/6Y9IWBy
 xPK2Tud9yHow/+BWxA8oRg1h7HWi2S73Ahu3NSIlF+N7pZE7PNyjuyCB4e9Py/O3vh5/lB4MHH5
 ILQwH0zfBJWTz6rennOIn9sCHW4PvYelizRlhSD1OgVSMm/pZnGHiewV1Ss7dwta7aFrd7vlm84
 wY/NXeS2OUxK0UAekOA==
X-Proofpoint-ORIG-GUID: eQtM3vfTTksrGSuxlPpP-RIEGbJdFnnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 02:52:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3036

CONFIG_EXT3_FS_SECURITY has been removed since kernel 6.18[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d6ace46c82fd2d3bdb58c35e3dd5cb9e83e136bf

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-kernel/linux/files/selinux.cfg | 1 -
 1 file changed, 1 deletion(-)

diff --git a/recipes-kernel/linux/files/selinux.cfg b/recipes-kernel/linux/files/selinux.cfg
index bbbb180..cbdb3ef 100644
--- a/recipes-kernel/linux/files/selinux.cfg
+++ b/recipes-kernel/linux/files/selinux.cfg
@@ -13,7 +13,6 @@
 CONFIG_AUDIT=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS_SECURITY=y
 CONFIG_EXT4_FS_SECURITY=y
 CONFIG_JFS_SECURITY=y
 CONFIG_JFFS2_FS_SECURITY=y
-- 
2.34.1


