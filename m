Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA876D116F3
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:19:35 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15630.1764238765693211232
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 02:19:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gEZf2y0P;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34268059e3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR6dlPW3914443
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=OuldZHFrOuFux4bDuwGEgN88Vnu7HbZCkpXBaMMTaOo=; b=gEZf2y0PjE0a
	h7Yif9Y8bj2lzxeGG7EhaUPmcQHudI3NiSU7DxYVmCgTb7hIAXzjgBMGZTC7kbCA
	QL2rMe+uansJk6lj6G+JTrDUcgeZZDvY6bBleucS9dOE1LbKXfBf+eY44LHUeowu
	fvupDntY+ouCX+EugxrRKn7CKnqKsIs7IcCu5Pi2Jftp/ZvhV9vlNzuK2qN4smSG
	A7JGIFvro3Yx/tvIt4LORh7673ZVpO+DgU7OOhGP3NukA3NQ/HADTMdXa8o8c/DV
	iIm8qI3Y2EcV2FZXvAYunSZBVYpHKeHVCLQ+xhIMqAyhH3HkC3r3GdVbOya4VVKE
	3umNnoRXJw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjdb20-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COvwzYiK7ZGAYxm2yUZJo92c28t0ki8V2MGkYXErhnHpth6aO36Qw6mCrcuGqMbT796kI8g4Xbhe4GiTn9WbDKK4OAsDrRGNP13EsauKVu4MQvBe47xEx5cjXSwPmL26Z1VY7t025KeGIe58GkSggZAFovSbmQbNlfTXVBnkeAbrFoaymUDkETn2s8ifn/udQEIbu1SGWSUDiyrI3q8ld87yiQTlRy/MJhJ2lIQWcaehqUTXAN1BvJJnVR7uNo3h3aq1aTvdmHkrQV2o2aSSMgIwrfvqcI/q7IYd9TOCIYO85Uy9j1YyRdH+2rtdHgPcUIrjQNmX9hDPE+jU2FKSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuldZHFrOuFux4bDuwGEgN88Vnu7HbZCkpXBaMMTaOo=;
 b=YexD6diq5lYReAu7zSUgFWavarfkc8atIFPNQm4UxBZkShARu1cU97fvUWWeMPefU8iuHsrn3V9O5Auir8VtXQojKDzuNYXLdqdAlVlvuJzhSQETyZ6eS7EkuLTK3iSMlz82cCvd8BX7SqGZmTLWdrv1QX7+gq8kxYMt1HnXrezuE52gfPT+QzhTzKm4cvA9YsJvSd7Snrxc/wyUY3bMQ3LU9658ovAHyx/zZz1z9L904gfcMpMxMwZx+/Dc/MHRkTeptPmtLrxh5n6fSNl/QTaj/mRHgG7ro3lo5SAVoQGpG14KK+vp1URhdnSZUwMU45rIxJOabOglc7pGOLrLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:19:23 +0000
Received: from IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45]) by IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 10:19:23 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/3] sssd: inherit github-releases class
Date: Thu, 27 Nov 2025 18:19:02 +0800
Message-Id: <20251127101903.3512507-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127101903.3512507-1-yi.zhao@windriver.com>
References: <20251127101903.3512507-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To IA1PR11MB6396.namprd11.prod.outlook.com
 (2603:10b6:208:3ab::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6396:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b074091-3b04-4719-b699-08de2d9e6f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?l3tQHKGI1Dnz/AuTr7gA14LebHwmWqYFTuAB/ZOzL/uUYiJtkF2KW1yLd7aB?=
 =?us-ascii?Q?wyvKG10cOJx7+2mE2BftFsXEuEogbe6vWp4r7Azv3ToUsOuqknCd03O37J9l?=
 =?us-ascii?Q?8fLFPcYN+Oh7FuHqloAGrIXVQM1pR7Dw8cFN8TMTSF4RTNKQfJv6NpJOecA1?=
 =?us-ascii?Q?oGoXFZVnx81rn+Q8BQQv0cvR5kkqg9ZgyiYNy3PwPT7eqWwU0XbmDSbOPcP2?=
 =?us-ascii?Q?gIAd1hKzqRecgQaIaXHgROJCq18H3x18XBe4R38Ik4TBqFRDWuxmnXVqBsUk?=
 =?us-ascii?Q?L8LuaWzZNVhetSCFFP/6G3PHL0dY0DI0mUMOf509EyjhRfDMhmYq6rPrOKBB?=
 =?us-ascii?Q?yjhZpZQPf4vDv0+GIRY9HAIlkOA3sGX+CyDlxFkNnYC5PmVagOe2h4PfOD9r?=
 =?us-ascii?Q?V1XJbk7rX52T4N3v6d/Cy49kbp5L/5+KYJ45J7hlRaW8aAAYXgUA7n4V8tHZ?=
 =?us-ascii?Q?ELxN65ec9HKnMckKVaiu3xahvht8R0b0c9AI0H4ug+2ZaWNOsMV607YanhDH?=
 =?us-ascii?Q?TrhVpiiudJdKmi2C7RRAWzon5jVx6XsgEYyRiAYRoYC6YB7Jq1Ux8NBavIWd?=
 =?us-ascii?Q?ZS2A4eGrXgQMHqxuqTF39Mz6a1l7Iq8tJgp/aB59Jl64QmPcCsYCUCOo5ngR?=
 =?us-ascii?Q?02dUTfanq6vTgzaU8BFjYjBOn18vRkMqgUquKXcR9asvWM+p5rPYeQ35mnZ2?=
 =?us-ascii?Q?uYwcmiERY+/O7rSvBS400G2LhefNQJTtToSmCrzyRW2TYgT/PA99dK/seZ8U?=
 =?us-ascii?Q?IMk47qsWJPOGv+z1/F9pCbLpjtcfNFKdsr6J4meIJnNxC4XLjTgVvjAE5+wM?=
 =?us-ascii?Q?OwH7H7x4ypOVFmYDz5KeUpU6RrzlAH5Oqe93KKBKzEIq4Hyh+9Cs0a3ct+Tc?=
 =?us-ascii?Q?sRI3IZ7fvIbAWvnk+YrXZ5knyasNwI7nk3ffEthoKr5SnqZO6xK1Ig83VMgS?=
 =?us-ascii?Q?iIOj9bEwgzzTJ8rCufgkbhjDisMWkYK4PKIQhiqpuDAXMHu1jnSGvJAnCGAx?=
 =?us-ascii?Q?3FicZz5JSIOYsQuNFiJE1lc6v1Ab2ItdKwE6GD0kQAQxjc38HW8Ex4gx0fpv?=
 =?us-ascii?Q?CgBUUG4hd46YAS0rR8Mec3SwIk2/x4R5iupy5V1v71oAr4va8jXevg7HlEQk?=
 =?us-ascii?Q?9Wp3XCkBK4XXbIEdEPxkMkPzSTf+R6lUOLXxtwUjngrxHk3f5NsBd2fWuKn1?=
 =?us-ascii?Q?VQB1hPCPGtjZMzL9t1ur6AmjIdVR0Xw6AMg32tElrgsFVPiTxbl6ayRUMrsx?=
 =?us-ascii?Q?vF2UqoYTTZdMyqNnx9wcjsOsFVPxwCOvaooWUe9Nk26xHfW3tgl5+nZLVRMX?=
 =?us-ascii?Q?NoL+F8R00WDtVdKnGDsPgIJif65KnYyt3C7YUL+GpIcsw84RRheoobcDBF1N?=
 =?us-ascii?Q?X5BBVXR4X9qMq3ed64ifpJAmqSznhog+yPULSaRgfS+D9FimrUQvzXcxvkJz?=
 =?us-ascii?Q?g4/C9oP1AcvwEmFMXN/uRY5Gf28I3W1PYR8XliXJadJWfbtoqtOhICRjX/T7?=
 =?us-ascii?Q?5J8TVAbQjLVFnM/TBHSH3el16mWMB5w8CPQZTqddwFCH3WkVo5uy1TRiKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iI1xt7UBZnCPTUDmc1Zs6xWfEYxmxrqmmki2M+8NrT0MnfdS+d1a6TXOLvSD?=
 =?us-ascii?Q?MGp5lvF7bMa4mfhSv4mafqeyN1JNh/kCP11gQyUaZrF/Kq66LzHoFK6ME3Pk?=
 =?us-ascii?Q?1pl9Hvx4fmJqIwjjR+mOUUtkyiSKX5Iw5rn4cv/iK2YAODlPQ3BcjKUR751K?=
 =?us-ascii?Q?7SPIWuQx2uVjL1j3NFp+DsAHWTpI0p3cZbdu49/OgceVw7cZQQ1rS6gPA7nD?=
 =?us-ascii?Q?Ekwc9lWEP3B3MHvSV+AQqE3+3WOB0w8xBrGCKjghzdUbUWn8l4EImu9adl0B?=
 =?us-ascii?Q?dBMq3X4mqc5p5z2fHBejLk+VTd6855+36iiNVphyGMHv4AYxkplXbqHM/Khk?=
 =?us-ascii?Q?Ydx+wsCVoRxjXgsug27yyWtO13oUxjTXgxv8NP+0CzaiZJq/dvTXlGVeYiLx?=
 =?us-ascii?Q?PAz0xR1301ROFaoYpJRHkO4ToY/xtAw9bmmzf+VOALpncGVFuKKBAJ+N4P0f?=
 =?us-ascii?Q?uvolQW2xe1fjlb9By4ksKATHmuDpslvQfBMpj40EDtL7syxz4E/usGbE+DTI?=
 =?us-ascii?Q?ZcNoO6DLyU8SyLviEsGjD5UtB+/bnf2sUal5PfZQOOq46AlIxZw3IzsrRzsr?=
 =?us-ascii?Q?9Hkew6pAx8sf7Ox/l51VyOwN0MLRwodCGy7NRIMC2de/jw0+LnJIUheFrD8d?=
 =?us-ascii?Q?6xdmkZRa/ucgad3PYvN7xTg/A83y6w+Y9NcOWoUwpvmMZmdjRgmA4odp90X1?=
 =?us-ascii?Q?KfogdmfmFWkbIIs/ppYCWVHF3xZUS1BFpMqLEUbWJM6mSwwK424e831TeAvk?=
 =?us-ascii?Q?I2oc6Td0mDsTFVMKX75U2OlFwOn102UBjfmONQ/hZ09q51dFRUjz2o2GgVtU?=
 =?us-ascii?Q?qopj8rYNo1UwJra4ehKWx1u8RGZdytyrp37GHczYgn9SXRrMEJVZaQ3ryiP3?=
 =?us-ascii?Q?RhJM43aM5Hht+7+jB5+nJIEEAbxGdK28r8TbB3NAYjYDp21AnaDapyh/FryN?=
 =?us-ascii?Q?Kqi7YYy6KgKIrLJ6+h1YkcGePEbaJ/+5CxIdCOeXz2osRMTdJcrFJSsgwYVy?=
 =?us-ascii?Q?jN0FdA75VoXuxgoqN953gIXB2Ef7KbMxBQLMXQLtvdDLyYGK3Dp7IwhzvWqc?=
 =?us-ascii?Q?hKDV+GJrRZKLYNxIbN8bIA90jb+CEnwg0HNd3+CowWBoTcY/UpL74n4W/HYJ?=
 =?us-ascii?Q?qTXo58/U0ppl9yEbgQDLncufmbzY+hjeRkpdTt0BdIfKjt4W9MYWPUQ/5k/G?=
 =?us-ascii?Q?OxOpUas6FxRWUZQyU4t9dRzQWOZOy8ntBGdngm04d4jeWG089ZFPIg/YfxyY?=
 =?us-ascii?Q?8kS+OdoKhPHF8d6r7R8X33l0BF4b/Rcm4dXv+pkg3RgDc3Yh/SPPSlhwKz3J?=
 =?us-ascii?Q?136GGm/5+C2JTf4YIwar6OW4nWFLfw2TWDuybTC/A+3kO4cvOgb971e9Jm+q?=
 =?us-ascii?Q?T5IGIGSffn9O06oewtV32JWo0d5Sthvbasc3+WXgoXvyqvx4bdRSiRcdkjBZ?=
 =?us-ascii?Q?uepeMtTM2zYrDuSmsdTW9Lu3iucavCJYlsh4If/hMGKRgke94D4ZXqfPkPKx?=
 =?us-ascii?Q?uj2rBMAnIjMN8QxjO8UiUHyegq2fvxkzSVgYOYeuEY6aoJyMLLQtFOvky/X0?=
 =?us-ascii?Q?06FAdZVtX2OI1fbNDevjw7dGa0soysoU2RaUZ/cd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b074091-3b04-4719-b699-08de2d9e6f6f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:19:23.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QyYgTeT7N6PDUvU2swoZ/lML4Z3K9wXXjjRg0tnNmyVz6XexIuvinJJufPD2heupPPJSWTdzKxpDN8Y5SOruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NSBTYWx0ZWRfXzqbsE2w8j6j6
 3G2w43NmbPqqe0ZDVtujENInESGrjecGxnbdTos0nzfIxKOR5lrAc50a7qcYL58BeecEQPTQUF5
 COMo9B+ulntbL+XfoheVpHhCb7IchwouG7Vtr5DrxAa0OTX9v979yh+GLX/r9gJ1vSHXeaMwseH
 OAgDWwUAVHDjvx5vJ9YRsZrQABA4gXa3gp3l8dEeDc7hhjucYt/9VrwhGItFglPTs13ZKDnHyhW
 SqVFAi/m9b7YIzFIFa7aAVFv6QCUs4fMTvLpg5zwOfaXTzjFQhDqWY394bN/jqZIXkaKGTVG44J
 bsanvafH82TlVUeXKbkpgB40UwXNhDJX47Sd9h5hGINqMMKdOLZsHUPl7ZEltmW1VHertmsPXYd
 bxYNKyNw8at/9pm52YAb9pLfJaCGSA==
X-Proofpoint-ORIG-GUID: CPdQSyeVDeVWvwpy-mYkS5uQd1RMKGD9
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=692825ad cx=c_pps
 a=fLgsFiGMcCN2bMhaTK1NuA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=BKEijX8yvVJ55WpMrRIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: CPdQSyeVDeVWvwpy-mYkS5uQd1RMKGD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511270075
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:19:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2714

Inherit github-releases class to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version sssd
INFO: Current version: 2.10.2
INFO: Latest version:

After the patch:
$ devtool latest-version sssd
INFO: Current version: 2.10.2
INFO: Latest version: 2.11.1

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.10.2.bb     | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
index b02710e..8ee61ce 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.bb
@@ -26,9 +26,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            "
 SRC_URI[sha256sum] = "e8aa5e6b48ae465bea7064048715ce7e9c53b50ec6a9c69304f59e0d35be40ff"
 
-UPSTREAM_CHECK_URI = "https://github.com/SSSD/${BPN}/releases"
-
-inherit autotools pkgconfig gettext python3native features_check systemd useradd
+inherit autotools pkgconfig gettext python3native features_check systemd useradd github-releases
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-- 
2.34.1


