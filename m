Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC08C369BD
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 11:25:14 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.64])
 by mx.groups.io with SMTP id smtpd.web11.16507.1744802705558607329
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Apr 2025 04:25:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Nyj6uwgh;
 spf=pass (domain: cherry.de, ip: 40.107.105.64, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8sLyZ9XEkO1R04A06Z21SjChk3EW1pgl4uDBhyh4Ca96z/zXvAeECkb0AMBEP6roSOfILH08gTOHMGEr4te1UO4OUyA0abuqJ5ZpZZxGVKdyr4D8CjKzu/ClLlUoyEzRXA2R7mMkmkKDgS4ARFx4Krai4wgnT7JEsAzgLDeeUaStPhsqLaus+rto/TbYz1prMvvu15doR5Raxi/5wfCOBH9CE88JL7AUi0lWzsmhIxojQP0ofv/ARvMq8qKivhy1R6f2h20LapiKdrSPzYYHn3h8PMnaLmTUZZf7RCQgyb+mos3UR9rQU/oQriQzTlJagS2NKtKaI4Mgkl2Ij+fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbySSMOFZDmb7grorOIgjpdydqiz9rkhZJiHwpbU3UA=;
 b=nyJGQz5mUrG+NXBa0Uega2FOT1K0g/TkLzSeALEBOAVG95CfJM7UVTJ7ze64xg3RPca5FvO4ZaBz1HEdc07RC8h4rOgpMlvUPbERu+RQkH9h+TjX7KJxtnanMyUyxiCOyaTvUQt/btID784O+QNCPhhP6nXRmRNQ852A2kvPzlJCYyu7PReMGYtpf2Z19LnB6ol1ajmowmgHCBIyNa9kVXN3oQOyWclgySqlPDObCpaecRX1B+spthsPI71YpFhsKztQrAc4RC/OjElZsxHYIvYVeMgcCsZcGPtNDnmZTXMU7aiU3DcL5ugvRApv85JOw9hUULiVh3YWiKrxVMKLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbySSMOFZDmb7grorOIgjpdydqiz9rkhZJiHwpbU3UA=;
 b=Nyj6uwghcHAQxrASXbJ/KdWndXHFw3SwHq4WufbhDZnxAVZocLAyrAc9Eyo6HanBy8cf8tWIkB9DjHw5xITBTkUEdUuAv1A6tICe8TOlWTQZuodL4gNkwF0jkJpQXrR3JuJshjYdCyfwKNKq1lsDGnlEX2h7rF0GPHD9wcT0rVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 11:25:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:25:01 +0000
Message-ID: <28e034c4-faf4-4b79-8058-70f68014c94c@cherry.de>
Date: Wed, 16 Apr 2025 13:25:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 5/6] bsp: rkbin: ddr: factor
 out do_deploy to be SoC-agnostic
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
 <20250311-ddrbin-custom-v1-5-e5c994ac25e1@cherry.de>
 <20250415180709.GA9633@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250415180709.GA9633@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c579e33-86fc-4efb-7136-08dd7cd9541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WExzVFJiU0hmWE1CdmVNS3dmS2NSS3IwQU01TFZZSWh2R3Q5T1BmcmtvL3FE?=
 =?utf-8?B?dG9LL04wNjdCTnJEYm1jQUw0TVNHNnRvRUtPbDBhUy92TFFYYnhmQ1pHZVdt?=
 =?utf-8?B?aGhUY1ltNy9VWDdnYWZuNXZiTk1peTlkS2JhQTdpUXlUemg3dGVDQzc3Q3d2?=
 =?utf-8?B?N1J3SGVxNUZtUStYKzdsUlBiL1lLeWxmR3VHQzM0ZVQ1RWNIUGFXWnE0aGJI?=
 =?utf-8?B?ekF3ZmVqLzgrS1M2SXdZa0dhM0pIbVNPN1NHSXlzaUU5TUMvdHFFVC9iRmlE?=
 =?utf-8?B?RERvVGlrV2NZSnFrK1ZuRVFGU3JMbm5zSjE4bjAwOWJPVExoVjhBWGI1eXVB?=
 =?utf-8?B?VklPNzA4MHZTcVNlZitJNlNkZWJYeVRSWVdpMlN4SkpxYW1RNGNFV21EelhJ?=
 =?utf-8?B?b29kZkh6UG1TQllDNGlzRnhnemM4Mit1ZUZtU3B2ZzBRR2F6QlJLeGZqY1M5?=
 =?utf-8?B?N1BnY28rN25HVmlhWWM0QmRvQ3RyM3NKMGkwQXY5SGFYOXlrNWRoTXRBbFNi?=
 =?utf-8?B?eVRveUE0SUV6cmpnSlRxbmJEWUQ5a0RCWDkrbzd1ejhpVy9YL1hYSXRlajhY?=
 =?utf-8?B?YlJqNEw2NVhiWCtvby9QbTZQVXZDWmY3WGxTQ0RnaWd0dnBLRXVaVWNodWx0?=
 =?utf-8?B?TGM4NFhqS044REEyMUw5RmZQMEFPenozLzJ4STJYREVYZkcvTVBGd0FWOEZx?=
 =?utf-8?B?bEZmVm9XTUorUUp3bDJKOWxnMERIeTQ0REpnZjkrdW55ZXBWc3M2QlN6MlF0?=
 =?utf-8?B?NWYrVEIrZ1NOOC9QMVp0a3hFemF0NU1lT3RIQlh6dHozOWxBR1U2R2lBb29z?=
 =?utf-8?B?anR5M0NCMFVXTGpsUVB2UU13UjZXTTF6RUM5Y1VsWnhxTi9rWXRqWkx4RTRy?=
 =?utf-8?B?UGdMWjZFMHNhMjkzK0swV3dPOFZGbzF2YzhiN2NuTmlLbXp6b1RYY1VzTmh6?=
 =?utf-8?B?MGoyNWJ4Tm11UWtXT05XdWNqMCt6dGFoL1B0TUpsMDZSbjFGbnJtY1FZU3Bs?=
 =?utf-8?B?SS9UUGZ3VTd0aWdHQzFOZDFqYnpiVS96U2dZb3J2MXhoU2FCcU5aS21QODFq?=
 =?utf-8?B?UEZuNFVMK0pOZ040T29TbGxJQzhRTWpZb1ZBM3lETktoQmEvUFBiRnZaYmlS?=
 =?utf-8?B?N1dRRTh4RzN5Y0JSNlBIdEkxRUdUeVNhSWxENjhiWXVkZXVBSkhHV1hMVGVO?=
 =?utf-8?B?bWNhNnVmbUVSRTFZVHRLdTNPT3IzRlBkeUZYREZBaStweE11c1BqOG1iWTYx?=
 =?utf-8?B?TzdIUkJMYlVPY1FweWpRVWEvTzBhZGk2WW16RDVxK3BSYTNIVzh2ZjRSaDVO?=
 =?utf-8?B?WHczVmdOcmVlTzhsMUREMisyS2p6Y0FTWDBTWXk1TFZDT1MrWk8zNGpzRlhz?=
 =?utf-8?B?SHNGNVA4WmlqaXlRNFZUUG1DcGc1UU5nZnZzaGlTQ1RlbnYyMWh1dlB6RkF3?=
 =?utf-8?B?NFdycm1zZVdzVUJkTENVUHQzdnlSV014VXZpK2ZqM1dVQnpnRHNWb2o2bmh2?=
 =?utf-8?B?U0x4SUgvNENDWXpVNmNQYk85TmI0a3Z1V0hzWEtWMEN0Y3FoTmh0RkkxMC8w?=
 =?utf-8?B?eXgvQ0xhY2ZCNk5acmg5dEozVitBbUFKQ2ZZczVOS0tGdkk3UEh2S2F5bThX?=
 =?utf-8?B?N1NYd0lZaW1UaXF0YzMza0I0NzJIdnN6UE15YXZsQ1JGOENVWU1MY3hPMDZv?=
 =?utf-8?B?bWZFeDJsa1I0a3dWVzRTNUlJWEtnTWo2SmMzTUtybmNnNEQraTZNSDczL0kr?=
 =?utf-8?B?VjdCei9YUWNZMzB3MXlHRjZON3ZyTjZYNlBPZVBFTEQ2Q2JEZjFVYm4yUHAx?=
 =?utf-8?B?UytkU3A4MlBwY0taaFhySEQzVjhVTmJXa2gwZDJWdFpBTUFQdytudVhjQXpQ?=
 =?utf-8?B?Z0lVN3VlNVJKTFVkdVpBNFhPYWRZMGdERHgrNFNrWGl2eTFZcUtLU1V2Tlov?=
 =?utf-8?Q?12YvYfo2Ij0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rkx0N2Jqd0ducWZpb0JBOWRlTDduRVJDeVhobmJWY25JU1Vnd1VmUUh5MlR5?=
 =?utf-8?B?U1cvZHlMQ0k2UzBsbmkrSDBFbzI5aitvWEE4OUJGREJIazlwV1VHKytqdXpN?=
 =?utf-8?B?SnAwdnF0OFdaVkg1RGZhUlZLUEdGQUZENkJnd0F4bGorUjVsSGpiRUUyaksv?=
 =?utf-8?B?QlNtbzdSNXZsOTlYaDNLSUo4VnNjN1UxaE9hekdQdW9RejFvcVNac205Z1ph?=
 =?utf-8?B?b1RRcUl3L3hnMWJ5cUNuekdnOGl0dzhZZy9pM2FHTGRJbWZZOHZGK2t0SWRU?=
 =?utf-8?B?WHhLR2kwSGlkREYyQUJKWWgrODltSkEyYkF4czJuNVQ4azAyRXVxMUlpRFkx?=
 =?utf-8?B?T3l0RXpWbWxmU1hnbXFnNjBpM2x6b0I4akVMYVd3NXRkQjIxQ1RpVDd3VnhO?=
 =?utf-8?B?WDVMbEhHT1gwZFJOTWsvUThsSUVHaVI3dHlKViszT2VWV0k5TnFIdnk3bmJ3?=
 =?utf-8?B?Q3NPTWdhdTJaMVZ1QkgrVnZ1ZEJJUGVld3Z5S29aS2lQQjhiWXp3OFRsK3Bx?=
 =?utf-8?B?MkN0R1g1VG03emN3UFNlcHpWZ3UwZ2xVVVZ6ZENKbCtUM2NURm55S3BHTFdh?=
 =?utf-8?B?T3h0TmNHQW1xU0FQbjhoc1A5RmJSVFE4UURKNjdxNEhPUUdwM3FqbW9SeFl6?=
 =?utf-8?B?MFpqQXpyOG5HYmtaeEJ3eDNmRXVpcHp3aXRCMWpuN2dDbVcwZlpNRTZLVEJV?=
 =?utf-8?B?VkV0QzB3RE1sZytYbEVsK3F2T1h4SU54aXUrWGpGQWw2SC9kUHFrWlhHaVJ5?=
 =?utf-8?B?Nzl3d1BxL1FFaGp2RG9HNG15ZVdKRVExNjdhbE84Zjk4b2YvYnRnMG9KNGVa?=
 =?utf-8?B?TDlTT0h0Q2J6LzZ0NmNwUFlBZW9EOGFsVjVNd0lOdk1ZejlEdDc0aWh5cGxN?=
 =?utf-8?B?NE1OZ2MxbkU5SjcrdS9QWDdlamhMWE9kQ1ZQYkNIK0h6dHZhdnZ3R2tsbUdC?=
 =?utf-8?B?TTFocmtFcHlhQ1JiUGJNWWh5K1hscUV5YklPUzZsaCt6Ym1xaWk5UkVXTUQy?=
 =?utf-8?B?OHNiZnhtQk1sMkpIL05rcGt4MGRIaEg2WWY2bWVzV3NyV0J5UnlMWXh4aDMv?=
 =?utf-8?B?NzVYa2s0WlRPc2RHQzEwSlVqdVNhSFJBd2U3bUJvRG42RmMxa3hJeU5zc05l?=
 =?utf-8?B?NExSc0hGOGd4dVFkUUM0S0lQenhBWC9WSTNENVRqWkk2VzlTaTlzSWg4Y0JP?=
 =?utf-8?B?RVJNS1hDQUpvcElxRzFCVkxvQWw1VW9aVDlEZm9ISU1BWW5UWVcrL1Jtb1N0?=
 =?utf-8?B?SC9CSFJlbENSYzZMemhhaEY1QUtqM0Yvc2ZyOGdxY2JUR0lrM1pLMXpyRm1N?=
 =?utf-8?B?NWRNbUV5NURXTHlNbVRmbUhIWEpRQlZwcjYrKzk2cFVLcThSZUs0SEMzQWNS?=
 =?utf-8?B?VUtqb1AxaEFuR0tEOFk0UGkvWlJtUkRLTFpNc0NLanBBRjhDY29ZTGxBamIv?=
 =?utf-8?B?QzlzOTJ2WWwzZkZWVm5EaWNmMm04cjlqZzIvTEVOSWFuczc3OFNBSGViREsy?=
 =?utf-8?B?T3hVVG9kUzI4eXI3T0M0QWhGZnliYVNJazFkSy9KbzZCc3NsMGwrRFZHcnor?=
 =?utf-8?B?c1VUbU1Id1k5YTBiRk1LQXNta1c2c096TXpOZHlyY2pXWk90S2RjUkdhODhj?=
 =?utf-8?B?LzdETVNuNlhnR1ozK2NTOTJ0ZmRpcC90NWVaL3QwSEdQbzVMWkJYUTNhYVlV?=
 =?utf-8?B?ZnJRbmpGZHc4bkJBa0syNmc5K2pFZExJZWFRL0o1TDdNY3pmMVR6MCtORStK?=
 =?utf-8?B?TzZ2b1V0VEtWejdtU1BHNUhGMU0rT2pNWGhUcWNPOEVrU1huU3ByNjNWS0k5?=
 =?utf-8?B?ejNZejh2RjM0cG85ZmNxVjBqRG9iZWtKeEorMUcvVkRxZXY0bExSTDJ4Q2xP?=
 =?utf-8?B?MWxjZitrYTJVZlNwWVZvdWp1R3BaNFJRcFExY3VUK3F1TFpGNnNsV0RaeHc3?=
 =?utf-8?B?Q284SlR6K2IvaHE5V2lyK1ZZU1NjTGdobkptUXdRWGx1cjN0WTZKVzBuc3Js?=
 =?utf-8?B?YVR3cThvRGsrQzNqWFNQTHlhMmJXMjBTUmVLcFhwa2kxM3ZXUGRNUjV2MmtQ?=
 =?utf-8?B?SE5ETlFnY1NYS2R5MVZ3U2lGVGZ0QUNPZWdERk9TR3NUZ0tjQjYvWjY0MzB1?=
 =?utf-8?B?QXl5bDBYYzR5TTdiR1dYeHFxV05tZlU0RHpuMUExUElaS3RiVHY0K3gxamkr?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c579e33-86fc-4efb-7136-08dd7cd9541a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:25:01.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3A20rjgA2nk02ftSyRp/YT2GkVcIymdrzrHs/jMoEC13g4Y5BehA4B3xIZC2yoro3Lh+b49jV7L4APjC3Y1vQklU5B+IgEbdbeCFApBmmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Apr 2025 11:25:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1376

Hi Trevor,

On 4/15/25 8:07 PM, Trevor Woerner wrote:
> On Tue 2025-03-11 @ 12:26:34 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The do_deploy task is essentially the same for all SoCs, install a file
>> from a specific path to another one.
>>
>> No magic involved, so let's rather have one generic do_deploy task. For
>> this to work nicely, we check that all necessary variables are set and
>> notify the developer otherwise. This may be useful whenever a new SoC
>> will be supported by this recipe.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 33 +++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
>> index 193d0f00a6868f050a0ff4531278b3296d3eae94..17131b6d5a6b443409eacb5806e0613b292852d7 100644
>> --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
>> +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
>> @@ -8,40 +8,41 @@ DDRBIN_FILE:rk3308 ?= "rk3308_ddr_589MHz_uart4_m0_${DDRBIN_VERS}.bin"
>>   DDRBIN_DEPLOY_FILENAME:rk3308 ?= "ddr-rk3308.bin"
>>   DDRBIN_TOOL_SOC:rk3308 ?= "rk3308"
>>   
>> -do_deploy:rk3308() {
>> -	# Prebuilt U-Boot TPL (DDR init)
>> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
>> -}
>> -
>>   DDRBIN_DIR:rk3566 ?= "bin/rk35/"
>>   DDRBIN_VERS:rk3566 ?= "v1.23"
>>   DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
>>   DDRBIN_DEPLOY_FILENAME:rk3566 ?= "ddr-rk3566.bin"
>>   DDRBIN_TOOL_SOC:rk3566 ?= "rk356x"
>>   
>> -do_deploy:rk3566() {
>> -	# Prebuilt U-Boot TPL (DDR init)
>> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
>> -}
>> -
>>   DDRBIN_DIR:rk3568 ?= "bin/rk35/"
>>   DDRBIN_VERS:rk3568 ?= "v1.23"
>>   DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
>>   DDRBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
>>   DDRBIN_TOOL_SOC:rk3568 ?= "rk356x"
>>   
>> -do_deploy:rk3568() {
>> -	# Prebuilt U-Boot TPL (DDR init)
>> -	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
>> -}
>> -
>>   DDRBIN_DIR:rk3588s ?= "bin/rk35/"
>>   DDRBIN_VERS:rk3588s ?= "v1.18"
>>   DDRBIN_FILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VERS}.bin"
>>   DDRBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
>>   DDRBIN_TOOL_SOC:rk3588s ?= "rk3588"
>>   
>> -do_deploy:rk3588s() {
>> +do_deploy() {
>> +	if [ -z "${DDRBIN_DIR}" ]; then
>> +		bbfatal "Non-empty DDRBIN_DIR:<MACHINE> required!"
>> +	fi
>> +
>> +	if [ -z "${DDRBIN_VERS}" ]; then
>> +		bbfatal "Non-empty DDRBIN_VERS:<MACHINE> required!"
>> +	fi
>> +
>> +	if [ -z "${DDRBIN_FILE}" ]; then
>> +		bbfatal "Non-empty DDRBIN_FILE:<MACHINE> required!"
>> +	fi
>> +
>> +	if [ -z "${DDRBIN_DEPLOY_FILENAME}" ]; then
>> +		bbfatal "Non-empty DDRBIN_DEPLOY_FILENAME:<MACHINE> required!"
>> +	fi
>> +
>>   	# Prebuilt U-Boot TPL (DDR init)
>>   	install -m 644 ${S}/${DDRBIN_DIR}${DDRBIN_FILE} ${DEPLOYDIR}/${DDRBIN_DEPLOY_FILENAME}
>>   }
> 
> This is nice, but the problem with this patch is that the rkbin handling
> involves 4 files:
> 	- rockchip-rkbin.inc
> 	- rockchip-rkbin-ddr_git.bb
> 	- rockchip-rkbin-optee-os_git.bb
> 	- rockchip-rkbin-tf-a_git.bb
> 
> In the *inc file it says:
> 
> 	 28 do_deploy() {
> 	 29         bbfatal "COMPATIBLE_MACHINE requires a corresponding do_deploy:<MACHINE>() override"
> 	 30 }
> 
> These machine-specific overrides are found in both:
> 	- rockchip-rkbin-optee-os_git.bb and -
> 	rockchip-rkbin-tf-a_git.bb
> but, with this patch, not in rockchip-rkbin-ddr_git.bb.
> 

Which isn't an issue as do_deploy() is entirely overridden in 
rockchip-rkbin-ddr_git.bb so this message would never be shown for that 
recipe, but the others yes.

> I like what you've done, but I would prefer they all follow the same
> "template". Either:
> 	1) modify rockchip-rkbin-optee-os_git.bb and
> 	rockchip-rkbin-tf-a_git.bb to match and update the bbfatal in
> 	rockchip-rkbin.inc so it makes sense, or
> 

I can agree with consistency across similar recipes.

One of the issues is that we're using a shell glob at the moment to 
avoid specifying the exact version number for OP-TEE OS and TF-A 
binaries. If I remember correctly, I cannot have this pattern stored in 
a variable, but I could hardcode the version (which will require us to 
modify it for every rkbin bump we'll do) or use find with a glob stored 
in a variable instead.

If we want absolute consistency, we can simply hardcode the version 
number as well.

I could also move the whole do_deploy logic I added in 
recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb to rockchip-rkbin.inc and 
use recipe-agnostic variables. After all, we only ever install one 
binary in rockchip-rkbin-ddr, rockchip-rkbin-optee-os and 
rockchip-rkbin-tf-a so we would only need to specify the variables at 
the top of the file and the .inc will take care of deploying the proper 
file in the proper directory. What do you think? If we don't do that, 
then it doesn't make much sense to keep a default do_deploy() in the 
.inc, don't you think? And if we don't keep the default do_deploy() in 
the .inc, then we should probably not inherit deploy either?

I'll start working on a version that has hardcoded binary versions and 
moves the new do_deploy logic into the .inc, lemme know if you would 
rather have something different.

> 	2) skip this patch
> 
> I don't have a strong preference either way, but I do have a strong desire
> that they all match.

Fair enough :)

For what it's worth, you could skip the 5th patch and apply the others 
if you want, and I could work on a v2 for the 5th patch alone instead of 
making it a blocker for this series. I don't mind either way :)

Cheers,
Quentin

