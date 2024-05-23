Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C85C25B79
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 13:04:01 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.117])
 by mx.groups.io with SMTP id smtpd.web11.16279.1716469440048261962
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 06:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=fL7SQ+if;
 spf=pass (domain: cherry.de, ip: 40.107.6.117, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxoGV0wfoJZ/EAjpxsD2zpX1C558zVYcFiNFYNlfBhsGbHAmVbWn1xCMLHPIBkCUkKR1srSUzC8nY3jZKWjKX8LmB+scIoenbOxE3C5N2Wft83XYOyJTIBI3OvHg0akiJdeFSr7Arqbiu0aeS0RZE/2YIbcGMUk8kxEk/Fhko0mjatUI66OCdq/6KcBgwyqP6+4DxBhPEYiTEmSxXwvyyWGKKx6rqvIy7Sjzdl5wowg1h7gVi8VZHQpy3tncI5Ffytz8+7oQAaq/xuzcqivP8vvQbvB5c7n6ZKdi/aWJbpWB/Jsm1WyGIWDZhFMPF+WMGRhOnkwaLKHDZc9hMHnfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG0XlyAMbOaTyloEyW5ZtJme9zi8U/5fLrWqvvTuFB0=;
 b=Bl27ypgH/VOmWLaQP71GgU8B9UkSRHW3EcQ4Txu/O2Qi69F7hHIWCTG4JN/v7CLzx0C7lQQ2ZUm/AlB5jOnNE2bvtCH3g2zUmB/cvmLxZdZpDkIldcDyPkZBAhqvLrjrxBBNgDL9gOBS1SsH8d01eeBLksm+dQnW7iSQj32YpdndZ6lEVL2kmdg4EAc0PkHTLFDuPBr3LUrJNWFw2H3JUt2zjNxPSiwHJSB8fEEnO5BW8iC3HgWQzajKETJJqZpIoOmEJmBawRLg1ezM1/MaB2DRIFCQvI5r9/7HK7HUhHrudyOuypjt7sBdAtS+TOZqZAGFWfUmFHqhwJOZTDw16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG0XlyAMbOaTyloEyW5ZtJme9zi8U/5fLrWqvvTuFB0=;
 b=fL7SQ+ifhl5209dD2g7VXDV9EZDHRdTaBjnYxVYqt1loCcWrpUpxk6NCEtc2+Fr0HVORnVoqj4Sc1uH4grj5hTER2g5NSfd1GW/tJ89Jcb274Xqw15nxliSxOfd7acIFfArmOCCdPJhLS8wAG4wn69mG+mCvBeaDSGREruDVop8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VI2PR04MB10689.eurprd04.prod.outlook.com (2603:10a6:800:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 13:03:55 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 13:03:55 +0000
Message-ID: <0eceea59-17f3-4e7d-bb90-f23304b896a4@cherry.de>
Date: Thu, 23 May 2024 15:03:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v7] enable stored U-Boot
 environment
To: yocto-patches@lists.yoctoproject.org
References: <20240522225345.13339-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522225345.13339-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VI2PR04MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2370fba3-9165-4d7e-ad95-08dc7b28cd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NmJrWC9zdSticmxkRFUzRTNoOExPMWZLd0V2ckpLdUZZTUY4UWMyUzlXNkZO?=
 =?utf-8?B?ekVhRWxoWFF5ZjBTU3d0ZnpPY0s5Ky8zdUF4ZVR3TWx0MThvVDJTUHBQaW1l?=
 =?utf-8?B?Sk1Ud3kxTGhTM2ZMcVk0VS9teXRHZFY0MWluWDJGNHh4Q0h4UUM4SEZ6TDVJ?=
 =?utf-8?B?RDFuc0k0VjNwdmMyTlUraTNWaFRxc1hrQXpLeURsYkVvZ1V2STBHU05KVmxH?=
 =?utf-8?B?TGRwYmFEUDZtWHNNZUpGNTNTS3d5amxvaEVGZjMzR3BsVWZNRUtZMXA2eE05?=
 =?utf-8?B?dmk1cWpHcGkwK3YvY2lwNkRyMERFWGhDaGpBMjY0akxsYU1ERFhhWHFsT2tv?=
 =?utf-8?B?SzdsYlRpSzFGMHRZblhMaDRtdFhQLzg4Tk53RFh3MTZHQ1NadFFwSHhQd2hK?=
 =?utf-8?B?cVQ0aDF3RkFwM2NvSHhmbDJ0MG5RM2JNUFlDQ2cyelVxbi9QbUIzTGNhVUVB?=
 =?utf-8?B?bTRFNDZlZ2JDMmpvQXhIdUpJcnNQN3BrU3JMOFZDanFxU3d1dXEvYWVkQTFj?=
 =?utf-8?B?THdxS3V4aTRRd2hRY1M0bHRZNUJZUHNzR0RsYnN4T29RTGpUV2F3WDhycGo5?=
 =?utf-8?B?ODhSQUtGQUNIQVZUNWZMRXZvdFFkZVFVdkdIQUdCREpOdFJ2NzY3T2ZrWjJp?=
 =?utf-8?B?K0RabklmcnhzTmhMOTZveVVaRlVMOFdIMlFzUFMvcG5nb3FLNUV3dUtJa0VD?=
 =?utf-8?B?eFM4a2ZwcE00ZHU1OFA3eWkveGNxWDVHR0paRTFyeVZCWnY5ek9XbVJ5QlA3?=
 =?utf-8?B?VmhSa0JHTC82dU5wSkQ5YXJIbTN3dkRpb1RPSjVhMGcyNFVEdFpGdStDejJy?=
 =?utf-8?B?U2RzdjV3WjduUDNsSTR4K253dmFrYVY3WEtyVXZqZnJNOVIrZkE3SGc3ZkN2?=
 =?utf-8?B?MCtZblBWa2NES2ptNnRITFNlaXdNM3llUFkvVm1LakRQUGNLak1sczdWdzNk?=
 =?utf-8?B?UXJBNURYUnREdGFsam50aGtQblNSTkVpZHB3SmlQeDJGcHpIZ1ArN3ZlL3hX?=
 =?utf-8?B?Qnl2MGZOanlzSG9iTkpob2doeTBkbXBDTjNFK0g0Y1RLUTBDQ2pBSnlPaTlm?=
 =?utf-8?B?ZndoVE43THJVT3Q4RTJNTFFBSWpsWWl6QlJ5MTdoOEFoNE91NkRQNnk3K3Jo?=
 =?utf-8?B?QTFVSWhRQTE5NnFFNXVpYTdOZVlqd2FEb01nSVBCK0xVS1RFK3VDOFNxSzU0?=
 =?utf-8?B?WHlKM1UySDFCTmpKeXhFS3JGRDQ2bDJVWlBjSXk2QkVtM1ZvT0VMMnA4c05v?=
 =?utf-8?B?NmxZU1FHU2xaL3p4aHRKR2RhQlZuaWVDWmk2cG85UWU2SklFZ21kRkZPd0JD?=
 =?utf-8?B?OXpxTHZGVXdYd213K2FwaUFIZmFsVDVtSGNuN3FBK3hzL1JrNDFCSVk4SWcv?=
 =?utf-8?B?bWY2Y2F2R1VBeHVUZkRpK054QmJHTHFNU0oxSHR6K1hqZVpHcVRsY1kxZHVy?=
 =?utf-8?B?ZGhBY3JBbmNTanp6MitVQ0JGSGp5WEVkL2JXVWxQWnQ3eUlGSFVzWGZPNHZq?=
 =?utf-8?B?UHR2dFVxd2RKMUhlZFEyclNvQVhjZHFNcUxkaml2Y2JGc1RTbzl2YjdVSk5a?=
 =?utf-8?B?OUZtOWVXNGR6L0tMSXNVaWk1UlJOVCtwL2tXOHl2dVNEVjRPMlJ3ZkhlalRs?=
 =?utf-8?B?ZmQzRXloSEtJSnNBVDNsZVNDMzNLOXdTNzY0Sno4VWRNSXpqUkV4N2JqQTha?=
 =?utf-8?B?TkRYUk0rZFljcVNRNjV5cTNjS3kwWXRDcjRIcjNLV01MYnRJeE5MNnR3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6578.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0QxUnZWMU40aFgrSE1Qb2JnU2ExUjk0NHdxTmdpZ3ppMHdzMWJOL3lRbmxK?=
 =?utf-8?B?K2h4TmkvVUltODJXWms1bk9TZ29SYnhtMXVIUlNBcm5BMnBYN3lEMEIrcVRq?=
 =?utf-8?B?blcwb1oxcHRtOSt3bW0rT0pLcWhQbkY2cTZrWjI5eFNUeVFjUHJvS3o0MVRa?=
 =?utf-8?B?QU1HbTZLYnZXVlAzLzlFN0srYlA0dU9kaFBTcGMveFVYUFBLMjRhY1Q5dlpG?=
 =?utf-8?B?UnpIRjdTSlBqbElZTmtmaFlXNTVTSkpPaFBIbjdGZzhzVTUyNlpQbHRyTUJM?=
 =?utf-8?B?ZHprRGFlNnJMbGV2Ryt4QUtyeXZ6dWVnaTVUN08xWlNLN2ZDRDg1a3BlRS9W?=
 =?utf-8?B?NjRiTDFWK0kydVloUDhDYWlBajBHWTNBZVRSZzNuYWF0MWNnUkhPS05BdUlw?=
 =?utf-8?B?Q2xDcUVvWnZUUU1FaTJ2WVFwclNubk42cmJ4MGJDVDdzZlZnelBQb0VwejNq?=
 =?utf-8?B?MmFUTHFMRTdVOTFtV3AwQXJ5WngzWGRZMGJVdG55emZPLzZNMUNVR0diNlNZ?=
 =?utf-8?B?QlhDVFUrL0x4N3JPbTd4RDFmVk9waXQyVDR0R2tvVkpDTXNCaEtFdlplVlEv?=
 =?utf-8?B?OWFQU09oZFlGZjd2V2tDQ0ZHbkFCaEZEVlJ1WFl6QTdFMjVSNlVCTU9Lbld0?=
 =?utf-8?B?elV4azlWVzF6NFlIVWlSTXNnc1Z1Q1pJRy9icnZOdzVjaEl3aVRQNjNpSzN1?=
 =?utf-8?B?cVhmMjdBVEdMWWNOblFwbWVXamFZY1IxRndDZkUwL3hOWXpVNDByUlNkS1Nl?=
 =?utf-8?B?OWc2VXF3ek1MSmtITHYvWjBUZit6K3pDWVJzMGJKbEVJVVFPcmdxaStOREpy?=
 =?utf-8?B?d1QrVzU4cVBYcHc0OWFBa0hSbmR2SVluczA5UTJVcUdtK1VqNGlvSGJBMk9p?=
 =?utf-8?B?aEYyaGhvZUFXTGNpVFpEYmlrTDluTG0zZitWN0lNSWpET0xNdUJIVk9SMTY0?=
 =?utf-8?B?aEpsRS9GTkpac2lUVkpyWmdYSUtOY0lyZzc2Nk1sdUYvWGVWSWUycURHVXlo?=
 =?utf-8?B?ejE1OE9GSEtycmxWRTVhZy94N0taR2RKUklvVGVaTFlMU21RL015b1g0ekNP?=
 =?utf-8?B?dFM4QWFsZzU4TGhmd1kyT2pmckdnd1dWVkFhZ29uaEg0QlU3S3NhbjRMOVU2?=
 =?utf-8?B?a3BvNVNYTTdIaGpxak9pNDdqU0N1c2tnUkpqbTErNEtSZGMvbWl5ejhiaVl0?=
 =?utf-8?B?Tkk5WVhiNk1MaTUyVjNJNEgyTkI4bk9FZDBrb09hSWtnbm5wVXI4ZnVvSGVT?=
 =?utf-8?B?Sml2eGpQOVRFQXp4Ny9RSGdrUjBCMktwQ2RTdlhTQ3MwOE5CQS9kZXdDdmg0?=
 =?utf-8?B?Q0lCaDNaU2RoSnpsU1FMYTE2MXFadEx6aXp1RE9SMU1rejRzNElPUHJxZFdO?=
 =?utf-8?B?eVNzZzg5aXprV3Q2Y1krSUdnZ1lMWkQ1L1hkSUpNU2xrQ1o0MVpxZzdjbjl1?=
 =?utf-8?B?bzZzL3lwdk1nTUNMdjRieHM5S0JSeTNmaHVPUGM2a3VXSEErZit3d2tMb09l?=
 =?utf-8?B?T2J6VGNtWEt2cjZocDhoZmRtY1dHWVloTHJCa0F2SWNvV2xZRHRWMnhySC8w?=
 =?utf-8?B?N24zYy9SRWdkS2VudTRtcGFOOFd3T292U0VqMFJWTW15ME5ydXlEaTk3Mm1L?=
 =?utf-8?B?cEpQU0RhdVhxck1udU9rSURFajgzdUthN3pxQjhJWk1Gdmlob2lFU29Fd1hW?=
 =?utf-8?B?cmhSazBRenBrR1lvYWJkTW5oUHBFU2huanNwUk1WZVJRa2pVV2lpVkwvbmJR?=
 =?utf-8?B?SDRadFBlQXNtaFpwRTVYbDlpZUNZOUtEU0x6d0VyUUhDRkRhRURxczNlbUty?=
 =?utf-8?B?ajVDTTVEclRacXZkMnN3clR4eE1vK3pDOG5KOUFqZWhVRTF3RFIzUTdaQXpH?=
 =?utf-8?B?OTVyQVZiSjZFek82UytOcmo0N0tzVW5JMmJSNG94TlBVZ1h1c1RaUk5ZUUY3?=
 =?utf-8?B?Rk9ncmlMQ08rQWNKNTRUVURNR21TVVFsZUhOZE1kc21PRmx3Qy81TGIyMW5B?=
 =?utf-8?B?NC9YSGh4WE5KV3AxR3F4TWRnT2RpdnRGbFUwMFZSbTM1U2RPTWRVVGdtYUtS?=
 =?utf-8?B?MCs5dG5CbnZTYWlMcWxDbU1kcDNKTDF1eStUTlNSZkpCZWpJRnovaVRIZXZS?=
 =?utf-8?B?eTlVTEYrNVg5QWgrS0FaQlZrWkNOS1g5MDk2aks0bDZ2UlFQS2VrbWt3MnUy?=
 =?utf-8?Q?DDAjujnG0URDbuZSp8c5e6Q=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2370fba3-9165-4d7e-ad95-08dc7b28cd7b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 13:03:55.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIcX3LNHHFWTbZ13ElFO3D38fsRBxVqjwd9aIowi5nG+WbRMi2nbvD5DRyZPgSoVsVnqtSiayLiU5NxfgRwPveWf4JA/nqDRhItohP43gqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10689
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 13:04:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/179

Hi Trevor,

On 5/23/24 12:53 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> U-Boot has the ability to store its environment variables to a permanent
> storage device. Whether or not it does so for any one specific device
> depends on whatever settings are enabled in that specific device's
> defconfig. In order to definitively configure U-Boot to be able to store
> its environment into the device from which it boots, for any device
> supported in this BSP, simply add the following to MACHINE_FEATURES:
> 
> 	rk-u-boot-env
> 
> If enabled, there is now a second choice to make: should the build also
> include the U-Boot environment in the image or not? The default environment,
> as generated by U-Boot, can be included in the generated wic image. If it
> is included, then flashing the image will also flash the default U-Boot
> environment variables and settings, wiping out anything that might have been
> there already. If it is not included then your device will either continue
> using whatever environment happens to be there (if valid), or will not use any
> stored environment if the stored environment has not been set or is invalid.
> The variable which governs this behaviour is:
> 
> 	RK_IMAGE_INCLUDES_UBOOT_ENV
> 
> By default this is set to "0", meaning that by default the image does not
> contain the U-Boot environment. To enable this behaviour, enable this
> variable. This variable only takes effect if rk-u-boot-env is listed in
> MACHINE_FEATURES, and has no effect otherwise.
> 
> The script:
> 
> 	scripts/dump-uboot-env-from-yocto-image.sh
> 
> can be used on a rockchip wic image to see the contents of the U-Boot
> environment partition at build time.
> 
> Tested by booting the same image on both eMMC and SDcard with the following
> devices, verifying the ability to read and write the U-Boot environment in
> both U-Boot and Linux user-space, and that changes made in one are seen in the
> other:
> 	rock-3a
> 	rock-5a
> 	rock-5b
> 	rock-pi-4b
> 	rock-pi-e
> 	rock64
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v7 changes:
> - move u-boot's extra image install to machine/include (it wasn't having
>    any effect)

Couldn't find this in the diff between v6 and v7, are you sure you sent 
the proper version or is this outdated? You did add the inc file to the 
rock2-square though, is that what you meant?

> - only call u-boot's rk_generate_env() postfunc if the feature is in
>    MACHINEOVERRIDES (in which it is only *conditionally* found, unlike its
>    presence in MACHINE_FEATURES)
> - add a warning if the user is trying to build an image whereby they've
>    enabled the rk-u-boot-env mechanism but it isn't supported in a given
>    specific build
> 
> v6 changes:
> - separate out the MACHINEOVERRIDES handling into its own include so
>    that it can be included more flexibly into different scenarios; i.e.
>    rock2-square build was failing because it is not wic-based
> 
> v5 changes:
> - fix a bug in v4 to handle RK_IMAGE_INCLUDES_UBOOT_ENV correctly in the
>    bash test in postfuncs of u-boot bbappend
> - add extra check in do_deploy() of u-boot bbappend to only copy the
>    environment if RK_IMAGE_INCLUDES_UBOOT_ENV is true
> 
> v4 changes:
> - sort WICVARS alphabetically
> - tweak dump-uboot-env-from-yocto-image.sh script to not just check for
>    the existence of the user-supplied parameter, but that it is a file
>    specifically
> - u-boot bbappend:
>    - use a do_compile[postfuncs] for generating the fw_env.config instead of
>      a do_compile:append
>    - move the conversion of the U-Boot text-based environment to the
>      required binary representation from a do_deploy:append to the newly-created
>      do_compile[postfuncs] created above, this will allow the user to inject
>      any extra U-Boot environment variables they might wish as part of a
>      do_compile:append and have that occur before the binary is generated
>      so that those additional user-supplied values are included
>    - add a lot of extra checking (instead of assuming various resources exist)
>      before making use of said resources
> 
> v3 changes:
> - switch from using a bbclass so the `rk-u-boot-env` override can be used
>    directly
> - add SPDX header to script
> - drop `inherit deploy` in U-Boot bbappend
> 
> v2 changes:
> - re-word the commit message and README for clarity
> - use bash's built-in math handling instead of depending on `bc`
> - in anticipation of the upcoming feature in U-Boot whereby rockchip
>    devices can automatically select the environment storage device to be
>    the same as the boot device, use a more recent SRCREV for builds that do
>    environment handling, instead of hardcoding the environment storage device
>    by SoC family
> - handle RK_IMAGE_INCLUDES_UBOOT_ENV as a boolean
> ---
>   README                                        | 20 +++++++++
>   .../include/rockchip-rk-u-boot-env.inc        |  4 ++
>   conf/machine/include/rockchip-wic.inc         |  7 +++
>   conf/machine/rock2-square.conf                |  1 -
>   .../rockchip-enable-environment-mmc.cfg       |  6 +++
>   recipes-bsp/u-boot/u-boot_%.bbappend          | 45 +++++++++++++++++++
>   scripts/dump-uboot-env-from-yocto-image.sh    | 29 ++++++++++++
>   wic/rockchip.wks                              |  2 +-
>   8 files changed, 112 insertions(+), 2 deletions(-)
>   create mode 100644 conf/machine/include/rockchip-rk-u-boot-env.inc
>   create mode 100644 recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>   create mode 100755 scripts/dump-uboot-env-from-yocto-image.sh
> 
> diff --git a/README b/README
> index c76fc9131276..605773d4ecd3 100644
> --- a/README
> +++ b/README
> @@ -67,6 +67,26 @@ Notes:
>   	
>   	in the configuration (e.g. conf/local.conf).
>   
> +U-Boot Environment:
> +------------------
> +	In order to configure U-Boot to be able to store its environment into the
> +	device from which it was booted, for any device supported in this BSP,
> +	simply add the following to MACHINE_FEATURES:
> +
> +		rk-u-boot-env
> +
> +	If enabled, to additionally have the U-Boot environment generated and
> +	stored in the image, also enable the following variable (default: off):
> +
> +		RK_IMAGE_INCLUDES_UBOOT_ENV
> +
> +	The script:
> +
> +		scripts/dump-uboot-env-from-yocto-image.sh
> +
> +	can be used on a rockchip wic image to see the contents of the U-Boot
> +	environment partition at build time.
> +
>   Maintenance:
>   -----------
>   	Please send pull requests, patches, comments, or questions to the
> diff --git a/conf/machine/include/rockchip-rk-u-boot-env.inc b/conf/machine/include/rockchip-rk-u-boot-env.inc
> new file mode 100644
> index 000000000000..4eb877f77c48
> --- /dev/null
> +++ b/conf/machine/include/rockchip-rk-u-boot-env.inc
> @@ -0,0 +1,4 @@
> +# 'rk-u-boot-env' indicates the user wants to be able to save their U-Boot
> +# environment back to the drive from which the device was booted
> +MACHINEOVERRIDES .= "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', ':rk-u-boot-env', '', d)}"
> +IMAGE_INSTALL:append:rk-u-boot-env = " u-boot-fw-utils u-boot-env"
> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> index 147a36685d7d..b5ee6e0c2724 100644
> --- a/conf/machine/include/rockchip-wic.inc
> +++ b/conf/machine/include/rockchip-wic.inc
> @@ -1,6 +1,7 @@
>   # common meta-rockchip wic/wks items
>   
>   require conf/machine/include/rockchip-extlinux.inc
> +require conf/machine/include/rockchip-rk-u-boot-env.inc
>   
>   SPL_BINARY ?= "idbloader.img"
>   
> @@ -11,7 +12,13 @@ WKS_FILE_DEPENDS ?= " \
>   	virtual/bootloader \
>   	"
>   
> +RK_IMAGE_INCLUDES_UBOOT_ENV ?= "no"
> +RK_UBOOT_ENV = " "
> +RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.env' \
> +	if bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False) else ' '}"
> +
>   WICVARS:append = " \
> +	RK_UBOOT_ENV \
>   	SPL_BINARY \
>   	UBOOT_SUFFIX \
>   	"
> diff --git a/conf/machine/rock2-square.conf b/conf/machine/rock2-square.conf
> index 9468b9a6b559..b31eb574015f 100644
> --- a/conf/machine/rock2-square.conf
> +++ b/conf/machine/rock2-square.conf
> @@ -16,4 +16,3 @@ UBOOT_MACHINE = "rock2_defconfig"
>   # image class
>   IMAGE_FSTYPES += "rockchip-gpt-img"
>   IMAGE_CLASSES += "rockchip-gpt-img"
> -
> diff --git a/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> new file mode 100644
> index 000000000000..778772d27767
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> @@ -0,0 +1,6 @@
> +CONFIG_ENV_SIZE=0x8000
> +CONFIG_ENV_OFFSET=0x3f8000
> +# CONFIG_ENV_IS_NOWHERE is not set
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_DM_SEQ_ALIAS=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index a83179a9f007..33b521021a1c 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -1,7 +1,13 @@
> +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> +
> +SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
> +SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
> +
>   # various machines require the pyelftools library for parsing dtb files
>   DEPENDS:append = " python3-pyelftools-native"
>   DEPENDS:append:rk3308 = " u-boot-tools-native"
>   DEPENDS:append:rock-pi-4 = " gnutls-native"
> +DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
>   
>   EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
>   EXTRA_OEMAKE:append:rk3308 = " \
> @@ -34,3 +40,42 @@ do_compile:append:rock2-square () {
>   		cp ${B}/spl/${SPL_BINARY} ${B}
>   	fi
>   }
> +
> +python rk_no_env() {
> +    if bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', True, False, d):
> +        bb.warn("the rk-u-boot-env MACHINE_FEATURE is not supported for this build")
> +}
> +
> +rk_generate_env() {
> +	if [ ! -f "${B}/.config" ]; then
> +		echo "U-Boot .config not found, can't determine environment size"
> +		return 1
> +	fi
> +	cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "can not find CONFIG_ENV_SIZE value in U-Boot .config"
> +		return 1
> +	fi
> +
> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
> +
> +	# linux user-space U-Boot env config file
> +	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
> +
> +	# convert text-based environment to binary suitable for image
> +	if [ "${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False)}" = "True" ]; then
> +		if [ ! -f ${B}/u-boot-initial-env ]; then
> +			echo "initial, text-formatted U-Boot environment file \"${B}/u-boot-initial-env\" not found"
> +			return 1
> +		fi
> +		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${WORKDIR}/u-boot.env
> +	fi
> +}
> +do_compile[postfuncs] += "${@'rk_generate_env' if 'rk-u-boot-env' in d.getVar('MACHINEOVERRIDES').split(':') else 'rk_no_env'}"
> +

Could be simplified with:

"""
rk_generate_env() {
     if bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', True, 
False, d):
         bb.warn("the rk-u-boot-env MACHINE_FEATURE is not supported for 
this build")
}

rk_generate_env:rk-u-boot-env() {
[content of rk_generate_env in v7]
}

do_compile[postfuncs] += "rk_generate_env;"
"""

Cheers,
Quentin

