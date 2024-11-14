Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA0D65C79
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:23:58 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.65])
 by mx.groups.io with SMTP id smtpd.web11.35012.1731583435531774597
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Nov 2024 03:23:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=W/HjIM/5;
 spf=pass (domain: cherry.de, ip: 40.107.249.65, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he7J4tlZCQPzwHXcYAGLEP4lkyFAuwoCR4z5MSahbW9E/gkENKDlUdK8LLmaJJ/CFJwIsMhrDv534ljMcr7SADvMWfyj30sD9EKXdfnK0R3TvqMEa0+0rTL0JeiA9S8bytSPCeIVP2Zf1F2/BTZxuKZGINor31VNdu+kkCM90FKJ/VZwG02swTDx/0BjY/3/jX7fU24JkLw4zAzZSPsVCbJG+tG0gd1EFMiyShNjk+xVoYM09J5V9Tw5clyF78gWaoUhCmOTSmicWL7Uq3h+tFOu22CHSb6TSu5j+yxQyNdszKlsjEkCZMzkGX025cgKeUPBjfqnsDjkRmw3JyUa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMrgLcDDLvEseL92cu0ic3WnIGnvCNQGd/1c6PENgvc=;
 b=sw8bWN4e5X8bgz0kmpxQlIsur6FQNIIhXkkqC9D/vgQeouN2WISxW8tkqrRHOeZeeCV2igSl6ijQx/cMSKBXBdXq6SWSIfiZNxd828X+YmcTk+YUs/OP++SRRtcTJNCwkoJ2jARrDAcSElSySCSD0zMDDMscOOrFu8mQaaWitbccal5T3a0YZeSKpe3O+vt8hJyMmdsVSQgG9SzrI/8vN3mZ0kEA6M1ExJroh9Bom6M8+BOwH2iu+Ni1P+/Wlxxts9Idz6nGX6MTduv3AQFyRgTJGStOUkPEkVXS0owdbzCuCfoskb5oMly4b6Tt5VWK43JmHhOs82TzihEm7r2S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMrgLcDDLvEseL92cu0ic3WnIGnvCNQGd/1c6PENgvc=;
 b=W/HjIM/5vw6kRJgl9h6oXc3cAfIYw41//ZdtWSN8V/XeG4LU/naEruoZXnloWmhEuq48GqjI+r1J5W3JWKESuBIsM81g/rMS4Wz6178ezz/+K9pd9S4HFIVoutnb42TAMihjiy6SUSNMztWa4csv6KiZHqZiahchJTPnxJ/iHG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10232.eurprd04.prod.outlook.com (2603:10a6:800:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 11:23:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 11:23:51 +0000
Message-ID: <6a4642a5-95e0-483c-a0b2-c54fbef882ba@cherry.de>
Date: Thu, 14 Nov 2024 12:23:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/3] bsp: rkbin: split rkbin into separate
 recipes for DDR init, TF-A and OP-TEE OS
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: de0f24d2-7e3e-4bff-e5e8-08dd049ed0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjJsUVZjWTJHN3NjS28zZ0ZWcmNmbUdrZks2MHpXV2tscXlFNmI5OTBDbk11?=
 =?utf-8?B?c1dEVnNwelNkM3pVMVpVdE9TNUtzY2RZYWxqcGpFUEtaSFVKT29VNWpiankw?=
 =?utf-8?B?YTA4dGJORXlISUNYdkk0QSs0Z1NsUlcycm9TRFZJZVJHS0h6L0xVQ2xVSFM5?=
 =?utf-8?B?NDJpZXRHNGJ0b3lTV1YrcTBSUlRsL0R5SHlIaitGcERBcWdRbGJWNG8rdEhY?=
 =?utf-8?B?ZVZmaG11dFZLK3l3TS9NOHViSHNUaFpWNEpKaVlvRWppQ0ZjR1NuRGxkV2Rt?=
 =?utf-8?B?NStxcVcwenF1Mll4SGRyWmhvRHlBd2VodU1ZaC9pbzg4cmJEWWFNQk5lVE1o?=
 =?utf-8?B?bGtkSWpuUlllbnhYWWFIQnBpc3FOb09PVTBJV2lTbTVCRFQ2ZkpVczAvMGhk?=
 =?utf-8?B?eGRmM1JVNm5iK0VPbzFCc0JIMHlKa2NRbVc3SW9GNytrRDA3NkNZOENQYmhM?=
 =?utf-8?B?Qk1hVmhiVnZOSXp6bUg3TWlYV2RreHlkUVVKSU9xU29SL0RDZExJYS94VUh1?=
 =?utf-8?B?YW5COWlBb3YxRGs5Vm50R0xrRHgzL0JaeHUwQTh1N0tYMUVMR1BmdzVyWU5Y?=
 =?utf-8?B?NjA0dXVsNElHZmxEb2JkNldIcUJWbGh0RXVkemdubkxnaVpHaTNiNVZRZUZv?=
 =?utf-8?B?c2VIKzJPdktrWndUVW41S0pFWVo5cjFEVHlWZHFkK3gvQ2FQRkJDNkxhV0dV?=
 =?utf-8?B?THh5WkZqTjhCMjdxaWpKVzNmNnJLNW55YWRJdnpnZm05RlFhUVI4QlFoenB0?=
 =?utf-8?B?d2VoR2dJbEQxd09WanFvcHprQlZ4czVFM09GblY0T0g1d0MwZkw0U1N4NExT?=
 =?utf-8?B?M2ZjbzBXUk1CWVNzbW5OeUJDSVRpTjJmZWsrRVpQNUFqa1VRV2lmaFpUei9R?=
 =?utf-8?B?WE15M1g3OFg5cHR6dHgwZ1J5SGpMdy9UV243ZTllbE80b0FjUllONlNZRlVW?=
 =?utf-8?B?ejRlM05vYXFvdnBpOTBJU1h1UmFsRWhxdXVEaEp3SnVxeUtJTEZyckxHZFk1?=
 =?utf-8?B?QWROdzgxUXZMRk93YkdZaWZKalUvWkZjYUlzOW1OZGdjcy9CQWErVkpaN1lv?=
 =?utf-8?B?ZXhDMGFmV2d5VkcxSWFjNjViWktFV0o0aCtrNEhMRmQzSE9XRUJvN3R0MTZD?=
 =?utf-8?B?N0tndW5mcVRXSkpQYkFRQTJDKzk2Szcvd3VSNTVUSElTWDkyWGtKc1M5emdo?=
 =?utf-8?B?MXdIVUdEcEtUMy91Z3VZQldVemgzSWgvNkRIV0ZCTk9lT1NaWWhCMU9GWEo2?=
 =?utf-8?B?dEFDL0cvV2RjK21VOEFjbnFUeW9XZSswWERVQ2h1bHFJTDZKWVNta2FIb0Ex?=
 =?utf-8?B?S2J2THppdUt5a1Y3eWNaOTgxWjBlL2ZHTkhPdXNPM1J1aExKRmdUT0U1Vy9G?=
 =?utf-8?B?TSt2bWVueWxLSExSaG5CODFxTDdFa2dxWjF2cmgzQWlhdHo4OFM4UjBnVXpO?=
 =?utf-8?B?TmMrdUVLejNhMno1WVgyWWNCMWZORDB4M3M4WEhFeHBic1JOb0ljbFVwaGgz?=
 =?utf-8?B?dS9sYS9Da0sxa2Y5czRsV3dOaXlmSEcxaGJvL3p3U1lONGRESUlUb3REUnhN?=
 =?utf-8?B?dzJISHU2VzN2NHIrR3RpV1VrUTFocG80Nk1kQklNMk9IRXcvY0p6dGdVRmRO?=
 =?utf-8?B?QVA4d2FDQlIrbktjN2ptcWRlcVRnSFM1MEtvcFkvaUd6Qys2YWFVWUJ4R01x?=
 =?utf-8?B?OTFzSWdVcExTNzVVS2ROVk9iWFU1NWtESEs1UTdjWGxEUi9XaUI5VHpCeS9K?=
 =?utf-8?Q?BslpSz0HXuZ3Q6HbYvvwmyfMw5ZN5Bj830glwuZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEtEejBkaHBpeXM4OGVEbU54VUNCYThIK01zbEhvelkrQnljNGs0N2tOTHhy?=
 =?utf-8?B?YzJJdDBiZ1MyYkN1aUEvay8zUVdGcVNzM3YzbDFzZXh3aFdNcDNzVkxaY3U1?=
 =?utf-8?B?ek5TZzV2TEJnKzJCRjhDTTVuc1U2RWF3M1BXb2lINmc3UTQyaEVBaFdsZ2hR?=
 =?utf-8?B?a1VVc1VSN1QvN1FyUkMzbXJCSjJNYW1DSHZzaW9kSC9NMEttRDN3V2daRzdR?=
 =?utf-8?B?aldWcUVzMzNWQkhrMEJTUjZyT0U4ZmdUYWJjVU01L3hVRUdBMUtxY0xtN25n?=
 =?utf-8?B?bnpwUmJCcGZhVEswek8xaXVzZi9xQmpTOFczMFFrUk40NHBSWXh5YkFtZ0tM?=
 =?utf-8?B?N2xPaWRLNWx6ZDZqUTNXaVdaSlF5R3E0YXVKZ3JxS0lVV0xzcU5FTkVOQms4?=
 =?utf-8?B?TjRYRzR2UnVEOTJodmdkaUs1eldEQUI3UnpKUVdjSzIwckJUU1lPbHFXeG1S?=
 =?utf-8?B?WitqQzR2UWIwTEtmRHhuak5ydlphejh2NTIzamd6aENnOFhxTFVxM3l4SWV1?=
 =?utf-8?B?MDdLSWpTa1Y5WkZDWkdVZnczc3JsbXFDdTdkUDdQdlpXZHo1UTFkVmhJWXNq?=
 =?utf-8?B?cG5aYlAxaVlJVXJ4dU9uK2NSNXl1QWlCMXp5NEhNZU5zSlVQdHNjUUhuY2Fo?=
 =?utf-8?B?OGxFMG5QWlNJNllJU2IyWTgvTG0xNFVraVpLZ2EvcG5yVk5oS2FSSXRTS1dF?=
 =?utf-8?B?a05jcDgwZzIwSkQybDdqZ21wbFFRZkd6WHVjTHRoSzlmRGNZRWVFeHpZdkc0?=
 =?utf-8?B?dDhWS3E2bUxzcElRbW85WHIxTm5DV1hhcDFPbE9RbTc2cWI4MUdlOWZLcnow?=
 =?utf-8?B?N0FtbEtDQ0duakV5TjJnVlg0M1VNM3h1Q1prRmUwenNGcHRhbTJZaENFMzVX?=
 =?utf-8?B?aHRxaWwxZU14Y2doNFBCYngrQ1A0d1ptZmJsdzdRZ1ZpaEhLVkhZK1JJT0xE?=
 =?utf-8?B?Wjh4S2JURERUeWRUZVl5M0V0MkpaWG5pUndtV3E5d0hXRjlKazFTeWp5NDUv?=
 =?utf-8?B?R2tHeWdQSVRVSG9NRzZ4MnNOZitBL1Z0ZEJkUVlHN1dvNE5vd09VRHRmYlNY?=
 =?utf-8?B?bEMxMjJpaktPN290ODJjaURFeVJUTGlaa2tqTWhBb1J0Zk82U3JId0N2aGV2?=
 =?utf-8?B?eVh5QUJoaUJCV2FxTGYzZG90RitKekNOdjNTdjZyMWJhdURhQ2JuQWhZTUs3?=
 =?utf-8?B?NWtIdXNBVlo1ZXNXVE96ZXFyVHNQTlVVYWYyLzNlemdMYjNMcmd6dmJNSUpM?=
 =?utf-8?B?MkxMY01kU3NkRm8xZDMvZlhZVy96cVRQMTRlU1Y3L3orMDVtZzNBMHdoV2NW?=
 =?utf-8?B?N0wrUEtNUTE3d0twQm1GTFR0KzAvTE0zREZsT3AwbjM1cmxLbWNnRnZSaDB0?=
 =?utf-8?B?T2ErZEtVZmtrSGdCaTNTN3dkdHVVRHVObytMVkY2Y29UNlFHVUorUDRGeDZp?=
 =?utf-8?B?QXFCQWVNQW1CWElwclc3VVFPMVlaaFhSakE0cFhVNWhlbkpRMk16M0tkczVY?=
 =?utf-8?B?QmUvWTFKRHYzeEdGcEgwVnlMNUI2MU9wYXZEUXR3cEc5UzFUV2dIL1dJWVZp?=
 =?utf-8?B?Nklabnd1QllmTUZrSWdtUjUwbTN6c3prQmFSRjBKa3JFWFp3N0NOcy8yTndz?=
 =?utf-8?B?cnRIV3I0MGV2RjMyUW4xRHB5RkpSdHJYdDFNNmk5N3NGZEl5THZXRk1wd1JC?=
 =?utf-8?B?N0ZCKzBBSzU3SEQrdjFXam1jNkVuYmRJaTEzSkthTThOcFBwZlJ5TkxSaXhB?=
 =?utf-8?B?OERLR1cydkRiZ01BZkNNWXN5Qy9TTlByMlVHU21pVzVmOTNIZHViSjg1czJG?=
 =?utf-8?B?QlZiV0xwaG1wdW03UDNGZ2hVR0QwU3VWcDErR0Rad2tEb001cmF2TU1mL2R3?=
 =?utf-8?B?bnVNbGU0QVh1SFFCWkp3MTdUbGEyZEJpYWxidS9OMXB6NGROaW9sRmU3c2ZL?=
 =?utf-8?B?YVRuL09BOTRxNzBoY2VHUkJHc0ZFQkxXQ3pLaVhicUhIOUNkYno1NCsvQXZZ?=
 =?utf-8?B?MXRVcm94RTk1VzNhZ2FuT21IYVBqY2VQRUtNYWhqMFFVNkpmMFlIdzBXVElr?=
 =?utf-8?B?cDlqWkM4eWpWSWZGc1c0bSs3REo5bkgwalBSdkZFc0pnMUNTTW85ZXlRK3Fa?=
 =?utf-8?B?Y2R6VE1xQnEyamUzSVpRbTgvSzBuK1B4RWRQaUxDZHA3RHdEaDVJMEs5VzlC?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de0f24d2-7e3e-4bff-e5e8-08dd049ed0cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:23:51.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZj/Z65W/V6JKCUXXevUgtrpeJsnqVtDgT7M6K5n9UrAg5Y0ABzB4lwpcUEe4c7PVYKmRyximDyqyW348ecwFPn4gsMgpXl9VxfOElk96NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10232
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 11:23:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/798

Hi all,

On 9/27/24 2:36 PM, Quentin Schulz wrote:
> This is in preparation for being able to use upstream TF-A while still
> having DDR init and OP-TEE OS come from rkbin.
> 
> This is necessary because the do_deploy task applies on the recipe level
> and not package level, so if we have two recipes deploying the same file
> (e.g. rkbin and trusted-firmware-a for bl31.elf), the order in which
> those recipes' do_deploy task will be run will decide which binary will
> be used. This is terrible, so instead the binaries provided by rkbin are
> split into multiple recipes so that only what we're interested in will
> be deployed.
> 
> Note that the rk3308 rkbin recipe wasn't changed but I assume we could
> migrate it to this new "layout" too, I just don't have a board to test I
> didn't make mistakes.
> 
> This was tested on master (styhead) branch from yesterday, plus
> https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/T/#u
> for meta-arm on an RK3588 Jaguar board, plus some patches that will be
> sent as a separate patch series since it depends on the patch from
> meta-arm to be usable.
> 
> Nothing else was build tested, but since RK356x is now supported in
> upstream TF-A too, I added support for it as well.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Just because it's unusual for Trevor to not send a mail saying it was 
merged, I do it myself here: this was merged into master.

Thanks Trevor!
Quentin

