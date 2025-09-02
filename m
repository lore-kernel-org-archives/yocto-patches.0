Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B21CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:56:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.web10.76739.1756817787665556974
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=GSGbDijB;
 spf=pass (domain: cherry.de, ip: 40.107.162.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iq1ROx44dfShDXn+Fx3r4OxUNhDgsJXflbYzKJNKXKY+CV339LsX50ucMWVEPKuNNkGFDR1Vf58aA7Vrl7rmROs/m7MrvSLoPU/ObVnWjghZBuvKoozLCB5s7slC8ZSvgrqBK1eG/gtLRLvYRwIuvBgVJHVi1mjjfbmxHhVMEV/nb1jH6pyuVJigD48x2XNdjWzHunndUVIXMTnExbsEDOUV2cE1RgoopAduXPOxnzgwELEzFiGa5YzISddD1sDSKYcTmJga4KAsCdOYRfcgxpylSXCztQxdwStMPWT4QrC/tcPQmxLX7WrYhAqk3bGUL8RLRA89jV/+LlgdM05gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7zhmYX7K6oySDIxDl6dyb2nAVXj9hrAQI8AbwHjDGs=;
 b=R2URU7PTxAqGE+R36mTaSUVKuCKT5PZxdOd/DDaADcPAWiGwFB2mzQPWcWHU79HYIddyPfkGuIUv5ii2XvhalMDlaGViyha5Cw4In5iYGptYF+0zAUI7LZ+18WkyR7+D4JIGPj2TOlF79iyVjONnZo3wa0kmQ7MxwoNKdFwAdkjZZGHjujukYHuOk/cE5YVF1rwD46JXEHRbjBNrnm1RT7+iO/KQPoNjGVt2chbyXIgkUdqAbbNOio0ptKbEMVTgd/izEF5NxyAaVwXncLqeXdDO5mQc9wYhFKnGIYQMkSC6g4geUb/2/W19aFghNKaLLGQFCrkpq0wp0gn/lJ9H2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7zhmYX7K6oySDIxDl6dyb2nAVXj9hrAQI8AbwHjDGs=;
 b=GSGbDijBqI6WRO8nohpXUu386N3gzJyWKfqPJXgICWIiItxN7P1Kc4a2AWAT0LDYdAocv+IMffkv12O/BWpPZ5NIPhujjBAVUCIVO+asz5fib7DNmnqaiNVf/7IrNAhdtZfQusPFW+Zh94p6m17No43uY1+UMkskGB6XHOPzGrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8671.eurprd04.prod.outlook.com (2603:10a6:102:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 12:56:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 12:56:23 +0000
Message-ID: <2cc19805-1e22-4133-8ca9-7feea194856c@cherry.de>
Date: Tue, 2 Sep 2025 14:56:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] kernel overrides
To: yocto-patches@lists.yoctoproject.org
References: <20250902125435.28394-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250902125435.28394-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8671:EE_
X-MS-Office365-Filtering-Correlation-Id: c5648528-134f-4701-9da7-08ddea201f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUwzRHhHcHkvY2tVYUZtWm5VdENTV0toeWN5VFA5Szl3TkpYL0ovSVk1eDJ2?=
 =?utf-8?B?aFRzb2Q2SXZpd0dVTXFTQ0RpVkRTemhyWUlCZlBxQlpYZjFHamNsTWhRMlE0?=
 =?utf-8?B?STRCcGtFR0ZDM09zZkpZUUt1TEM0WWpNUlVhWnh5bUNhbFMxcGl6OVRtZGNE?=
 =?utf-8?B?Qk9jdlVGMUFWU2lIbUhpT3F0MmcwOXNZR3MrQUJ4cFV0dlpmaExuSFFsTWNL?=
 =?utf-8?B?Y215bHJDZ3JvbjRRYk02OTM3Uk9JSFhEdXhZVXhuMkFtKzA3TG1KVGdhU1ZK?=
 =?utf-8?B?WE1oSVM0N3VXKzVHbldMSzVIdlNndktjSmNNaUdWNGJVVVJMY2c1ZHZkeUVw?=
 =?utf-8?B?SEl6WUpRWHVmV0toZDZGQ0hVMDBQQUhvblFZNjRvRG5HdDlBUkZvL01DQnlZ?=
 =?utf-8?B?dmdhd01BWko3WWt1eVR6dG9SekZIN2JjQ2JnK0NxbS9DVHR3dGZTQ3BoSDUy?=
 =?utf-8?B?ZUV4UmJIM2JTbTUveTR3akhJbmVHVmw2ZjZycVVYTTVncHJsUXNudlg5dkRG?=
 =?utf-8?B?UHpRWVZManRrTkVSRGJkb2ozM2Nld2gwQlFtMGd6WjBNYVk1aXRNSGo1SFh4?=
 =?utf-8?B?aEYyQUZlMGsxN3JPSUpZaDdYVUt4cDNuYzRhMVpna1FmSTh4UEV1TUpwdysr?=
 =?utf-8?B?amFmNzNwTG5SeVNOSnQwNkhzS2JiWWRlbGJsTU9lclBETXpjeTdMUTJWa2sv?=
 =?utf-8?B?R2VyZ25MTUgyeERHbkVGcVc2NHErNmx5NSt6VUVLSWI3ZG9YNmJhbFk3eFdM?=
 =?utf-8?B?dEg1bjFYVGVwbkJVMHpUeVpIM2RIcVJPQUo2RUFaTlE3R1BhUjB5VjFmQ1E5?=
 =?utf-8?B?M0ZnT1FwNjFrWWhRR3d2Z2FIeFBKOUsvOUpSTW14YXZBMG94UEQrSVFzK3Fm?=
 =?utf-8?B?RDErUFgwTEVNcWZLcmlRbjUvS0JJUWJVeUlvSVZ2eEJhaFVDSnQ3OXl1dE1B?=
 =?utf-8?B?bEs0RUZ0VTVENnhuSUdPMkFHd1RkTHhkeHp3RERkQVRqdUVHM2kxTjlqQzdh?=
 =?utf-8?B?cXVleUsxK2d1NisyU29rbmFPWmtlVk1rQ3ZwWkQ4NjhTOVNTU0psZGdWQ1I0?=
 =?utf-8?B?YmxCRDA2Uk5waGdFQ0N4TmpOdmZTSno0VkRoQTdzUEhXUGdFYUhQd0F5Lzc4?=
 =?utf-8?B?NzZFQTliQ3l5WDE2VFBXVSs1bjNmK3BEcW52TTdQS29wdDNSZVpoTlFDSnJ1?=
 =?utf-8?B?S0pQbG5ucDNRdFU1WEpqMVNEUVBlUzBwTVM5SDFla1pMSWJQVmxOQVNwdTM5?=
 =?utf-8?B?NnEyOWZWOEovdHZRb1JJYUJrNHVWa0UwaitKdjdkd0lTTGJHVTBCQmU1RDUy?=
 =?utf-8?B?MnJRV09nV0prbFkwUXZKRVpzMjVZdDRjbnlEckdFRVR2VEdLUUp6OG9pNkwv?=
 =?utf-8?B?RVZBRW9vek1XUkZxYVBYcjc5SkM5T0k1YUJBdGZpSjdkcFlTTjBhbWhWbFdS?=
 =?utf-8?B?SFY4a3o4a0NUTkU0S2Y4eW0yOGQ0RmlJaHBRSitNd3BwUzF6SkFIWlFycjZE?=
 =?utf-8?B?ZFJCRWVPdERLKzYzYlB2YzVYR2dIMlF0K0hDQWdCamZvNEFobWJ1dlJXU2FN?=
 =?utf-8?B?Q0xLQmNPL1BjUHhvK1FNU1lKN1FHQ1NjVlN1VnBEaFZDZnBQMmx1cVRSMUM2?=
 =?utf-8?B?Nlkyb0JDdUZ3OXpZSFNMalNPR3ozbnkvaUFPY3AyckVWSjRaM0VqQ2ZZTEov?=
 =?utf-8?B?bDN1NFdNcTg2ZFYycDRSWVZLbFZSYUdnNDkrTUM0WXVpcGRzTFJxRWs2RFFx?=
 =?utf-8?B?RGhkQ2Z3R09lQmJZbWk1clY5NDRJUVB3cDRqRGx0enRadEk3ci94VHhMUnZ6?=
 =?utf-8?B?VnhNYW1OZzZIWmI1Wk4zaG5uUDlwOTU4d3dWQzRydEEyNk1ZaUROWGE1YzdX?=
 =?utf-8?B?bVdxcGphemlMc0dyS01rM3NVYkVXN3UrdHkrdWlmM3ZmN2xPUFYxZDJxR2ls?=
 =?utf-8?Q?YcusVoepmNw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnNSeE1UUWlqcG1iamJrcFNZRzd2dml3VFRwK092bWs1VUtsNGNYNzhuTWhl?=
 =?utf-8?B?Y25LWjNVcENicmtzV0VBTTJCczFoelFabVg5ZWUvVlFMdGNUSTN2UzFzK1FB?=
 =?utf-8?B?bUpETXkwT3VZbVE5SVNUcmxuMVRkRExZWlJiZVVaUE92R3lDTTdYTEJZUTlh?=
 =?utf-8?B?RFJ2dVkrZVVocFJjYk9iWEVrakF1WnYzY0pROExhdEN1RlJXTktpTWdscGtm?=
 =?utf-8?B?VTNwQ3BJaHpZblJkOEgzQzNkcHFZdzYwTmJOaEVON012K3BDZEFXOG96czhr?=
 =?utf-8?B?WEpZa3N5WDNuZVJoRWN4QXBvMVZJMlNHWms4c2NET1hvbE80NlIyd2t2SmNM?=
 =?utf-8?B?Uit2U1JOaUp5SzA0TEoxTWI1SFczV09ZNkNkeXBZNjNHQW1McUdZQkRDK0Fh?=
 =?utf-8?B?Y2VsNUhWODdyODluV0V3L3MzdnUwMkJoWUYzUlJVMGRXRm1ra0F2K1VMTm04?=
 =?utf-8?B?d0I1aWhKVU9NMmJPZVZoRWZ1TXliK3l4dmlGcUx1djBKZHcvRFErcVdjcGpV?=
 =?utf-8?B?K2c0cU9hcW0zemo2N1dJRFk0Qm5GcUJubjF4eVREckNDL2pOaW1Ha0RYamhH?=
 =?utf-8?B?QzJ2cDFycXZlRHlwK1VsV1g1aVJaUVE3RHlZWFRTTzAvY2RPZm5wcmp3eDdT?=
 =?utf-8?B?UXFyR0ZLRkJ0dEl0TUZnejFhZk1RWHRZaXE0UjNTTlhpSFZRaHZrdXZaOTNr?=
 =?utf-8?B?Q1JvMDAxWFhTTVEwMHhtWThsV3NMZnNwOXlpemlLYWtEMjhKZnlMNW92RFdm?=
 =?utf-8?B?bDFySXBEUUViWCs0QXg4ak9TVU5uUW1QQmg1L2cwMWdVSmIrS0xXMWNDd3Zq?=
 =?utf-8?B?UkEyc3dpTHJqeEJNOEFRYStNZ0dTSDRSVUQ3eHZVRENrbm1vVE1NUHFCSHQ2?=
 =?utf-8?B?NWQrWmFrbERnTERzTTU4bkh1YS95WkZGNmlzemhZWU94NDNEcmNCaDN5ZVB6?=
 =?utf-8?B?cWpjZzNPL2ptNzVqV0hRaFozUE1hbHNCZHNDNmJRbFp4Qnhsa0orejZ2d0U4?=
 =?utf-8?B?c2tWcStqK3QzbFRiQ1IyT3FIeW9oNHdVQmlNKzNpdHprd0ZFS1lQQmVUTy9P?=
 =?utf-8?B?YUh1YVNsY0lUcWhaWHY1SnpvdnpBL0VjcERBeUhnYmR6TGpVcnhDenMrTG5t?=
 =?utf-8?B?dDVhbkI3YzlYMXFmS3R5Z09aQitwczhSaHh5dXlLTnZ6VEdkQzRJNHg5ajRI?=
 =?utf-8?B?SHZlbG1HbXZDNnN0Y3dzMVZEcEFpL2I3enZvd1VSU2JDRVdLUW51SDVvRmRU?=
 =?utf-8?B?cnhMUGJRSWdHa3RvTjRWNWNmODBRdkZndzdtTEZCejZqOEFvWWxwc2NGdnUz?=
 =?utf-8?B?UXpPdUIyOTFIb1BSZ1Z2cUhucllRYmUvTHhZNmhlTUlxRkhyeUJhRUFqTExW?=
 =?utf-8?B?N1NhU2M5L3IyMnk3UFE3VS9oM0ZDYksxZ1hiQUxDdUYydzVFM1lrLzhkRTdu?=
 =?utf-8?B?Ynh1Wm0yT29wQUFSajNKa0tyMUtsRFNWc0hvamZ1cGlJLytZN2dSMC95TzZw?=
 =?utf-8?B?d3pNMktsaW5RTGdySWVHZnNGak51bkIyVjhzUUpBeGNSWm9Ra3YvVmVzTENq?=
 =?utf-8?B?UXVreE9NbjJLZzB4MlQ4UllqVVZFTGxTVFZzWFYzSEJCdlFIdmZXc2lkbHJF?=
 =?utf-8?B?L3lldlptYjBuVFp5aTMzbGVpZGloWlpqN01CUm1PSWNtcVVsVkZ4bHhNTEZS?=
 =?utf-8?B?RmovaUU5SVFaK3luOHpNaVczWC9CcVdmT3NBMjZsRVVGK3Y1OWxuTFI2anVx?=
 =?utf-8?B?Zk9TN0pManBBUkJ3QmlJeFdBTXd0Wmg4d0wzUzFmU2Y0UHVQMVJsU2JkZy9x?=
 =?utf-8?B?andpb1hHZHFERG92a2ViV0JnNGFRT0pld3MzKzM1STNKeVkxMndZbFdNQzFJ?=
 =?utf-8?B?UEM0Y0REVEw1Y3ZtT2pibkhqcEFGODc1WlE5S25GQmErb3lqTzFCOGNmaEs2?=
 =?utf-8?B?YW9FOEowQ09OVUZmTld5K29DWEtoYkp0WnJodndreGdEdDVpRVphYW5ycExO?=
 =?utf-8?B?amdrYmRyQlJmK3IvQVhmUEdaSzhGTE83bC9EdVgyUHdodzRKRnpSdUlqcDdm?=
 =?utf-8?B?WFhBbUV2SWhiaC9VWmduUXBXUG8yd0pUUWRRODZ4Z1R2dzRsZE9vM2tpNGdZ?=
 =?utf-8?B?NVFrS2UzbWVJUUlCZ3YxS3J5OUNocHhka3I1emdzTkgwVGxzcmVpbW15V2JD?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5648528-134f-4701-9da7-08ddea201f03
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:56:23.7967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CNl5BXl0V8j5zYFK7Bn+FdVDTRC16q/UHXzEE4+w5J7ePtFdbibEe5NZHzExWU7tnbzlkriuP5swPDJuaU9zzYYk2Ifdfy4EXOTJt0o6UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8671
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:56:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2114

Hi Trevor,

On 9/2/25 2:54 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Add a :rockchip override to the kernel SRC_URI appends to play nicely when
> multiple BSP layers are used together in the same build.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-yocto-dev.bbappend | 2 +-
>   recipes-kernel/linux/linux-yocto_%.bbappend   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> index e06c8a4f717d..67a16b4d67ff 100644
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> @@ -1,3 +1,3 @@
>   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>   
> -SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"

I would have preferred to not have this "broken" code make it to the 
master branch in the first place though :)

> +SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
> index f0fbe57955e1..75de6110c228 100644
> --- a/recipes-kernel/linux/linux-yocto_%.bbappend
> +++ b/recipes-kernel/linux/linux-yocto_%.bbappend
> @@ -30,5 +30,5 @@ COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
>   COMPATIBLE_MACHINE:rock64 = "rock64"
>   COMPATIBLE_MACHINE:soquartz = "soquartz"
>   
> -SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> +SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>   SRC_URI:append:nanopi-r4s = " file://nanopi-r4s.scc"

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

