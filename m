Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD7D2FEC5
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 17:30:31 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17560.1769535024829317168
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 09:30:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=GOqC5jnz;
 spf=pass (domain: cherry.de, ip: 52.101.69.60, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY2/z2e/KIgrz2BeSZ7M7HROsi+PL8qVrS/LY+BD4xyRmNlxaA9QiSFrEZbWFo/DVMKop3styJ3AHQUXf4J1+bDR67TJH7j36U29ucjo6DiWgYsJXziSsYaYmgPQAWATADWf/9WShlYeFvR2rWsxiGPx/oOjH+HOij4MvwNU5ANw5iUXeinwGhcUi5gciHRjySPvrGAEKni4QW12VdMMJzQDUhlhvsYEJaf+yHyAmPhVLH49BpO7thwHAvOipurtZnkvsG7tsrAXwuL/3Eg+xGzYL6ZCbDl6cmBQ6vgLXtd7LP6vWY7QZGlaMfNK9Fny4Sr+uYcC5CyLKTtkITa/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ3EVHvwj73AN97AxmKmu6E2rsPYME8jxtUpZImELTY=;
 b=o0pasMsw2PWAGjBAZmzzA/EzSMbZvgxeRYVwe9YHz4GxHktatXEbD5X+sTBz4FitH0eQWul+x9gkTQbN+imURTKQ6xFkf1Kw/cCEWd7WVGickxnrXg6d1UF94EjXt7gKuhyENMF1WaPIH4zNf2ufPPUqOWLMhKWwNlCWMoEZyqfgS33sIzIcGiA6D1AELLwsNRlmOfmgvAtwgW27Mcvua4789fYvFI2w67erbIxqdGVOPMk+3jn0x9UqozoZzfGnz6UuL/6lAk8POtEOx3db8beyUwQk6Hx/Vx9luSF8RaDqodMXBmnE8KPlpIUfVepI6depjTgnFwu85kLS58iPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ3EVHvwj73AN97AxmKmu6E2rsPYME8jxtUpZImELTY=;
 b=GOqC5jnzuqZ7Lq/J+a9oTHdoRtWPTjHmFtDa0mtHfzL/Pm3fEHcwXlee200Eo4HG6DiBn8tRbLZn3Ytot+AGOYkphBzmz4Hvv78WjGa2nPS/WiJjVSYDc5rf3RpXGRrXpcnnszmLwTKoXABNopVn4K3h5xWGpBJEowkHap1EU68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Tue, 27 Jan
 2026 17:30:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 17:30:20 +0000
Message-ID: <8087c0ac-48db-4682-a3ff-28da284f351a@cherry.de>
Date: Tue, 27 Jan 2026 18:29:47 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-tensorflow] tensorflow-lite not buildable since 3.14 python
 upgrade
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: be8394d5-f67d-40fd-27ce-08de5dc9bece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWsvVXlkSmZ1aEJjNVZnTFpiWjNYZU0vVXJSaWUrb0Y0dms4SE9waU1LV20v?=
 =?utf-8?B?YmFUcWZPSGhpcXBnei9YMHlzeVhJbzN2Y09QVUJuMmtqbytHRTFrU0NTZWxh?=
 =?utf-8?B?VFNEZy93aU9rS0JRZloxdk01bGxtTEJ0SGNBWXRzeHdNSmxzOUVuckhTVUU1?=
 =?utf-8?B?Z0l3dXAwY0x5YWFvSGY2QmJFOWhSRE1YYVVST0h3bTIzcmdvVFpMUzlBdlly?=
 =?utf-8?B?QjBRMkNGdmQ4N2J1RUF3bTZPZFFtM3JVck9uMy8veVNJL2NpQk5Iem41aDc5?=
 =?utf-8?B?QTc0Vnoxa1hFOTBkL2FSV054UExTSzA0MWE5NEpmQUFONm1zM3kxRkdrTVM0?=
 =?utf-8?B?NDZoUVBkTFFHZ1ZSWEkxMmtGeHVZbHF4dm5RLzBwZmxBbkZoc2VYWW9ITFZU?=
 =?utf-8?B?aUhqM1FSNm9OK1Bxc0FtWXlJTDcvUW9PV2RVUE9jdkRXeDNJUnA0MS92eGhN?=
 =?utf-8?B?VVQ2N3NTazJQbUFPYTlUajMwRWRHSFlZL09BemZ6WW5zRnJRazRNSzY4VU5U?=
 =?utf-8?B?RFJ2eVJ0a09MVzJ1TkNMNlIvMlh6M1FBMTkwUzE4UlZWUE5qSXY3M3lhTTZ5?=
 =?utf-8?B?TXVORDJEeVZFd0tqTE5kL0xWVU5Ma0dyWEI0MzNMeU8zUkt1UzBzMU93NXZs?=
 =?utf-8?B?S3AzVEVVdG5GcnJKV1Z0QkxEbkpjeC8xbXd3dHNFQ05lZkZLWCtlR3UzRTh3?=
 =?utf-8?B?SnlNM1p0NDcxSGhiVDhlRllkY2ZPWXBxUkxvVFRBNnk0b0dpbEZHakRMcXdN?=
 =?utf-8?B?VFA5QVpZMStxUkxkQmZtUGxmam9yL2FLZ3RJWGNncHdDNldBdzIzejAwRHhY?=
 =?utf-8?B?ZU4zTk9tNUp4bFBBTzlTc01hUDdPTGgyVUQwdVM1SW03WE5WaEtkL0J5bnVL?=
 =?utf-8?B?UmVsYm1DUkJES3ZoTTNLQW5oZE1JdHV0andmRGdNRDNFTXlTZnFkcWtxMmIx?=
 =?utf-8?B?NXF3TEVTU0dBamtSanpnNmxHM2lFeVJ2VGxOQWltdTZsUVRoQVkvUml1d2Y5?=
 =?utf-8?B?K3I0S3ZxV0ZWZWNqWDdWblk3ek5hSE1rZEdFSS85eDAvSjlUaEQvckcrMjVw?=
 =?utf-8?B?RytscTgvcm9FMndTQkxLRERuVHNFWXFDbUhwYUhmQ1NPdFZpdnNMbllJVFFt?=
 =?utf-8?B?VjdleHFTNmQxUnJpWnRJUWlaa0hKU3p0TFhaNzZpWDlBRGxkQjJkRVp0Vmdm?=
 =?utf-8?B?dXB0MGdkWnhUZTFTRjJkR0wxVzAxUmp6aEV5SkxwcEUwTmRySWVnNUtqckVL?=
 =?utf-8?B?WFhoMzRsaVJKUnYrQ2VSRDJqZDMyZjg2SnRURUdtdjkzVGVkQVBaN3F2SElU?=
 =?utf-8?B?TlIxelZpTjJZdlQvWUphNnhXTkxGK0IyL1ZiRVA4c3c3b1hvVGhuSUZ0cU1I?=
 =?utf-8?B?MXpvNHZwQmxmUHQ4WkMybDRFQnYvOXh5Tmc5RlpjdkRMUXlyZUVKLzBHdzgw?=
 =?utf-8?B?cU8xVGl5SnRTU1ozMytWeU8wek1lSDBzT3hjdkZhTHJONTFJVWt4aTMzaUto?=
 =?utf-8?B?c3NrQXU1d3lsMS8vdFhYMEkwYzVWeGNDYmtVSzZwQ0F2Tlp2TytYajdXRm1s?=
 =?utf-8?B?em9MVzZyR0dUZHMzOW8yc2QzZEpNWklvd2pWUnVyYTFLTHlUbmVqWjNEbmp1?=
 =?utf-8?B?UFRuRTlvOFgxb0J5b09QU3l3QUNlQnZiSDhsOGdnWlIyWlJzVDY2eXdGNHFn?=
 =?utf-8?B?Y2htbmg5MFE2aDZWbjNGa3ZTZm54QWZZUWk3cnE1eUZ1cHRtQ2ZIZUpuTUhS?=
 =?utf-8?B?MTE3UnpINkIvZGVWdHNIb0Ywd3ZpSHJMYUVwNHpjUTcvTUlrN2JZWHZSN0hS?=
 =?utf-8?B?dkp0Z2RVRmFlR0wyQkxyTTR6Q0ppSE9OTFN2UFFpbkZ1bjFmb2RGbCs5VHVj?=
 =?utf-8?B?dnA5Sjl0czdDc0pBK0xjdHBGd0VmZkcyaGFVcjN4bHo3dUVhdXZYdkNNRXBY?=
 =?utf-8?B?cEpDUmJVeHdMZWh2N25MSHA2ZjVIR3duN1RNbHNyWjJXTm9SYjkzTkh1L0Q0?=
 =?utf-8?B?YTU1SDR6QUVSTUExVFRrN0xoSDBEQWtsTVo2REV0K3dNUXVHSVZqWkJPSTBG?=
 =?utf-8?B?eHNVTnFKbk5sWlFkMzJCN3AvVWk2Sk42MWRsNkJyUC9rdWc1Tk1lQ3NtQmdU?=
 =?utf-8?Q?By3I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEtyM1RQZzdITkhZVVdWNEtkSTFVOEFjekNPb2VmRUZTWTVEbkRtd0ZUMGZY?=
 =?utf-8?B?a2QveUFmTmJHb2puWFdOenQwTFo4TEllbGRPZHNIZ3RkeVlJMEFsa25jR1ln?=
 =?utf-8?B?U21reGRmNWxTODE4bGlpK1hSeS90Y2NpditzM2VqME9hMHUxam0rM2lEem4x?=
 =?utf-8?B?ZUlaNlpMRUI5cDlWYitvTHZQUFdsWWt5QmxSaDlaWXJqTGM4Q2lhWDl1N0NB?=
 =?utf-8?B?LzlHa2VtRzQ2cSs5Ujd6UmRFREZncSt6Vjk4eEFLWDNSV3cwMjV2cXQxUjZx?=
 =?utf-8?B?dFc0L2pldlhKUHJta1BSaGtXc3ZiSzhlZ0JpZkk1YlNGTU5pUGFpM1pDeVMw?=
 =?utf-8?B?MnFzeFdZMVZvSkgzTDBGZ0pmKy9hcUpRUE1zWVhzRTJHNVduQmtqWVU4NTdm?=
 =?utf-8?B?bkNVKzdPNlJ5cExDdFpsZGNIL2ZIcFpqUE9zVzIweHlYZmdWWEtoOFdKM09R?=
 =?utf-8?B?MEZ1RXdNc29EMnJsUHZlS0ZZM0FwWldIWVg2VXNQVllTNnB3aVArVHhyeEYw?=
 =?utf-8?B?WStxRzR6b0hGMzl5TEs5SUhpNDJPSzllQWprZmhGKy8yZ0ZOQU5kN1dLQ1g1?=
 =?utf-8?B?aGtPd0xVak50aUtrQ0g5SUZDa1pNdG1tTHFpQ0xYekhXNFVMQjBoakxyVlIr?=
 =?utf-8?B?ckRJRjIyc1hYbGJhWS9nZGllVzIrSlMrMHRnZGluaEdUNUNiOUU1c1JKRmVP?=
 =?utf-8?B?OUhCSGs5VENjSStjb040emEvK1IzRExhQXNYblRSalNFZTJMaWlRa0NSMnY2?=
 =?utf-8?B?NjRma050b3ZQN3BFRHVuVE5zWmZmWVErZG1XZ3ZNY0JVbDR4L1ExMnFrTjYx?=
 =?utf-8?B?VlRyMjZLaTdTK0FVUW9Yc2R6cGZjTWFpamZPaGthdDErYk5pY2pyY3YwNnRR?=
 =?utf-8?B?dERPQVdEaUFuWWF3bXprZW9xUTd3VWRyRjQxRVlYNnFhVTJGTjZlVDZyUXlt?=
 =?utf-8?B?SzQ1d1FMek8wY1dSUm5QU2F6aTNLTEk2LzJFK1RObXNhS3h6dG9TSDMzdlNl?=
 =?utf-8?B?eEw3Z1BkcHNKZUkwWm11M0JnOGdheGlKSVB6Wi9uOUtJSXQ1bG9zT3ZFOUtM?=
 =?utf-8?B?VmxSR0ZZWUdEazI1cERrQkhxdkJrUGJ0cC9UVmo2Y1BWVWFHMEszMHZkQkt4?=
 =?utf-8?B?L3lRY25zVk5OeTZNZDViRklJc3BxcWFCbVh6SzBCYlVWUWpDRFEvakw3NkxV?=
 =?utf-8?B?WkNqSEIvQXUxb2ZrYWZQdkhFV1JISjFDOXNsc2VzOFdZcGdIYTNkM2JLL3pY?=
 =?utf-8?B?WGd6ZjYydHR5WGZKc2N3c0dObndocnhoRFFvV1NFdnIvZTBmNU92T2dxcFBN?=
 =?utf-8?B?c1oyZWZuRGgrS0c0RzFGWmhmMURjSWl4Z284aTUyR01RdTVHUURKbEQvZjkx?=
 =?utf-8?B?ckUvWmNabmd0TTFKRU1Vd0l0VDlzWDE5YW5iUmVPUzl4V0pkTG5raUNqWTZW?=
 =?utf-8?B?RVhvM0hUeDhLeUpzL01Hak1IK3RNaVRrampubGo0empTNEI3QXoxaE1vcVFq?=
 =?utf-8?B?ZVVSbyt2eW93K2kzVWRNVlFPaFdzcEZCWE5qQloxSzBmR1hOeUtmbXU3a0Ew?=
 =?utf-8?B?TTdUb1Z6MWRIc3lIV3UzSnZEWnRJa3Zyb0FkQjRyUUtqall0ZFlHUksyeGFK?=
 =?utf-8?B?T3R6bE9mQkc1K0g1d3JMZWlCZ3JvWUNuczRhWDlwOHVBdFBYaWxGTTJnT0NM?=
 =?utf-8?B?QVhJWWY0a0NpOXJOUkF2cXF5cEprN292Vm5OQzh6TzQ3VDN2eE96WWpmSzFH?=
 =?utf-8?B?ZkFDeDcyRGtaMW5EMXZoMWZ2RlZmN1pBODU2T24rU3AxbThaTG5PMStySUxG?=
 =?utf-8?B?QXRvbHNCay9VbmVETjJVeVpLa0IrUXhDUnQ2RExsWXNjVW1nTWVHbmJDZHEx?=
 =?utf-8?B?Q2tQZkhjUXBOSktQb1VRTGRqdVMxSmhKUUNyakNIWEl4WXhlOGhsUFVoMEpR?=
 =?utf-8?B?c1F2bG5xZkVzY0M4UjREaGFBeWp3L3c5ZW9WN0c1dWY0T3dLbkxkNUF0WVEw?=
 =?utf-8?B?LzcvSjdJOTNhNTYyVUZDWUgzenFyb1cvWEsyM3VGUUdaU1ZObFNVZGduTXg3?=
 =?utf-8?B?Rmo4WlRKRXpCWmZKRy9MYSs0RFZ1SVNNSktiTWhQMjZyYmsyR1VzTmVmbmIw?=
 =?utf-8?B?b1IzSmhOUE5WbnNYbER4dFhGdDZXbWNPeTdzaGlKTFhVYVIyOFhEWnkyNnJX?=
 =?utf-8?B?a3pWVmtqV0N5VjZXbWxvNGYwZUJ3cGNSRTZzQVhXWEN5eVRkK3lXQkJZekdo?=
 =?utf-8?B?ak1waXBUYTdoMUtqZlAxZk5QNkljUmNkcHArUVV2Z2tNa3BTMzladWo3cjBi?=
 =?utf-8?B?bjNVelptVXdsanNKWkJBVFR1K05abU44cFNFeHEvVFhwNXErYTZDNWhQUllE?=
 =?utf-8?Q?9OidCD/3BlBfNILJqot43bFlFJK4lCvU1983B?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be8394d5-f67d-40fd-27ce-08de5dc9bece
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:30:20.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mo/a9JHCvIqFE+UGDMG86KjFc3hD1cn7FNTBUxpURWy4ECiGSrKIskzYV9j0mYJdTnKc5d/7OLFkRXHhbtgZCVlCdIFFMXE7M2+CeLYhc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 17:30:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3118

Hi,

Just a heads up that the tensorflow (I tried -lite) recipe(s) doesn't 
build since OE-Core moved to Python 3.14.

There seems to be *some* support upstream (and plenty of people 
complaining there is no release with support for 3.14 yet) but it's 
still missing a requirements_lock_3_14.txt file which is the first thing 
that the recipe complains about.

Cheers,
Quentin

