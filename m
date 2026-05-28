Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B54CD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 08:48:42 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6535.1779958110426559995
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 May 2026 01:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=aiTZd0PQ;
 spf=pass (domain: cherry.de, ip: 52.101.70.16, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMrO4vY3j+VPRTTQsMruW5f6hhFAy81JxL2sq4sU0iKUsSltGX4lnFHFb6ai0RMjNLdWKOhKNwwM714stLkaQZdvpZ/owhnPG0P32erY8jfdxXcrGJDuUo40IUQKUiyzdk2tFV3wwoirnJW1O7rhLHD2ytGPZ6nFaHVR1HiZ+Xi4mTRx6XAPXubu3vTeCg/XRfiJkJmuRxUU+zlbSmFcUAPJAgI71fy1sfYaGeRFn7ieL74Qwiu3C8/e5KA/dGm9kFcLjPY/IbLr6wSbzm8dHsoOeNqLN2hr9fcXRKSZDVN2pSp8C54cUUI3etlyBj7sD8ae1kOHzaWOeKpzxMqvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhIO0UvdMBy1j5scTGq7AWDslv4CgtL0RVoRqtgBNvk=;
 b=tMKMpyfoTHJZCyU0aVG1iX7vhq+RErBsdveTAnPU7biWUyUbC8HI9q7yxRvZ7FWrztDQavPEcMQdV6L6IA9QQNDwtMKrCTuFTDbPHMljR+pn2VXm7dwp6AnyxPQaTCvhCoYcCg78tGOR7mYxXx8jkpPphd24XxyutepGzpBNViMSaxJdVoXrbrIyQ4yRmT0l4Tgg7sklbrURGvbKkrrs4esQ59xlwP+zoknKT5HUlbYv73yHAEppnxmmyIhj2sgk3RmxNbQbInOKgJyGEfYd0ypFot+pkzrhuwlP43p4ub6yZtTJmBePIZQgfjCjt9HVO/abdJE/Bmd0qWT4JTXsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhIO0UvdMBy1j5scTGq7AWDslv4CgtL0RVoRqtgBNvk=;
 b=aiTZd0PQkJLdB5C/C2cs+p0mYIbY1FKYiEfQKOps3MN3iKU7Ep+QDhztilevhOKJxoQYBxGfys2lQ8hr+Nlj9VYAg9bn/NTNcOpWXywt+tP30IUF3l/WZvljz6Gw3r06qF743sVPUpJ4TuQxMSCFPTW3EaXVx/zJlg/tEiefevY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:48:25 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 08:48:25 +0000
Message-ID: <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
Date: Thu, 28 May 2026 10:48:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
To: yocto-patches@lists.yoctoproject.org
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
 <ahcOBJWhevGNqPyF@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ahcOBJWhevGNqPyF@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bf234f-6207-422c-dd5b-08debc95e16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|4133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	h0UFIuBpbHd4eTClfTWKWZ+Qg0Ydg4gWl5LSgIw4VLFw+ln2XMh3n6xMbxShg8zQrQW+UidhUzysKmrcAS8OAWJ7Why3uaR22WSfQzmjjmC3D3pYhUOPXVUzviu8Rb1cebZhwQ1ciT16jn054PyB79AyQQKiMXYRP5xY0v5VutKcHc91O+XKjsAbwr3HwlXjlKxxmzbvSNFQo5McoSSnHBCibGdr7Xf7C1jRz5bG6Q4uYg1g2WNFNzW2fx2i7xdw8+KU5nxCf3xo6Mw3Ta39aV/zk9UW8/XMU3nFrwimfdkZaL+8iScyJcz5ktwq4GjkML+UVVTxPMChY/nxvVqQZP5ZsnARnjH4EuNnfBjt/il7kPHH2FaW+FvDDCf236KNAiyifkReLZtl7er0seKaStwY0J6hLXzTCywem7Aqj/S+fhxY3X1FdcPPXyyti20zobY0hsrAl1HWpw6Ah8EfFHprmHDg6H3TAh2aRzz8+4TQjl1nzlNWPU7kT1qIx/h/AH6TxtDNq8VLuO0G8vUypW9IBX+3j/ZO5myUZdamyOaQnLYq95y3M2sT88muXPaqSxOBIoOwDbgtv4ksJ6q8gq7GWE18adsyoD9gvfOsX0ZmUnEYjv8UPiZoX/dKvMAKeHT491pvLlJuskHqP1sLes8v2WX95sPjXFSeJiaIr7sdDTmShTatcyt3BC8BYtbWw5h2o6wfjJ6+WHyeU9R1wQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(4133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDFEcXdGTW9xUVdFWnVSakxYWEJCZTdxMkVpMVRBS0xwbzBDbHVQeGZaUExS?=
 =?utf-8?B?QjhGRHpPZ0Jldk1jMGlTWlJoK1o5RzJZeHVNZXJxdWhZV2RpdFZKUXY0eTB1?=
 =?utf-8?B?NFN0S21GelR6Tkd3b294a1czaUxrZ2xqK2ZodXdhS25mQ3U2N0dOSEdOYVY3?=
 =?utf-8?B?QnJCS1cyK05XbjE1L2tEUkxSeWduNDZxem84UDUzaGsxUnU1cVVaeDJ2clMy?=
 =?utf-8?B?dDVkWVV2dlk0LzBxRkxtZ1VUM0FacmJJLzI0OEl3Y0tRaXBVVENOYWNBb0ZI?=
 =?utf-8?B?VjlTOW94YzhaZVNydGV3MVdMb3lVNXBMU013OEVXWEsveG1OYnJ3SVlxb3Aw?=
 =?utf-8?B?WFFTdFFBM0RyamU1eUMyNjNVSHJLMDRKb2VXeThldWZ4OWw2U1dnS0hCTlZj?=
 =?utf-8?B?RlpGQ0NXamU3L1ByRkkzdUlHNERtWG1TR0J3c2lhOEdTeEJVb052aFFFNk1k?=
 =?utf-8?B?N1E5WGJCZFNYdC9Eczk5TG54V3pvVkR3OEdiVzFIRHNGOW5tbU5RTUp3NG1h?=
 =?utf-8?B?ZTNmL1RpRDF6QllqZGZhTTg0MjRDVFZZdDYzcmp1NHQzY0YrTmFKVGtIOUZk?=
 =?utf-8?B?NWdPMmdBYnRsQUpkc29rYTRYbTVLZXBFdVliTDArL2xybjEvbDI2WXhmd25R?=
 =?utf-8?B?eThpUUdBcFFmcjVXUnIxWlpkTGVmbFpZNUxDYVJhaU9iclBBQTgxeFVlZGh1?=
 =?utf-8?B?ZThlUWc0VndJcnp5YXdsR0x6bjhCWUkwaEVXNVlHRWRqeTM0RHRqTVJRZkRQ?=
 =?utf-8?B?WEV5NWFTMDNmcmFnSnp1ZmgvSVpKU25yZXJuSFBaWnI5QkVsZHFSOHU4QmNy?=
 =?utf-8?B?NTc5VVAxek5BNGRNK0xwc3AvWE5NdHUyQWM2czE1RGdUSjBOY1pSZ2J3WTEy?=
 =?utf-8?B?ZlRKR0g4L1dqN1dsYjV3Smg2bHBnd25Gak13VDBlY1RSb3d5THBHcktjTHhj?=
 =?utf-8?B?SXVRR1oyTzV0ZGZwRUs2b0FYc3BqdGU5aDFSalJqYWlhcDV1MUVnRnJBWDRG?=
 =?utf-8?B?eUM4Q2tGeU5DVU5zTG8wSmlONWpPSkU1WkpmanFOVVF6ZWQ5WUliM29DN2tr?=
 =?utf-8?B?SE1kc3ErckRIbkNFR3IrZEtlTi8zYS93S29oREVsU3Z0M0xkUHJrazVEamJL?=
 =?utf-8?B?bFc5OE1aMHNUNjhVMWxXcFZoMmhUNXJiRzRnN1I3eFMrc2NDdmJtMlB2eVNE?=
 =?utf-8?B?NmdYU1VWd3RyVm93UkJZdzFEcTdFWmZUeHBtNGJvU2xaa29vN3dKait5TTJu?=
 =?utf-8?B?SU1yWXFaZWVvMEJIaTZ5Z21mem9aamFjMmcrb2FhRUpJSUxEMEt1VFIydm5t?=
 =?utf-8?B?OVREZStyd0x0cWJuSjJTZU5oTm92YmVueE9XaTdJbVlDQkxsd21jemZpZnc1?=
 =?utf-8?B?dU9aYk1GN2ZXOUpmaC81RlE5ZmtJTGR5RDNRZjFNQ3BRZ3B5Snd6T2NER1Vu?=
 =?utf-8?B?K2JFdkVVM21jdGlSQ2c4d1Y1ZlI2bDBmby9SL1htSEZhZCtwb2ZyN3k2YXJv?=
 =?utf-8?B?UzZLYVJ5aG01RnA4dmpuNVVaNnhMaWVZVUxCNWdQS21QWGtxSXR6SGI2ZFQy?=
 =?utf-8?B?UlhIaCtsZU0rYldNZlF3cjBjUzE2Q0lKZFc2NnhhVFUrVzJpdGIyZ1BwTFRt?=
 =?utf-8?B?Q3dMZG1ycjFnbUJGQk9HTktiektqa3Z4WnBPUVVuQk1YUmhlYzR4cW9GYkdB?=
 =?utf-8?B?MmJuNTVlTHpydHM3ZlJRSnduMEJPbU5RbmkrWG83VS8zY0hhWVljUGVQc0pz?=
 =?utf-8?B?SFNvVUw3Z1ZXWnZONkJOcXdOajd0K0hzcTR0ZVZEbUpWc3pDK2NzZFNPTS92?=
 =?utf-8?B?TytjaGNiclMveTBRaG10aFZ6MGttcE9HMWlCMU9XS1V5SG5yQkpCMGtEUmQv?=
 =?utf-8?B?ZkZUNStnTTgvSUJXaGZxaXdOMHNjZDU1c2lLczM4S0oyOUgrY1NrVkFSanlF?=
 =?utf-8?B?cmNDZGRDN25HUDJ4K3FnTlhYdm1NbmFObFV0S2pXZi9IdktKNGNHWmI2dC82?=
 =?utf-8?B?UzA5V0JEeEE3aG9qc0xIcnJkMHBjcHJ4QkVhRmxLRFFYWnFMVFlxNjhMU0Rw?=
 =?utf-8?B?bU5DdVlLOWY4NzJSVjNIN2kxOEFGZmlaN0VKVjNrVlc4bTk2Y2ZTeVJxaDUx?=
 =?utf-8?B?cmFsMm54a3UrRE5ZRmVjWGtiRFVpS0IwSjlYVms1K3dHUFh6ZnVzWVM4Nncr?=
 =?utf-8?B?Z1IxSTZ6KzBlQVdaRkIwektDZUdJdEJzdDlKSm8xZ0hXdXVSc3BPMEpYOTZU?=
 =?utf-8?B?ZVVIQzVlMWN0d0dBOXNWWERmTFB3YlBmWlE2LzBCdW5HNzlDclVKUTdvdWVj?=
 =?utf-8?B?aWpiTG1YRUU2TzhHNWRwaGRnUEUrTGJENldYdXdMNmxlWFF2VlM1Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bf234f-6207-422c-dd5b-08debc95e16d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:48:25.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qv7whRq+yf5uh4/AI8fw526FHiVncr9mZ/YQA2uz2TLYgDBdELLfFKBiQnHszECDmHPZIxa3OZmdLW9guyO8ejwFZME708JecvQ7LQ7hHng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:48:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4082

Hi Trevor,

On 5/27/26 5:30 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Hi Quentin,
> 
> Thanks for this patch series!
> 

Thanks for the review!

> I believe there was a little fuzz required to apply patch 1 (around the
> -D), perhaps a v2 against the current to clean that up?
> 

I'm assuming due to commit 9fb264d42a20 ("bsp: fix upstream TF-A deploy 
desync") already being merged.

> On Mon 2026-01-26 @ 03:48:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
[...]
>> diff --git a/README b/README
>> index c2697d1..f49fdb5 100644
>> --- a/README
>> +++ b/README
>> @@ -222,6 +222,48 @@ Notes:
>>   	NOTE: this variable must be set before any include/require in the
>>   	      machine configuration file
>>   
>> +  OP-TEE
>> +
>> +	PX30, RK3399 and RK3588 are all supported by upstream OP-TEE OS. By
>> +	default, OP-TEE OS is not baked into U-Boot.
>> +
>> +	You can bake OP-TEE OS in U-Boot by setting:
>> +
>> +		RK_UBOOT_TEE = "1"
> 
> Is it worth pointing out this is a boolean so any of
> "1"/"y"/"yes"/"true" or "0"/"n"/"no"/"false" will work?
> 

Not sure it's worth the added complexity? We also don't say that for 
RK_IMAGE_INCLUDES_UBOOT_ENV, RK_RAUC_DEMO, RK_KERNEL_FITIMAGE, 
RK_OVERLAY_DEMO but we word it differently for them.

Would,

You can bake OP-TEE OS in U-Boot by enabling the RK_UBOOT_TEE variable 
boolean.

work for you?

[...]
>> diff --git a/recipes-security/optee/optee-os_%.bbappend b/recipes-security/optee/optee-os_%.bbappend
>> new file mode 100644
>> index 0000000..2a5ec8b
>> --- /dev/null
>> +++ b/recipes-security/optee/optee-os_%.bbappend
>> @@ -0,0 +1,19 @@
>> +# Increase size for FDT in OP-TEE OS to the one in TF-A since v2.13 to avoid
>> +# panics on 64+KiB FDT passed by U-Boot to TF-A to OP-TEE OS.
>> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7687 is merged.
>> +EXTRA_OEMAKE:append:rockchip:aarch64 = " CFG_DTB_MAX_SIZE=0x60000"
>> +
>> +# Disable early console by default to avoid OP-TEE OS panicking on boards with
>> +# their UART console different from OP-TEE OS default (UART2 for rk322x, rk3399
>> +# and rk3588(s)).
>> +# In-tree default changes if https://github.com/OP-TEE/optee_os/pull/7688 merged
>> +OPTEE_OS_EARLY_CONSOLE ?= "n"
>> +EXTRA_OEMAKE:append:rockchip = " CFG_EARLY_CONSOLE=${OPTEE_OS_EARLY_CONSOLE}"
>> +
>> +# Enable hardware acceleration using Arm Cryptography Extensions on PX30.
>> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7689 is merged.
> 
> Have these 3 merges occurred yet?
> 

Yes.

b6c7291c246b ("plat-rockchip: increase FDT max size to 384KiB on all 
Aarch64 supported SoCs")
763be3b08c16 ("plat-rockchip: disable early console by default")
74eb4d9ed3ac ("plat-rockchip: px30: set CFG_CRYPTO_WITH_CE ?= y")

All available in 4.10.0. However, meta-arm currently is still at 4.9.0. 
I don't see patches on their ML 
(https://lore.kernel.org/yocto-meta-arm/?q=op-tee) for a version bump so 
we need to keep those in for now.

I guess I can change the comment to say we need to keep this until 
4.10.0? At the same time, it shouldn't hurt keeping them in even in 
4.10.0 or later.

Cheers,
Quentin

