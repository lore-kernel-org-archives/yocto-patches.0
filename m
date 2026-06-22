Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B3CD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 16:00:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.299.1782144015518970681
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 09:00:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=RQeUl/9B;
 spf=pass (domain: cherry.de, ip: 52.101.84.27, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9xB/8OEECADHu7V0aY7aGexpts1v9j06xl/Ih/I2cZ8C+WGOr6nDz3KsMf7YVPkFfmBqfxqqQXfyR9H4BDYzRH20acwXqEBhxx9Cx7WECUZOomYEH4dsc6brFYD30zBMkzoOnIMjeNPHy6rNJpXAiUlbPOV/HVURqxERp2vVXt8pRkYh4HEiuVSK7BocaFJezSz6CoPDMH3dzsYGrUcN3DxlAfXUz0hBKqtEnnmRobjfoHCzd1+1mZvxSD6wZOuOrB/4MkTFfMGVYZeOQjQEcf0+Nup6QopkR3Rp0YRm3YvZ5/3s1dgRDl3NAQ94Lou+YwDVX8qtPyoiat6+XGXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwONFyGnjONy4pE0j6ONHE5UnleBZw3Fol9qfpj7gtU=;
 b=n/jD588nLhdPoNSnYyjgNKKtfq+DosxWlv6RiHoMaTNh2ViNn3CKm3+UaF0fegxgMn/cdRkF2KY8d9rFFe8OL6resZvSkYcIrzPoztpB3Kx7aTDUaf/IIhBWanD0PR0/pSy2d98Da2RpYHxrzIolyT8sgqN8UFltmWVOhpZjFQNt1V/KV/sXnJjWAKD6PPCqsRmMvfU7+nghaJOvakiJHLCIHRmY6L/1M/xLtxFJ+9EDgt8BMHtIV2e32z/QaNpadsIC9cSYTbrhkuv7qKvV9qWQ4uY1z3V36igwpbZmNldMoCZS63lJY/trxC3ws1aZG1pViyIfu+2hvK5dw1LCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwONFyGnjONy4pE0j6ONHE5UnleBZw3Fol9qfpj7gtU=;
 b=RQeUl/9BLAX1VE5Gwk5534+8rGdgRhVyOKikAKfrCpfNFFLyJGGg3POSAZv4pVdutw49c66+/La3luF8eZl22iJKrLRP/8nMGxUgMM3A3dWu3sfiKuQ/PW8Tg4TkRu1ZlR42zlFscSa75eclcOGagq92pKQDibcLd57DLSveiZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10597.eurprd04.prod.outlook.com (2603:10a6:10:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 16:00:10 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:00:09 +0000
Message-ID: <9edde087-11b6-4377-b74e-7637883c0d52@cherry.de>
Date: Mon, 22 Jun 2026 18:00:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] u-boot: fix incorrect
 commit reference (radxa-zero-3)
To: yocto-patches@lists.yoctoproject.org
Cc: Cleiton Bueno <cleiton.bueno@b2open.com>
References: <20260622134626.3616736-1-cleiton.bueno@b2open.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260622134626.3616736-1-cleiton.bueno@b2open.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2PEPF0000089D.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::652) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10597:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee4e40d-8c6f-423b-1089-08ded0775621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	6c/O+0o3JU/2M2T9A/ekA8Z3/ZEnPyOg4iA7DvNVFBDQq6H5qsjuO6EuCBIJL3o9Y9aL4Pt5Zy0vN8K3WvVYrDcdzs1QgXix61kHFujCj4ZeqT1CYHVF8n/0UAoFPI26Gw1q4NUfNyt2OP6vJrF6Bo03Mn45BiCKdTj/l90/A5ne3HTtHANlK8e2KaEqlkKQklMez9iR50R7eu32PeTMXX/lxe+E6n2A0cxsxyxQa3m9nGXAIUfoHuUS2XNkkCy2OyxrlGm8sHuwGDnrS2EleX1/51jPQtYFzk9ihnh15zsYUHxU/ArIHNVQBYQFk3gQ/VFGByRZrKfcWati1DtPj7ufybITYR78rr/TfYcC0fffWmV4R0tuYnu4Sn/nGQcycW6kxl9Npt7XJwNfm8zi9OyNpY1RWpFwDStskZ4pExnERwTLAd0YfKpKpUwL0KyBTFaTmkfYpmanXUwB/hxEjHXhdkZVeqkNWyFMkxtb8m52h4LOwKNa7J/lzmLMJtznbOFtJOwM2/gRAc+fVmejLXCaoi0DPYdkKJluUudyEM/Ofz6DDXANnLqAJ9omx4rhIR4T2ovvtL70tjzudvm8HoJ54s86tMl70CI25/+hcioQxHjGrM+GF4XbIQmjwOLwyoejP3oI5harhiQHXFApcSg41uj5lfGo96S606ZFmDM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S3ZKc3QwQnFJcFQwSXNWd3pHc1c2NXJLTExjVHFRTFgvVW1tOXlxcVRQYk9B?=
 =?utf-8?B?c2VoWkZqUGxCeDRBTjlPVVpLZHhPRE1iTVNaOFZzTmxnZWw5cFd3ZHdCM1ky?=
 =?utf-8?B?NWtsQm1QY25xYjYxQXM0SUZqNDNmM3F5b1BMOWx2ZWhJVXNzMEF6MVVrWDZ0?=
 =?utf-8?B?Z09mTGxBWkNMVTVYM2hJVDU4RXR3NUpUQlhEQ3VDT2EyanZJMG00eWdjbVNv?=
 =?utf-8?B?QmFVemo5Zkg1VmlMSFlXb0hyNTFFRlh4dmN6T0dzWmV6VTNHUzdWN0pOQXhn?=
 =?utf-8?B?WU9QQ2t2ZnRmVFRMM3hJcUlQcGVkSzBMOVk0M3R2WVhBdklKeUtFTlE5L3A0?=
 =?utf-8?B?MEFMZDZROXJnRVlHTTdHNDFVYWNOWWNJdWVRUGtKb3dFaU8zVWZIZ0lBRitq?=
 =?utf-8?B?YnlWSktPWkFOQXY4VU9Ed29iem1vc3JIMnRHU0pKaGEwUEZDU2xKZjYyN2Vz?=
 =?utf-8?B?dGo2ckkrT0h4clgyaUJBM3EyZkU0RVN2aUhpN1pKamN0TkpmSTZsN3ZxUHk2?=
 =?utf-8?B?UXNHWDhHM0VrMXo2R0Z4VVZ4aXVBRFFDT1k5OFZhZWdMSG5HNzFvTkY1Q2tY?=
 =?utf-8?B?YmlzOGxxdUlxWWRBVEdBckhLTXpFT21PTUZUNHMvR1crZlBSNnB0Ty9mRmhK?=
 =?utf-8?B?V0xhc0xleU5KVEJ6cGlIOTBmSWRad2NVR0tXam9PZDlqdHBVOWNFemFvOGI4?=
 =?utf-8?B?QW9YWjZ3OURiQ3JSM2xnZDNObjk2Sk9uMTZXT0FnVjIrWmI5ZUl1VUFtdzBD?=
 =?utf-8?B?bHg2Y2VIWkJMTlNzVFM4d0l4MkVpb3lkMXQyRmFLS29GSmt6TG9SZUV0ZVJW?=
 =?utf-8?B?K3Nwb3hac2U3bm1oY1pFc3dxV0xibngyUVJQM3ZuS2tqbjZRK05LTTE3Nmhs?=
 =?utf-8?B?ekxSTmVyRHROUlNRejlyeE5nLytqZWNvK29Pb21uOCsrb2Z3Ri9lVm1vUkcr?=
 =?utf-8?B?QW1IblZ2aVZQTk1uVDg2ZXpSbGtrakZYQUFUNEplaTZlZytiSVpKRmhsbW1D?=
 =?utf-8?B?dkNHZ041L2k3N0phd3N1UjZMbmJTdW5VY0svQm9FME5LS3VFQUZ1N09iSVlh?=
 =?utf-8?B?R1lkam56c3JTaE1WdkZmRGd4ZGVyblFkcHdXK0tJeDNicnZPcEwzd1lWWVZS?=
 =?utf-8?B?bkpMRVhnbmwvRmkrWmgxUkhzN3dOaUhBR2hjTUsxQUFsVkN4dHM3NlYwTkN3?=
 =?utf-8?B?b1pLOHBsR05vTlFGVUg5SUlDRzFaUVB5VlZmTDBhNS9UVmNGYU1zYkw4Y0I2?=
 =?utf-8?B?WHVxT1VjZGs4N1hBR1lwOXU5NFQ0L3JqVER5SUF6NnJ3bkpJVSsyeXZtZFgr?=
 =?utf-8?B?d3dFK2w0enFDV3BNOTNJMk9OdFZQN0xTVG1LdFZxS0ZHZUcrWjV4SjFQdVpE?=
 =?utf-8?B?RkV5TWNUTGlyN0tHNExKMTlRc3NxRWpQaS9GajA2V1ZrcUF6RW9Wa01EcEh1?=
 =?utf-8?B?aS9tOUg0bEpBT3ZoWVlMMHdjajZNMUQwM1ZiL1FBZ0tqdUtYaEdKNzFEdThF?=
 =?utf-8?B?QUFQa3FMQk1CYmFzck0xbzZranFNNkpDMjUyRGZDS1FQNjZWbWRtdC9sTHhi?=
 =?utf-8?B?aG10SmRIdDNWUTVwOVhHMXJXb2JRQ0JCMVFySzIramJRZ25udkxoUjZKVTlV?=
 =?utf-8?B?ZDgrSk9EOE12ZjhLZFVoV215MnVvNDNFcWJYZEJtWDJlaWlHeVliTS9ZOE82?=
 =?utf-8?B?ZmoyQUpIc3gzUU5vRDY1VTZXVTJlSFlCUXV3aytOSWhSby9rcWRsMldzdE5V?=
 =?utf-8?B?UzVTc2hwbU5sS05Sa1BOUXB1b3dGeUw2akZvZitLeWxtYVNjVWxqdlJUV2RP?=
 =?utf-8?B?cmxEWFV2OUxzYVZJMkgwdG82RHVxK2FDU0hpK04rbkpBZUwxRUhlcURqL21m?=
 =?utf-8?B?ZEhoUnFHTHFUSzNpZnJDNk1SZGp3eEh5eXNvZTlEeUdsaUFzcUx5S1ZhaGNC?=
 =?utf-8?B?eWZkSkhXQkVSRmorUk9odjhmblpJOWdCMzVFMkJ1NVR3bGcyQ0VXKzN3UDNX?=
 =?utf-8?B?c2dxRDdWWnorRnVMblRweVhkaE5CRWhNYkpKVWR0WUd1VEl4TmhxSk44bEVu?=
 =?utf-8?B?bTQ5QkgvY3dpVEJ3OUlMc05Melc5bDh3b1FpZEV0Y1E1ZUp3WWVJMnlVSHYy?=
 =?utf-8?B?ejNZeDRaRkJxTy85MFl1a20vYUhIaEpCRTdyMTFrSzdKeDYvTHJscjQ5WTZB?=
 =?utf-8?B?SFVScjNvQWUxRWoyeFdJS244MEVRYVNVcVJWa1RVMXZIRGx5d2NWdWE3Zjkw?=
 =?utf-8?B?czNBb3RLNytVRXFzd0ljc2QwTHJTK05mRzFNdFA2NW9JdTAvd00zQktrcklt?=
 =?utf-8?B?TFIwUEUvSURFdjdEYXkwV3VmdTNEczQ2QzNoaVgrWjNrZ0FNVGladz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee4e40d-8c6f-423b-1089-08ded0775621
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:00:09.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlI6gNgebX87S2djUEk2OCPUqC0zKeJoPrTtADfc5y1fAWpZw5xC3rcvGIt2WOtZm8N3e94KDylpJFi4IZLqARnXnKTTowa9F4+bue/BiHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10597
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 16:00:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4258

Hi Cleiton,

On 6/22/26 3:46 PM, Cleiton Bueno via lists.yoctoproject.org wrote:
> [You don't often get email from cleiton.bueno=b2open.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The commit 8cdf606 is incorrect and does not belong to any
> branch on this repository, it may belong to a fork outside of
> the repository. The correct commit should be:
> 2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
> 
> Signed-off-by: Cleiton Bueno <cleiton.bueno@b2open.com>
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

This code doesn't exist anymore since Walnascar, on which branch of 
meta-rockchip are you building?

If it's for scarthgap/styhead, I think it'd make more sense to add 
upstream 2024.10 (or later) U-Boot recipe since the board is supported 
starting that version.

Jonas (Kwiboo) is the sole owner of that repo and may freely decide to 
rebase branches or delete them, so we should really aim at not using it.

Cheers,
Quentin

