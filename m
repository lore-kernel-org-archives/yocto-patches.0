Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48DBC369C2
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 10:17:33 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.41])
 by mx.groups.io with SMTP id smtpd.web10.15779.1744798644899215028
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Apr 2025 03:17:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=hzSrtiiL;
 spf=pass (domain: cherry.de, ip: 40.107.103.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJVODgMI5WbE6ld8t/XSSEJsgQZiZkPcR9Up5fLJ34sUULybhdOqbBUcYKBfP1ix0fFxWAp5kWvgLXR79iFfS4rRtfVqYr18dXqCw5/vrxn5aXHS8qGyuKefBgIiSd9XLST4I/jiBdEvdzFgzsEpRAD2p3P+QnjMvIy6VxAj4dQPRvneshUyQIeaX5UvvlTJ5u7uk9wqGfaSxRaZ3dtZjKNBXKrugzuZ7LNVWhKd3bN6MqWd0YrVbM/eEVlSRdZYne39LQs/sYq4/M7HRq0eqRmg892u9yyzPmd5SIOwY6WY0QIpXYRviSWcIR3ETwJz1dwrvyCyzGo0/60A8yzGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsSgWk7ViALFWWK4gqzDGCnSLFDvMX3DytIYizpV5Dc=;
 b=u6lHd4W7s6cE1tyccnx73L9EoHHAbT7UGwxRgEAwDJ2CclnVPR4mNLTpAVmfvc9zNQnTNltfkkCk7qmhwnd+5oW8mNW4cY0kgMpw2OZ7mFmJ4y48btmY9kpr57mLmpL/mWfymmLpQLTm7yJ2o2oSNPo7Q+BaaaJRx09hijZ6VMkiu10JO2anv8+wncvsC2jWUyKCuKXT1mtHRVWyf0O7GdU5o+cR/H8RR4TLEOen1GnA8WYIagNuvL1tOk6yMCpxRLJ+/CuSX2PE5rL4Imb8qBdcZgq4fDBM32NgpMITfwf0IyWFAIyRyRAwieEbdG3aS6mns3ZK09Mmyw7VmMkbkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsSgWk7ViALFWWK4gqzDGCnSLFDvMX3DytIYizpV5Dc=;
 b=hzSrtiiLLGAYByahDelUmxxaxSsAsdHp3M5v1dPgEJxUGLMbiMSFTqgIxVU/8PlXUzBhW4D8pbpP5SpSQWEEJejNpc2cEUtwQy4CTXKxzygdNXeRnp4n3HsLLDcMXyosGLkTuP6KLR7zig0ROrDmxzSYeSzZwH+0s4mzrjeIZqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7638.eurprd04.prod.outlook.com (2603:10a6:20b:291::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 10:17:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 10:17:20 +0000
Message-ID: <706baf32-f9ae-4bb3-ac93-30eb9d7f8363@cherry.de>
Date: Wed, 16 Apr 2025 12:17:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 0/6] rkbin: factoring ddrbin
 do_deploy, customize ddrbin and bump rkbin
To: yocto-patches@lists.yoctoproject.org
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
 <20250415181447.GB9633@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250415181447.GB9633@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1e2d9c-5cfe-4a5c-0797-08dd7ccfdf3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFJxQjd3YU9RTS9LekxhQTFOaFM3MlJ1bEpmMEx2MFptQStWdERGdC9lNnY5?=
 =?utf-8?B?ZDBjRm1LQmozQkJYOVhjZmN2Z1JQM1hqR29sem1UbkR2RGNVMEJGN1JqVyt5?=
 =?utf-8?B?YXZCYXhSeWdtRWUrTWZyTmdNK0ZVbDZOSjJSVDlYVnBrNzEyZWVPZHJvQ09w?=
 =?utf-8?B?UTNnL2czTG9LT3Z1N0xCVEhuUmlSdFE1NHFMLzlJQktSYUdpcTFqTlVQcERG?=
 =?utf-8?B?QmtuRUh3VHZrNXBNeG50dlY4eGZKL2tHSjkyOFRIWXpzOW82M3E5TCtLbkZo?=
 =?utf-8?B?OVd5NFp6Ky80V3pST2dmTmNXVUxHUm95Tk1RNGNFYVBhQ0ZxeFJoYlZDbUtG?=
 =?utf-8?B?ODV2bUYzczRoRGZnUlRkU0ZmbjhBWVdhc29Bczd3YXV1ZHBaZDRybDdnTjdx?=
 =?utf-8?B?cW9YeHI4ekpneDZ2bXRoL3Q5eUtSUHhzR0pBcUtjd2NMMDNsTkZTWVVTVlB4?=
 =?utf-8?B?MThlelNkMU04WUtjV20vRzFOaU5XcHhPU2QrNm9jdW5QUVVOdDJhekRBeEZ4?=
 =?utf-8?B?K2VmZStzQlYzaW5yK2c5dXpHVDhueXBHTjhGaUYzbkRBYnZkVU9aSE4wbGRa?=
 =?utf-8?B?SHphRFJVZWZZQ29VdDQ3eEJGUTBPU0w1ZGRySEh1clhjcnI0VU9OcXBySXRn?=
 =?utf-8?B?aHJiZlBqdXNEVjhNdG5zcC9PQi95RDhoUXZwMnBpdGo1eGJiQ1kvZ2tZMXJx?=
 =?utf-8?B?OWpQUHNTVythUnpvVmNITVpOQlFicG80OFFaY3dEWkMrRWFWZnEraU03VzhU?=
 =?utf-8?B?MnhIeEFLcGp6T2wxOW96NFlQNUljYWJyK1N1bnRraGNGZmlRRlRWN3Y1bTBD?=
 =?utf-8?B?T3dHd1hrY0R0djVod3cwbE9uai9PR1pRR3lscEpOeTYrYUdjVFc0d1ZOU28r?=
 =?utf-8?B?ZmRETFZ2VllhRFlzekVUbnNFNTBza1ZBUkpmSHZhZHNKVUFldWJ0SG5mUDhK?=
 =?utf-8?B?NFEwMlFZc2xHZG9ZZmhpUXh2VTl6eXZBMWRoYlE1NE1RTkVjSDRzNExyQ1pt?=
 =?utf-8?B?R1luc0M3R1VxcHVzL3UrTG0zRVFTR1NuVktZaHU0MXdKK3pyT0lqOG1JRi9R?=
 =?utf-8?B?aEFhM2pMeGFqbzdpRzJlWlM4aVJsYnZ2SXlneVBLTVdyOHA1cU9MMTVBaHc5?=
 =?utf-8?B?VUZWOC9VTFRyWjYzUGlsOXdWSjBMNW5tUWVoeVUwaS9HbXdXMXZNa1gzbWpP?=
 =?utf-8?B?U0FrV1cxUEtTS1BOQ3lXQWYxRnJiNnBhUy9sTHNoSnZ6alFZYTlWWUJrQ2xN?=
 =?utf-8?B?QkdyWDlOSkljMFkrNjZWK3lpQzlTQzBpNm91WnJPaUFVd1dJWlM1bzNYVGZF?=
 =?utf-8?B?eFVvQ1VDcFVDaGpkVGEyTnE4RkNGVE9BRS9HSmJBNTAyaTErMnY1dVJya0lr?=
 =?utf-8?B?T2ZqcWFpKy93TjFNWTdpdEI4dTg0TVlteVdPU1RJdkh3d2hyQ1c1REp6ZTN4?=
 =?utf-8?B?MnBUNnRzclZKSmIyakpjSGxtLzhHRHlZVkVHSElnb1FsOFhCVHhLRGhmendq?=
 =?utf-8?B?Ulp1dkhHZDV3NEtac0NienV1bkd1M2xnZHRSWVpsSmVOWDdnQ3hDWGNkVWkx?=
 =?utf-8?B?bTl5QTUwUDBmNGlqMCtTN2k0Y29qc2VKT2I3alpQL2dPSlBvSWQ1b203LzJM?=
 =?utf-8?B?RStsRGxsbzV4aGxCS2JkanVSY0dBbGI4N0xmT0ZuZS9vRlVra1hORnBoOWUw?=
 =?utf-8?B?WWFYWHFUZFNYbE0wY3N1WnQ0K05xdWk4NmRGOVhUUkI0emt6U21HclIwRHJO?=
 =?utf-8?B?NklUcGF1TDFCaHVtelB6T3FxSStLMHRLMmlrTVlYTnFJcU9KTFB4VVlEclU4?=
 =?utf-8?Q?MX3CeUe67aUaTodHOsiMDAGpyvIQM7XxZEk6A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3RTaE1FRHlzWWlnZHpZOXMvRVdFZUhjdmJTRWFiNUlablNNc0dDNGZXZk9P?=
 =?utf-8?B?eUVybkpEd1BPM1dUUldVSS9EVmlKUUV1ZGFIR0tLVGVrOHFFZm9hSkFyZDR4?=
 =?utf-8?B?dkVaR1dMQWVvcmszUDJJTkswdWtjcVh3ZmEwUmFHV0lwYnJ6d2pPT1ZPcUNo?=
 =?utf-8?B?bkI5UURhNWswZUROMmtiekdiOU5SREJKSDlJbCtJQVFHdjkzSXZyVStOeHFP?=
 =?utf-8?B?UW5BQURoTG1GMHZUR29kUmt3MS95bkgrVG02UjFKNzJBV2I0TGV3dUlpM2lI?=
 =?utf-8?B?NXRhQngwL1ozWU9GVGRzSlM1amdoQWF0UUlGYnp0cjh6N0hpbmJ1SHJvNytG?=
 =?utf-8?B?TWxSR1MrWnBzOEpmMFNUbFZJaTlRMHZDeklrbVdPT1FjWDZpTHd6RkJwb2pq?=
 =?utf-8?B?NnVzYWFpNjltYzFscm1FeEs4bjZZeTRzUFdLeENITW9iMXNCeFpJeC9NN3pj?=
 =?utf-8?B?SWsyZnNKK3BTNUtpRm9XbDRzY3FrU1ZSelR6djdpb3ZOUUJ4UTdSNUM3V1Rj?=
 =?utf-8?B?M0RYVDl5bjFlNWIyVm9rY1ZxdHBhdHVja0kyalVmamVtcWUxUVlpNXdkWGJw?=
 =?utf-8?B?enNYblZqajJ6K1poNEg2OE5iQWhRVnRhZkVsR285WVltZnlDc28yTjJmY2E2?=
 =?utf-8?B?cDZYQnJ1Rm16RlllZzBnVWJYNE5HcDBIUEM3WnFReGZ1bXlZY1BickdOdlFV?=
 =?utf-8?B?endQa2RDYmFzY254VnN5SjlINzdFZ3JRZGNwdENaZVIyZHlONEkyV0ZSVmNE?=
 =?utf-8?B?Y0FrbTg1UFFCM2JHM0xPS1lTVklybHpjcTYwOWZXNDQvS2NMOVBIbVhURzZS?=
 =?utf-8?B?QTE2aUI2ZVd6VXhFTm83clNoQklhYWc5ZXZnWlpyQzQrdkZLdnRDSlZONjAv?=
 =?utf-8?B?WmxxRmFjUnN0MFpTVHh4a2lXa0s4U2FidDExWVljWm9HMFJocjlnbC9GMTNL?=
 =?utf-8?B?eXZ1YzlwZVMrZ25BaXFJMmY2M29zUUlPS3ZDZ20vMlFUVVVmaXplWHkxL2I0?=
 =?utf-8?B?YUJZcW1xdkkzM2hvWmNmZ3l5WFlWV1lCenkwb09JV0trWGdLZmZJK2krMkZ6?=
 =?utf-8?B?S1FrVE9EWXhnTDQyd0F0Z1p0Sk9TTElsNlh1czFTeEhabFdDcEVSOUhkTmtv?=
 =?utf-8?B?VWlmV3ErU2kwdzB3My9RbEgyWEowREEvZkRTVlp5QU9rdWxrdnpySTFHWFZS?=
 =?utf-8?B?L3JKL25xK2RyaTdVUFpTQUlYQ20xOUR2UDVlRnBKSlQ3cVFGY094NHZUK1FU?=
 =?utf-8?B?c1V6aVh4MXpNVm40NEUrWHhlK2l4VHN1eHBLdnppMzJ3a2xNTW53UlNoSXRr?=
 =?utf-8?B?aThOcmEzSlFxMXBWOTJRa3BYZitkQkczWDQ0S0dEbkU3clpSd2F2UmJsNktq?=
 =?utf-8?B?N1pEaHh6aDRyVS84TzE0SWNWQ2xGamtUeFFWRkJwMGk2SG53RWxJSnlSUmRZ?=
 =?utf-8?B?alRGTEpmdnVSenYvZ0pSWks4aXRZYTdON3gvbnVkbUQ3L0FWVStuUmJoa3VR?=
 =?utf-8?B?SGszSkNQWE5iUGFuMmlPQmVIeGF3TkNQb3F0OGpIdU9zUFRQZXNNdUZ0MEZi?=
 =?utf-8?B?ZEljWitiOUVNcG1aaVlPYjJlSENJazZyRW95NEtFUXhIWkRMVThPNjlOWnZD?=
 =?utf-8?B?WC9tY2dGejFMRDBJcDJkeFhseUJQaHpUbUVzUURQeFJlNUF3bjgxeEp1eVJs?=
 =?utf-8?B?UlFsQnEzM05ZWHN5UnNadHRKckkrd0E1NEdlTTJvTnBpYWRnVFBoczVrVDA1?=
 =?utf-8?B?elgyL1BoaXMxTjQrVW1wL1JIcDZIRFVGUVRLQWp2SCtjV0NtSUtFUTF5SklL?=
 =?utf-8?B?aldPS0NGSSt6QUVoc3ZLZldSTUo5Y1hlWGVTV0xZVWc4c25VQ2x3Ti9QVS9L?=
 =?utf-8?B?cm5hU3diTWhrRFRpUGtIY2Y4MXRCM2syemUyRjNOeVkrZlRFRGlzNDJnbXYw?=
 =?utf-8?B?UlMxUmttZVB0YVI4VmhxSzBJYktCNkdxNUtzQXdBS1hYVWNJSDBtS05lbUxZ?=
 =?utf-8?B?SjRRSzZISDNVVXZTNFZEL1dmdFJOaFlpbWdXT2JVbFhMNmQ2ZjRUYlo5VmE5?=
 =?utf-8?B?Y3FrYzRqdlVzd2ZsNlo0bkkxdEkzblJFT245NWhCeVl6ZFZUVURsVzFZNTl3?=
 =?utf-8?B?VGppUENRa3d6TTNSTEhGUlZxSmN1U3hReXdCU2JmbU0wbURqRlVzMW8wQWpp?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1e2d9c-5cfe-4a5c-0797-08dd7ccfdf3d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 10:17:20.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNLDXkXNJqQMXv3lx9eW321802rLz7OLT4YHONbQd+GbYwnUxblGEgBN2ST602nQK5awHOcF8tqR38fYIdFhRmqlVVH104C2vfSkfWk9AoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Apr 2025 10:17:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1375

Hi Trevor,

On 4/15/25 8:14 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Tue 2025-03-11 @ 12:26:29 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> @Trevor, maybe you can check if that would fix your issue with the
>> RK3308 DDR blob you wanted to keep on that outdated version which is one
>> of the last versions where the UART you want to use exists? It'd be nice
>> to get rid of the rk3308-specific recipes I believe :)
> 
> Yes, that would be nice!
> 
> If I understand all of this correctly, I tried using the ddrbin_tool.py to
> unpack the parameters of the latest version of the ddr.bin for the rk3308.
> In other words, I applied this patchset, set RKBIN_RK3308_LATEST = "1", and
> did a build. I then unpacked the parameters of the ddrbin that was in the
> deploy directory. According to the values that were placed in the parameter
> file by this tool, the baud rate of the uart is already set to 1,500,000. Yet
> I'm still seeing gibberish with the latest version. So I don't think using
> this tool to re-set the baud rate to 1,500,000 is going to work. For the
> time-being I'll just leave things as they are.
> 

If I'm not mistaken, we kept the old rkbin for the RK3308 because it is 
one of the latest ones that uses UART0 (M0) for its serial output and 
the new ones only have either UART2 or UART4.

I would recommend to set

uart id=0
uart iomux=0

in a ddrbin_param.txt for your Rock Pi S provided you want to expose the 
UART on pins listed here https://wiki.radxa.com/RockpiS/dev/serial-console

For the ROC-3308-CC you have options as UART0, UART1 and UART2_M0 are 
exposed on the headers. Considering we use the same rkbin, I would 
assume you want it to be on UART0 so the same can be done in a 
ddrbin_param.txt.

Considering there are no iomux on UART0, you possibly could omit `uart 
iomux=0` but eh, doesn't hurt probably?

> Sorry for taking so long. I had wanted to play around with it and see if I
> could get this working. I'm going to try anyway, if nothing else it would
> prove that this mechanism is working correctly. But it does not look like it
> will fix anything with respect to the rk3308.
> 

Did/Can you try with the uart id and uart iomux changed in ddrbin_param.txt?

Cheers,
Quentin

