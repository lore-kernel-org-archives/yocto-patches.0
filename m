Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7AFD6ACE9
	for <webhook@archiver.kernel.org>; Wed, 27 Nov 2024 15:25:40 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.68])
 by mx.groups.io with SMTP id smtpd.web11.74248.1732721139219696722
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 Nov 2024 07:25:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=G/XdBOmd;
 spf=pass (domain: cherry.de, ip: 40.107.103.68, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGKGQOgxGMArq8Eq8L8NcEfxzGlvc+bvcjpqs2br+3tuOAzzWTIB59BTtcGNkoREzvKO4zayPdY9a6ksbG3mtNV3tM19bAbdsISRrfs6Jrv35U3IBlPthi9i3s+UU3rNc1fRJMt25hNByvqO80rjIjToM2z9kDNzU6QVc4NIIqbVioGJl+2NZ/1t4pZdGVHf69ZG5uw/SX6xyPA2ye4r88ZeE4N6IAP2kaxhs/pZq54k+o2zUHOX0fdKCSqZcesa9it+X2QihnNKgSXsGjsq6OyI/7qWXw18M3M1mVHzzzIVx6DnB3EDbVZBqN+XqfnHqM4a6iTlVY3JoZSlnaXNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvHhho5sZEGFqLmFP8t7cpK8aZPhM2Y4wZPqmfP05Ck=;
 b=FLtDLU50zb2AF2BvN5c6RlpdCT+mcT1uIyDesWtf4Zx1XNZeiIy9n9N7lzGy8NAn0Ra59C8/k8rYutYwZrLfty2GcVu/4t3pandbhbJLBwpBD4GFaLHy+ObwMuOXpg06NRzuEmymSBfq/H5HTnzaE/cTE6B66y9wpyr1pigi/Dcqv9LDIqTfRyHg/Rjm/une29mVE59qJw890FuU0cNEtDvNKn6uRNfKeyEJNaT36HXpqpZQCy7LRjaMqkEekNL3RW+HowvUQlVyAeazoPmcTqIetT9G420QpIEa7NA2Zo1txJC/XrbOW9wD6n9KsxJNnjn4sS461i+QgbhyA8JFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvHhho5sZEGFqLmFP8t7cpK8aZPhM2Y4wZPqmfP05Ck=;
 b=G/XdBOmdOzsfXO667Nz/7lJyBdUHqCZEKIx6PMRz3ZuXqcNPCUVarkSFLbNK5vI0u5H494WG9Sv74bTREX1vuyLu1UEb1pR7HSDe8SOoXhl/7jwytmeC4JYWtUHQeH+g2R/QM4+wPffMlO+mR2tbHRVhGlzGtUxbAAJ4P6dwteE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10364.eurprd04.prod.outlook.com (2603:10a6:10:560::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 15:25:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 15:25:34 +0000
Message-ID: <74336a5e-5343-4141-a67a-dc22c55f9a5f@cherry.de>
Date: Wed, 27 Nov 2024 16:25:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/2] bsp: rkbin: bump to latest commit in
 master
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10364:EE_
X-MS-Office365-Filtering-Correlation-Id: 237be56d-4458-4154-0a0f-08dd0ef7bcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c3FXcnFjTE5nWlRaTllXNFVnekI5SGN5c29mRGVKVnE3MVMwS2tvL3dYdkxq?=
 =?utf-8?B?N3ZCVVUwVk12bDZUalFBSmFud2VjS0l3UHZNb1d1S2VTdTBKZ1djUTk1VHVi?=
 =?utf-8?B?c3hFbXFYcFl6c0szWlN0MTl6OS84N2pDY1hWbnFobFlwWDdKYXJwSWlxeHlx?=
 =?utf-8?B?TmR1WksyN2dVeHBrTVd0MW5EU0RYSnBNR0tWZng1TDdwSDFRdy9sZkhWdk1M?=
 =?utf-8?B?L0FUc09ldlNWeXpKQy9sN2IySHhGOFFBZCtzSFpmVTVJVkU5ekovUUozaDR0?=
 =?utf-8?B?OFFKV2RFUmR3SFU1MXA5VEx6b0NHREZGWTJ3OGJack1pZWdjWUxOWGpIM0Vh?=
 =?utf-8?B?Y283dTlxSjRMaklldXgzemRCcVE2NEk2UTBoNGZUR29rN21ST1lFZzV5S3BB?=
 =?utf-8?B?VUFWcXpydXl1NHdyVFM4ZlBMSUJwa2ZzVFR3S3J5UnpyNHQxaWw0ODNIOGZC?=
 =?utf-8?B?dlUzZUp4RUNqRWMzS05kM2ZRazdHRlZxWEVrdnFRcE5zSzd4aCtJMlRiUFdS?=
 =?utf-8?B?d3hXS1c2TmlZK1JKU0l1UlZYakhTYkZzZWw2dzVJaFl0elRqYStVTFB6bEtT?=
 =?utf-8?B?VjZoa2E0cklpWm54czJPREhJV2YxTXVoM3U3aW1DdnRnRWxoaDB3cXl0WWpS?=
 =?utf-8?B?MXI1eU1NY1N6eVl4OU1obGhxOGErWnlDUmhJSTRtVGpXRW9zdkF5Uy9BSVZ5?=
 =?utf-8?B?ZDJKUmlJcVdIdEhKWTB5dFNhZG9vU1hOdnpSSFFaWXNsZ1RWMTBnUEloWVBT?=
 =?utf-8?B?dDRPTGhGaWlOcHY1Wi9nbmhJK3QzT3hxWUFZMTJsbE8zaWRvWHpUMnhib29t?=
 =?utf-8?B?ZGhFSWp1NWhlU1UvaE9xbjRsMXFmOEc3L1dkNkZhVWRSd1VCNWE5NitUZ3Ja?=
 =?utf-8?B?NkJINnZVWHZaNHREQVQ0dnY4c2M0QmZVWXNhbHRKOWpralVBOWZUcElBRmZD?=
 =?utf-8?B?UldTOGZRM25GZlVCWGYzbVlWQW10V0FuU0REdGtJUHl5NkZpK3YyMi9DSVI5?=
 =?utf-8?B?MVJEM29FSDlrSjVXT0Z2VVFLRHIxcS81d2VJQmtUaE1VMEhobDZyR1g2VGl5?=
 =?utf-8?B?SEFvMDFKTm5iTmhRL3U2SFNOUEc5MmtLTlVIbE1tK0ZnKzVPbkRhQkZiSjhk?=
 =?utf-8?B?M0JPUWVFOXZnbTM4b2Yvd2J2QndVRTZWYVNOaFpubDhpT3pSakl5RGxJWEM0?=
 =?utf-8?B?cGtOZG9YVmFOaUdzRWpTdTAxUkhIYTM1UFdBOGxtL1Z4dk9BNDNPT1VEMzBt?=
 =?utf-8?B?ZGFTN3JFbFhZY1JPVWs0bCtmMmpVTzcrSkxwMUlweS9DQ3N6a0M2ZVlyN1VY?=
 =?utf-8?B?M2pzaHc3NDVrYkwrLzZ4UUxEMTR1NlIzYkNOQkN1TW9oMGt3NVRqdk5nOXRW?=
 =?utf-8?B?QkhjTyt5aktORS9VVXppdmtrRjVZUlBQZlpuWlZ0anpzZk9SanR0K2xpaDRz?=
 =?utf-8?B?WDJlcHBudjRrQ3BJMTZKQnBDMVZXZE02MGFkVERvUE92bHZpMmFrS0xVRzgw?=
 =?utf-8?B?TkxpQTJUaW9PcW52bER0Mk5McGNKNlFWbmZWR1VoRUhlZE9JU2tQNGJsbFRk?=
 =?utf-8?B?Qy9tME9xSnNwbFBta2dGNm4xUzAzb2Z5dHdKRXlBTE5vcEt6aC9LMHlONmxs?=
 =?utf-8?B?dHlyUHRjeVh4WkJzdW0vaUNpMlpodlFHYll4MUlOeit5TnVkQ1NoU1FXSDZU?=
 =?utf-8?B?S0JMM0wzYmJwYS9acXpyLzlSQVJwWWF5YlVyUVhZaGFGblFCcS9LOGN6ZTVu?=
 =?utf-8?Q?OKpg+9nVl+/lxxbn8Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0toZTY3VjBqT2FBNVNNTE5waW53QTdWbXF5OTgwVlFrMnowc3A3MUtGdXhE?=
 =?utf-8?B?dkZBcjY5b1RCcXB5RkZEMVV5S0xtMlppVWJQamhnTjB2ckVNaVNHYnlqaU5l?=
 =?utf-8?B?S1J0cUlpd1pFUE1pc3RSUzhkOGJ4MDNERXc3dDdianVnbGZpdDl2eS8wb2xH?=
 =?utf-8?B?d052bE5laG81b3Jjd3J6Unh5T2VaeU5RVjllUTNjUGxhNzUvc3JwN2lSQytF?=
 =?utf-8?B?azloazh0SVRvdHdsU3F2UEphRFh6UTZPRVpWWjN5TmZlM1RKb0NveEcvcFN1?=
 =?utf-8?B?L0RGMVo1OXhRZklROFd5c2hud2RnNHl1OEdteHBsQU5uWU9JR2czbVZwZG94?=
 =?utf-8?B?eW1IS2hud2tqR3I0QnhCZldZMXVBNWEvMWN1STFtdXdKWVFidERBdmxzem1n?=
 =?utf-8?B?V2pOYTVnM2xNTXpQUGpZcUVRR0N4MmpEbHZyMlRuQ3lBUzkrQ05pODR5T1dY?=
 =?utf-8?B?ZXp1REEyUkNmZS9YZDdscFhyditaeFZhc2R6Rk5OcmduaXJlVTlmd0R0ajFH?=
 =?utf-8?B?TENqNzl4aEl1WlE1dUkvOUpyT3I3OFNJSEYwalMwR2QweWI0N2ZuV1M1bmU0?=
 =?utf-8?B?c0hyWDkrWElQWVdlVWNoK1prRE4yU1QxbjA4QjVKZVlMeFNiWElzQ3E0dy9H?=
 =?utf-8?B?am8wU2x2ZjdlTGdXaFJ3TUwyL2JhbWowMC9wMkdPYnZ3c1ZNQlRPLzJJZFFz?=
 =?utf-8?B?ZmZrVm5ma2RzK0I0WUU0WlhNSDR5NTZwWElhNHMwWFF2bVVEdDl6VWVIdG8v?=
 =?utf-8?B?TmVHaEo3anRmak9ybjdKK1dKSEQ5MjdsT3VmUUVvTkZ2T0ZyK3VOV0dydnBa?=
 =?utf-8?B?RHp6Z2ZKbEM0d0wwYVFBUkpNT1Y2QkpiV1FMVWFTNmtQVzErVWVBYUxHRVZT?=
 =?utf-8?B?bTRiK0NGUks5OUdubzVKemJFNlZzUWUvQmVJQWdwQ3l3OGYrWFk2bVFFZnh6?=
 =?utf-8?B?aktQZWQxa0NtQjc3T3l6S2hMOW1rZFBkdVFTWTdiS0NFYlhrR2NmSlo5Vm1v?=
 =?utf-8?B?TVNmM1BiSFJydjRDT1NEK0Q1UUxnWUQyWFpXTzA2VlN6ZlkwaHVKR0ZmNkpL?=
 =?utf-8?B?MThJNGgvelJWaHYxb3h5SGJRM2huVTZUczdEelFNZXFlc2pkUHRUcUZVaFRI?=
 =?utf-8?B?My9WL2tJZG5VM1c2Um8vcG9TL3VFSmRpcHhQUFhncy9MNFBFWXpmTzdpVjU0?=
 =?utf-8?B?aEdpS2YzdThoZlJRTnJUYnFBS3QzVFhvMzdyeXNQV0lUdFIwakY2RytYM2ZP?=
 =?utf-8?B?S2NER0hCV1oyVDRocXpXbTUwQm1QQ25yTVlxT09nVDR2KzBxK3I1ZUl6amZ0?=
 =?utf-8?B?ZzFBRUVWdlRmNmM4ckFadm9HaGgvVmluUWtWRlJ1Y3RPN2laVTd0Q2NOZE5P?=
 =?utf-8?B?M3V5RzBWTlpqam1PSy9vOXRqVEJPSzZMRldtcUkrdlptR2g1TlQzS1ltM1RE?=
 =?utf-8?B?c0FaS3NERkxRVUVONGpZaWZxdXMrbFdQNHZ1eUhEMy9UYjNOYTBqR3pmTXZH?=
 =?utf-8?B?ODZmWnQ4aFhaZjNqQzkrZjhnNVFUZXFCcTFIZEgyYXJXa3JoTXdnQk9hQmRJ?=
 =?utf-8?B?NWZBMk8vYVl0bUlaK084NFlQa1Zud1BIYlNvK2NmUG5EMmgxVWgyZnltZUMv?=
 =?utf-8?B?dU1TdktlWEVKNFJaUGpOR2NtNHEyWG1KTE9oVHZBV0U4L3hEN0xqYVpGZHEx?=
 =?utf-8?B?VmgzdVowVU5MT3VONFIxQUhDZ3QzTGh0ZFdYMG9aL3JTOXM0UW9Rb0F1ZjVL?=
 =?utf-8?B?RkVQNHBodXFNY2JFbGFzakpZSU01N0w5RnZPSDdaZEx4UjNNR0dsK1E0U09P?=
 =?utf-8?B?b3dNNTV2WDFXQnp0YzRRN2JyV0tTWG5oZHlseStJd2wyaDMrKzJXUG41Nnc1?=
 =?utf-8?B?bWNXanhKWjk4WXRLUlc2Szd6aGo1N2ZiMUE0VFNBZGZ0Q2E5NzMxS3UvM1N1?=
 =?utf-8?B?VmV6RURJWFA4TWczbTgvdGNrRngxcTNZamxNZHNQcVpBcnoyMEoyOG1DWU44?=
 =?utf-8?B?MXNjUFJINzhHcjVuREM5VU9peXZkUzRjMjVIaHRIT0NzUzVkUDk1TXhva2RH?=
 =?utf-8?B?UkUwOFp0SGY3UzhaTGVJN2taTnEydWJCV2ZTZ3NrRUkzVUlYaTViMXN5bHAz?=
 =?utf-8?B?Tjh6UGJKd3cxd0hhVlFMZ1VkTjhnWlhZRnM2TEFJRGdhb3QrN2VaR295bFFB?=
 =?utf-8?Q?vegxWU3c5wUJNpJrSw1Ns+A=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 237be56d-4458-4154-0a0f-08dd0ef7bcee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:25:34.7176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptqG1BVVo2fjbNSJvH9mNnpF3zns96eerab/IpYQpYi2S1rZQoO5dEl3J9e5K+mv9Zgdynr+C3B321cfPahxEZ8ExsV4nsK8cby/dnCnW7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10364
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 Nov 2024 15:25:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/847

Hi Trevor,

On 11/27/24 4:12 PM, Quentin Schulz wrote:
> We've been hit by a lot of random RCU stalls, system hangs or resets on
> some (not all) of our RK3588-based products running some old BL31/DDR
> init binaries.
> 
> Upgrading to latest commit in master branch seems to mitigate those
> issues, so let's do that.
> 
> Only build tested.
> 

Just for your information, I plan on backporting this to scarthgap once 
merged.

Will probably backport the file renamings as well except if you raise 
some objection about this?

https://git.yoctoproject.org/meta-rockchip/commit/?id=56ac8facb1e14a2c7c99aa7e4a606fdd11b70245
https://git.yoctoproject.org/meta-rockchip/commit/?id=e2d1876f028006eadaf672174b8d3072bbec48d1
https://git.yoctoproject.org/meta-rockchip/commit/?id=60354969f0c621f1dc775e7fcd2ad0f3fe8975f8

The downside is that we basically break compatibility between commits in 
scarthgap as people would need to rename their bbappends to match the 
new filenames. So not so nice.

Cheers,
Quentin

