Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2F6C531DC
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 13:17:33 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web11.15849.1724419046705851231
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 06:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=iJpbQRef;
 spf=pass (domain: cherry.de, ip: 40.107.104.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ER9ogVTNDOPuMbJRuBRzcxqbNobsx4prYGYsv2G1f/ZsoEmmfhAbxIU3o+jy5vrxmOLfwfYMIS9y7GA+PvRGRhCwgLgxJEe5CCU4iqM3eSOstOWLfHSynUaOitoLd+euAUaLFW7nl6bawQSUzdmDvleR1Imy627QEXUWgYdWnWnu3ZAoLXUSCuZfwrh06UV+W7cDy3G98ZIm0wGTeq6mR7ZbuM3vr4PhbFcs2gy5tKZDOLoTeu3XeydGgclOkzKk2/gnptw3pZ5LN6dEA9rMuOgEeXzdRJDEHuE1omylotxQlppO9JTidEKYYiJ1nOo6MrIt2F+k/t2L1llCfb/UsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuoGP+7X7SB05yiS+0pXqRLQxUnAGIb3Zhx8KMj3KHw=;
 b=F8tbpEyof7UMBQlP+jpYsShGJiuu0HYqX1I/08oFmFyiAthOsf+egK6zUKQ8XUu53YUrYMpcM0h1kveA/zCh8Z9J8Ly73zXaeaibruvsvXVzlPth2/c/ZnLWe91TMrBk9opWJnMTg1GlLHn7G8jXCOvEsXX+3I2N5URaZ0ymUM8gQJKzdAP0NN0R1dB1Ng2No36WPkZehw51aVU2WCAyIkZszHDFaU6bMteTd136c9bBzu03jPxfq0E1rVhwkPuAO1XXythKAb72ekIpRwyRs+WYt3BpK9E0NOVWlgRMv/zeEnztrKqUGf7ro1NNCHOn9waPJxzj7tECImM7wqFPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuoGP+7X7SB05yiS+0pXqRLQxUnAGIb3Zhx8KMj3KHw=;
 b=iJpbQRef+vY9YxZF3z1N1lQhl6qyA4QVUlwhSF8V698w/G4XJ6sFSuYuxoO4mNW7nQaUp7jyShC4biUqL8ERcwp80pURlhpEO+qN1DKXzVDF/XUdX9HuJE0jE8FCZxAPviUR7pgn1opFdM8LA3aZSmeS6nJ4ycykUisLfcG1ulo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7101.eurprd04.prod.outlook.com (2603:10a6:800:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:17:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 13:17:21 +0000
Message-ID: <88170668-0528-4faa-a727-73777e91a8ce@cherry.de>
Date: Fri, 23 Aug 2024 15:17:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: Rename bbappend to
 match oe-core
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Khem Raj <raj.khem@gmail.com>
References: <20240823131438.1539692-1-raj.khem@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240823131438.1539692-1-raj.khem@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: c66c046f-eed4-49c3-dce9-08dcc375ebf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cC9ZM0gzOFhZR2FYbjdkSEVFL0ZwSUc4ZkF3MVZQRWFvZXU4OGF3cktiNzli?=
 =?utf-8?B?ZisyRThPWmh1ZmFvQTdzUjlIMy9KR2hYV2RpV0thTUM5Vmk5TWdremEySkJY?=
 =?utf-8?B?b1Y3ZzgyK3RMTjhlSjNrWU9TL21STjE0MHEwTmFKRDRISFFHQzF0cU5WOWdG?=
 =?utf-8?B?aFJzTXF4eUF0VlFUaTc5U29CSDVDeGV0TlBjZGpsWnRWTDZZSUx4QkJ0bXpv?=
 =?utf-8?B?TG1DcEFJUCt3NXhpU2pINExiQ2NVL0tXN0E4NWx1SVJoRS9WRnk0VjdoVEtm?=
 =?utf-8?B?SnlmOWRwNTNlOVV5T0ozcjljOEJ2OUNNYlBUR215WlRnSWFER2JRQlIzVmsx?=
 =?utf-8?B?UVRvbm03YUlnNzNKcEdUaVd6eS91WXZuZ1Fjd09WSDR2NTFwQnIwMGE5RFJl?=
 =?utf-8?B?RjFwbm9wdVEzWU5xZWR3MWljSHI2SnZNdDFlU1VlSURHamZZeXNDMFIyZysy?=
 =?utf-8?B?clJkNDJjeTNmUDkwdVVTamRRRGpldUdXYU5vb0RPeFBQQ3FuU0MrbElMTFZu?=
 =?utf-8?B?UUpqazU0MW1ER3hxUUNROUVURjMxYmRaS3dvbVBkd2xNZFlYSDIvRkVnWEVl?=
 =?utf-8?B?WHdDUEVPMXBNOGtaM1Y4T3BESk9NR1JReUw3V1ErRVhIQlcwZU51UFpUakcw?=
 =?utf-8?B?NTNGVDVJVHhmeGNQMDY2aGwzcmpjeXdwUDZKb3ErVDc4M09pODV1T1hOQStK?=
 =?utf-8?B?Rk9NWDdKak9sVUwzUHJVZ25kcDJBaytDUXRLSnJseFV0WEl2NFJyckxRYmp4?=
 =?utf-8?B?R3BScmxEMkFRanpZUTR0bHoycjNqcTVNQnZMWjVhSnhMaWVQZlp1clpCYUtV?=
 =?utf-8?B?ZWRpdnFJWXc0V0hnV3Z4T3ZGcXpqdmRJdDB0OEtkVGJoNmVXWTlDc3dsMVBD?=
 =?utf-8?B?dytSV0dxaTdiZmZuZXkyWjBqR3ZNeWwrUHZ3cXZVMHIwclRhdXdHdC8zaDBl?=
 =?utf-8?B?YTllUmJCQzdEd01WL0NJRnFrZnlpQjRIV1RLd1VNdDR6d0U1V0xmUFpWWThC?=
 =?utf-8?B?MGxrR3lhalhCZTUzTGNpUTlkem83eVJneU4vengrRW44ZmphYm04YlFUSjdN?=
 =?utf-8?B?ZlNzTFlQa2FSSnozSWJzZlo3WWovTkJodEV3STZlTzBzMng2c3VYU3pZdEk5?=
 =?utf-8?B?M2VwRjRJN0FJWldNbElPWDNWVzh3SmJuQjErVXlXT3oyVmdMVkVDN1ZISzM4?=
 =?utf-8?B?WXlTdGtaUU92cHh0WEs4Y0IvSHFtd1g5cm02aVQxTGsyeXp2c0NNTER3SGd6?=
 =?utf-8?B?L1RIL21XWTBxUTV0Q3ZUb1BGR0FwZFBBeUxELzNPbVpPdml5V3lhRUcvYW1i?=
 =?utf-8?B?aHVCVHpZeVIxQTBmU04yYTRkbHpQTkpHdlJXK09WdS9oRkFSVkk1dmhEYVB3?=
 =?utf-8?B?b1p4WW1MYy9TMThURUQwUXBIeUFHOEppaFVTSkxsMklqVi84L241TVVKZUVZ?=
 =?utf-8?B?OFNhdTNqSEwrWUdkUjMvS05mc3RicVJRTnEweURpWHdkTWdTNTk2ekw3MXM1?=
 =?utf-8?B?aFBvMCt5b2xtRDE5THFuZVZCSFN3ZlNvaEw0Qm9JK2ErZFRhdlRWWGcxby83?=
 =?utf-8?B?WTkrODdlek1NYWsxclRWdy9RbEdKYTUzUngyYlhDcURqb0xqMGRiY2Q5SUw1?=
 =?utf-8?B?R1R5Zm9OOGdlMjd4SEYvVGM2TStaRVFNaXczZWZ6OVJEWGVMT3hhcDJZZkkr?=
 =?utf-8?B?TnFlOXZzcVF3Rm9OMGtoU0FZYVh1NjVQNTdhaXgzZ2VlNnRrYk42WGNpYlRu?=
 =?utf-8?Q?MH+DnWCxSAsemMxn9o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0kvVFN1NnFvUHN3bnBHMTRwODRuNExPOEd5R2g2NHNNNm42VTkvbWJlQ0ZV?=
 =?utf-8?B?K3NpaHlrVTlWa3MwRmpNOW0zYm1QaDgvczZieklmY1FIVFJ5aWgvNGJPRGhY?=
 =?utf-8?B?N1g5emc0RWhBRUJCWkp4SnNyQ1psVVhSM2hDV1AxelppWWpiYlNOWDVXRGgz?=
 =?utf-8?B?c2JVeCswbVEwam5oSzMvWUFOQW1KM3NTM0x6Rnd4NVRtZ01tS2FaSzIvYW1t?=
 =?utf-8?B?Rmkrekh1UnlGS3ZjazFGNXRGclB6VzhZTkZHV0FIbW5CQjFVU3dScDFYMXU2?=
 =?utf-8?B?MUhZLzdpTzBiempZeDNIOVg3dmhNWUJqeDlwTmJUYk1kc0l6c1FPWGRmY0E2?=
 =?utf-8?B?ZlJNV0tYZzRPMWJVOHpnTU5VanFXcWQxR1ZVaEpEdHVLbWZNejJIUnNoeERC?=
 =?utf-8?B?K2o0UUtxWEtqdEw1d3I2TnNZVjlWZjd5YTFuUHgvVFZWTmZWV3QyUHQwTkFl?=
 =?utf-8?B?ZWd5dWNMYy9JQU56RzI5K2U2aGhYMWNCU3hRd1hqcVFFS0s1SWtvcldoV1hl?=
 =?utf-8?B?SHl4RDFMSDBPZzlkUDdyQjZVNkNWcFRwTC9oTXVYK3NqQS9XRy9Tb3FzeVBW?=
 =?utf-8?B?aCt4dnJFVEdYV2JhbnE3VGUxekpQSWFqUGxnWFI5V2ZmSXVmV25kNkMxMFFl?=
 =?utf-8?B?aWdOVldkdndNdDNNODVtYWRzZkFuTnBhdUd4UUIvQ3ZWLzRVdzFXNUkxejBh?=
 =?utf-8?B?VHFmY0V4eDFyY1dlL2FOeG04Njg0Z0hmOThyd3pGYXlMTERSdGRlU1l5d3lK?=
 =?utf-8?B?c0NtUjJsTXVyS3FVSzZUNWVJcTBwUFRYcGFHaVZSN0UyY3dzT3JjbE9rM2Zo?=
 =?utf-8?B?MDZEQUwvbkExM3ZhbFNTY1ZRNzQ0bmRSb2ZKQkF3SjAyTXViL0QvWWVpQXR1?=
 =?utf-8?B?TTd1YWloYTFkNnoycC93OWFrekxJY1NEN3pCY040TkhndktIbTUvazR2YXpt?=
 =?utf-8?B?OEVaZllPcTJhTSsyRWdOSHl1T3JQWUYvWEJsaW52ay9oaktVS0F3RFBtL2JB?=
 =?utf-8?B?OHFlT1hiVXNxcXc5ZmJkVVRtUkxBMVAvcWxjTUw5QzBTUVo2NFV1bW14REpl?=
 =?utf-8?B?Y2p6aThsZFFvVDZXWkI4aEpMWnlYMEVuU1NYeitURk8zT21kbElxVlBqamVq?=
 =?utf-8?B?eGJOaVJCSjVsZDI2QmZaRGJXMWIvOG5obnJ4R05WSXhlK1FwaHU2OU9ydUl4?=
 =?utf-8?B?MXMzV2s3bzhHbTJGZk40VlBmTWtIV1RxSnBXRUY0SkwvUDQ3SmUzSlJtKzdL?=
 =?utf-8?B?bFRTQlZnNnZ0K1RNMUJnOXlwMy9CNUcxQXNIblRjZjVyMHAySm5EbHlKemJa?=
 =?utf-8?B?UnJXdlZqU1p6MVg4NTU5a1o5YVM5ck8wWk00ZWFZclQrY2MwdHA5VnI1dXpo?=
 =?utf-8?B?eG56dTF3bmNkQ0N4RUVDR1RpUHpmQUFYWThmbWZ2Ync1L0d2UDlVdmhwQUNj?=
 =?utf-8?B?UGt3Y0tKTXQ3RVMzdVJzN0VGeFBMeDFma3hDdGwxLzdUNFE0NGM5ckxqZ0pw?=
 =?utf-8?B?UENlRWdueWRhZ0NkeTdacWZURFlEZEVpUzc2RjVzOGxCQys3dUkrZjUzaFZs?=
 =?utf-8?B?TG9yLzlJQXFNd1FSRXlUZGMxbXNOV010NnA1NStKd2JmNlJWUWFKeWJpZG5Y?=
 =?utf-8?B?LzY2TW9sZ1NsYVh6NDE3SVUzR0RGcHdUSkRiZnl1OTBKaHNiNnZhUVdLcURj?=
 =?utf-8?B?em9FMTVQSHFSbm16Q0l5WXFzZWZ2ZzdRcklHUmNpRk1Da3NkajBBVFJ4cTVI?=
 =?utf-8?B?YXRyK1lPRXlza0tRcUdGYTI4Uk1MNERjY1pKNVBDSUpXMVdsWlhkWjdJL25N?=
 =?utf-8?B?NFpueC8rczMxSVZ5RlhydEhtY1ZuV3l5OUd5ZEI5aFgvREZlV1ErTklJaGhp?=
 =?utf-8?B?NFRYNDlrVG9EbHpSeWVBN2l2M0I4ZjlqOXh4cGRNYTd1R2JmR0hua0pyRFFX?=
 =?utf-8?B?VTBISnNnSUVKYUVDL3BLdUhQMGc5NElvMkRKdm8wN0psbVdackhaQkVZZUFq?=
 =?utf-8?B?U1pyanQvYk12ek5aNE83NFJYYTA4RTk0aGRYSGJScXNKRmJVajBITFYvWlln?=
 =?utf-8?B?Z1R1QS9YZmZVWG5jK0dpV2p4ZXFEQzhZdm5HYllrZTBGZGp0dUVNMVlTcEhD?=
 =?utf-8?B?TnFDNlRiSDMyeFBKM3RmMjRBZTA2dnZyMVlIUkVrbUdQWVJ5VlJMUStmeWhi?=
 =?utf-8?Q?GVicPu8aX1K04QEkDBYe8cc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c66c046f-eed4-49c3-dce9-08dcc375ebf4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:17:21.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C//8lFZ8VrAUeyLkNKNcaL9zTwGWpVpcsfwfjCV2RFfAZ8AT5j8XWdQjJ345tIB5AmJ+8L5DyCSLN/r1aoEGPb7kYbbxVw3yyRbmCq1l+xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7101
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 13:17:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/555

Hi Khem,

On 8/23/24 3:14 PM, Khem Raj via lists.yoctoproject.org wrote:
> OE-core dropped _git from mesa recipe name
> 

There's already another patch posted on the ML, c.f.
https://lore.kernel.org/yocto-patches/20240823123253.3562592-1-martin.jansa@gmail.com/T/#u

Thanks!
Quentin

