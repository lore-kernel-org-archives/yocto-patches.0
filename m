Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B691C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 07:52:29 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.131])
 by mx.groups.io with SMTP id smtpd.web10.10176.1716450748132683410
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 00:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=af/Nhk/v;
 spf=pass (domain: cherry.de, ip: 40.107.7.131, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCTP0i0JhOijMUixLTlczOJa0zw6dBZDX2ALceESeWr92p6DpejLc/a3rD96+fIb5S+5rsdpkB1RJRHoFqaVIZqZB34Wn7v3z+Wwi8gctAO9X74oHtEZBMnmhRIlFRvYu5dVYHxbSd7er4JCoEUH61OUIBqgR6l9ypI71KNyBPVl9TI6D7x6BiByTgtef+Xe/cf65YkS9G8nZcYtaTGJmjVykVx2nXiU4JFpuSstU3Ko2rYpNEf2cKI4wo6Oi4BmSbkLlCx/D3QftWzr6QByNtaBTw1QCpEV0N+5IWdsUeZVWVFjhNcCklUxfEi8Hldg/FDrrysfqdlcVG8BcO6vVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txBwQsevdAVZOif3eXdn462inuW98Y8lf7NmEh1OtS0=;
 b=gtaU9mQZjnSAnNp0TEr5RLU+HILRzBBb9EXSJHez6YL75Eo3wLrqbr25Wv6RjqK3nM2DxVA+RKrq+r/v4fQFt5XSftkNAqelUQ4unQm9yixbTEWRmXMhlZoj7HEPGq8xv0ZfuLTTZJznmjs1/TWiNPDHY5D8OTMY83kEtdP1GE+XsXjeQspkoqLRu/B94Lsu0nhlT2qpIJCTW/Zwga/8z2vGl4Od9Kd5TD4nI4CifGKSDGUEeCqMhKM+k6FFjumoZye9HlD10Mo1mto+Mg05Cq0NToxo1oHK4rkZ/RvAtVdvMIjw1+tR75NnJ/UkeCn6L5n5IaSk68PmfYsG31EYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txBwQsevdAVZOif3eXdn462inuW98Y8lf7NmEh1OtS0=;
 b=af/Nhk/vn54ipJKz2rRNy9v64c4HFsfzz3QVT800iuF4kEgCTkmYOUUynCOHS7tKLH1l4fiesx1Ov2DYvjrLzruHB9PAC/+RZs9ydkaK8jxCw2Uk5swZZQYMA9YQNprlufF6p6h/BDWwzz8PnNWxp+o4Scyq2EClyHwmZEtwnis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 07:52:23 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 07:52:23 +0000
Message-ID: <b34f9407-1c1e-4502-b76a-ea4e839a2f3a@cherry.de>
Date: Thu, 23 May 2024 09:52:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/4] rename root partition
To: yocto-patches@lists.yoctoproject.org
References: <20240522230808.14409-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522230808.14409-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccba569-18d4-4d41-080d-08dc7afd47ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDNiZXFteHJ2ODNTYzZVRmtVYmw1TktKOUNMV0ZDbEduejZQRFlCSWtWZytK?=
 =?utf-8?B?bThRUmJzTnV2VE9UZDF3cjJtalRUMzVreHc5bS95alRlQVpMeFFsUjNxT04r?=
 =?utf-8?B?NkJRSVdmN240MkZrQ1ZqK2Vmd1diWW8wSDdjRHNVa3RCYmJldWRXS3VqSUF3?=
 =?utf-8?B?dDZmQVRCSXAvY2swckdqRFh6b3lXZHlTTDZuKzh5THdNanBHOXNKUG9hNHBL?=
 =?utf-8?B?YlBSVXdjVmZJa0MwM3RRVHlQU0NZaUNhV2FGMkUweFRiQUhWaXFlUmF6MGo1?=
 =?utf-8?B?MjZBSUtFS1pkNmZBamNiajlqdTArSmgyeTJVd0NzYzZ0ZzhLaEY1V1J1WXpG?=
 =?utf-8?B?Z1BPdWhTMEwvZVhqczBjMk1YYXpRRnhBMVMwZ25GZU1OMitRZVlzZ1pkVDBx?=
 =?utf-8?B?TXlrY0xJcU03VTU5QnFqUkJEYnVlZEEyU2d0Mk9NWVVQNzI0ZEZiRERNTENC?=
 =?utf-8?B?YnZMekNxR21oanJ5SHFrZzh1TEsxQ2VOTnowSDZwOUtEbmErNng1QjZ5M2M0?=
 =?utf-8?B?YjZIZkd0VEYwNFR4dkZZUTNVRTRUTnBqamdFdWlJV1V6MmxvSnczeENlYjMr?=
 =?utf-8?B?bEsyaTlGSStwb1VFR1BTQXlQVWRWSnIwYUtDMm5TQldmcngrNnFmd05ZTmZT?=
 =?utf-8?B?ZDBkNFFieVBWVEtkVHFlengycTQ4bzlRYjZVMjZIUHplVldFVXlUMllPTXd6?=
 =?utf-8?B?WUVrLzErNTNCYXB6Z0ViMlI1bUtOY3BKbGR1N2FzL2V2UWsxQVc4S1BaRkVs?=
 =?utf-8?B?MStRL2lxU1huKy9NZjlqMTM3MEhkUmF4TFZRUjRrLzU3VnJpa25YR1ZVZmdz?=
 =?utf-8?B?NTRrZ3k1UU9jV0hxNHFLekI4NGVxMUhGbHNraE1jejNqQm5VWlRjYUJaNkVa?=
 =?utf-8?B?cUlvaDZnSWFyRzR6ZkQ5b2hDVXl6SjRVbzdsV0xhR0dGdXA1bzZSOWZRb1lt?=
 =?utf-8?B?UEE0ZlJDZ2dGVnJ4cWQxSFFieCtYdmhjZm02aWpPNWdWd2pFeVdaY0hDTzlL?=
 =?utf-8?B?cmdvVnRYelhFVUxIK25FdTgyTkhGOTY3OTVnQVNiZXFIQWYxdFdXc09EdmlK?=
 =?utf-8?B?Tnh4RTJkQkZLS1c0aXJTbUFwZHROZjNsVXVaVERidjhOUExkNkpmK0lKWVVO?=
 =?utf-8?B?dXJoeXRmTmI1UWJpa0wzZGhYVTE4d21CejlGQ3R0anJBTkNwbzlrT0R5V3hC?=
 =?utf-8?B?K1VnT2lYNEhUdlYrYlBiSVNMU0xJd29vZkxldzlFaXJLQVFTV2Q3d0dMR2Nk?=
 =?utf-8?B?dmdWYmxWVHNaZDZQK0Z2SnJ6WitDZDIwN1RabTF6Q2Q0K2trcG16UUppQmtE?=
 =?utf-8?B?TXlmeUtKYXdiRjlrNEUrZ01zNGFMRVRHeTNiYXJtWG0waVpONndianlMVUVn?=
 =?utf-8?B?dnBodUoxejBraHNMemozTWorL1Zxa3B4b1JvOG1GUGxreWtnUktDaWo4WitI?=
 =?utf-8?B?TFB1TDhHS3A1VE9yektNVUU0VEE5blN6emJTYVBVa0grQXVVYnAyNGM0eStW?=
 =?utf-8?B?ek1pUDBveGZlNVZPSGFSUkx3NU9TUEFESFJEcVFsRG1PK0kvRHVEYVFOVlB1?=
 =?utf-8?B?SXk2dFlVdVNZQTkwdTF2VnNvSjZKOS9nT3BSVVJXUmJWVnJuYnp1N2xvdHlR?=
 =?utf-8?B?OHVPbHlKa0ErQmxlS2dtN2JPaXR1cW9YYjJhRlNOUnZ0eTJNWUhGbFpBQXdR?=
 =?utf-8?B?SFRVNmpDUkFvM25JNktyV0xlM08vTzkySjJab2hvdTc1aU5xc0ZvdUl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6578.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTBaSEZEcm93dE9zY1ZoWm56YzJMR2NtY3ZlOXZDbkpRc1dtZjhwS3hJa2lH?=
 =?utf-8?B?Wit5UFBHVWgvckk0OU9YSEdEUnFYZG5FelE2TC9KVE1hOFBkaWx5ZHlkdjgz?=
 =?utf-8?B?VHlVOTQwTHhJb3JjbmpWOTQ0MXhjWHlsc3B4QjVuRVY1R05xdndQTzFxb056?=
 =?utf-8?B?M2prZjRNRjMzUkJiOXpoMWFMcXRrTHhDTC9DT2pTeDhaTW81UHkvUUdEZnIv?=
 =?utf-8?B?eW5mWVJUZ2NXR0dDSU1vRExSZ2MyVWJRT0NQTC9FNjFJMVhHcXo3L2loOE1W?=
 =?utf-8?B?RjBXelBWWXozeVVOblhlcGlQK0RKRTdRbmJ0OU1lV1NuL2RxMXBTUVhENkIr?=
 =?utf-8?B?Ny9yZi9lY1ZNSmFuRmQ2clVHSS9VUGxMaDRSaVFiYW5BbU53V0hJZnl2cUk1?=
 =?utf-8?B?MEF6MHhzMW9yelBRMDI4WGV0S25UWUxVenpCbzZhTjdSOEJwcDBlMWZreU93?=
 =?utf-8?B?RU5qclJ4MmZQWUhuUjYzZHN3M1dmYVA0ajVtKytZK1FRKzVJbThGS3FGSldT?=
 =?utf-8?B?aXo4eUFQaTNlVWNrNUhweW5SZTdEVFVEUmFvUy9HVTNzd3hXZGN5QzI1UG5I?=
 =?utf-8?B?OU1lb2FZTGdzZi9TUlBjODNvVE14M0VDNDVHb2RGOVdKZytEMlV0YXRmZlZM?=
 =?utf-8?B?T1FFYkFGakRiRUxvS1VPY1V1V201d2p3L1ZwZjVCcDR1b01uQXVvWkkzVVFN?=
 =?utf-8?B?aGVPalJxd3ZHbjk2aUdQNzZhVWF2dzFkb3drd1pIM3kvcnZpNGs0WUpDcFdI?=
 =?utf-8?B?YWY1alRmUGNxZ3ZDOWdlRzdGWWx6cGJEN1c2RDdpOS8zRGJmRmtZMFZIQ3ly?=
 =?utf-8?B?RmpiczNoTHQ2R25SbHJoRFdIRGdFNGV0TDJoV3duZlJHekRkTDJtdVJzQmxt?=
 =?utf-8?B?bkxodlVlM2IxT0ZzUExoakhFMjhtZ1ZvK0ZxeW1QSmhGY1drcGVyaDk4Wm9R?=
 =?utf-8?B?QVhaVEFHT1VIdTV0Sjdpd2hwY0thQVhpOGdqb05DNFA1a3VMVGRXREZobk03?=
 =?utf-8?B?eXkramJpZWtoRGFlNUttOHJpQXF2WGhiNlpyQ0Z0cGlFMHFHVEpRYW03YjNT?=
 =?utf-8?B?UGJHeU1RaG1xeTdwMDhNVmhKUkJKYitqWUphajhnVXNzOUxGTGM1ZFBqaFU5?=
 =?utf-8?B?dTdnNnREY3pRbUNSYVpmRDg2amRkUk5Qblc5clJBd0t6Y3JvMXkxb0FrOVow?=
 =?utf-8?B?T1VIVHdEOEl5L2hSY0d3ZDRBS0k5bS9TZTgxaUhnS3FoSDFKdzVBTFdSV0xH?=
 =?utf-8?B?TitOd05BUlBPSFF0dFZDSUtYcGdkTmJWQjd5Wkk2R21rOFhwNm5UcHhwMDI0?=
 =?utf-8?B?M1ZmMVI2aHRWSHRQYUo0M0VFREo4YUJSTUd5aVQvOWNXM1FRSlN1dTJiZ1o3?=
 =?utf-8?B?OUVFaCsycXNsRGt0d3dwV2FUU1A0ZUx0QmFpTXo2aTdSL0x0aEt4SkoxRmc3?=
 =?utf-8?B?RjRUb2tkRE4zYmx0Wm5jRzJWT2tCVnhJZWxNT01MWjhKbFBRNUNHbE12Y25Y?=
 =?utf-8?B?ZkRGcS9sQ1BidXVkVzdyc2NKSkh6Q2F4eWRzSi9NVGp1VjlGd3o1bGlyaU1q?=
 =?utf-8?B?dEpEbmFpN0FHQSt6cEJrc3dNYlNnUk5Cb1k3ZHpiVGpwTU83dTlMRnd3bmtU?=
 =?utf-8?B?eHVlcXprSXZlRFdZOUsxdzdoU0Q2bmhsakZKWUEwQnRENmY4TEdtSzB4d1pK?=
 =?utf-8?B?WDl3U2tMNUE1ZklBNFRmY3lpMXZleEJISmFIUE5aY09oRGJocVJ4UkE4ZUVM?=
 =?utf-8?B?Tml3UldnSWVSbkUrQU5icGZYVWpKeUZHblZpVFcvREhLVEFqOG9nVlR0ajhE?=
 =?utf-8?B?cG04cE1LUFRxQ3RueXhtRmNycTZQRFRheFF3dkl6YkpQWWIrMVVtRUFHcG43?=
 =?utf-8?B?OHZRL0ZXVlA1M1VJL3M3WHI2MUk1MllSUUYrM3NCQWZzWWZpSmxSRkZUVDlq?=
 =?utf-8?B?NjdYbFlHRitWbHJHT2RMRjJRc3ZYUTQ5SHZWYjdrbnpKaVFveUJKNzJEOXNz?=
 =?utf-8?B?RUpjOUgzQjBQTi93QVNIZFBiVmVOdm5RMGlYdnh3bDdRSGlsV1REUUR3bmVq?=
 =?utf-8?B?dWc1VUtmaGZ3eVNrSjdKbDVCMmJmaFh1VWhyNndZQ0tWaGFkYXk3cEI4UEFi?=
 =?utf-8?B?MzQ1MGR4MjVtMG9nMWtQTG12T1FmRThNaVVGWjdsZ3cyWUhKM3dRKzJRekQy?=
 =?utf-8?Q?pU1NFZPwk+tCYmjhHe9VLT8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccba569-18d4-4d41-080d-08dc7afd47ff
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:52:23.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfNbC1XIK+DX48yPsIcOqjBlFkR7dy7gM8wYD5milTSajHoHOYtTGuHAGbaeU2hZIC7fy/OpuRuenXyG/zHUg9VIpZIHXR4pgE1gdYdfUK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 07:52:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/172

Hi Trevor,

On 5/23/24 1:08 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Rename the root partition to "rootfsA" in the off-chance the user may someday
> be interested in implementing some sort of whole-partition update mechanism.
> 

But... wouldn't they need to write their own wks file for it anyway 
since they would need to add an additional partition?

Basically, I'm not sure we need to half-support those use-cases :)

Otherwise, looks good to me.

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/include/rockchip-extlinux.inc | 2 +-
>   wic/rockchip.wks                           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
> index ca33f4c7f42a..ab46b76d33a1 100644
> --- a/conf/machine/include/rockchip-extlinux.inc
> +++ b/conf/machine/include/rockchip-extlinux.inc
> @@ -12,7 +12,7 @@
>   NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split('/')[1]}"
>   
>   UBOOT_EXTLINUX ?= "1"
> -UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=root"
> +UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
>   UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
>   UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '${NONFITDT}', d)}"
>   UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
> diff --git a/wic/rockchip.wks b/wic/rockchip.wks
> index bc65f73b0cf3..e1d74d9983ab 100644
> --- a/wic/rockchip.wks
> +++ b/wic/rockchip.wks
> @@ -26,6 +26,6 @@ part uboot_env --offset 8128s  --fixed-size 32K   --fstype=none --part-name uboo
>   part reserved2 --offset 8192s  --fixed-size 4096K --fstype=none --part-name reserved2
>   part loader2   --offset 16384s --fixed-size 4096K --fstype=none --part-name loader2   --source rawcopy --sourceparams="file=u-boot.${UBOOT_SUFFIX}"
>   part atf       --offset 24576s --fixed-size 4096K --fstype=none --part-name atf
> -part /         --label root    --active           --fstype=ext4 --part-name root      --source rootfs
> +part /         --label rootfsA --active           --fstype=ext4 --part-name rootfsA   --source rootfs
>   
>   bootloader --ptable gpt

