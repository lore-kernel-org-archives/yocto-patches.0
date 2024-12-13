Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF90E7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 10:10:42 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.12047.1734084637154457726
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 02:10:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=VnsTZCHM;
 spf=pass (domain: cherry.de, ip: 40.107.22.86, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeS0skPEE8uvBKAe/dO0RrJHFiwG2H2eBMaEjXH4npXiJGfK9I+UUF1uXlpwlMI4PV5B2uNJGa3hpTJBUwXi6BdBiJ3f8BJIomAV1D8jQCLxxgERDrAmZO1JNX/qhUXynMnFjvd2CUAXt84uJZxFALFTpauofNQesY4d1BRo6JSdInBWzKCG11o0wtD5FMMslqGO6nUGvsb00t12S0Ke9/t9f/dGwfMVmoIxeZL3pRiZhIyXnRpGIbS/PvlOP+W+/pXzkG3zJ8QAMpwZE0BSX+Fli3s6QpTHdsd4tA1zTRrWXxH4O7D4S3I4RX1AXOEBv7Xlus85JohsjvlmY2N6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfmbVOOuz+L8ibaRcKCxg/i62octRWyq5hiLJPMutmU=;
 b=hi+xlvohPWHF1CX36NA6+WNxCShZBl8w2Tiu3OPgKtjZET0SUs+7aj5LgZctUS/kZ1toY5AffLyJ6xhhEBHdwQ/B+lYAlpOyf3V5lBUxBkyv6Efp/pjMjW9kuUm5md+1xvmkocY/eSk9rtkRwLN8Zeocyxzak6rTbIUJhi7T5DnTwIqMetHmjZpPFnw5tHZsHu8jhcRjeM0igZY43BhN5BbcQYVDiOgNHW0WN+ZZKeD4sN8UsduS6YOq6LIxS0U28IyYBHV9AqDR4dekNARUEbalxoyyIbA1srRJDjS77ZzSwNRKBr4olv/QwcGcm+F+AxQZ9MSrxEQ6/STwa9+dNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfmbVOOuz+L8ibaRcKCxg/i62octRWyq5hiLJPMutmU=;
 b=VnsTZCHMSlowgwnvmJZj078BpKlUx7bx0+DAA9hfXScWRwPzBv9ALxgXNAMquZfV1gYf2pa0CItavfDhBT/GZPdTZTnijzCnN+OaoqaMwqxISkA3PIm7mrRDJuquCIvj+YuMM31lp0czULCF7KFMgnaj6YjgbtntRNCDWSlr6YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB8062.eurprd04.prod.outlook.com (2603:10a6:102:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 10:10:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:10:33 +0000
Message-ID: <7933e42e-32aa-47f3-a45e-497bf2f3aa40@cherry.de>
Date: Fri, 13 Dec 2024 11:10:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
To: yocto-patches@lists.yoctoproject.org
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241212201137.GA26940@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241212201137.GA26940@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd5fe86-79d9-4a25-dace-08dd1b5e612f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bVJzT2RodHN4OUFKUG5lRFpXRlFBU0U5TTlxVXd5bDdOQ0NUZElMaHpGdG1n?=
 =?utf-8?B?ZE1DT1RDOENYUW5FeC8rSTdod2xNaUtscnZjQmFrTHpTSFpyMlUwZDcydVBI?=
 =?utf-8?B?WlVydE0vblNDbVNydVBMY3VXRUFDcnlQMFc5S3NKcE9LbVJPMmQ1OFIwcHZh?=
 =?utf-8?B?c1RlVWd4TVppa1FmSU1tWTRMY0d6ZVNiMkZySDdBSGNFR0lSaHRUazgxWnV3?=
 =?utf-8?B?Z2E0YnFqQ1Q0T1ppRzdQZEorSm5hbFRmbzFmUk1SVXdSdXF5N1p4SnNjL0U2?=
 =?utf-8?B?ejNOTSsyOE01M0FiTWhYUFNrR2svMGczVTdjUXRMZTVBQVdvWDVIR1luQldx?=
 =?utf-8?B?elRyaGR6ck1kcTlialBWVld6NzF0dFZNYU91NHk2eVpsekYxTmJTdHBzM29O?=
 =?utf-8?B?a1lTY1kyeVdHRmdIZitaWnZuMzIwRlpXOVVwMFdwTzYzc1RYSEFIeU82TVQx?=
 =?utf-8?B?RFp0OG0yQkIxdGRIZ3plM3R6aUFLcDhUaFdmNHV6dHpJckNMMjUvOEdmMWI5?=
 =?utf-8?B?OVg1cFI3bVB3Q2dvd291Qm5GalhGOHUvbU5wZGRRNkFteWYxSFRsT1V2eDdN?=
 =?utf-8?B?VVhCc1piNnpwSlkrTDFWMFpJd2V1eXh0WWlKV2dsa3pDeHpla1hZcWtjNUpq?=
 =?utf-8?B?bTB3T3RTV1hVYmJwWk5WWS8zQ09HRVpQTzBWQXp4RS9LdE9wdVFycVd5OUpi?=
 =?utf-8?B?RStWeDkvMGFGUTI2ZkxwT1pwU0ZGVnZQMm5MenU3UFB4THdmdGQ5bzJuc0tY?=
 =?utf-8?B?eW0reEpQaUhhQWVZL0NWNFEzbHF4K0hnSzYxQkVSaDEzYWl4RDMwZGhvSVVy?=
 =?utf-8?B?a29mRlRGT0NDOGFoQ0Fqd09JRDExajNpVGE5S2U4R0JWS3JiTHRUVDlESXB2?=
 =?utf-8?B?ZFFsUm1tb29GME9aZXo4eFlUOW83bEYyM1FJUUNiZnJqdDJuTkZYUkVsMnJK?=
 =?utf-8?B?c04wbEtydUdxVGFBQ3Z0aDFEQkR1UW1zY2NCNm56eHZaZ3ZMbHB3UmdpTndZ?=
 =?utf-8?B?SVdFTmc2NG9XSXBNc0FuZ015U2c5VXZGRFZHbmcvbTZFb1FDQVlNcEc0UGoz?=
 =?utf-8?B?eTNtZDFkV2dPdnZaOEtJWWNRUlZPcG02ZG9oOUlaemR2S20zQTZXbitHOXRY?=
 =?utf-8?B?RHNXT0s5am9oeWJwdndxWk5VSWN4dGd3RTREK1dtVTZlY3RGSjhSRzU1MU5V?=
 =?utf-8?B?djZsNXpIcC9Pa3lpTEc4WWVqM1ZyOUgzS1JsN3N2OVVqakdhdFVaRkNQMTll?=
 =?utf-8?B?ZVZpeDY4QnkyUnR4dGVYMit5UkhkRU1qZ01OZnRPN0tOQmNQNnJsYUZ6VEdN?=
 =?utf-8?B?WVpyY0tpa016cWVDeHJUMWtTbmVUeWNjV2hZV1B0OG1oVFowWWxzMEtFR0lB?=
 =?utf-8?B?eEVwL3U3K3VmbEVhcVBLdE1UV0hvSVhCWkl0OTZnNmROVlJkOXZCZHdoZUEw?=
 =?utf-8?B?dHIrUFBKdGp4QVhkTEtBTFY1VHgwdzRuQ2ZsaFJjTnk1WXYxajJzZ1hIZXJ5?=
 =?utf-8?B?Y1RUaTRSdWsxbEVXN24yeUR6c1NHMTd3MjNHd2xnN3pxdHFxek1XUW8vWUhp?=
 =?utf-8?B?L05wdXFFYnBxVVk3NGprWm0vNWlNb1hjWWR2Z3ErdG9jTmFuR3d2Yjgxc3kx?=
 =?utf-8?B?VW5KVGpOcytTRm54b09MMnErelpiQkhzMmJkZFdLLzQzQnUyci81VlV0L1Bz?=
 =?utf-8?B?VjFWYzE0VURGckRBdHljMnhNUTVVOVQ5NVMwbnprcWRuRGk0RkpUckRxaDhB?=
 =?utf-8?B?aEZvYkI5bjhGTkFxTU9wbU5UN0Jrc1BMTjZUTitrT0JFdGk0QzdzV09lUnd4?=
 =?utf-8?B?eHZ3RDZKQTN4clJZU3JqQUxFTWIxSFdlbG1NS3ZnaytuWjJrcFZzdUZ2VTFW?=
 =?utf-8?Q?0mmeja2BVClm/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YWZweEhtQWFvNStmVks3R3MzVUpPSDh6OGhqYXJJaGoxQjRVbUhjUHl3eUtP?=
 =?utf-8?B?V0d2VFhmOWJsb2FtMmM4alV5TlYrMzdJTnB2RTkyYUh2N2ViTXRnRXRjamxp?=
 =?utf-8?B?bVBnTlNhYWxlelZmTGNlbXh1NUlLUklEbmZpcjIxbTgwVDcxamRidlBNRTlG?=
 =?utf-8?B?Q1NydkNCbnRjZm5LNklkMXFRMHNRT1VqZ1I4THpOTEFMbGwwRVdQd25FWENB?=
 =?utf-8?B?dko2bXpBYnNCNERXM0RrLzRUMkVwbEsxUlJxTStYdGFWS0FxVEZyK3dqdmVQ?=
 =?utf-8?B?UXViMTVjWEVQQmYxVDdLbHJkWUhQZ2R2VnJ0bm9zeDcydDIwN2VZYnFMaUNj?=
 =?utf-8?B?S0lDS1MvZmZ4blNaNHFMRnN3Vk9TenByeGd5MDJITS8vVFF2UWdkdC81NWNx?=
 =?utf-8?B?WjZZVUYzYjJ4eXM4bDlsRW91QU5qaFloU1hZaUFSQUtGMnkwSk5FV3A1N0Vs?=
 =?utf-8?B?RnBoZmZFOWZTZlRXN2R3U01ndTV6OXJMSHUzb0dIbGpTZnEyS3JsTm14Mndx?=
 =?utf-8?B?QmVFODNWWmJZUlRYV2h1YjFTMmc2UzNia2svUzY4RmFnUEM2Yk5XWVRLN1RH?=
 =?utf-8?B?MnluQkN6S2JJcHFxZTJkZ0FRZ3pOWnpNajJ3Mkl5VDc4Zi9EaW12cmM0M2hy?=
 =?utf-8?B?Y3pQYzA0eXRpejlqVEplOWl0Qm1UaHUvZlFnNmZLckU0T3NNakcrKzJxSEdC?=
 =?utf-8?B?alBDbnRveS9FYWE2UUZlaUhwSjVUck51Rk54dnlhTzhka1dTRFdwU2xRL0Zs?=
 =?utf-8?B?UEY2blVqYmZOSnh0Y0xVMVlqb0FFLy9pbHh0YWtibVhZRVRVS2FTcWdVRXJy?=
 =?utf-8?B?QTNiclg5NjBMZTZvTFp6S0Vha0czWkQ0ZlZSVkUvYWI3dFZKcVlnZ0ZQVUFV?=
 =?utf-8?B?VlZOSDNVWVRtWmxENkxrbnJIV1Z0ZjJRcnc0RUF3L3BiUWF0V0lMRFUvUHlD?=
 =?utf-8?B?UlplbGFwNHVXRUpGSCtkZVhEWnBLMUhEZnh6SEhhNGlUZVVjQmd4cExjYnJ3?=
 =?utf-8?B?VlRqM2d5OWN4QVpIWGVEemFEUTFsNDNyb2pGNHZtNmQxQzMzS09nRHBHOTJv?=
 =?utf-8?B?QXlLOG5CYXozZnY0QjdyZkMvdS84RWsxNnErZTRzR0M5OGFzK1laVW82UFQv?=
 =?utf-8?B?d2IzVTI1V0dmZUtzcmlPSkt0Ykg3WFZ4bVJBSWtpdnppQ1lOSm5ST2cvS09p?=
 =?utf-8?B?SXdWOVUrSnA3d1hlYVdBUDBtSEZwZDA4VndxdzJjVDRrdUFQcmRYZUZNWVkz?=
 =?utf-8?B?T2RaK3BJQ3NteFRJeUJlRGZ0dnZMVjlzeExpdy9iSmhqMmtUT1hQd0hVd3ps?=
 =?utf-8?B?b0liMWl5NEQzSmpBT0IxVTlHUVo0WFd6S0t6Q295U0VoQmhCOWk1RXhhVnVu?=
 =?utf-8?B?ZEc3NFc0Szh3aWRzakpBZEo2RVhtUUpRM25uZHhYcWttcCt2ZTBaSXNxQ3FL?=
 =?utf-8?B?cWt5VUg5ZE1DVW9BZGZ0dDhmMzZOeWJjNXcvMUplSTdDcFBKMU9rTi9NN2xa?=
 =?utf-8?B?RmM1b1FpeVJ1aWk2RjE2WkRFSWN3SlpoYlJIaXRRbzB1bHVQZE5JaHlNT3ha?=
 =?utf-8?B?ODBmOWJQQzRqOU9jYWtSV2liYzduQmU2b3hKWkwyZXJLcGhoNzhZTVJrSnF5?=
 =?utf-8?B?a1pQU1E1R2tjaVRYVmZmdDd6NzRlL2xHS1FnSmdlMlNQcE4zMGdZbS9zRVQz?=
 =?utf-8?B?MS9xRHd5anFVUDF1K0NjVHZMbkRPOVl5V0hKOUNxczhnMDJxaUowbG8vN2Yv?=
 =?utf-8?B?M0FVUzBnUlE2NG1ldHh6Y1pJSEIrdm0xWWYzZFVGMTdvVEdrdmt6Q2ZCMDQ2?=
 =?utf-8?B?RU5UMEo3RnZNNEIxeVpmeEV4TzJuQksxeEMwZktPTVF0eXZLMmtyYm8zQ1VH?=
 =?utf-8?B?RXd6UGtZOWZjbldYUEhhdmVIdGlwSHBxUkVYam14ZHQ2V2QrZVl2eG00ZFlY?=
 =?utf-8?B?K3hoQ1d0Z2l3Smx1aEwxNXNuWCs0RzBNUW9Dcmp6RnV6SWdHVzlHQTd1Rzhz?=
 =?utf-8?B?eUowaUxCUHR6Wjk0cUlnVzY0V3hoQnJzODNoU1NmbkdtTHU0cmtFYzlvbVBn?=
 =?utf-8?B?aUFFWDRmbzlmY1hRdGg4NS8vekwrenhWOVNuM0dGZ2NCRHRTZDhKMkJnWVZv?=
 =?utf-8?B?aFN0TzE4SEpXRDBRcnl6QXVWNmhOb29Wdk5qLzhMeTJaaEdrWTF4STA0UXVR?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd5fe86-79d9-4a25-dace-08dd1b5e612f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:10:32.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+WusGvUyY+4jkNn5zVPN93mKZAA03u9cGLOVEi/04IfJfbKAUPBOipMdikDiHBUe52zSWEa2jykwzmEddCBM8oujQP0qQevNgDKJ3NUKc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 10:10:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/893

Hi Trevor,

On 12/12/24 9:11 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> We've been hit by random RCU stalls, system hangs or resets on some (not
>> all) of our RK3588-based products running some old BL31/DDR init
>> binaries.
>>
>> Upgrading to latest commit in master branch seems to mitigate those
>> issues, so let's do that.
>>
>> Only build tested.
> 
> I have finally gotten around to testing before and after images of your
> patchset. This was complicated by the fact that the u-boot and kernel for the
> radxa-zero-3 stopped working recently, so I needed updates for that in order
> to test everything.
> 
> I was able to confirm all of the changes work on hardware except for the
> rk3308.
> 
> 	in order to test		i have a
> 	^^^^^^^^^^^^^^^^		^^^^^^^^
> 	rk3308				rock-pi-s
> 	rk3566				radxa-zero-3e
> 	rk3568				rock-3a
> 	rk3588s				rock-5a
> 	rk3588				rock-5b
> 
> In all cases but the rk3308 I have nice before and after captures, clearly
> showing the old version numbers then the new version numbers.
> 
> In the case of the rk3308 this patch set is moving from v2.07 to v2.10, but
> here's what the before looks like on the rock-pi-s:
> 
> 
> 	DDR Version V1.26
> 	REGFB: 0x00000032, 0x00000032
> 	In
> 	589MHz
> 	DDR3
> 	 Col=10 Bank=8 Row=14 Size=256MB
> 	msch:1
> 	Returning to boot ROM...
> 
> 	U-Boot SPL 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> 	Trying to boot from MMC2
> 
> 
> 	U-Boot 2024.04 (Apr 03 2024 - 02:37:23 +0000)
> 
> 	Model: Radxa ROCK Pi S
> 	DRAM:  256 MiB (effective 254 MiB)
> 	Core:  281 devices, 21 uclasses, devicetree: separate
> 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> 	Loading Environment from MMC... OK
> 
> and the after:
> 
> 
> 	DDR Version V1.26
> 	REGFB: 0x00000032, 0x00000033
> 	In
> 	589MHz
> 	DDR3
> 	 Col=10 Bank=8 Row=14 Size=256MB
> 	msch:1
> 	Returning to boot ROM...
> 
> 	U-Boot SPL 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> 	Trying to boot from MMC2
> 	## Checking hash(es) for config config-1 ... OK
> 	## Checking hash(es) for Image atf-1 ... sha256+ OK
> 	## Checking hash(es) for Image u-boot ... sha256+ OK
> 	## Checking hash(es) for Image fdt-1 ... sha256+ OK
> 	## Checking hash(es) for Image atf-2 ... sha256+ OK
> 
> 
> 	U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
> 
> 	Model: Radxa ROCK Pi S
> 	DRAM:  256 MiB (effective 254 MiB)
> 	Core:  293 devices, 30 uclasses, devicetree: separate
> 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
> 	Loading Environment from MMC... Reading from MMC(1)... OK
> 
> So I'm not sure what's going on here. But I'm happy with the patchset
> otherwise.
> 

What's going on is that we have an rkbin recipe specifically for the 
rk3308 which is selected by default :)

I have not updated it as it was specifically done because the UART 
console/mux for one of your devices didn't exist in newer versions of 
rkbin, so I assume this is still the case?

If you were to set RKBIN_RK3308_LATEST to 1, this should work (albeit 
nothing on the UART anymore).

Does reality match my expectations?

Cheers,
Quentin

