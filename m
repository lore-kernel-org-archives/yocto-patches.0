Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6473EB5946
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 01:42:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9349.1770774140030207727
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Feb 2026 17:42:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rOFAbzYQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6502cba9c8=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AN8DwQ1219449
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 01:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=KEgM0fjThpUZsV1FkbHC
	zMY7d3MIVuSl//ts1/mMMvk=; b=rOFAbzYQMNoA3C3uCshzI4PTEupK48p1KTRN
	GYYysz3hAfZ36vUTRwFb5fxhcn+77mNltCpTDQx+tcossgDQ41f2I7TnfPyzOtmQ
	rlpKBIkHyq2v/yrILn0EHbCEH/9bUrHK5Ogf7Cn/RWxkft1AwGLk5I4ayrB3Nyqg
	1nGveC5/fXgWZDs6AQgGSiul4tCLrZTo9vFTC9BfpiHOGZncPBuedL4afL+UAwOb
	1xmeza58VeQ5DoaA3AmVJAldXhAoc8+WGyNeBF2NXa/igBykO3LyOuGYua05QmRF
	5gZGR0HdHoM6aKMKzev1lJWBKEtXJSzp+hHZnNs4FX3SqFxmVw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5vc5c339-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 01:42:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nthCAns/M1RebO2r000AkU/RK3dai76yQlLwiJeVaJHTihHsgfdA2GzoSFeIFrp+EDrGZb/zVhGDKbaRCWlr0fCxaZgqV/z5rDv39b7jqXf5XKLdR5XwW5Bj696Tt0XICU+JCJozNX2D2tO2jXw6D2BCat2iNu7Pk3YmsjVfoIHtOvH3tnquUF/mLg4KcR1EpofhOGAKHzYWB1Xd9b0IuIYYiu7Jyq5Q+oqq+ehJ/7d4vqdipurbWiFeFsIZb5yo0A87YXzglA6AeGnBUMvQGUV7+k1mqFKkaQsxBeG7ewKyI3LTqnaUQYGYaqdGRrfoNc49aDoXePu2deAGbre9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEgM0fjThpUZsV1FkbHCzMY7d3MIVuSl//ts1/mMMvk=;
 b=ANegg8ACadHO4udIL9wnhQyYegtVt5IgyGPsLXpKNgGoXazqwZ3NDMC+4WYaW2+p2wPg5RBrJiD/4GrVyog07UrikpGU0QB3BxpqCVv2/dRmc/7aBctv5+nE+/+4MLjJeZQC9Qq/jYfLr0Dw7wqqr8yYcbOImnzU7+Az7npblRnB1wJGZXk+h3SUo7JCKAS9Dqh72XUvukMnRY9wKZF+g7HswaieAHQ7vKPF3nlly/kD8g2kgYGa7Jkak/w6gPvWGUTcR0FHbI5G8ED9RpRoE2TWvOIOj/F7eCJyNCGRMJ8IGBj1WKFzhZxhvNKtnJVJlsGHtcM8rDaXBqDLNa8AUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 01:42:12 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 01:42:12 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH v2] refpolicy: update to latest git rev
Date: Wed, 11 Feb 2026 09:41:55 +0800
Message-Id: <20260211014155.3758127-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0115.jpnprd01.prod.outlook.com
 (2603:1096:405:379::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db6a1ba-2711-4c83-ca24-08de690ec6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?te2pM0wQH+hKtdCNNQ6fMnPIcdvxh07mO8b+xtBEuCu8xad0D6nujMzqL+LR?=
 =?us-ascii?Q?pnAk5V13Gi0Mah3ldwxLkRERYWJ/Rx9Ow0EzfKljl00BhCBuT3+9zvYSgm3m?=
 =?us-ascii?Q?pjhKnS8T7BAncKL4f1ulShPFo3poOx4NrlEMYl7yu2gpzql6ZNkT6xTviXy9?=
 =?us-ascii?Q?LnV5ZBqEej7H6peQhExKuJfNHJtxfmHJ5/YZFjjye11eYoCTQA1gTLLRi5yL?=
 =?us-ascii?Q?ino5DEyk+ySOh3XQHY7Hced6d7OKMllA8YV1rnxyU996ZgQNgKYOecSQ0W2/?=
 =?us-ascii?Q?EM2awwxQvb9XM9WiWVrmR8w9Cj3MRkkcaAWmcVy+iCQvgy+77W13An1IyyLX?=
 =?us-ascii?Q?Q/UNfKbPSONpdIDjV9B4VQlDgPo4gr/57U4xkJmDx1j0C8g44ItqbdJv5avH?=
 =?us-ascii?Q?wyam96Kf/erqCdW6qkX80RtQSJ6OwPx+zZK8i8lNmd/y10klmp0Plx/JLEg/?=
 =?us-ascii?Q?XwAORy/XTlbii0Y5R5rhpx5M3BERu3i6vM1ZJj9os59Zo4lC6bWqEKDJ5zCy?=
 =?us-ascii?Q?IH0b38dWfZ1H0UNVd/8ze6cRVa5u2i6DE0voO+QuUNnoAFCyIeu2w6poSGIJ?=
 =?us-ascii?Q?u97Z5JKdvGWAt1+33gA/0PA5ML9M15ANu6CcxiCvX/azqa32zJgyih7qEgnJ?=
 =?us-ascii?Q?rAtzz+f3aflDkwmIX7z8/hQIj2QEM9tVni7wwlaIgpNdK1Ml3wdlUOc3+aqc?=
 =?us-ascii?Q?2nknYrRwDdEjax1S3ft4FAIy4uArBpmJcsHMqNm9cO7eI4bw3QMPk6laSpJo?=
 =?us-ascii?Q?m4DpiqqyI0m9OQXKPT4uR8sDfnMAB9eTOEsP/4K1c4mt75i1Cgj/lO8LlRZY?=
 =?us-ascii?Q?raORSFkbPOcK+LXJo4qGr+nryKWKWWVg8IRyKE1H/VF/bQt7UhqPHpdGnPEC?=
 =?us-ascii?Q?Haoo785IEgFZPazHEGhSMcpVfwn9j3dsG4g7bjuFayX++bGUTsVw/v2254VL?=
 =?us-ascii?Q?SM1yjr2tPDo6dH77MYVvfCEYg9pxwRFeQX/WkPE1RF2V4Z5VqPBNgx9xVg0w?=
 =?us-ascii?Q?LnJK0kW//dH6wq+RHOZBiGIhhjfa3eBaNPFZ9HslMNU1havfs+ZUgPHp7zmf?=
 =?us-ascii?Q?f8DXJcr9/XwCCh5jRW9iT9yr/hxMQUSlm47afq0mWzD8onLYXnp0Pte3fJVQ?=
 =?us-ascii?Q?wLasGFw6guOmAuNeh+L8E7gFcQfLVP31qKkojsJN7oeboGywCgbuyOn8PpAn?=
 =?us-ascii?Q?dGc8ER0uwCNWV25uNZe/Sle+sS/9NpoyuhXC+Ub1+i083nkMu+HLEz53zWVc?=
 =?us-ascii?Q?XSm0n4mUFKTPzSW18J2qsXYPgW7QZ63nUh7f93y6q/yu+PSNCwpFqgu+VKGL?=
 =?us-ascii?Q?reZqE/6f79OjxllWd2BsGOjo6fgIY0UekmGFlFlZf+kbSRgvfeTueB20HtVX?=
 =?us-ascii?Q?Wc8ztOtd7qd6rYFkxbFzHHUlH3ej4eD50Xm6PhelCL/3jmdHYK4BwkiV3ji1?=
 =?us-ascii?Q?2LpwEYBF54GJvscSVtJypXFYJec8llOySQUuY7iThfyLtzjrbq8CedBzwZ5K?=
 =?us-ascii?Q?Flad6VzbNB9zB5Fc5z1SLhq7xakMfkA5QBKMuRdcKOf/3i3Lr4Y2CyOuoL7y?=
 =?us-ascii?Q?2OsK+vYhV/JJrp8r/AShqVDTlSQz1r1EW3qAT9UFMj5U3gJnQ+iOQxn8OPCO?=
 =?us-ascii?Q?Hb4W5UFQKbTlPYHeJPqTp+M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7142099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TMdD8LhmkWkXVBD1CQ0rpC7U+5pfUi1E2wYzTIdhvKSK26baqfHidMfh9PJ9?=
 =?us-ascii?Q?fsu5w5vuAXIfn2Mh8ikzI0M8c/jNQeP7MpBbVgLo/ImuABOV8mb/t8xmWbKs?=
 =?us-ascii?Q?qiZLWSBo2YSV3Vi1ltF4OocMROz8di0xWKbrG6BmElxvUNJUff2lIA8FEe/Z?=
 =?us-ascii?Q?yDRvdWdPvvnqgvJWEaFnxB5hbRAiWhpZlVDN4bif7u0rK1GaaJ5sOu7SXuUf?=
 =?us-ascii?Q?1FavFm4xMdpvdFB9zel//QYw/ViMkZ0rBim4In5abiCX7AYZ67rnX3FXo0xJ?=
 =?us-ascii?Q?Wikc8JnmQa8lwj9MYPzXgu3uMEGlSjY6hwYAaEuUzXOKrH20tgRua78F8IZq?=
 =?us-ascii?Q?3MWyRjBESOwners4HUiCDbEXYmq4LJlCBPyI8TQVqP/pZAFWkJV5uI9CZ2mk?=
 =?us-ascii?Q?Gtf5ZK9zK6M00Y/gRbqG1ziBD2FbRFUJU7VswjGLgE0wjFf9KTqWVM/godzu?=
 =?us-ascii?Q?HunKhf1ZzFNhs0ELMlx4weZsSv3PVLNpD7bCJs7fQB/soe34Tk+pKCDlL2oW?=
 =?us-ascii?Q?cou45IwvzxrCYRQODwLeGpvnGqM3nt2vfyhhRUMtnaCfOPJmxweoR7fTbdK6?=
 =?us-ascii?Q?3VGugx+SxwCs55SW5fb5UPdo7MuuqGXq4pAqOvEMuk6pPp0VGwIn0FziRQMb?=
 =?us-ascii?Q?S06iS5YsINrYrhhhx5dj0pDdWwhxmeTdU0NXBm8IcWFE9uhb0SGKHcHzcfRo?=
 =?us-ascii?Q?x3cZauiJNXZLtgQYdSEVSDtnvuvpU4XT0TQ7M6xY8es6Ojlh8ZmXo6YEQYx7?=
 =?us-ascii?Q?AgGte5+Ikw+YApcNa20wCYxG0jn3R7YN7/V2q/b0hju22m0r6S3ln5pnNvk8?=
 =?us-ascii?Q?5Pn9qi6pSyGtnz5vu5nGQIYSj6fJ2wvkkZHxHeODQG4NjQhC1Y8Y0ByGArcc?=
 =?us-ascii?Q?+dsyoFxXKX6yDzG6BLR7Dc3bVWy9eZtr0CqacJBGS1uH1tBgTuE9IsP3YWn/?=
 =?us-ascii?Q?p9PUZbtZuJfU9oKym38LZnCkI6rES0JD6GDyxi0r9wHhbNFyAz7ZKr10AGQZ?=
 =?us-ascii?Q?lhaoycWscuppNxGvNjuNZCmOciMkCNNGixceoo2JkkJEGp6bxOFEixAPMfUC?=
 =?us-ascii?Q?wcslA/0MR2pSz9P6lsGaYcdw2ay9on2S4AFUu5X+ZmJMnDM4vOx54zg63cAK?=
 =?us-ascii?Q?8x7RFULmBDRKvG13J9oRASdose0F2/VvpNd/8mox5wyiJc0OAHRaacZ/eu17?=
 =?us-ascii?Q?cNC/534fgd10bjaZkqg1AIdyuMoy3plzfFW8+4ed3uaoHtzGUw2ZVOLw9qc5?=
 =?us-ascii?Q?cEqH7qcbveTVEVnYmObGU5oEktoGxsSdoWuZWmCGJi4u9PPWXllufdRYJ9Ie?=
 =?us-ascii?Q?JwmLfx3QsXy8JJVyQnd2Qyu1sfzM//GxYl2OaYC6BaYHHwWUW3b6wWsx5rLy?=
 =?us-ascii?Q?HUy7LmtruefC0QXItamNFNc69lvOEJw4B1NpHf/HkGiXWmKGL0H53Ic9GmNU?=
 =?us-ascii?Q?x/7831nOE6Ty8LIJgBAQzW7g9/UAfEqNS1/gWusOeiPhu47owzyL8Sz/pyHh?=
 =?us-ascii?Q?p/2VYyRPJAXnYGh1XBJoRH5QvRQBrnWKBzTWMVOKlQaBLw2XG5Ni4EZaRj1j?=
 =?us-ascii?Q?thgErfp+51oUVl/XZL8LEvr6tR+TqLRMr6oMI+eSKRGd2bKKewixHesebm7m?=
 =?us-ascii?Q?LCwx0cUuMmmYv2Z3FMJCCjb/sGUK0fxl7yWVan5H8O70Dq2VLQb5cTsDEjwn?=
 =?us-ascii?Q?dxNBNn6b9HOrCzOt5DCOVUEmKsSIbAK5UMDjpsmJ5RudQb/boLkYL8cU0ruZ?=
 =?us-ascii?Q?jOWEauuAdg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db6a1ba-2711-4c83-ca24-08de690ec6cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 01:42:12.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXN/AhluglMPP9e+u0mehmedT7adqGyNdrZdQsWejkjG9ogAjffxc+WgJr/2X85zc9/irpfU3cQvnutLF1mBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-Authority-Analysis: v=2.4 cv=dPyrWeZb c=1 sm=1 tr=0 ts=698bde7a cx=c_pps
 a=CdU078GllgbuWnh+Y24ybw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=9Wbp7B8dAAAA:8 a=NEAV23lmAAAA:8 a=zaASz_1EhW-P5F3Dr3gA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDAxMiBTYWx0ZWRfXyVPz5rq5cXaz
 /C0gCJnbcokhIolq/oRIB9DMra2LrCxdQ5CNKyUMoJKmu8zeczz8xyIVL+ITHFopofwF5kGqGGe
 9BPZPu5d1bq19O/2JkeN8q7k1F96IsEBAXAvzIA1wPx2NC3Pe3NvpD5y0U9LAOWDH6CwZZczhxC
 U/ZYMpYwULGH+WijBXwGYVCM+/fY4KH4FNPWg+77cebeejOLvu1Ch1r5Prq7ZE05lhbu482Hmtd
 pPA2DFP2unZzRz5FBWc484GYeU2adX2unHBJdPYm7C2ti2yqbNL8vzO5cpL/TO65O3oQYuch4FA
 QOOP/6LoP1MjY39NtVrklLmejXyo6MLnZujAc+qO1L/wO3B0RN9pdUvvrv39VznbmJKUFT8pKb7
 x0r8WtEVBOS1cRA2QAkb14N9k0wl2jfEZH8ITE9XPtTis9u8KHX3SGTFvnpa1drlpuXnCLuEzSg
 uXhMmIp9+PldvSo+t6w==
X-Proofpoint-GUID: 9IM9FCoEctBTEB_Fp9qadySNBJc8k-va
X-Proofpoint-ORIG-GUID: 9IM9FCoEctBTEB_Fp9qadySNBJc8k-va
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110012
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 01:42:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3212

* 859c83274 loadkeys: allow loadkeys to read and write tmpfs files
* 249573c16 systemd: set label for /run/userdb
* 2b296cfd5 Add policy support for Qualcomm FastRPC devices
* ff5bd4b6e sepolicy: Add sepolicy rules for bluetooth Notify failures
* 8bd8bcce0 systemd: fixes for systemd-user-runtime-dir
* 93533d690 ofono: allow ofonod to read localization file
* 0636c25d0 Add local policy comment for pd_mapper_t
* c8aef7c55 pd-mapper: Introduce SELinux domain for pd-mapper
* 0b6686d45 file_contexts.subs: Improve comment grammar
* 1783c0c4e ofono: introduce dedicated SELinux domain ofono_t
* 4a507774a dbus: Remove permissions from unprivileged user
* 4a1caa541 systemd: systemd-pcrphase read /etc/crypto-policies
* 62df0656a userdomain: Remove permissions from unprivileged user
* b91cef911 obexctl: Add sepolicy for obexctl to work in ssh
* 43ef3db9b Sepolicy changes for brctl to access devpts
* dc09a7554 crio: various fixes
* c09e51c2e init: allow using system container BPF programs
* 209a6c32f podman: allow watching systemd-resolved runtime
* e9721fb96 container: allow execute_no_trans on container_tmpfs_t files
* 3137f0388 netutils: allow network access in a user namespace
* 0ffef59b3 systemd: dontaudit user session getattr generic blk devices
* 22bb0f57a systemd: allow socket activation for systemd-resolved
* d70476c36 tuned: various fixes
* 1ed2834f0 kanidm: hookup systemd unit dir management
* 16022b3a3 init, systemd: add interfaces for systemd managed unit dirs
* 5f4841dea systemd: allow journalctl to search log directory
* 8df481716 build-policy: Add temp backwards compatibility
* e02eed27f validate/diff-policy.yml: Fix library usage.
* d978a9512 ci: add module storage test
* 7ef63156c ci: Create artifact of the workdir if the build fails.
* b63504dfc build-userspace/setools.yml: Add commit hash to cache ID.
* 14233d24a tests.yml: Increase userspace to v3.9.
* 93a6a5339 locallogin: allow local_login_t lastlog_t create,delete
* 1f0dbdbef authlogin: add auth_create_lastlog and auth_delete_lastlog
* 6aa166162 authlogin: label /var/lib/lastlog (lastlog2)
* 4b01becb5 snmpd doesn't seem to need sys_ptrace capability
* 41ebe4a52 init: Fix typo in init.if comment
* 47c348f5a Suppressing denial for systemd login to read process init
            scripts
* 5cd787409 logging: allow miscfiles_read_generic_certs(syslogd_t)
* 7c0a3dff6 logging: allow syslogd_t syslog_tls_port_t name_connect
* b0be996ea Adding rules for virt module
* bed6cef8d Adding rules for mount to search configfs
* f1fef8e23 Add sepolicy for bootloader to create directory in dosfs
* 1e55618a2 gcc_config_t: allow reading cgroup files for cpu.max
* 1ea2d3de5 firewalld: Allow firewall-cmd to be called from systemd
* 1b0172c86 Wireshark patch to allow execmem (which it unfortunately
            needs), allow (#1039)
* cdaa2e506 games (#1026)
* d68c6b921 Label ~/.cache/gstreamer-[0-9\.]+(/.*)? files (#1042)
* a6b9cf804 fapolicyd: support for new
            /usr/sbin/fapolicyd-rpm-loader
* 49e00dc0f chromium: drop the chromium_render_t domain

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |   1 +
 ...tile-alias-common-var-volatile-paths.patch |   4 +-
 ...inimum-make-sysadmin-module-optional.patch |  10 +-
 ...e-unconfined_u-definition-to-unconfi.patch |   6 +-
 ...box-set-aliases-for-bin-sbin-and-usr.patch |   4 +-
 ...m-allow-systemd-networkd-to-accept-a.patch |   6 +-
 ...ed-make-unconfined_u-the-default-sel.patch |   4 +-
 ...y-policy-to-common-yocto-hostname-al.patch |   2 +-
 ...efpolicy-minimum-enable-nscd_use_shm.patch |  35 ++++
 ...sr-bin-bash-context-to-bin-bash.bash.patch |   2 +-
 ...abel-resolv.conf-in-var-run-properly.patch |   2 +-
 ...-apply-login-context-to-login.shadow.patch |   4 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |   2 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |   2 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |   4 +-
 ...ply-policy-to-network-commands-alter.patch |   2 +-
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |   2 +-
 ...c-su-apply-policy-to-su-alternatives.patch |   2 +-
 ...fc-fstools-fix-real-path-for-fstools.patch |   2 +-
 ...fix-update-alternatives-for-sysvinit.patch |   2 +-
 ...l-apply-policy-to-brctl-alternatives.patch |   2 +-
 ...apply-policy-to-nologin-alternatives.patch |   2 +-
 ...apply-policy-to-sulogin-alternatives.patch |   2 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |   2 +-
 ...pply-policy-to-kerberos-alternatives.patch |   2 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |   2 +-
 ...ply-policy-to-postgresql-alternative.patch |   2 +-
 ...ply-policy-to-usermanage-alternative.patch |   2 +-
 ...etty-add-file-context-to-start_getty.patch |   2 +-
 ...k-apply-policy-to-vlock-alternatives.patch |   2 +-
 ...for-init-scripts-and-systemd-service.patch |   2 +-
 ...bs_dist-set-aliase-for-root-director.patch |   4 +-
 ...ystem-logging-add-rules-for-the-syml.patch |   2 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |   4 +-
 ...ernel-files-add-rules-for-the-symlin.patch |   2 +-
 ...ystem-logging-fix-auditd-startup-fai.patch |   4 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |   2 +-
 ...ystem-systemd-enable-support-for-sys.patch |   4 +-
 ...ystem-logging-allow-systemd-tmpfiles.patch |   4 +-
 ...es-system-systemd-systemd-user-fixes.patch |   8 +-
 ...ystem-logging-grant-getpcap-capabili.patch |   4 +-
 ...ystem-allow-services-to-read-tmpfs-u.patch |   8 +-
 ...ernel-domain-allow-all-domains-to-co.patch |   2 +-
 ...-allow-systemd-logind-to-inherit-fds.patch |   6 +-
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch |   8 +-
 ...-systemd-networkd-and-systemd-rfkill.patch |  10 +-
 ...main-used-for-login-program-to-conne.patch |  84 ++++++++++
 ...temd-add-rules-for-systemd-ssh-issue.patch | 154 ++++++++++++++++++
 ...stem-mount-make-mount_t-domain-MLS-.patch} |   6 +-
 ...les-sysadm-MLS-sysadm-rw-to-clearan.patch} |   2 +-
 ...rvices-rpc-make-nfsd_t-domain-MLS-t.patch} |   2 +-
 ...min-dmesg-make-dmesg_t-MLS-trusted-.patch} |   2 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   2 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-systemd-make-systemd-tmpfiles_.patch} |   6 +-
 ...stem-systemd-systemd-make-systemd_-.patch} |  12 +-
 ...stem-logging-add-the-syslogd_t-to-t.patch} |   4 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-init-all-init_t-to-read-any-le.patch} |   4 +-
 ...stem-logging-allow-auditd_t-to-writ.patch} |   4 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   2 +-
 ...stem-setrans-allow-setrans_t-use-fd.patch} |   2 +-
 ...stem-systemd-make-_systemd_t-MLS-tr.patch} |   4 +-
 ...stem-logging-make-syslogd_runtime_t.patch} |   4 +-
 .../refpolicy/refpolicy_common.inc            |  34 ++--
 recipes-security/refpolicy/refpolicy_git.inc  |   2 +-
 66 files changed, 403 insertions(+), 127 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
 rename recipes-security/refpolicy/refpolicy/{0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch => 0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch => 0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch => 0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch} (96%)
 rename recipes-security/refpolicy/refpolicy/{0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch => 0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (97%)
 rename recipes-security/refpolicy/refpolicy/{0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch => 0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0048-policy-modules-system-systemd-systemd-make-systemd_-.patch => 0050-policy-modules-system-systemd-systemd-make-systemd_-.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch => 0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0051-policy-modules-system-init-all-init_t-to-read-any-le.patch => 0053-policy-modules-system-init-all-init_t-to-read-any-le.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch => 0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch => 0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch => 0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0056-policy-modules-system-logging-make-syslogd_runtime_t.patch => 0058-policy-modules-system-logging-make-syslogd_runtime_t.patch} (94%)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 011c153..9e9d1b6 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -14,6 +14,7 @@ domains are unconfined. \
 SRC_URI += " \
         file://0001-refpolicy-minimum-make-sysadmin-module-optional.patch \
         file://0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch \
+        file://0003-refpolicy-minimum-enable-nscd_use_shm.patch \
         "
 
 POLICY_NAME = "minimum"
diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 3d84620..24c822f 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From e27062c7d2845b421374b390bb300f60793316b5 Mon Sep 17 00:00:00 2001
+From b666c26dd4c57e90cd0ab7e3bcb52943b72676a2 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index ba22ce7e7..23d4328f7 100644
+index ea643ddbb..6c5aa4b91 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -33,3 +33,9 @@
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index 4a9e963..f3cb097 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From c2203debb7315bdbb0262a29e00477f8acc4e0d1 Mon Sep 17 00:00:00 2001
+From fbf828a2204ae673442f90b17c97db17965578e9 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index c4c1a5323..956c5679d 100644
+index 15bffd9cf..9b20ff8d4 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -677,13 +677,15 @@ ifdef(`init_systemd',`
+@@ -680,13 +680,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,10 +48,10 @@ index c4c1a5323..956c5679d 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index 75ee52efd..74593c55b 100644
+index 5840ad5a9..02b75e657 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
-@@ -285,7 +285,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
+@@ -287,7 +287,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
  userdom_search_user_home_dirs(sulogin_t)
  userdom_use_user_terminals(sulogin_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
index 6bcf6e0..2d7ac6b 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -1,4 +1,4 @@
-From cc5872b91123b4bd66a906bb9f46be5410669634 Mon Sep 17 00:00:00 2001
+From 433b5e7bc3d3e13ef1bb239c5f543ded27a2d142 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 19 Feb 2025 21:35:02 +0800
 Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
@@ -32,7 +32,7 @@ index 7ec2aa471..8f0f6ac2e 100644
  	role secadm_r;
  	role auditadm_r;
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 71e1b15ae..940c98ce6 100644
+index 1c98f5e85..4ef723b85 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -8,9 +8,6 @@ policy_module(unconfined)
@@ -45,7 +45,7 @@ index 71e1b15ae..940c98ce6 100644
  userdom_base_user_template(unconfined)
  userdom_manage_home_role(unconfined_r, unconfined_t)
  userdom_manage_tmp_role(unconfined_r, unconfined_t)
-@@ -273,14 +270,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
+@@ -277,14 +274,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
  optional_policy(`
  	unconfined_dbus_chat(unconfined_execmem_t)
  ')
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 674f394..6c1b839 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From b99da006e440106534655b2fabfa414dc4fbc899 Mon Sep 17 00:00:00 2001
+From d5d91fe32d2d3488acfd0df11d80074e6f9c200d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 23d4328f7..690007f22 100644
+index 6c5aa4b91..e782151ef 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -39,3 +39,9 @@
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
index 1dade31..fe3b386 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
@@ -1,4 +1,4 @@
-From 0a0de54c7a95e959bcf9c34dffc1fc21291d994b Mon Sep 17 00:00:00 2001
+From 756a5281070bee3a99d3a7be82d90e98290c0598 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
 Subject: [PATCH] refpolicy-minimum: allow systemd-networkd to accept and
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e4f53fe66..19f8368a8 100644
+index 5649f79af..d6757ce56 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1439,6 +1439,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
+@@ -1451,6 +1451,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
  allow systemd_networkd_t self:tun_socket { create_socket_perms relabelfrom relabelto };
  allow systemd_networkd_t self:udp_socket create_socket_perms;
  allow systemd_networkd_t self:unix_dgram_socket create_socket_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index fc8e0e3..84cc14b 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 275d9a2e0d59f27797d74e4a9b39ad8e1041b7d0 Mon Sep 17 00:00:00 2001
+From b328cb59c1c6bf8a43b496f50e59d277cfdd7946 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
@@ -38,7 +38,7 @@ index ce614b41b..c0903d98b 100644
 +root:unconfined_u:s0-mcs_systemhigh
 +__default__:unconfined_u:s0
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 940c98ce6..c8f3f9c3b 100644
+index 4ef723b85..671d38664 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -20,6 +20,11 @@ type unconfined_execmem_t alias ada_t;
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index 65c7b2a..ecd2de9 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From 2febe93c54945827d753bb2df9e85341d2086a36 Mon Sep 17 00:00:00 2001
+From ca910a2049117088df2feffdd18aafbbc84cbc7c Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
diff --git a/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
new file mode 100644
index 0000000..9e18682
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
@@ -0,0 +1,35 @@
+From 587af51ddbd93aa7c0dfa13f8abb97d676e200c7 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 26 Feb 2021 09:13:23 +0800
+Subject: [PATCH] refpolicy-minimum: enable nscd_use_shm
+
+Fixes:
+avc: denied { accept } for pid=336 comm="systemd-logind"
+path="/run/systemd/io.systemd.Login"
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=system_u:system_r:systemd_logind_t:s0 tclass=unix_stream_socket
+permissive=0
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/services/nscd.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/services/nscd.te b/policy/modules/services/nscd.te
+index ffc60497c..d226f1145 100644
+--- a/policy/modules/services/nscd.te
++++ b/policy/modules/services/nscd.te
+@@ -15,7 +15,7 @@ gen_require(`
+ ##	can use nscd shared memory.
+ ##	</p>
+ ## </desc>
+-gen_tunable(nscd_use_shm, false)
++gen_tunable(nscd_use_shm, true)
+ 
+ attribute_role nscd_roles;
+ 
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index 2763cb0..a80ec96 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From c66bca3019b40cd6d626ec62331cc85fa459f253 Mon Sep 17 00:00:00 2001
+From cf97382a3c2c8fd841ddd9420fdd51eaaf87a942 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 01c6801..14a8f68 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From 62f52190b1ff3beac1b48e657484f6307b70b238 Mon Sep 17 00:00:00 2001
+From 344b071e8aeb77d15fab6131c3d0540a1d319096 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 506055d..0753adb 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From d26183bfc1fa9b9e93ac22707ef7b9b2f7df3238 Mon Sep 17 00:00:00 2001
+From a6eebdef46d6987614e22dd92edc6ff2202ad88d Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index 9712f0f87..b3c2f56b4 100644
+index 3f13fa9fc..6dbb7a499 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index 7fef05d..53245b5 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From b01a876ff4dd5c8030e8239cff5278753de824a4 Mon Sep 17 00:00:00 2001
+From a572902044b8965a2afbf5436c37d1c910a38dff Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 5e384b9..2f99afd 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From 8f867445e1e81f99a45f2791cfee6d197e4209e1 Mon Sep 17 00:00:00 2001
+From 085f1fc734f93738e44364de9d5ad2c52321c899 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 9ca2d7b..2c47ff1 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From e8176157e818d2afda0c92933c089616f39799c6 Mon Sep 17 00:00:00 2001
+From 5b45a3a02bb95f6ff008716f3a35c3295dcffc48 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index bf47884f5..8fb419ee6 100644
+index c36f27498..81314fd16 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 8b55a7a..2f4eb52 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From f66c77baa8d7cae2e71421554ce9fec52a666c3a Mon Sep 17 00:00:00 2001
+From 6ea8be2d788b50a54b52412a473629bbedc99c98 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 69eac13..2500731 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 05cfce6462a9b669d0e9c19e5054eed6eaee929b Mon Sep 17 00:00:00 2001
+From fbc67ac67b34d0bed2bfd7f9ccbbbc84b9a87c05 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index 268d066..fae65e3 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From ade8050fdc8c309f8b92d118687bd97f5ca794f3 Mon Sep 17 00:00:00 2001
+From b1484fad712a955c22a9fd0c2db3eb452d171d88 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 5cde88d..6b2902e 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 284638aff460da4730009afe994175ce2f4d184f Mon Sep 17 00:00:00 2001
+From 078961ecb4615082b4c37354cfd10d30feff5030 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index bc66308..f1a10c0 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From 1e014179592a6987c0a122ab4a6ee9aa61c7fbd7 Mon Sep 17 00:00:00 2001
+From d47e8bdcc5f3b8bc21c7efb11d1028d8aee04743 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index e059828..0164d1e 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From d19a7e3c74f84b482612fc523eeea0d9d9263594 Mon Sep 17 00:00:00 2001
+From d366090f2d89448878cfac371c3d1b9694d67f87 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index 972f0c1..b2e52fd 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From b378cd35ee983e30074f4cef81e512adc1ba8d14 Mon Sep 17 00:00:00 2001
+From a672c11dd652dced7d36ed4b96ba6fb2b20c07b3 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 917dcc4..10e9dec 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From fac8b484bd3b5cd3d1283a2ae04317f6e6d89bac Mon Sep 17 00:00:00 2001
+From 3241cedb4f96b2b5a7fd8d9f70f90f339e69ee88 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index 4143b49..acf8521 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From 25ede8d1c8ac8618d10130957bfd9ca7029f7f88 Mon Sep 17 00:00:00 2001
+From a358cddc1a278ac8e40c40a58f2fb20bd6e8da5c Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 9e88c22..9cd46b3 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 0707b5c142915d994b8cbc08d4d9659697c40ed7 Mon Sep 17 00:00:00 2001
+From 663b9788a061a029d10b9caae0c08e37f7efa063 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index 5c62515..a67af58 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From adec1632a9c7d8f80d2f353c5d69cfba429d5e2e Mon Sep 17 00:00:00 2001
+From cd5fe8a285ee8c9911d80f3c6d92166e59a811e4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index 1408ab4..31770a9 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From a6057afaeedbc4ed148f3554746aeecc6ee31e3a Mon Sep 17 00:00:00 2001
+From 386fcec20066a67912e71a2f24d96fccdcd80329 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index 8c2b6da..ffbebf4 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 94b6c8baa19eb3ac8eda4a9b4151dc3c69e432fc Mon Sep 17 00:00:00 2001
+From 675ef147f22a7c61dc47d4173307d0b4ce703aff Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
index e1a0eac..1b173a1 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From f112cd85a2121fe84a4ace6b781dad5dc77ba5fe Mon Sep 17 00:00:00 2001
+From 521f56f178d4eb2edb6fb553e7d5a89c34efc502 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
index 3239ce8..fb56f09 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 677a140a33f4abc1ef7a2baef768d50485180595 Mon Sep 17 00:00:00 2001
+From e96c35b96cde4176cff786bd9fa7c27f3ef18c62 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 3c0b031..2cf78d6 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 4a1c5f7649d960a1a5456f84da1fcc88d992b155 Mon Sep 17 00:00:00 2001
+From f6c4563a967dee1ca09dd4759503f79bfdbe4fe0 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
diff --git a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index 8c785e0..ccc53e1 100644
--- a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 709df66b11b654fd15fcaa6c0ac5e39bedadde51 Mon Sep 17 00:00:00 2001
+From 1186572ce9dd51b05c21e1f93e2495a46eb20176 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 690007f22..f80499ebf 100644
+index e782151ef..8aaf36858 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
 @@ -45,3 +45,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
index 7d3b042..a27572a 100644
--- a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 17aa22ea4681d38fe7a90c0a3a0a9b2181bd7f0b Mon Sep 17 00:00:00 2001
+From 90c97030a68682dd11f5bf968c4705a4524b263d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 90b95d4..57fd4ba 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From bd0c6361b144e638039830a3a2eff4b05c36add6 Mon Sep 17 00:00:00 2001
+From fb1d2f5840747edf6d8a0031d38c5e7beb872520 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a2f35f278..11a0fad46 100644
+index 0ba5d3d8b..d8621f9e1 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -429,6 +429,7 @@ files_search_spool(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 7570ed8..87de42b 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 87b66b35c6bebc4fe807f7d4020519df10af483f Mon Sep 17 00:00:00 2001
+From 8041f8d8f41166061dd86e5fc1bea9323168ae7f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
index 34e224e..054742a 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From a6cffb4673b5ea372f7aa0679e8d89cd97018d85 Mon Sep 17 00:00:00 2001
+From 403738f594cba99590bdbf01d52d984e55d9e08e Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 11a0fad46..a1e4a5b8d 100644
+index d8621f9e1..cbef358c2 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -120,6 +120,7 @@ allow auditctl_t auditd_log_t:file read_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index da62522..58bd04c 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From fc37036aa30e58b4d9c75cbb412d6371212765b3 Mon Sep 17 00:00:00 2001
+From 3995b0994210a4e7035169961fe94012afffe544 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
index cbbe755..8b08712 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From cbf27ba4d70fdb9c4877929789311d3b25d7837f Mon Sep 17 00:00:00 2001
+From 4f6738e1d904da305282cb4c5a8c90669a4d328f Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 4188c9547..cbc72d6a9 100644
+index 4c8158470..255b8a3f0 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
index aba8479..7b317f8 100644
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
@@ -1,4 +1,4 @@
-From 70e8a8c6468a279b8ae38ff4a681255d05439c0a Mon Sep 17 00:00:00 2001
+From edeb47c29f852c8a85bd8d33c2cb472920cf9a28 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 30 Sep 2023 17:20:29 +0800
 Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a1e4a5b8d..97b86b2a7 100644
+index cbef358c2..d22a3207c 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -27,6 +27,10 @@ type auditd_log_t;
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
index bd88d11..f826de7 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From 39b06488ae85aba2442f3eac2eb42b91edf5f285 Mon Sep 17 00:00:00 2001
+From cb2183b13c440bfc03d56b26c4f90868e753e307 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 35 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index db6bd9752..64d83367d 100644
+index 809fde402..1955f5409 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -267,6 +267,37 @@ template(`systemd_role_template',`
@@ -73,10 +73,10 @@ index db6bd9752..64d83367d 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 0be775e9e..efa65779a 100644
+index 10b085d41..b751f7de0 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1480,6 +1480,10 @@ template(`userdom_admin_user_template',`
+@@ -1479,6 +1479,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
index 496010b..bbd40e8 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From d167a78e361bfd81bdda18692ef0e66a3921cc74 Mon Sep 17 00:00:00 2001
+From 1960cf45c37cdd9c11a012fe641dd37537b6f6e4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,7 +21,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 97b86b2a7..45ed81867 100644
+index d22a3207c..b1d9c20d2 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -406,6 +406,8 @@ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index bab51dd..b032c3f 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From ea19bb6f4c7d130f0b2d2c025b6359a5a7f82c83 Mon Sep 17 00:00:00 2001
+From 75088c2e74893f5ae19f44a15766a91e74a25af2 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,7 +67,7 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 45ed81867..a3afe5525 100644
+index b1d9c20d2..69b3405b3 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
@@ -79,10 +79,10 @@ index 45ed81867..a3afe5525 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index cbc72d6a9..cbae29894 100644
+index 255b8a3f0..b9af00ec8 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1467,6 +1467,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1471,6 +1471,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index 605ed6c..a9ba8ad 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 003ae9b4e2e4049a62745634a83ad3f95d2a7e9e Mon Sep 17 00:00:00 2001
+From 41f947d2985d449c5712e56c4b177a7f1b373867 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
diff --git a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
index 7661870..c55a35c 100644
--- a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -1,4 +1,4 @@
-From ec677f6cd1fd050e5f558aec6101296769d6bcee Mon Sep 17 00:00:00 2001
+From 7ec9f3f6be543977921eed4b2bba4c6e27004883 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 09:54:06 +0800
 Subject: [PATCH] systemd: allow systemd-logind to inherit fds
@@ -35,10 +35,10 @@ index ebb7ef0e0..0398ce6fd 100644
  		allow $3 $1_su_t:process signal;
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 64d83367d..e6aa112c0 100644
+index 1955f5409..0d9ff59e2 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1501,6 +1501,24 @@ interface(`systemd_use_logind_fds',`
+@@ -1581,6 +1581,24 @@ interface(`systemd_use_logind_fds',`
  	allow $1 systemd_logind_t:fd use;
  ')
  
diff --git a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index c615c81..d480089 100644
--- a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From ed34e4e062a23f11708c023b2daba4b83b74e23e Mon Sep 17 00:00:00 2001
+From 496131601f622dabb953cf3f98c64dd726060d33 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -61,7 +61,7 @@ index 08ed91f19..0fa4cbf7d 100644
 +	read_lnk_files_pattern($1, bin_t, bin_t)
 +')
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index e6aa112c0..3f3426ebd 100644
+index 0d9ff59e2..da6a30470 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -155,6 +155,7 @@ template(`systemd_role_template',`
@@ -73,10 +73,10 @@ index e6aa112c0..3f3426ebd 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index cbae29894..7e39556b7 100644
+index b9af00ec8..e79dec101 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2142,6 +2142,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2148,6 +2148,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
index 6113588..c85b08c 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
@@ -1,4 +1,4 @@
-From 7049caea5b0a37084d144c37212f6da57b16e7df Mon Sep 17 00:00:00 2001
+From df839088b81e67270d856bebcb6c3b7528f6b46c Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Sep 2025 15:15:44 +0800
 Subject: [PATCH] systemd: fix for systemd-networkd and systemd-rfkill
@@ -35,10 +35,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 7e39556b7..adcd931b7 100644
+index e79dec101..b4afcab57 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1419,7 +1419,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
+@@ -1423,7 +1423,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
  # networkd local policy
  #
  
@@ -47,7 +47,7 @@ index 7e39556b7..adcd931b7 100644
  allow systemd_networkd_t self:netlink_generic_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_kobject_uevent_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_netfilter_socket create_socket_perms;
-@@ -1459,12 +1459,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
+@@ -1463,12 +1463,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
  dev_read_urand(systemd_networkd_t)
  dev_read_sysfs(systemd_networkd_t)
  dev_write_kmsg(systemd_networkd_t)
@@ -63,7 +63,7 @@ index 7e39556b7..adcd931b7 100644
  
  fs_getattr_all_fs(systemd_networkd_t)
  fs_list_tmpfs(systemd_networkd_t)
-@@ -1893,6 +1896,7 @@ logging_send_syslog_msg(systemd_pstore_t)
+@@ -1899,6 +1902,7 @@ logging_send_syslog_msg(systemd_pstore_t)
  # Rfkill local policy
  #
  
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
new file mode 100644
index 0000000..6ddc91f
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
@@ -0,0 +1,84 @@
+From 42297b6e559cce0778517bbc4625a44417d7ce0b Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 6 Feb 2026 22:13:03 +0800
+Subject: [PATCH] systemd: allow domain used for login program to connect to
+ systemd-logind over unix socket
+
+Fix the following AVC denials:
+avc: denied { write } for pid=392 comm="login" name="io.systemd.Login"
+dev="tmpfs" ino=849 scontext=system_u:system_r:local_login_t
+tcontext=system_u:object_r:init_runtime_t tclass=sock_file permissive=1
+
+avc: denied  { connectto } for pid=392 comm="login"
+path="/run/systemd/io.systemd.Login"
+scontext=system_u:system_r:local_login_t
+tcontext=system_u:system_r:systemd_logind_t tclass=unix_stream_socket
+permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/authlogin.if |  1 +
+ policy/modules/system/systemd.fc   |  1 +
+ policy/modules/system/systemd.if   | 20 ++++++++++++++++++++
+ 3 files changed, 22 insertions(+)
+
+diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
+index bb282024c..db8fd8e39 100644
+--- a/policy/modules/system/authlogin.if
++++ b/policy/modules/system/authlogin.if
+@@ -227,6 +227,7 @@ interface(`auth_login_pgm_domain',`
+ 		systemd_read_logind_state($1)
+ 		systemd_write_inherited_logind_sessions_pipes($1)
+ 		systemd_use_passwd_agent_fds($1)
++		systemd_connectto_logind_sockets($1)
+ 	')
+ ')
+ 
+diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
+index 505a054ff..e44d82a88 100644
+--- a/policy/modules/system/systemd.fc
++++ b/policy/modules/system/systemd.fc
+@@ -127,6 +127,7 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
+ /run/systemd/netif(/.*)?	gen_context(system_u:object_r:systemd_networkd_runtime_t,s0)
+ /run/systemd/nsresource(/.*)?	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
+ /run/systemd/io\.systemd\.NamespaceResource	-s	gen_context(system_u:object_r:systemd_nsresourced_runtime_t,s0)
++/run/systemd/io\.systemd\.Login	-s	gen_context(system_u:object_r:systemd_logind_runtime_t,s0)
+ 
+ /run/tmpfiles\.d	-d	gen_context(system_u:object_r:systemd_tmpfiles_conf_t,s0)
+ /run/tmpfiles\.d/.*		<<none>>
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index da6a30470..e184b1d77 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -1600,6 +1600,26 @@ interface(`systemd_inherit_logind_fds',`
+ 	allow systemd_logind_t $1:fd use;
+ ')
+ 
++######################################
++## <summary>
++##  Allow domain to connect to systemd
++##  logind sockets.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`systemd_connectto_logind_sockets',`
++	gen_require(`
++		type systemd_logind_runtime_t, systemd_logind_t;
++	')
++
++	allow $1 systemd_logind_runtime_t:sock_file write;
++	allow $1 systemd_logind_t:unix_stream_socket connectto;
++')
++
+ ######################################
+ ## <summary>
+ ##      Watch logind sessions dirs.
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch b/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
new file mode 100644
index 0000000..768768a
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
@@ -0,0 +1,154 @@
+From 77336cfaff881b80e3f0c1dd4abef78a208b304f Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Mon, 9 Feb 2026 15:42:19 +0800
+Subject: [PATCH] systemd: add rules for systemd-ssh-issue
+
+systemd-ssh-issue was added in systemd v258. It is a small tool that
+generates a /run/issue.d/50-ssh-vsock.issue drop-in file in case
+AF_VSOCK support is available in the kernel and the VM environment.
+
+Add rules for it and allow getty to read files in /run/issue.d.
+
+Fixes:
+avc: denied { getattr } for pid=391 comm="agetty" path="/run/issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+avc: denied { read } for pid=391 comm="agetty" name="issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+avc: denied { open } for pid=391 comm="agetty" path="/run/issue.d"
+dev="tmpfs" ino=846 scontext=system_u:system_r:getty_t
+tcontext=system_u:object_r:initrc_runtime_t tclass=dir permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/getty.te   |  5 +++++
+ policy/modules/system/systemd.fc |  3 +++
+ policy/modules/system/systemd.if | 19 +++++++++++++++++
+ policy/modules/system/systemd.te | 35 ++++++++++++++++++++++++++++++++
+ 4 files changed, 62 insertions(+)
+
+diff --git a/policy/modules/system/getty.te b/policy/modules/system/getty.te
+index 75b94785b..48a29461a 100644
+--- a/policy/modules/system/getty.te
++++ b/policy/modules/system/getty.te
+@@ -100,6 +100,11 @@ logging_send_syslog_msg(getty_t)
+ 
+ miscfiles_read_localization(getty_t)
+ 
++ifdef(`init_systemd',`
++	# access to /run/issue.d/50-ssh-vsock.issue
++	systemd_read_ssh_issue_runtime(getty_t)
++')
++
+ ifdef(`distro_gentoo',`
+ 	# Gentoo default /etc/issue makes agetty
+ 	# do a DNS lookup for the hostname
+diff --git a/policy/modules/system/systemd.fc b/policy/modules/system/systemd.fc
+index e44d82a88..130c62370 100644
+--- a/policy/modules/system/systemd.fc
++++ b/policy/modules/system/systemd.fc
+@@ -49,6 +49,7 @@
+ /usr/lib/systemd/systemd-resolved	--	gen_context(system_u:object_r:systemd_resolved_exec_t,s0)
+ /usr/lib/systemd/systemd-rfkill		--	gen_context(system_u:object_r:systemd_rfkill_exec_t,s0)
+ /usr/lib/systemd/systemd-socket-proxyd	--	gen_context(system_u:object_r:systemd_socket_proxyd_exec_t,s0)
++/usr/lib/systemd/systemd-ssh-issue --  gen_context(system_u:object_r:systemd_ssh_issue_exec_t,s0)
+ /usr/lib/systemd/systemd-sysctl		--	gen_context(system_u:object_r:systemd_sysctl_exec_t,s0)
+ /usr/lib/systemd/systemd-tpm2-setup		--	gen_context(system_u:object_r:systemd_pcrphase_exec_t,s0)
+ /usr/lib/systemd/systemd-update-done	--	gen_context(system_u:object_r:systemd_update_done_exec_t,s0)
+@@ -99,6 +100,8 @@ HOME_ROOT/.+\.home	--	gen_context(system_u:object_r:systemd_homed_storage_t,s0)
+ /var/lib/systemd/pstore(/.*)?	gen_context(system_u:object_r:systemd_pstore_var_lib_t,s0)
+ /var/lib/systemd/rfkill(/.*)?	gen_context(system_u:object_r:systemd_rfkill_var_lib_t,s0)
+ 
++/run/issue.d(/.*)? gen_context(system_u:object_r:systemd_ssh_issue_runtime_t,s0)
++
+ /run/\.nologin[^/]*	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
+ /run/nologin	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
+ 
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index e184b1d77..c9c841a2a 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -3211,3 +3211,22 @@ interface(`systemd_use_inherited_machined_ptys', `
+ 	allow $1 systemd_machined_t:fd use;
+ 	allow $1 systemd_machined_devpts_t:chr_file rw_inherited_term_perms;
+ ')
++
++########################################
++## <summary>
++##  Allow domain to read files in /run/issue.d
++## </summary>
++## <param name="domain">
++##  <summary>
++##  Domain allowed access.
++##  </summary>
++## </param>
++#
++interface(`systemd_read_ssh_issue_runtime',`
++	gen_require(`
++		type systemd_ssh_issue_runtime_t;
++	')
++
++	list_dirs_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++	read_files_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++')
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index b4afcab57..11a206fd0 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -306,6 +306,14 @@ corenet_port(systemd_socket_proxyd_port_t)
+ type systemd_socket_proxyd_unit_file_t;
+ init_unit_file(systemd_socket_proxyd_unit_file_t)
+ 
++type systemd_ssh_issue_t;
++type systemd_ssh_issue_exec_t;
++init_daemon_domain(systemd_ssh_issue_t, systemd_ssh_issue_exec_t)
++
++type systemd_ssh_issue_runtime_t;
++files_runtime_file(systemd_ssh_issue_runtime_t)
++init_daemon_runtime_file(systemd_ssh_issue_runtime_t, dir, "issue.d")
++
+ type systemd_sysctl_t;
+ type systemd_sysctl_exec_t;
+ init_daemon_domain(systemd_sysctl_t, systemd_sysctl_exec_t)
+@@ -2071,6 +2079,33 @@ fs_getattr_nsfs_files(systemd_sysctl_t)
+ 
+ systemd_log_parse_environment(systemd_sysctl_t)
+ 
++
++#########################################
++#
++# systemd-ssh-issue local policy
++#
++
++allow systemd_ssh_issue_t self:capability net_admin;
++allow systemd_ssh_issue_t self:unix_dgram_socket { connect create getopt setopt };
++allow systemd_ssh_issue_t self:vsock_socket create_socket_perms;
++
++dev_read_sysfs(systemd_ssh_issue_t)
++dev_read_vsock(systemd_ssh_issue_t)
++
++fs_getattr_nsfs_files(systemd_ssh_issue_t)
++
++init_read_state(systemd_ssh_issue_t)
++
++kernel_getattr_proc(systemd_ssh_issue_t)
++kernel_read_kernel_sysctls(systemd_ssh_issue_t)
++kernel_read_system_state(systemd_ssh_issue_t)
++
++logging_send_syslog_msg(systemd_ssh_issue_t)
++
++manage_dirs_pattern(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++manage_files_pattern(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
++files_runtime_filetrans(systemd_ssh_issue_t, systemd_ssh_issue_runtime_t, { dir file })
++
+ #########################################
+ #
+ # Sysusers local policy
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
rename to recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 8c0bc8d..22df7c6 100644
--- a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 2460a7db017d5bcbf53d1e2419ee9422f8de7271 Mon Sep 17 00:00:00 2001
+From 3d50a217b3dabfaf8534041aefad3e9a2477d86a Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/mount.te b/policy/modules/system/mount.te
-index 1417bcb27..f0a826a76 100644
+index 687c532e1..319ddd2bb 100644
 --- a/policy/modules/system/mount.te
 +++ b/policy/modules/system/mount.te
-@@ -120,6 +120,7 @@ fs_dontaudit_write_all_image_files(mount_t)
+@@ -121,6 +121,7 @@ fs_dontaudit_write_all_image_files(mount_t)
  
  mls_file_read_all_levels(mount_t)
  mls_file_write_all_levels(mount_t)
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
rename to recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 5afa497..1f8e4fc 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From f86a3f306eaa24038f9090e4f99b4f46914735d9 Mon Sep 17 00:00:00 2001
+From df5097ba1d8e492c3bd7b019432d9012e943e1d8 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
similarity index 96%
rename from recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
rename to recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index dce8f1e..621c54b 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From adfe3ab856fa6a1650a47d5450080307aaf19e97 Mon Sep 17 00:00:00 2001
+From 93e604f1b58a174b3871713dd5a3449a9d4a0d04 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
rename to recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index a3b36a0..5ca30cb 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 00e1288cb8bd975c9252fd3eda97cbc3bb705de6 Mon Sep 17 00:00:00 2001
+From 81bee8a2e32c4e5c0c0e321b4ef1a5c2b7a59c93 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 97%
rename from recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index df316ce..faee3a0 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 42dbcc5513da2e2f63ddc9af7b551b01244bdce5 Mon Sep 17 00:00:00 2001
+From 6cfdfb222bb39241c126d71c892c73860ad7198a Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 147ca29..21c1fa4 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From ccd95772201397f33dc4aa585d253a010a713d5f Mon Sep 17 00:00:00 2001
+From 763d9886f4f16582b08deb6485f39c5547e7ceee Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,7 +27,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 0772961ab..ad51a24ab 100644
+index cb9c3d97a..43b4789f7 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -256,6 +256,10 @@ mls_process_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
rename to recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 2e1c99f..11284c7 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From 86bb36e5b6dc2c1c20c30b569f7c2e8c1f680015 Mon Sep 17 00:00:00 2001
+From 9346ebe2f4863a4adbbb36fa9a9596eafa48f945 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index adcd931b7..2595abc8b 100644
+index 11a206fd0..5aa424e5f 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2241,6 +2241,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2282,6 +2282,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
rename to recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch
index 560bc2d..18320b9 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From d0a659f27ef2877a3d282fc90fe2e8035efa7d92 Mon Sep 17 00:00:00 2001
+From 3bd39b5127037d6aead60d2c665773329fcce203 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 2595abc8b..e4f53fe66 100644
+index 5aa424e5f..5649f79af 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -463,6 +463,9 @@ optional_policy(`
+@@ -473,6 +473,9 @@ optional_policy(`
  	unconfined_dbus_send(systemd_backlight_t)
  ')
  
@@ -56,7 +56,7 @@ index 2595abc8b..e4f53fe66 100644
  #######################################
  #
  # Binfmt local policy
-@@ -676,6 +679,9 @@ udev_read_runtime_files(systemd_generator_t)
+@@ -686,6 +689,9 @@ udev_read_runtime_files(systemd_generator_t)
  # for systemd-getty-generator
  userdom_use_user_ttys(systemd_generator_t)
  
@@ -66,7 +66,7 @@ index 2595abc8b..e4f53fe66 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1196,6 +1202,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+@@ -1208,6 +1214,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_terminals(systemd_logind_t)
  
@@ -76,7 +76,7 @@ index 2595abc8b..e4f53fe66 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1920,6 +1929,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1934,6 +1943,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
rename to recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index a96d5e3..961f0b4 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From 49eac86160aa1b5e587a62441b22a8c2fccab2af Mon Sep 17 00:00:00 2001
+From cc4bae3b5fa0d7c9f98401aa40d9a753503239ca Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a3afe5525..a2df275eb 100644
+index 69b3405b3..63405a193 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -499,6 +499,9 @@ fs_list_tmpfs(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index afced9e..f737243 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From b9be2d9790614d313fdf46d9e7cabaa47d7d3ea1 Mon Sep 17 00:00:00 2001
+From 0786f87a616c9c3fa2c72026180e0e5f375b6ae1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index ad51a24ab..cd0e3171c 100644
+index 43b4789f7..a66b8731b 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -255,6 +255,7 @@ mls_file_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
rename to recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch
index 973c0f0..75fb9a1 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From 3bca256a6b97562f9c75e03dd7e8e62077bc71e9 Mon Sep 17 00:00:00 2001
+From f5e17d4a1eb17a247d33dc68b96ff15326541924 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index cd0e3171c..c4c1a5323 100644
+index a66b8731b..15bffd9cf 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -261,6 +261,9 @@ mls_key_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
rename to recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index 9b1762c..b98c750 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From 50037f06b0fecd6f8d0416832d18bbf8821a55dd Mon Sep 17 00:00:00 2001
+From 12b7d2999051ab060d12f3c55287d6f96094e0b2 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a2df275eb..daaeefb64 100644
+index 63405a193..7ef69524c 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -240,6 +240,8 @@ miscfiles_read_localization(auditd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 0a24032..1767ab8 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 2def1a0849bcef3099f50c99c12eb60974dc9c28 Mon Sep 17 00:00:00 2001
+From ea9fd03253df275d10a0b7c42f45975078b89a7b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
rename to recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index 1bbeeb2..a7e132c 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 66402eb7ea25179ba0e21267f0dea1b506a6ab26 Mon Sep 17 00:00:00 2001
+From faae5ef0261d41da137b64e0d99adff300316827 Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
rename to recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index f7d13e1..3203249 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 2a968f30e93462c5555277442b04f4abce3637ce Mon Sep 17 00:00:00 2001
+From f639aebeade83c4d3bfe7ab2ec94c3a6321082f4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 3f3426ebd..bb32d1981 100644
+index c9c841a2a..36cba9a19 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
 @@ -266,6 +266,9 @@ template(`systemd_role_template',`
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
rename to recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch
index 8a2cfef..e6db96c 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 71542a544be671d68d9041aa84282f53cae5d05d Mon Sep 17 00:00:00 2001
+From 55fdb65085d3358caf9b142baf2996aa4ae28738 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index daaeefb64..4de798007 100644
+index 7ef69524c..87b4779ff 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -463,6 +463,8 @@ allow syslogd_t syslogd_runtime_t:file map;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 59dfecd..2e1a929 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -56,22 +56,24 @@ SRC_URI += " \
         file://0038-systemd-allow-systemd-logind-to-inherit-fds.patch \
         file://0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
         file://0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
-        file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
-        file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
-        file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
-        file://0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
-        file://0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
-        file://0048-policy-modules-system-systemd-systemd-make-systemd_-.patch \
-        file://0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
-        file://0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0051-policy-modules-system-init-all-init_t-to-read-any-le.patch \
-        file://0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
-        file://0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
-        file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
-        file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0041-systemd-allow-domain-used-for-login-program-to-conne.patch \
+        file://0042-systemd-add-rules-for-systemd-ssh-issue.patch \
+        file://0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
+        file://0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
+        file://0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
+        file://0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
+        file://0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
+        file://0050-policy-modules-system-systemd-systemd-make-systemd_-.patch \
+        file://0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
+        file://0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0053-policy-modules-system-init-all-init_t-to-read-any-le.patch \
+        file://0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
+        file://0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
+        file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
+        file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index c5f9ae1..adf9930 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20250923+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "0deb7170f8e5466a39c95468959321c2c28a5f33"
+SRCREV_refpolicy = "2cba8023863718709d0349faf62a9f4da2248a3f"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


