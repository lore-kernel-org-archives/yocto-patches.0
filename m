Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB18C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 13:02:52 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.121])
 by mx.groups.io with SMTP id smtpd.web10.13832.1717678969108905320
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Jun 2024 06:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=aHvOQTpa;
 spf=pass (domain: cherry.de, ip: 40.107.8.121, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CifKfxbxkshjvmfF7U/dSdquYVm3EeGkP0/7XF5Zb6Sehg5Llbkym9amptEefU6vllcWGwrheeG/EMfVAaRLaI1VsxtlZlv53TFiKgi6MzP0srYhU+UZCfz/BpsV6mIjbIjtudEQqBWK4/QpgA7UvUhJNuocwDD22FRgPdBzEZLXfcvyA6Fy5m0fhPFiYxSL02I4iymWmvtkLvsldnynZd3saUYP0cdqnnqLd5kyCACEEdeUAUAcVCRxyiUeN/rM1uqzjEaFxTgILiEFSN/zHgxixuMeUd7koD+GBtqvgw39Leuh52N+1BVEDJzbVMSfemzd079J+ELZWcXlH25Dyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4S2LllybOqyjUNFqRwwUzDVCe80BOp6CnffG2PCA7s=;
 b=FxtAUvRBAZv419nOBEjMakrdR/w8vxNbK7PZJ5WGe/EaTQB2ASQdiPi88OjIfdITvjy1ATbwTYC89eB7Pr0SRka/3dJ4wqWGC8lxgskhTvCDabo1whRkrhzHf0u2u9ZnTvsvnEyt1MK6P45G5MWK/rA5xpuStfqSUpxhSs27ANm0ju/zVefAiXGJ1vOKedXMyfk8KKtCNX04QGhQJqlfOMzeasQ/CHrMPX7dsn9zTiZLQ5mo1U1GSOhMNciDBZjXGu4rlOmFED1wpRBDxPInpc6TSb0ZwW/BiOrBIVmgs7QcTrg8irFQ0tueqWUo5OMEs+NJhyNWTKfapsAUFuzsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4S2LllybOqyjUNFqRwwUzDVCe80BOp6CnffG2PCA7s=;
 b=aHvOQTpa77D/Ow/WBumwnZM7imzSoSXrs1O0ilZtRWTbTg9pz3QNXP/4JAVgT7/E35D6h1sX53wpGLb/0I7unW+sTq/uzqQmJmPX5pQnghvyXt5pN3XA01ukr8bl69XTyVb1xinO6dS8uDO9GdUfA8O17mEcI1wHNACbe4Tr3tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM7PR04MB7063.eurprd04.prod.outlook.com (2603:10a6:20b:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 13:02:44 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:02:44 +0000
Message-ID: <0759df07-2e28-45fb-a838-10763309a463@cherry.de>
Date: Thu, 6 Jun 2024 15:02:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip master scarthgap v3 00/16]
 various reworks around u-boot and rkbin + fixes for MACHINEOVERRIDES
To: Trevor Woerner <twoerner@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
 <20240605172312.GA11530@localhost>
 <8835bd6d-80a5-43d1-93be-ec5d1cfc477d@cherry.de>
 <20240606114959.GA30114@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240606114959.GA30114@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM7PR04MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 190996f2-1276-46b7-6640-08dc8628f4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L0ZGcmp6c3loL2p5aU9RSjRtQVZkcDJGVTRzaUF6SFo3clA2OEhTTUlMWVhk?=
 =?utf-8?B?dnpGeHAxM0pQaWhuNi9DeUI1NC9ONm1LVXRqVm9jeTJWd1c1TlB4NG9vTHcz?=
 =?utf-8?B?SWttZEw4QlQ3Sk12R2VJOWRlbUdxRjgyYkUwdXlpNnplSXpmMlYycG4zbkU3?=
 =?utf-8?B?M2t6WDB4QUJIKzBrQ0s0RlhHS21WYkhOcXJoa1hCd1lYd082QXpWM1crbDhj?=
 =?utf-8?B?aXhUZVRROHhOQ3Bza3FLUDBOZHZ1S1JPdElJcjhiTVo0MUw1S2hGS3VDcnRa?=
 =?utf-8?B?VnIrRSs3R2V6bW90MTlFU0Y0L28vb3IrQXpCWE1GSEhSdUNrUlhuSTVreGV0?=
 =?utf-8?B?NDBiNVp3YjZHbmdIbXdFdmdscU5OTHM5ZUcrNmlpa2crQnZBUzJ1OVNkMGk1?=
 =?utf-8?B?aVZHNFFBVDVKOXJ4Si9NNTNVLzdLRWRVZEhXQit1VzVKRzJIaTVMbjZuRG53?=
 =?utf-8?B?WjNKRmZGSVJJMitSZURaak9wZldER0hGbStCM1JPNS9zYVdMK09FUklUTTQr?=
 =?utf-8?B?TEM1V2phTG1uTzdBVXJjTFdmT1VoaUQzcjRRcDVGeWpxUk9xWmZyUEZXK1Av?=
 =?utf-8?B?TzVMM0I3Rks3aFhISGhLWkpzL1BPeUNZdmtoMVZmbXZ2Z1NCOE11M0dCRWtI?=
 =?utf-8?B?VkRKa3hEejVtcWFROHYzRFJzL0NFNkZUVFVWK3JlNGFXZllMUjZBdkpJL3ls?=
 =?utf-8?B?R3BGV2hnR2V1TnQ3dGZESUlZNHova0ZXd3BkVVVoWmoyajY1QVdLUm1WeHVB?=
 =?utf-8?B?N3k1d1Urb2ttSEpkczlmZENjT3NkN2k1ZVBVcUcrVlJPd0ZOZEpUZjJQN041?=
 =?utf-8?B?N0NNOWJ3VDRPMUlQN3hKeUVEMGFBVmE1RjgyK0FJU1FXdXBYRlQzSGtQem5m?=
 =?utf-8?B?N1hXWkV1OVRmZEtzMmpBMm42c0NlMnlOcGUxejlNS0l4dWlGdExlaXhFWHF4?=
 =?utf-8?B?MDJWMjhjSXR4eGRnYWNFVzVWd2UvVHU2OG5wK1dpdngxM2xXWnNMWlV2bExl?=
 =?utf-8?B?WXZVbzIrUklTNG9pWHJDVzYxazIwVzg5SDN0a2l1Y0FSRUIyS2lrbkJWVTZ1?=
 =?utf-8?B?ZUJUQnllOXNka1JkM0hsaThBL040Ri9ScWg5ZWRtSnhuOVhyVTJOQmFhdWli?=
 =?utf-8?B?UE5xZjYwblRiaFEvbFczQjd3MGE4MTVlL09vOWFmeThmajdsMFpUbVZ5YUpM?=
 =?utf-8?B?N0pkWUlVMzhPNEFKUGtqaGszalJDT3ZGT1d3Z0ZNcHR4RGQ2ZnJkVTlJOVow?=
 =?utf-8?B?M1JBVHJUNkNDMUYxc0RLc0RJdmFGcGdJdUVCcDFkMVEvcFlla1U5ZUVYUmNn?=
 =?utf-8?B?eGt3R0ptekNGSjRKamptUXNqZDc4V05qYmFGSGdrNG43ZmxBNS9YMXlsV0Mz?=
 =?utf-8?B?V2gxSFpvTDYyMmxpY3Y0WGtUb0J3WUpFVW1vVmkzV3ZJTWlmVkVSbFR1WnlJ?=
 =?utf-8?B?K1VySXYxZFYvNWxVOEJyNk9IVDBaY080UUR2eGhZR3NBSytyb09ZRVQrbFdF?=
 =?utf-8?B?OXU1VityNXFaUWpqcW1qQnpzTWp4eU9YVnRUSzdmMGVLY3BCT25GMVcyYW9P?=
 =?utf-8?B?MnNyN2JaL2dvZU5zc1Yzby80dk5SeGN1M0N2UW9WTzEzRUsvSTNZa0RzQmZG?=
 =?utf-8?B?Qm9UREt3ZHFFSTlYckhGbzAzeUh0Ty9aamZNSEVYQnV3UVpUZGl3NGJkRGl3?=
 =?utf-8?Q?L6h5jiLLuZaxWHoU9M3o?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHM5WFdub05kUVcraEMzMHdNNFZBOXFrUjdHaHAvb0FqNGhJbThrRUltN1Np?=
 =?utf-8?B?Wk53KzVHelVZUVp6VVN3bUhZVWFuNWNpTEwzRTJML1ZNdERDVVdhNHBXellW?=
 =?utf-8?B?d2pQdkNqallTemZZQlN2MU1nKy9HWUQ0cmVtakdhZFRhMzFYdmhHNE1SYm9o?=
 =?utf-8?B?Tk5GZVE3b2VROExNL0VDL2dZSm9RdmFwUGpLZDhYWTduWURvWXlMUytYelcr?=
 =?utf-8?B?b2dlNDg5SXg4RTFaRzdCb3RZMkhMQ2JXcWhXUWRFdjJlZGh0OHUzRnpUS1FU?=
 =?utf-8?B?bDN5bUhaZFcyRzZ0aXl2VkFOYXJ5TU13VElBWTlnRFBCYW9raHlabm5yUHhG?=
 =?utf-8?B?MDZxbGtPZU5JSmZxY05xSWhQdjBGN3gwUnlVL0I0QnpJaU1SalpCVncrbzB1?=
 =?utf-8?B?MWxjeDJDT010TnFTWDVsSSt6ZzNxaXZQT1h0L1dESXFqT29mQ1puSmR6SERP?=
 =?utf-8?B?UjZ5ZUJhdEgzUXRVQUpNV1Y2bit3MjZndTlSbGVubE11aHA0OFM4REtnTkls?=
 =?utf-8?B?M0EyYlNLaTVVbmVPeXpLeUJ3TWhoTzVpKy8xa2dLSVFYWVkwVm9XdCtkckZT?=
 =?utf-8?B?Y2hFWHZLTFB0LzN0aHZiSWxqUktvS3l3ZTVBMW5LeWx3TUFsMnI2ckJYaEcr?=
 =?utf-8?B?T2pkZm9WV0xmOUhkejZUNFgvWURndHdvYjZpcCswYlFVTFN0WDlrREFuOXBl?=
 =?utf-8?B?dmkrcWRiVU93a0hMMUowL2NqNG5WdHZOSk5uNDVualc4WlJmdnVOWE1tOWE5?=
 =?utf-8?B?dW5tV1VoZ0xqeUJvU2h3OUY4WVkvOEM4cFdMa1l4M1NUUTMxTjdrQTBXYSs0?=
 =?utf-8?B?WkcvOS9hVGVzZGVGS2RqQzhCYnFuQ3AyMElJQlFWOWtjcVVLSy9MbTRnRUk2?=
 =?utf-8?B?anRhRFZudXM5TXZiYkVvRlJFbFhwY3NRRkNoTmZyamtRRDdtT0xibUl0RDNh?=
 =?utf-8?B?MnowM1o1RUFLTlc0TEtYMUVyVmI2RHdnS09oa3lXWVFpc08rR3lwRHNvTzR1?=
 =?utf-8?B?VklPRlBBeVUwUnpVL2pXTWxGVFNUZGxFOWFoamlEbEdYNWtSektLQU1tOHFx?=
 =?utf-8?B?bkdnOEp1dGJtc2djTjhXUm85Q2hJaFY5UTlCaEVKb3F1Qk5mZXdqY1l1a05m?=
 =?utf-8?B?MjgzLzVLYjluSUgvV3g3SVNUL2lYMFV1Y3lVd2puWUplYUE2RjhjcHZSQUdj?=
 =?utf-8?B?dlBpL2RqdTZHcURLUk5nUm1yUnVMMTFiZ3RSbU1LNXlmUzdPU2tpOG82akt6?=
 =?utf-8?B?ZUpuMmdxdnBXUi9zclM0Yi9HMG4yMjdtSi9jVmMxQ2JQYTdlSHVGWllQU1M0?=
 =?utf-8?B?VUdVdXdxMWdSRCs1akJzKzl2c25pVEpzSDNqeUh5aE52OEl6dWpXWjRxYTZL?=
 =?utf-8?B?cjNkTURoS25IaWNpaWVGVWZNT2J1dGhlT01nUmRSS0RyajRrZU1aZEFmWkFU?=
 =?utf-8?B?OGcrUTVaMi9JYnpiRGJkbzJ6WUd0cm5Ia0xqaDNJSitYd2pDOVJiZ0QyV2d4?=
 =?utf-8?B?VGhQK2FmenJueGoxQ01WTklLRGZCNFRZWVg0ZGlGTjdJWUJpZ0lRZCtGMUhG?=
 =?utf-8?B?SE9zdENCZDc2U3dYdWM3RGFxdlVSUWZjWlRFamNzbGRicmpaQUJFczd5dW13?=
 =?utf-8?B?L2VHaGV5emgwN2dtMEgrQVBpdDZHVzZsZSsyZDNBMUxEWCszelUydmthazFa?=
 =?utf-8?B?cDhiMnZLZFNlNnR1ZmMrb0hBbXBWSjJzSVpUb1dscHJCaU4vNG93L3FRUzdl?=
 =?utf-8?B?MG1WYUFNbHQ0MFhNeUI4TGtzTGd2OWxrQVNxd0ZGT3IrV2FRdTd5MlVwa2hi?=
 =?utf-8?B?QnViNTVTUTVWMmMwQWpnZENPU3lhM0QxbnlBS2tDM3M2ZGVyblpWZXN1dVNx?=
 =?utf-8?B?OFFNVEErQ0dWTzlPaHJYeExBbVNqMEo3UFdubVNMRU1UOGFWaDNseXdUdk93?=
 =?utf-8?B?L3VyajFlTEdYbzJ6enNNaHUvVW93cXVvc2o4U3JGOVlLd24yTDB6am1SN0FY?=
 =?utf-8?B?QituamwzcXZqaitFeHZHM1pld2xXSHRVN3RHZGVEekpoaWNId21JUHRoYkhr?=
 =?utf-8?B?bFM5TWVkODhNK1ZwNlZIK2kxTEJ5M0dmZW5LQU9HdTU3eE0rVm5CNTFNZHVp?=
 =?utf-8?B?dEhMNWoybmZWbXJQQjljUFhJUUJlekMvSVJiYWdpSGM0WGRCSUJ5RFRsN1Nv?=
 =?utf-8?Q?n/3lx6I89jpjHuT/bYn0TH8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 190996f2-1276-46b7-6640-08dc8628f4d0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:02:44.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fskUCP5SyCY8mF1ClQG0SU1MO0rnhf7cGt01awG2alXZ2R+LEBGdluMf8L13TJCXublLOAObiwskSLJg6r4GZMaQQV9iPoIeARnwLVQoeX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7063
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 13:02:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/281

Hi Trevor,

On 6/6/24 1:49 PM, Trevor Woerner wrote:
> On Thu 2024-06-06 @ 10:17:17 AM, Quentin Schulz wrote:
>> Hi Trevor,
>>
>> On 6/5/24 7:23 PM, Trevor Woerner wrote:
>>> On Fri 2024-05-31 @ 11:25:07 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>> This does a few reworks of how we handle TF-A and DDR bin blob
>>>> dependencies, hopefully in a way that makes it much easier to add
>>>> support for new SoCs without having to touch too many files.
>>>>
>>>> While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.
>>>>
>>>> Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
>>>> rk3308-rkbin instead of rockchip-rkbin.
>>>>
>>>> Finally, fix a few MACHINEOVERRIDES ordering issues.
>>>
>>> Here are the new MACHINEOVERRIDES (with these patches applied) for all the
>>> MACHINEs we support (with rk-u-boot-env enabled):
>>>
>>> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:firefly-rk3288:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="armv7a:rockchip:rk3066:marsboard-rk3066"
>>> 	MACHINEOVERRIDES="armv7a:rockchip:rk3188:radxarock"
>>> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:rock2-square"
>>> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board-s:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:vyasa-rk3288:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4-2gb:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4b:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:nanopi-r2s:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-r4s:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:orangepi-5-plus:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:roc-rk3308-cc:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:roc-rk3328-cc:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3568:rock-3a:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-4c-plus:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rock-5a:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:rock-5b:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4a:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4b:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4c:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock-pi-e:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:rock-pi-s:rk-u-boot-env"
>>> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock64:rk-u-boot-env"
>>>
>>> For uniformity, would it be nicer to have all MACHINEs include the SoC
>>> OVERRIDE?
>>>
>>
>> I'm not sure to follow here
> 
> Sorry, what I mean is the "cortexa72-cortexa53" parts, which I guess is the
> CPU? I don't know that I've seen those overrides being used often, but I would
> rather either see all of them have this override, or none of them, as part of
> any MACHINEOVERRIDE cleaning patches.

Ahah, this isn't something to fix in meta-rockchip (or as a temporary 
work-around if you prefer, or for non-master branches) but rather in 
openembedded-core :)

c.f. 
https://git.openembedded.org/openembedded-core/tree/meta/conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc#n7 
for RK3588(s).

I assume we need to add the same to other Arm conf include files?

For the Aarch32 ones, the Cortex-A17 and Cortex-A9 already have this but 
not setting cortex-a17/a9 in it but rather armv7ve/armv7a.

For Aarch64 ones, all that use a big.LITTLE architecture have it set, 
but not the other, maybe something we could add then?

Cheers,
Quentin

