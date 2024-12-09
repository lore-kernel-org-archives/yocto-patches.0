Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3229BE7717D
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 15:23:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.48])
 by mx.groups.io with SMTP id smtpd.web10.104290.1733757772213934047
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Dec 2024 07:22:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=aOxMNXUq;
 spf=pass (domain: cherry.de, ip: 40.107.22.48, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXInclFjg86QrqxmSrdrbFYjh+P3LwWJwYs6J4xUDILZOpmNW025S6t78lZgK5pGjYn6q154x6FyPteCnDkIn1HjmJijXcZjaHFxpQ1pRDlsjZSugHdpaNS3fulHytLrbBhV6KvUgWDBgMG1FZTJ8zuuzZrq260736b6aeewL6di1g9ZS37tLDYcl44qI6muROZ8kHS4vQeznPl/UulxA1NHQtLDmLJ5gvguD57NSd4bdaEaLMci4OlEcXZ8V9Q97iZYgROzd59kqugQsprYMNW+iYi9j9N/3j83jrmVjEMoSnVmvhNRQODhjyTCer3+tWB0wyMsMfsWfBwlAC/CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88GzwZJf8UZ0XZcbT2dPxP1ElEEysvpIH93vKKTF6VE=;
 b=g/YwRk9Pp/MljDVuCqhaiwmCwwjKEMgs1PJj1hyu6P7E8fkvmiTfgaUvpBs2rWn+lBX3s6gM6rqQs8siw001mBHXvagFkgW8ClhkvLaY3faZ7p54GgsJth5ppzQek18EvIKvLMibSKtPK2jOOwHPAFWaXWOIIe5jfurTX3nVemvcDv8xPBG+UnCJW88LWeDXT744NdygZSEBj52DLBatyibcvQK3D2/yKROy8WJ6Ixwdaahha5wiku2G00nJZ0HuI5MLbvQAM7WLZ6Z+7ECwaP6fnH3XNMViY8qHbO4c6EPifb/sYb2nPOOMSQ/W06JCaTuD3Zyk0sPKTgjGaDCdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88GzwZJf8UZ0XZcbT2dPxP1ElEEysvpIH93vKKTF6VE=;
 b=aOxMNXUqoB8AGJf1cGrjtoiOBcriLY9jHcxfbvyrLDgJ8v51SexdjQV1adRqGIcADklP3BPb3Z+2QLH3To3EufabRIACHPHT5LXIgZpmV5JOacUELSuWrCb0Hwy2qrK93Td7jJvYNfCK+LHt/U5ANeQyZuRfDtD1GDRVmLOVdR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:22:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:22:48 +0000
Message-ID: <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
Date: Mon, 9 Dec 2024 16:22:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 416b4768-4da8-4378-59c3-08dd186556ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SVhtdkpDb3NrQXp1MEVkZWdoU3Z4K1gvVlNaV25TWDBNVXU3dG91T0ZvYk5B?=
 =?utf-8?B?T3pld3laaGo2dHNWSGZNVHVSM2RocWlwZkNhNlplS2FseGw3R3ZxOFdwQ1c4?=
 =?utf-8?B?Y01EMFRyRVVaZ3ZDOS84MzRpZG1GVEwvVUVxZ3I2dTloTTdaTmhhbjZKQ1dD?=
 =?utf-8?B?UFJwQm1FNmZaYjE4K0FDWm1ZU3FBS3JkR3BXdzdrbWlRdjBiK2J5ZE1LS05G?=
 =?utf-8?B?Ymp0YjROck5LNTFVbkttd3RHa1hZOWxjaFMxcnNRdVZCeU5rWXdWSkxnZEJS?=
 =?utf-8?B?RTZKQzdHZFJRRlJrM2xhYS9YbTF6WnI1RzY1NEdJRFB3elJTL1lhcURocWNQ?=
 =?utf-8?B?Mm9EVkNSZTdGQ3RRRlpoRldBeDQwOXlyRHdhVTJ5UklyOStoc3hIbGdsb3p0?=
 =?utf-8?B?SWZjZ09DU0FUcHBMSkhhNk5TaThrNWgyKy9kQUp5SDNQOTh4RUt4WVlLMnpi?=
 =?utf-8?B?TVY2OElKb015MHB0YUVSWHQvQTB5S2VlYU9DUEFIenFrakhvVnoxYkI4RmRX?=
 =?utf-8?B?SEphU0lTTlZaTHlOT00xOTlLUzdEcUFyRGxTWVQ3c25hTlplN2pqUlozOERp?=
 =?utf-8?B?RXY5UTdVT2kwVDFiWDBHTVA5dlR5NXpEbHdlMXNJZE1uTFBwbERJY09YNnQ5?=
 =?utf-8?B?UUtSVy9FN043K1M4VURKaGoxZHA0RUtOZU1ETkhHTDEyRGtON0lRb1A3cW1X?=
 =?utf-8?B?N2tEOEZFWHhRV2Z3UFdqMlI2Qk00SFFuMkdpMUlPWkdUN0xESHF0QXpNMU85?=
 =?utf-8?B?QjdYYUl3ejd3UDVwZURCUHh3OU5nWGZ5UDNhd2ozeklPV2ZZTm1TZ3RpT0lq?=
 =?utf-8?B?eE5wTmNCUEd3ZXAzMzVxRjdQd1B0aUJNdjRpdmZIbHV4NTFYV1VSZFA4VzA3?=
 =?utf-8?B?OVVjbDNxRFVzYUREY1NURm5hb3hRWUJFM29aQ096N1FNNnNJZlF5SkltSEFo?=
 =?utf-8?B?WGl0SFI2K2pXVkVYQWJURWNXb3UzRHF6ZWNFdGhxM1l3ZWhqVFIzSWJOZmty?=
 =?utf-8?B?WnpPakJ1NXdXcXB3MThqUWlwdjJxVkd5ZTZwNzBtbzlCeCtUaE0vNW9mcHFm?=
 =?utf-8?B?S2szbmpMTDFSdy9lWHRkMXZESHUzTXN3MFQzRW5mclhxcEcxRzhlOVFCbEZw?=
 =?utf-8?B?cmwrZ3REcnE5SFV6b2lNSXR3SkEwb2dBMUxkdm9uaHEzK3RFVEo5cFlMNnVx?=
 =?utf-8?B?NU9XOW15bGZGOGJYN3pGSXZaVDRFMWpFK08zc2Z5VkVEcW91RFpobXRFQVY0?=
 =?utf-8?B?MlRLOFhzUEVDb3JIN2pTZW5QclFENnEyQTN3NWVoc3RCQnp1akdyWlBzaWtw?=
 =?utf-8?B?NExVR3FVS1Vzb2g4dWRBNS9wVkVLSHFWVVVpQmxicWJkRzZtcFB2RHkrZDhh?=
 =?utf-8?B?KzRnYzdHM3IxZEVabER6bHRmWUtJWFU5OTlOeWxLUytoekJkMmRwOGZ5cXJ3?=
 =?utf-8?B?UjlISURNOXdqRjQ2K2ZBMTZienRsQlRya1VoOEQwbGRyV2VOK0M2TDBIVmVm?=
 =?utf-8?B?VDVLVzhUUWFrZ0xiUkxvZGFDb1VzdWMrVWdQeXVDMXBoZXpGekVyY3oxVXBr?=
 =?utf-8?B?ejBTN0xnd0wvSWJUdmVKNEFSZ2NFOWRIMk91OE4zTjR2UHlnNWhYcFlHck9R?=
 =?utf-8?B?cy9SakpITjRnNVVRMHhVNTFMcG55ZGoxQnQ3a1hvSW1IaGllaTIrU1kyUlB4?=
 =?utf-8?B?VDlGTzVnR2tzSTBJU2N0N1ZGQTg1WWMrMUk4aE9SN2gxWFpQK1lHMC82UU43?=
 =?utf-8?B?Z25KNEJUSGNzZVIwbnArOGxpdzROa0gzYVRYZ0dSSFlmR3ZpbWFtckpQYi9D?=
 =?utf-8?B?MWlZekVKK1diVXBTZFAydz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aThoWGNrYWZBYlJKbW92MXVZSURYQjdGdG4zTngwMVNjOURzWVNrbWVlTUFp?=
 =?utf-8?B?OEIwTGxFQ0FzOGVjdnR0RERsUGYvRytOSlJFQ0ZBWVc4cmtFVXNoMGRHY0hn?=
 =?utf-8?B?S0RQbytvdWpHd1pJVE5SYWZFVi9SOUlpbzZBMWVYek5kSEtuNHJJTzljZ2t5?=
 =?utf-8?B?YjlYS3I1VXFtZldoL0wyVzlQU2ttN0ZKT2ZVckkzVHRNOHAxTGRCNjRLaG1C?=
 =?utf-8?B?S0dIREhscWVuSno3dGM3ckRXMjg2WVB3RVFvVE9KSTRpcHlLUmgzeHBHVThP?=
 =?utf-8?B?WUFPc2hCZy84RExvUE5xWVNTQU93dXM4OUcxUnFBT2Y2aVovbmFLT05SVm9n?=
 =?utf-8?B?bUhWdllWcERFWSthb3lDWWlVTUpUSllZUFlPRisvZXprME5xb1dNaHRpOXoy?=
 =?utf-8?B?Rk5pUTl0MUdrUWMvdG5jRVkzb04xSnFhT2FlcXUxVENxUmpmRkprNlpEWFlk?=
 =?utf-8?B?YUl5T1hUY0tTL293eDFRYjRXa3ZqNkFlbDB5MTVSVjN5NWU2M1ZBTEhHcEg4?=
 =?utf-8?B?SUpsZ1BtcmFyaTBBZUY2aXRyMDF4YlhwdkMveVc1RzdLTXZ0c2Vpck5qYnND?=
 =?utf-8?B?WVNhUzdsd2xRbFY2WVlNeXNZaXp6M0lqUWtGTmd5dzNNWTJyTXhENEtpaWU4?=
 =?utf-8?B?by9BWUtNYWowNHJ5bEdKTFRYRGVpcWUybDJHejVSZzM0ank1QWh4eWFLYWwz?=
 =?utf-8?B?OHExVVU4djZPeDJmUjJmNm5kRDBCVkhnMm51Zyt5cEpkcnJNQ2c4UGFXbHZV?=
 =?utf-8?B?S0NWc24rOTcxbkNRYzhHajdya3JxM1JLMkFqdUhMeDFVZ2hJVkt2N0dVd2th?=
 =?utf-8?B?RHcrK2s5Rm1rM1NmMEh6dFpaM2JuODA1Z2N4clZ3N2pSbXFZZjZ2QUlaaWVH?=
 =?utf-8?B?UU9QYjFKWGYzeEp2Tlp6YU5abU9NUDdUeEVvbW5CbWxUTS81aXFnZHREdmRL?=
 =?utf-8?B?RUdXcG8wZWp5Njg5bFdBb3FoM0hYaGgxNU5lb0RLU2NvcTBIVkJvWWRHNGRR?=
 =?utf-8?B?R21yRCs4cDNENHJRVW5KRHR2YnFLWmd0OXkwUSs4N0hrSUVMekQrYTFRZmND?=
 =?utf-8?B?UUtmY3JMZC9DN1B2bWUweDRCbGtLSXFUbG15blBqNTZQdEpPSmRvMG8xWGxq?=
 =?utf-8?B?amxqalozYUVHY0NiaEpnRHFCYjdWVXFFb0g2SFNtaVhVVk5DRjJYZmdJWTdG?=
 =?utf-8?B?TWQ4SWV3NUt6bHFRakJLR3BEa0tSTmRpRXhha2kxK3pDWWFCSkltT2NwbEFN?=
 =?utf-8?B?QVRBV3BjSlJIdFZxMFloeUZDdzJBM25TTVlFZHRpUWowWnVYWFJKbnIzUzF0?=
 =?utf-8?B?Qjdzc2pLRmV0OFJxcE85SEk3aWVxamhERk9hOExnMXFMYW1Ub3lxYUxjemJ2?=
 =?utf-8?B?d041WTEydWtTRXQyVXBtSUtsQ0g1RHVsT2dpL0xLMG9FNklLVXlpWGpuZ3lE?=
 =?utf-8?B?d1FoNnRITTA4KzBldko2M1BvSkdsdDNDeGIxc0Q5emRtblkyS2JlN1BERDd6?=
 =?utf-8?B?OU9kQVBVcEVCcHE5OGRwYmUvQWQ0bzAzQmFIVWVsZEUrVHNaV1kvSVp5T3hi?=
 =?utf-8?B?UE13K1FJeVdTZGduT2k3dTd0UUNrOUZtak43OXY5MVN2NG9QdnVzZ1k4UW8z?=
 =?utf-8?B?TEdNNDYvK3FHT3VMOGtMUlNzMGk0V2o0Y2tobUJFSFR0cVZXNlF2Zjd4VUJT?=
 =?utf-8?B?eGJEbWFhM1ZiSFRVV1doY1p2L053U3QzWVI4ajBqWUNKZmplZGlKazBVLy9X?=
 =?utf-8?B?NFpEQmtYMXFDK0JmMXgyaHQrTmRlb2lIY0J4YTNpbndUWlFYVVRkL3FjMGRk?=
 =?utf-8?B?K3VubXBodjVXbUNid1RUc09QVjk3UG5WRHN3OUU1VmVJS3JOMW5ZY0JHY3dK?=
 =?utf-8?B?WUFGVC91V2xRTUl2VjhZSU00ZjNUSkdFVlNnZ0Q1amxsTUliMTZ3c05CSjB5?=
 =?utf-8?B?bk4yc0dWMktCUkRRNTNxY25DV3ZHNm0yZjV5bmJBTzE1UXNPZ3VCWTlUM1k5?=
 =?utf-8?B?c1dlNi9PVVZlK2pmeFpiVWJUMzY2a1M3QWU3MnRBSVdyOFhzbS9BVkYvSWtJ?=
 =?utf-8?B?ZEhLQ0NpVlJKbWhIcHo1MkJiNFZmdjBadWp5SnF2ckNNMFpLQWdaakJzZ2Iw?=
 =?utf-8?B?T3F1KzRPQ044SFc0bmtUNnZmek9wSm1IOGRFQ2pqMnVyTU1KVldNb0VZYlNs?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 416b4768-4da8-4378-59c3-08dd186556ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:22:48.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1vlKDJHj5kppSYFhRz+sAFDYIjI8Lf5Ah/mTw9qcCLOUnVUDK7jlHDTiaiY+qwlr/iSlODYFORskvXExXCuFBAeHnl7PzZjcbHvo3TvB44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Dec 2024 15:23:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/873

Hi Oleksii,

On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
> [You don't often get email from oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> During the fetch stage of u-boot for radxa-zero-3, the following issue occurs:
>    Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781126c8c in branch
>    rk3xxx-2024.07 even from upstream
> 
> This happens because the hash of the head commit for the rk3xxx-2024.07 branch
> is different from the one specified in the recipe.
> This can be verified by running the following command in
> <yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
>    $ git rev-list -n 1 rk3xxx-2024.07
>      2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
> 
> Update the SRCREV to the hash of the current head commit corresponding to
> the rk3xxx-2024.07 branch.
> 
> Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> ---
>   recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index c939a48..9432e2b 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> 
>   SRC_URI:radxa-zero-3 = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
> -SRCREV:radxa-zero-3 = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> -SRCREV:radxa-zero-3:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> +SRCREV:radxa-zero-3 = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> +SRCREV:radxa-zero-3:rk-u-boot-env = "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
> 

Master poky now has v2024.10 and at a glance it seems the Zero 3E/W is 
supported, so maybe we could simply ditch those overrides for master 
branch in meta-rockchip?

Other release branches should probably get a fix similar to the one in 
this patch though. Or ideally just download the patches from that tree 
and apply them on top of v2024.07 for styhead (we would need a new 
release branch for that though). Scarthgap has v2024.01 so that's a bit 
too old to apply patches destined to 2024.07. But we could maybe point 
to v2024.07 upstream+patches instead of pointing to Jonas (Kwiboo)'s 
personal git repo.

What do you think? Trevor, an opinion here?

Cheers,
Quentin

