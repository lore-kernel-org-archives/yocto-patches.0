Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB5DC54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:23:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.2])
 by mx.groups.io with SMTP id smtpd.web11.46472.1748859799608818705
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Jun 2025 03:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QWP8qQOA;
 spf=pass (domain: cherry.de, ip: 52.101.66.2, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWWpRMjkpOaHE76AhGsT80p/8TOlOhFEEB+Si8EPlAPX2A39yq2F5HIxl74MzTo1nJg8mItfxntrO0Xb7CssgRsTvVUJn8hY43ROMaDbg82Xvhl7g7L2REGy9lOVkWa82s/8n8SJ5DecA7mV2nVRW7EOS/zBSs/abO9sFfkgopbVvP6udbpL4R3auGxgk/o/QV3gN4KFiVtFQM0KLjDJbu6ypJLimZrxeaUOo/bXFrvo+O0SMCfb1tLZLCKBTthfRXVMUMeOPc1Aq6tUPt7c74cQxbLlYott5cGWApriLrZyblAp1tO5nNDT2170yQUsW6VslK6h4dUzq1JM65B+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO44azeDJNPC/EFoejqoLie0F7TPRR1BFl5Mi7PotmM=;
 b=R8IqORxPKOYpDhlIN42TQlCixquio5xPYE2Qx0n1bAZkeXlPTD+1hnysYjmVYczYPhK+AkXD77uoCtqBcgT4Njer1VfSAUciXTeq3DCE9OEJe7ViZVgwQhCl8SuL6R4zKWqnTTMURtMVkr24vnzez3+xePAURr6a69AYBGyy/D94KzFuv6nJHdXdHFi/diJLCi1ILjWKn2OWDZaX2At2EOu9gq7bb/wM71BT5GNwenVhXvOR3oajfKQWkfyNDiJ/K35XTT3LqdT/C+sDGAzoP8DpeiD7gAhmzo+mc4pSHAbDHDl8IAGAY40/UfxB2tpgIzOnWutzzKrHu0nkhAP9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO44azeDJNPC/EFoejqoLie0F7TPRR1BFl5Mi7PotmM=;
 b=QWP8qQOA4wn6J1CqkOdr01JdG7+drD8KsYdqW+oUueasgoPbTWKsyoHbB7YyIqPVqhLStDUXGrFQcVSr/auez4lXtyGrJawhlVxuy6Cow61PmCJsG5FvwgPgz99wiNAwSUW0ezI+7QzN+xXPkq16Yyi4MTWXl1as7eF24ZnwdjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Mon, 2 Jun
 2025 10:23:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 10:23:15 +0000
Message-ID: <4e9fd55d-18a0-46b1-9711-0dcc2df1aa32@cherry.de>
Date: Mon, 2 Jun 2025 12:23:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][scarthgap][PATCH 2/2] remove
 radxa-zero-3{e|w}
To: yocto-patches@lists.yoctoproject.org
References: <20250530172234.7393-1-twoerner@gmail.com>
 <20250530172234.7393-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250530172234.7393-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0499.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10483:EE_
X-MS-Office365-Filtering-Correlation-Id: db0f3f09-1c6e-4f2d-84fc-08dda1bf7c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3MvQkhnYTBtajUyMUFMbisxdWF4WkdFRXdQNkViSmdOQndNVFNYYXFZaURG?=
 =?utf-8?B?RmRrMGFQc1FKOGxmc0cvbHl5OG1jRUlSaUJaWVVFeXI0UUloUGI5U0pLbDVE?=
 =?utf-8?B?ZWF3T3JtOCswL3c5VU9MZ3hUeTA2bXVFRjNYbEFScXRuRzVCUG5QMEpObXdx?=
 =?utf-8?B?S1Y3VzJwUm5URGxoU1pRc3QwanBvN2c4TDJ0VkJ6ZnFtak12ai83a0RJRnRM?=
 =?utf-8?B?MjY0SzUzeVQwc3ZjT1VFTGZrK0tIQ0hMMHZyOVJ5ZmgxNCt5aFhEa1ZpODFH?=
 =?utf-8?B?WklYZFdRMjRQSnFVZzY3dzB3UldQOFpPamFhWWhJREhna1JKUGlHWktPU1dJ?=
 =?utf-8?B?Uk1iZXh4WmlKcjh1SmROb2w3MDg1cGN1b0l5azRSdUdabStNNmRSR2tNUEhs?=
 =?utf-8?B?c2UwNkpaUlo5aXRLUk1nTTdrZGRKY3h0MHBSNXExdGRYcWNPa2tEaklCMUJz?=
 =?utf-8?B?L0hONGVqNTN1WllFdURmb0F0VGdxWXdId1BkWmQzdjVKaXREN2E5UjVBdTN3?=
 =?utf-8?B?SUx6YWhIRWZDMnJ3WmtrR0E3WFVVYVp3NCtNTEtyMjVJVHZuRFY0Zkx1eHQ1?=
 =?utf-8?B?RmdZU0hPRHlSL0pObFZQRVVRaXJabitDY25qdXpVNThaUS95V1VNNzI5WmVG?=
 =?utf-8?B?K2R1WlZ2dXRnMVU4WVlZcy8yL210cCs3WGgvNitJQ1B6UGxjeFpSR0VKanlM?=
 =?utf-8?B?NTA5enU2UThGWFByQUNjMWxKcnZMdzBIcnVlNUV0d0I0YzVsNVAvU1N3Y1ZT?=
 =?utf-8?B?ZE95MXFaMEo2RWZ3NDE1MndMa0g0VUdkcjdYKzhxanpmNmUza1RMM3hJcWts?=
 =?utf-8?B?WVRYa2xZWDRaMDAxOGU3bGNWOUxzZkdubVA0N29PSnlGTWk0V01ra3dLMWU4?=
 =?utf-8?B?alovdzc0U0xneTBFVHpwTFhCcUtUSkdzWEJTVVJhdFAxdVZZTVpZVDc2V0Yy?=
 =?utf-8?B?RG5kT2d3aHUvR3dBZ1hMa09xSklsMDNUOGVpMmRTU3V3Q1lsdHptZEJOemRH?=
 =?utf-8?B?MjRGRU9vOVFaa05rS2Fmak5hOGd2Z2poc2hSUFBqajdxemJIRGxzZUJwTDAv?=
 =?utf-8?B?VlY0bGRUQUl4KzR4eWdsRCtlUGtFOFRpQkgzakVYcFdDR2ovM0k4RGhjS25E?=
 =?utf-8?B?UXIvMjc4YzlmK2pTaCtLbFFOZ1gwUjlCeTZhcU1XYnJ3VUx0VUF3RDBsM2k5?=
 =?utf-8?B?Qk1semtUakkxaExKNXk5WWR6ejNncGhzRS9wbWtxc0VqQ3hQeGVLR281bk9S?=
 =?utf-8?B?ZkxieW5oM0F2eW9PTkNPNVdZaTFoYnV1REZFZFArWHdNbWJtRC9yVk14MjRM?=
 =?utf-8?B?VlZObUNFbFBxTzBRS3JvYWRZc1FNSFA4MVRzdjZJUXE2bk9HVDlGVE9jY0hr?=
 =?utf-8?B?ekxSbzNBaTR6SCtWQ1hmUXFFdGdnV2hxT3BSSnJ3a0dySkZFZy9ZMUlGZTIw?=
 =?utf-8?B?elVid2oyeGRrdytlK1I1ZWhTa2t0UGZ2Q1VOcE1lL1BZaytaVzFZdVdjQjNG?=
 =?utf-8?B?UEZ2NXVuZkdUdXpvRmdmM21QWUI0ellDTGdjZE1GSmpWTHN3cmg0VU5WUFVQ?=
 =?utf-8?B?NmJRdDA3K1lINjlzcDV0ZFlkb0ZNSmgyNVVWd1hINFZRcXVnQm84ZVo2SEhC?=
 =?utf-8?B?NFBLdi9xU0FGUlRyWFlGVk5JWm5EM08zOWhycFZRcjY3MFhTdFMwV3FzcFM5?=
 =?utf-8?B?YUc2WGdOa2JydXQ5OUg3Sll2M2ZLemNvak9yblhpSEdkQnhuaWtSTGtRNjNI?=
 =?utf-8?B?b2dDRWNkem8yUmxZWFpJT3hBWWVKSXlSMHZEOG01WVhwcVI2WS9GVWtvZERD?=
 =?utf-8?Q?0MSDDcBe4NLQ2UqnZVfJUGVc+kDRcemiA3Ovs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWswa1F3N1REczhxMUdaMEJQZk45VjE3Tk5UbmpDeStEb3N1b0Vub0xhR0tE?=
 =?utf-8?B?RVJXODF1Zy8wblJwQmdhTVlmd1Z1UVlISG5pL1dnYWgvRWIrZjFiY2JyZitv?=
 =?utf-8?B?UVd5cXlLYytwNi8wMzBMTXV6OVdTVm5EOURNTWxDYWZTU2FFZDBsamxqM282?=
 =?utf-8?B?WWVwR08vc3NSL1NBYlp5UkhXM1NEN29vcGZ4ZzE0bnNrVXdVQTFGcmRNeEEv?=
 =?utf-8?B?ZUJrOXgxcG1YT0dWTDQ0Z3orRkR5eGk4cEh5bFhhcDBXS2hGNUY3ZzRSbkhJ?=
 =?utf-8?B?NE0vUW1lMmh5TEtOb293ODV2TGNYeFVpTnh3V3dPbHg5NDloUlNPeUdOVWlG?=
 =?utf-8?B?VCtvaXZpU0VxclA5djc1clpnM0doUXNIRVhLRkN3VklKYlljekhTZGtBVU5y?=
 =?utf-8?B?WWlKRE8yc3BnZTJqaGJRRnkzdFpDZW11WWhCMitXN3BXUWZmN0VmT0tOZjBu?=
 =?utf-8?B?MU9RRWc2dnZpVGRLUXlRd0IwaDdyUi8xdEluOVplaXFDRXNpSWdRNWI5SG9G?=
 =?utf-8?B?VGR1ekMzSmwwQUlWTUs3MkFtT251RytTQllVNHpMZEwvMTJlbGQvbGM2aC9h?=
 =?utf-8?B?eWthV2QvRHY5K0FWL0xvdzZ3L2l5NWphWDVBZUxOR2N6WUUraGRuRE9ZTkgw?=
 =?utf-8?B?blFLSHlwWGhFZUlQZm1obEMwb1RHTFhYUU45UGJUQ254OVhsSnVFQlJOek9s?=
 =?utf-8?B?dWcvY01KSXJxMkJ5amU1UE9TV2Jqd1VVOEtZd2hzZ1JvZmxtM2UxeHFTcGwz?=
 =?utf-8?B?VVZaZjRHM1Njd3JTczJoTUN0TDV1T3ZNYUtQRXdrVE9FVVdxalZ6ZUJTbHpC?=
 =?utf-8?B?WjMxWVR5czR0ZWhMZi9qWm9VTkhHTzlCK3RUL0tZZ3dOTmJpSjRSZktmek16?=
 =?utf-8?B?YVJjemtraEN3VU83QndMa256NmFWMDA4ZHRnMlh6dzRKTk1mUWx5TXNTSGhm?=
 =?utf-8?B?R1o1UFlrbnlYU2VYOVlrR2tTT2J5eU9QUXhMZzFTS3NmWG16OGVGNHJGWmh3?=
 =?utf-8?B?UmNLUFkwam8xTDZrZXIzQ0NFd3dRbzM3a2pJdmhoSE4ybXo5K09QZDU5WFpB?=
 =?utf-8?B?MXIrYmNHODVQVXNoUS92bi9jTnh1NExPblVNZGREanRRVFk5cVlsaWI5Q1d3?=
 =?utf-8?B?NDRGbHgwOHA5QnhnUkhxOE1uR0tHK21pbjdRcXVZWmpzMGxuMHBubFhqZTRj?=
 =?utf-8?B?eUxzS2tjWW94RCtLc0ZOMEVOWHAyWDIzbHZYS2U5SmN5SW4venBMZ28yNW53?=
 =?utf-8?B?eG1Db0pQZ0tsbk9wWVd0alVrNFdaWDBYTEc4VWFBWlBzZlhvZnRoZjhCbmg4?=
 =?utf-8?B?Y1hXK3p3MGI5NnlYR1dUb0RVV2Q0SHlPNnNxRHJleFYwZjEvcHdrRklIdStQ?=
 =?utf-8?B?aGlwQmlrSk9rNm83aEV6emR3QkdBZjRvUVZtSG5LeHN2ejlZOXQ2NTRqMDBW?=
 =?utf-8?B?d2x6eS9aWXdYbzhWKzQ4Mm5LY093UnBGbjNWSFF3MjF2VTBGV1JZRy9IU3Vs?=
 =?utf-8?B?RHBxb2NYMlB3b1dQNno5WTRoZlEvb0ZhaEZHN1JPS1VRVFpPcGlvMGZ6RTdw?=
 =?utf-8?B?WXhQNFFoUjlpWXE4Z05yQXpSaElzc0FqYk1vZ0FXV0pDREk2TVdmU2xQVVJl?=
 =?utf-8?B?RDA5V0s3Wi9yZTdFaW53WW03SEcrZDlOYm12WUMvL1BYUVNMY2ZicTFJY2gx?=
 =?utf-8?B?UGUyaWt6dEU0dmxIN3o2MG5kNGpMTEM2ZHkrMnNQTXJ1am1kSlNYeVFDdGlh?=
 =?utf-8?B?OVdsQWFhYkt5NVY3YmJ5aVpCbzhmcm1pK3dvUUNkQmxBelRMMU43UVlLVnM4?=
 =?utf-8?B?dW5Vcm5nYVRmVDRmUkNSRVNZVVVWdzNqbVR0b2ZFc0M2YUlaQ1FPWjI2QnI3?=
 =?utf-8?B?WUhkbjFaY3pXak5jbGFNQk1haTMyNmVMQ202em9pNklkMjc1NjZzZlF1WjNS?=
 =?utf-8?B?endtMVZtYit3Nlk0a08xR01pZ1J0SGVGT2JHUURqMFJzS3NWN3NsR1lES0VB?=
 =?utf-8?B?Y1czN0NaalNOaVc1bjk3S2FQbmJicFl4TjVGSG1IbWhEV0RaTzZhNlF2MmRV?=
 =?utf-8?B?TlFMc0tsQzRFSmIwbjgwV0tPVU9JUFhpSFU4Q3lkdW9hU0xEUUZQeDRkQmVD?=
 =?utf-8?B?UnNUaW1tOGNJbVM2Tys1ZDJyYktpeFNNRnpaUjJCY3hrc0gveHp4OUxMOHdl?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: db0f3f09-1c6e-4f2d-84fc-08dda1bf7c7c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:23:15.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2fxUh+52PUPIdHjAI5906ledRPDfQ/tc6vBqhmL8dn0b78DbjG95wOAhbBKAS0ktwVQhg2XrEDofaFdDYesqMBUQlh9uhsdaxyci91/VgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Jun 2025 10:23:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1605

Hi Trevor,

On 5/30/25 7:22 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Remove these devices from the scarthgap branch. In the scarthgap era they were
> only supported using non-upstream forks and branches of the kernel and u-boot,
> branches that continuously move, change names, and disappear.
> 
> Branches after scrathgap have upstream support for these devices and are a
> better choice.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/include/radxa-zero-3.inc   |  8 --------
>   conf/machine/include/rk3566.inc         | 23 -----------------------
>   conf/machine/radxa-zero-3e.conf         |  7 -------
>   conf/machine/radxa-zero-3w.conf         |  7 -------
>   recipes-bsp/rkbin/rockchip-rkbin_git.bb | 15 ---------------
>   recipes-graphics/mesa/mesa_%.bbappend   |  1 -
>   6 files changed, 61 deletions(-)
>   delete mode 100644 conf/machine/include/radxa-zero-3.inc
>   delete mode 100644 conf/machine/include/rk3566.inc
>   delete mode 100644 conf/machine/radxa-zero-3e.conf
>   delete mode 100644 conf/machine/radxa-zero-3w.conf
> 
> diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include/radxa-zero-3.inc
> deleted file mode 100644
> index 1c6f972c1e31..000000000000
> --- a/conf/machine/include/radxa-zero-3.inc
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -MACHINEOVERRIDES =. "radxa-zero-3:"
> -
> -require conf/machine/include/rk3566.inc
> -
> -PREFERRED_PROVIDER_virtual/kernel = "linux-torvalds-next"
> -MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> -
> -UBOOT_MACHINE = "radxa-zero-3-rk3566_defconfig"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> deleted file mode 100644
> index 2522851fa392..000000000000
> --- a/conf/machine/include/rk3566.inc
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -SOC_FAMILY = "rk3566"
> -
> -DEFAULTTUNE ?= "cortexa55"
> -
> -ROCKCHIP_CLOSED_TPL ?= "1"
> -
> -require conf/machine/include/soc-family.inc
> -require conf/machine/include/rockchip-defaults.inc
> -require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> -require conf/machine/include/rockchip-wic.inc
> -
> -KBUILD_DEFCONFIG ?= "defconfig"
> -KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> -
> -PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin"
> -PREFERRED_PROVIDER_optee-os = "rockchip-rkbin"
> -
> -UBOOT_SUFFIX ?= "itb"
> -UBOOT_ENTRYPOINT ?= "0x06000000"
> -
> -ENABLE_STATELESS_VPU_GST ?= "1"

Not sure this is wise, people could have their own RK3566-based device 
with their own U-Boot, kernel, etc... recipes. I think we could just 
remove the machines, but keep the include file for the SoC?

You could remove the KERNEL_FEATURES if you really wanted to I guess?

> diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e.conf
> deleted file mode 100644
> index 37792cbf36a5..000000000000
> --- a/conf/machine/radxa-zero-3e.conf
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#@TYPE: Machine
> -#@NAME: Radxa Zero 3E
> -#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
> -#http://radxa.com/products/zeros/zero3e/
> -
> -require conf/machine/include/radxa-zero-3.inc
> -KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3e.dtb"
> diff --git a/conf/machine/radxa-zero-3w.conf b/conf/machine/radxa-zero-3w.conf
> deleted file mode 100644
> index 5193d45e1f69..000000000000
> --- a/conf/machine/radxa-zero-3w.conf
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#@TYPE: Machine
> -#@NAME: Radxa Zero 3W
> -#@DESCRIPTION: The Radxa ZERO 3w is an ultra-small, high-performance single board computer based on the Rockchip RK3566, with a compact form factor, and rich interfaces.
> -#http://radxa.com/products/zeros/zero3w/
> -
> -require conf/machine/include/radxa-zero-3.inc
> -KERNEL_DEVICETREE = "rockchip/rk3566-radxa-zero-3w.dtb"
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> index e555dcdac355..7e0bf813d27a 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> @@ -16,7 +16,6 @@ S = "${WORKDIR}/git"
>   
>   COMPATIBLE_MACHINE = "^$"
>   COMPATIBLE_MACHINE:rk3308 = "rk3308"
> -COMPATIBLE_MACHINE:rk3566 = "rk3566"
>   COMPATIBLE_MACHINE:rk3568 = "rk3568"
>   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
>   
> @@ -42,20 +41,6 @@ do_deploy:rk3308() {
>   	install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
>   }
>   
> -DDRBIN_VERS:rk3566 ?= "v1.23"
> -DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
> -
> -# NOTE: the following are not typos
> -#       the rk3566 uses the same bl31/2 as the rk3568
> -do_deploy:rk3566() {
> -	# Prebuilt TF-A
> -	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3566.elf
> -	# Prebuilt OPTEE-OS
> -	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566.bin
> -	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3566.bin
> -}
> -
>   DDRBIN_VERS:rk3568 ?= "v1.23"
>   DDRBIN_FILE:rk3568 ?= "rk3568_ddr_1560MHz_${DDRBIN_VERS}.bin"
>   
> diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
> index 00cc15c6221c..2d9ec2e676f7 100644
> --- a/recipes-graphics/mesa/mesa_%.bbappend
> +++ b/recipes-graphics/mesa/mesa_%.bbappend
> @@ -1,6 +1,5 @@
>   PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
>   PACKAGECONFIG:append:rk3328 = " kmsro lima"
>   PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
> -PACKAGECONFIG:append:rk3566 = " kmsro panfrost"
>   PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
>   PACKAGECONFIG:append:px30 = " kmsro panfrost"

I wouldn't do the changes to the recipes, especially since we support 
rk3568 still, which really is kind of the same trick with rk3566 as 
between rk3588s and rk3588, mostly the same except some additional IPs 
(e.g. PCIe, additional Ethernet controller, SATA controller, CAN 
controller and ECC memory support).

But the removal of the zero-3* machines, I'm all for it :)

Cheers,
Quentin

