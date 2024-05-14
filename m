Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C48EC25B75
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 09:51:33 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.91])
 by mx.groups.io with SMTP id smtpd.web11.11363.1715680284833380767
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 May 2024 02:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WZIRame2;
 spf=pass (domain: cherry.de, ip: 40.107.8.91, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF2UaPUMKWoEJF+RYw5+wgfgnbFzL8adj5Hj3vadFZAWDud81Ba6rWjoQNHmHBv/CeO6Wm9PmP2CJQgOLMlYu+YqukFgC2rJ7D8z49sLidUXVdUyZR6BoKedQ1c03pYQtoC4xK8jH7ZpW0uTrqGRnB7gMH8iG/r4qI9rpAi3wHi9TgYVLmFesm2nknjemEMgy97vuKsqirt+Rm+PUY4r6pasgck6vmnInZIKzMDsPAmmX7YKvZhnpKL+ZCucxzT39tFUU0tIQ9mt7pSC0pyoRoBLharavbQsGrsaLWjuLIr5ElPW/UDwevllWnNizn2i5PQyc2/Dq8P6CXlRhMxBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOX2RI6BegdGBm86aWEJDsLFPsiFh4/i6NkGEt2UibU=;
 b=JnB8gByG/8SbLPFhNX0E2AloTDq4IJOfwvmU4xtf9Yx6+WNoW6G5/Otg/LFXVlMF6DyeV1wH7AsaBbNIsPSj2T/aCzeb50ib68z9EGVVfzkmJcIA8YzdUqcDql5MVvUA0TpgzfwJo3Q25sjrappMeXTL0pFG296mzshpKwu+Yp/520B60pJR2w9PvNqEslaGOv+GNcRPKwt6l8ygGMD8xx6nt+TeOxPClSNTv4j40/Lppg1u/AQC99GbFA3AQUeBwMcs25njL9ZizadOSXEAtoW5w24cLS+f2/mCTSnrAlP2SvFP2dgTJ72LWIRmep2EGhMUpV0N7sdOqrEDax7lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOX2RI6BegdGBm86aWEJDsLFPsiFh4/i6NkGEt2UibU=;
 b=WZIRame2e3PRGvrlUMyaaVby2y/fzI3jzwbbFXiZcswKIy/omx2FvUzgNzwcLmgkI9jRIksGUYhcxT5vEbInxH0WxVeMOh0Zab6o+LMCq30T1W5z7kWzlhfKnawiGylyMVG6sXRV++F6Vy9YeNoFFj0ena2Rdhf0VwuuMPuM9Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 09:51:18 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 09:51:18 +0000
Message-ID: <630e82cf-d767-40a2-974d-74d4c25438d2@cherry.de>
Date: Tue, 14 May 2024 11:51:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH meta-rockchip] rk3588/rk3588s: add SOC_FAMILY
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240514-rk3588-family-v1-1-5366b1534a10@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240514-rk3588-family-v1-1-5366b1534a10@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 726db172-2aa6-4e48-add0-08dc73fb66fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z012a2NwMWdrd1NUalFkV01BNWRuQ09LM2VrV3FQRVpCaXd2QkRMWmFTblFv?=
 =?utf-8?B?RW9xeWY4ckRIV0UxbGlkRGsrenU3Si9VeW1hWmpLYS9lZm9qcEtKeTNieFJR?=
 =?utf-8?B?Q0E5dUFrT3lLUmxUR1F3b3c4cjVQdi9oSElsYXQvUzk4Y2RhczlIRUdXLzE0?=
 =?utf-8?B?Z05ySVlXTTg5NWtweUFjT3k3bTZESmZBQlpieUVNeUhZaTRhMFduTmd1R0l0?=
 =?utf-8?B?cVZMc2d3RlpYckJRMEswa1N4cGkrTnUyd2tNaUtJclBIWkU5Y2psWVcrTHZC?=
 =?utf-8?B?akxTQTF2ZnRBS0FJUE1HTnZNT255MmdyT2NJSE1zMFgxR0M5VVNQbCtmNk5Z?=
 =?utf-8?B?QWNZa0E4VmVxeC84eTBSazRldXREbzNySFlJZ1hmd3dUeEJpY1M0UnY2enpY?=
 =?utf-8?B?K2RGR2J6V3RYZWI0REhYRmZQNDhSa3RZcmZ1Vm9uaGJvaGtBcUJoei9yN0JM?=
 =?utf-8?B?T2JzcEpoU3lvRm5WdFhBQlZZb01QdU1oWlJnQVVaNmFqUmowaU9MdjNwdHBs?=
 =?utf-8?B?TG43REpYdXRHbDVtZndHeS9QVStWMU5nZm1kb0M0TldFelc1MitLakljUm8w?=
 =?utf-8?B?Zm1OTVcyWDRIajgzRGJtTGoza01pUFZVZElOMmlhbXhFVzZLMXNpTktBdStv?=
 =?utf-8?B?N3l3K24vQmtxQ2t3OHF2cWtWb0hrcUZBZGxZTy8xeHNYSUZTTllQQWFKazMr?=
 =?utf-8?B?cC9LZkkxQ3RxNmxpcHpTNjNSaHZrTWs5OWMxQ0ppL09LUTdoSm53ZmIra25D?=
 =?utf-8?B?UHV2MnlEN0lOb0tUV01rellVQm1YR0FOaElLMEtiejRQUWdMZ1pKNlJIQmEw?=
 =?utf-8?B?d09HeW1ld1k4bUFaYkN1anpkQkFYOFF2bVdaWlRUUGEwZ0QwWVB6TEkyK3VB?=
 =?utf-8?B?OWFsL2prbWFHRkk3MVZ2VlNDRWlyVksydGdJT01STG00WDhzY1lFck4wdklu?=
 =?utf-8?B?Sm16QUE0Y3c4S24veFZNT2JFMzlFUEdSdmhjNjRZUWx3NzdiM3VhUkVTNDBa?=
 =?utf-8?B?WkZDai9VdlJ0Z3FmNDAzSGkxVGFrY1haL0thRmtMNFFRS1FTaXFTYzdQQzlL?=
 =?utf-8?B?ZHFiVW9ZdXI4cEd5cmFCNllPVjV0azQrY3F3dXoxaGt6SlphNVFTd0VWeWlj?=
 =?utf-8?B?OEh0dDRhcDBCQTBYVVh3bVpqVDBHNFRpc3RWS25Hc2IzdW9pR0xjc09qeUFn?=
 =?utf-8?B?bnk2SUYxaGJVY1hQMitZdnV0RHhXek1JSDNSTTNaNlRTbUU5b0FxaEM0ZUwv?=
 =?utf-8?B?TEZySDBXcXA5d0hwT2hNeU5TSzQ5dE52OTlpWjJYb1QvZjAvUUxiN2tKcnZi?=
 =?utf-8?B?aFJFTW02NjhjVGJtMWpyYnVJTUJCbEk0eU1iazV1VUlTeEI4aGhrSnNuYjBB?=
 =?utf-8?B?S2tHSncwRk9EanBkdlE4RndvZm53OVBFelhsa05GSkxTUHdhOTBTRHRNczY0?=
 =?utf-8?B?NTRXUzN1RDcweHEyM1ZXMVMxYmtxcWFWODFjOUdFWjRSN1NVS0lqZ2RNK3N6?=
 =?utf-8?B?VFZzUWdVRlhKS3o1K3VDOEFrUEdUWkJWOVRGREg3OWRiQ3czSzUxQWNOQ2Qy?=
 =?utf-8?B?VytzNVdPQTNlSVRJM1E4L3NqdHQ4YkVlVWo3aElvTGVOSWxDd2tCR2VzbWlw?=
 =?utf-8?B?M3RKMXl5dGVkVmZhYmtLVEVNTGwyOUJlM1dpOEN1c05CQ2ZuY2tQdFB5WHRh?=
 =?utf-8?B?RFZOemd3WFNEVGdWQmdPRTZIdHdNc0ZoN2oxOFJ2bmFJREhRbkFuMmVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekl5SW1kOWozemZQelBicTRxMkhTZ0NrRFFLNVNIN2JVY0JMRSt0OTdqRVdy?=
 =?utf-8?B?RVpmOXJiVFZoZENmQVFrUk5SSXZZekk0eWE0b1B6WjdrcTBzQTlIbzNRK3JU?=
 =?utf-8?B?SVBHN2E0ZHI3dnY5R0xxa0o1SklTWWlsY2VoNTdCZUFjYm5FMmtyOTNERlhY?=
 =?utf-8?B?ei9nTHQzUFdLOURwS1pjUU1zWEt5eDVGYmtYWE1ha1ZRSHVVUEQ2SXZnbnBQ?=
 =?utf-8?B?VklTSUlDbkZhdVV3ZmtQV3RmelFFOFYzNHo2NGl5M1dQMVNhWHIxOTVSMW05?=
 =?utf-8?B?dXg1bnFWZmt2M3B2YWZFQnE1WVBPbEZZZjVIOFBoQ2JCeVAxUTNBRTR6THQ4?=
 =?utf-8?B?VHZ6NUhteEV1aG4zSm1oNnJ4WEpBVkZhWkZBQkt6TFFza2N0MEthemxaZ1V0?=
 =?utf-8?B?ZHJycFp1cHJXVTdveThxZ2F5eDZHSmVLWGZIZ3RwS1ROcHdJQlpjMU03R2NM?=
 =?utf-8?B?a2lVS0Z1Lzlka0ErYW1ReDFYd2kwRHBxaUg2eWZWQmtSdXcxaEZMSVI0SmFr?=
 =?utf-8?B?cTZpeXFHMXJSRFRtcXl1R2RqaXBhck5WVnNGaHVUYlREUW9FcTkwc2U5Q3NQ?=
 =?utf-8?B?VW9QS3dTTU5UMzE4QytrWW1lQWdlOHdHbndxa3NFYy9UVlJLQmJ1QUZRNXE1?=
 =?utf-8?B?eDlQdHJPd0VuWjFSU0ZqcEEvZXRmQ2Z3ZjJINjBuUmkvQmxISk9LOGxtekhK?=
 =?utf-8?B?eGRsNW4ySDMvMlI4SnMveDlSeGk2VXpUZzhvWDlxbmVjb3YvdExvdUZGdlYr?=
 =?utf-8?B?ZUIxTFcxMWtVYW5KSHB1SXZDVXBNUS82MUJjR1V6VUtqU2xVYU5ieUJQSmNU?=
 =?utf-8?B?S1FNMzZvNUMvT1NQZUdnY0F4ME5RY3JzVWN2emtURWducmMreGowWmxYOHlz?=
 =?utf-8?B?dkJlL0FHQ3FnT2dWTkl3U3FvdUJ5c2owdzZ3RHgzVmNqVGJEc21VRGZoTWMz?=
 =?utf-8?B?c0Rjc2duZWRZbzhxdHUvVXAyTTdpSnN5bnBRd09rRVhJMWJGbllQTVFURjdq?=
 =?utf-8?B?SVFqaXdYZHgyVmVDVUdRd3psVFJVODNQQi9MaDdtR0ZtWDFNbk1wcEtQWmxY?=
 =?utf-8?B?QUpzZFkvYUNCZ2EzZTBEU3dIUnNlWFp1d2YxdmRMWGJDRG1TMEZjb0ZqSzRI?=
 =?utf-8?B?Mlp5TUkyVEVrbjRIUk90bi9pZ0dBeGwrQU5QTU05SHhOTnZnc3FCWkp1V0c1?=
 =?utf-8?B?RlNieUVoTTZnQWFjMGIwQ2hPNmx1cW1ScGxHVEVFTlE1ZDVIeStJQ3VKakRP?=
 =?utf-8?B?RDBJTjFJR3Z2c0I4THhUK25lNTNIOFR3bm9lcEFWWUdjVFU5YU5SVVI0Z1Fu?=
 =?utf-8?B?TFMyT2lvWmNmZDNRdWRCL3V3RUV4b3l1bnNpeFUvUUFjYWVyNE1vTW5CdFdo?=
 =?utf-8?B?K0pLeFZGVHFtTzlpOXNaaUNVakJCTGdEQVlpQWRnbXNLNkNVV291RFdYdzFS?=
 =?utf-8?B?Z3JyM2V2M0ZJVWtzdDRocCsxV3VrbFcrcW9xZWpueUc4OHY5c3cycmFsVGNO?=
 =?utf-8?B?Y2pnRWQ2a0NhMVNmTHBUNlJMaHo1SDg2Yko1c1NFZFpNaWtKRjJteG8zQlcv?=
 =?utf-8?B?bGJ0LzZ2cWlSZldDOGcxQXE0ekJkWUpHY1BQZmpLdDVxcDhnb1BOell6am9J?=
 =?utf-8?B?SFpIYTVZSXBnSE51ZElYdSsxUTAwSFVONkNmQThJTFRIRUtwakNCc2FkdkUr?=
 =?utf-8?B?a1FVem9jQmR0QTcrdzFBc2d3N01uTy80TkgySnh1OUZVS0FBZEY4NUJWcG0v?=
 =?utf-8?B?blJxZU1LY3llc3VSMjhQek0zM2Rkb01YT3RTWVIxRHZvcmlTTnhUaUNYdVhI?=
 =?utf-8?B?R1ZrMUtLYkFHNzA4eHN3cmFiSUJqa3VYT2c1cWkrdmVzcWsrMFJFdnhBMzk0?=
 =?utf-8?B?azBoMkdTZ3gyM0F2WXc2VDZHa1VlRnUzTVNHUHlteU1WeWpPdTVzK3EySUdZ?=
 =?utf-8?B?MDBCanJ1VXlJV0FJSDVKazhFOGI0aFJ5VklGVkw4OXU4WTJwazVmTmR3dGFt?=
 =?utf-8?B?WnVSUkVFQUcxWEJkWjB6TnQ5cTZlMWhUMVdVallBOVdqL2ZMdXJFQ0JVazhL?=
 =?utf-8?B?b0F1d3FzcGw0Nk5YcFZ3RkRDcElZbVJLQnI3d2FmNXJiWURTZjNpWk9kcmZV?=
 =?utf-8?B?eU0xRC82cFRhdTZMY0ovUER2N3hUQUZxUUhOUGgzeWNuVlJhblNacmdURzJj?=
 =?utf-8?Q?V3uAt5stZL0WsadCmx1ny/s=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 726db172-2aa6-4e48-add0-08dc73fb66fd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:51:18.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y30pAS68j/lfW+ZSjLSBA2iS0cLB6e+nUQ0ZKBMi+ibJKtoqcYLne/p+v27HuMzv68vvfylXTcNzWlhqz+AHMCPztMOouuILktLbP5ztbN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 May 2024 09:51:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/135

Hi all,

Please do not merge this patch.

meta/conf/machine/include/soc-family.inc adds SOC_FAMILY to 
MACHINEOVERRIDES. We obviously do not want rk3588 in OVERRIDES of 
rk3588s machines otherwise we won't be able to distinguish between the 
two of them.

I suggest to add SOC_FAMILY to rk3588.inc and rk3588s.inc and figure out 
what we need to do the day we need to do something that uses SOC_FAMILY 
but should match both tk3588 and rk3588s?

Cheers,
Quentin

On 5/14/24 9:26 AM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The RK3588S is a stripped down version of the RK3588 but all prebuilt
> binaries and most documentation from Rockchip use "RK3588" as an
> identifier for both, so let's make this the SOC_FAMILY for both RK3588S
> and RK3588.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   conf/machine/include/rk3588s.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 878f7a8..b570d46 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -1,3 +1,5 @@
> +SOC_FAMILY = "rk3588"
> +
>   MACHINEOVERRIDES =. "rk3588s:"
>   DEFAULTTUNE ?= "cortexa76-cortexa55-crypto"
>   
> 
> ---
> base-commit: 88f2064ca2b83b42a7c8a59616ab80b763ef2485
> change-id: 20240514-rk3588-family-6f322d5f1034
> 
> Best regards,

