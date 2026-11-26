Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10985.1795687364141775887
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 02:02:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=LvwtJrFa;
 spf=pass (domain: cherry.de, ip: 40.107.159.17, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYBHvs8/H6OJAR3WgiKritgzKjKvzxDA3oFM1JbMMchTi9ZlO0Rh/XSY9LZvmtit9YB1x8421iykXiaSXmQ+ZSggRM2ojh02PSx4O9s13yqn1OyDkv/XWMyevWwfQsJj4JRCkSR9Bvqd4yBWJee0s6K6c+FOlNENZGfpuTiaXIRLVybpVGCYa7EGhNBF/jPh9xaMDAqWKD6bNMNLhuy/coWf6NylTKEWt75b590LT62h+wT9aW79b2ra1SzwsGFofhXUL8l0MAk1oxHXAe4Uy0i/0wkDYfOUc4gBQjsm0ZF1Hw6ccR46u3chVPVLsFLV4pFxUpg8d02YLrz6k1GOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUICNh1gPbi+xG9e+GFkif5Tg4d2VNRmN737HxSpSQE=;
 b=PXizzK/bkgaqsFqwOqebH6EwBbGQmd22KhMNpx3LjyHvJ0uzBYxIrL+ofn3FtMsp7wfG1H6p4F+f1Q1sQY51q1SfDZpjcVOxcx9+dqNIH+9N0Y4NQsHCVgGVZUg5DPWfiv+hpjmQZ+N0yKK7l/dimA1+70AlxEyTbPLOV13WYX4KjQBpvI7eW2cK7sRbMMf6h65tVlSn+U3J25PobAxPbreko7l1zvYpylXUr4RUpesRMTW65XgPH63uHrRhgd7t7uh1CCvYk4aR/dto9SI+gO/lVbEib7+/8eeQNKrukPbvTsDoZ5l+VuAFJrIVsz2s5JWWC5K6B8Lfxe8XFSHc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUICNh1gPbi+xG9e+GFkif5Tg4d2VNRmN737HxSpSQE=;
 b=LvwtJrFaAV/ProGYXvaNQUenFxv3HMbZMAbRCmtWws5F74A6TKHnrnMd5wabbAvjnTNa05H7RYuopOj1pOUSH9JiebpaBLdn4vDAl2gLMiDA15bFlWmQDd5sfCc9G5flQaB0tvLNNfDjz3/rgt80VQojqkOZi8ITgccTbt1VK/Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB12035.eurprd04.prod.outlook.com (2603:10a6:20b:73f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:02:37 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:02:37 +0000
Message-ID: <55a86d60-8777-4e99-b953-9bc733242fca@cherry.de>
Date: Thu, 26 Nov 2026 11:02:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip][PATCH v3] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20261126040956.3591113-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261126040956.3591113-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB12035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf02e5d-564f-43bf-7873-08df4ba46679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|5023799004|261022115727099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: z5ax2bzgYxHpfoQMuDg/k/GhYDt781s+duTPBiEa7xmr+P7yF1YhtHHdYcYXLTgRzfUgDd9noxnLwag3jwErt1/agCncPpP+YHuSunYnBJJgvCidy+Htyw0DkCQqan1K9TIHeXn25KLaHcIdx+ojLHYr8LPG7dnjOhEA6oaiXKU3vSZ7xhTe/9YT/75wGv/EggBlANUWr854NPTGwLSa9184IsYOAzCaMJGXXOy6Q2v4Om7CPKK6kSwwya98gj4Wo0RAXBcp2DOL9piOZ+vT/IkRvMyzo+kpDJuV3Igh8g6u56mmSsJd3CE6UmF7R+fwEJIDZaYMslqwdtWNWEzX3rI4zAMfmb+OiF+omfwIlWdr3eINye9r6ZKHk8HEKeRdoQU24A8dR33xuHpkCgn1tPqkODhDa3KhlLAmKuUTfCq2K9093B40bir0xX1QEFn5clx3Zhf1aKKJRBDfdZSCOjT5o7nPPZTM6LFAUWerwOMDA8ls0+NK7mI5M6S3BKjJ5Q40lML7QqmSASkXkaEoT3Jh8pM917opEOJzVp83sjAe8UIIX6Op/Bcnvhli9pobJQhkjF6aP0sDFsmIf6102EpdCkcSUiYYxkCJOyYWKcX7GXr55N8fcU6CtM7KahUf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(261022115727099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0xMNTc3b1JrYkNCZENiQ3VlY3FLT0d3UGc3c1VSaGsvblZWQXg3OW9MS0tl?=
 =?utf-8?B?SFFrekVCVFhLSDlsQWszZkJzOE1hNDBkTU94QXUvbTAwQUNkUGcxcmxCWE5G?=
 =?utf-8?B?aHRNemdLaXNQY1F6YjYzdHFscG1ZT1Y2V044MGNBTE1vL2sycVhJV0xiTXdz?=
 =?utf-8?B?MzRoZVovMTRjaFJHWktMWHFuMm9ZTzBVS1JXSmR1ajFaM0RtVTFnc0dIM0FN?=
 =?utf-8?B?amhnMmdoY0RtZlpWSld1d0FTcVFPVUM2WThSd0hyL1pWeVBPUjVPQTJOdDRL?=
 =?utf-8?B?bWE1azUvaGJhYWJhelZScVk4YzdyVjNHaSswNVVkV3Qyam9zWGdCbHpnMDdL?=
 =?utf-8?B?UlhrQit1bzd3OUhMbE5ublo5cVViN0pjSDIxMVVTdGVVZ0d5ZGgrWXRFK2No?=
 =?utf-8?B?M1dnaWYwTXNOSXNXN24zeDBPbWtaZEpEcExwQ3VPSSsxeUJ2T0t1M0JISFRx?=
 =?utf-8?B?ZGcreGU5YnNGTkZqaVJuNEdtL2FFNnlOTmVOSXlnQjNmVm1zU3RHWFk4QVJV?=
 =?utf-8?B?Q1dzemUzUUpmNWZIVTNGODJ6VllGRUNtaHBOUmdvaFhBTnJVY0E4SjVYeEpY?=
 =?utf-8?B?eWthLzBIMUx5NkNaTjYzbVNzK3liZmp2UlRJTloybDhQVGF2RXV4and0UVds?=
 =?utf-8?B?OHNqNWJsQXdTUDgzVXB5VytqeVhqcEJRSDNpbGw2c3JPVm44dmdFTkkwVWpU?=
 =?utf-8?B?c3Vzek11SHQxZWN2ZEM1aWYzMVllT3JJMlVVbmd1TUtzMjk4RUtMTk5WVWto?=
 =?utf-8?B?UTJ0dnRTMEVTajRtU2Y3Wk42V2Q4WGd1L1RrSDdhMVN6RTA2bHJ3NEFoakoz?=
 =?utf-8?B?TmUzd2FvaW5CYUp6S29iZlpLNlptQy93TjFZRzVESDJXcGFjQzVLb1RhOTFx?=
 =?utf-8?B?ZmJISU5pMlRGR2hPRkN5UVJMNFo5bzZMbHBRVlpGUytTc1dVZ1ViaEU1a3hy?=
 =?utf-8?B?QnNTUzU1WVhGUERhbjBVR3lWNWpkbUgrcTl0dkl4TUNXM3ZpY3lvVzY5K3hS?=
 =?utf-8?B?UHI3Wlg3V3hTMktUTzA4VGVnQW9RNEx5cGhPa3R4VnpxOWZudzM0ZVcxMjJG?=
 =?utf-8?B?MXdZWks4cklYMUt5a1dQbi9FZFFya0ZGTmpNdWhoZjhpOE14d0tsYkE0S0FW?=
 =?utf-8?B?OWJKOVNRanpVZ3QxVTFLbitaOHk2Q2FWK0pKcEhsOFc3Vkx5QTdVNXArb2Mv?=
 =?utf-8?B?U3Mza3pDUHMzTFFucXlBV3hjYnB0MVZITlBRVjVWbFNSRnhYVmQ2cmRoQ0FX?=
 =?utf-8?B?eVZEelQvc1RUYnlBWm5ZUmZFbDV1TnZYNnV2S3VJeVNhZWhkT2gvcUJJZ29M?=
 =?utf-8?B?T2tLeVRDS0tGNnJ4YzNPdXluMXRuaFZvNEZuSGFFY0ZuekVCSHZzeDU5dkhY?=
 =?utf-8?B?dEZnVUdXNWpzQS9Xb2t1Z3VpekRnUWk2cFFKQ0VJZEZ6UDlrYU1UU2RnblhC?=
 =?utf-8?B?MVVta3RUL01QZ3liMFRDV2VOdXRIU21idzJTV1dOM0d4elJTTWN6UmlLQUoy?=
 =?utf-8?B?RXBLaVlYRzBqbitaZXkwVkdDeWc5V1FzZmE1czZ6Y3RHR2RMdysyY0JFOW5l?=
 =?utf-8?B?bUs2NlRTYjFtcFNkam1pY3M1bkFUKzJWdHB1Q2Q1dWpCUFBKeWdBMnM2LzZx?=
 =?utf-8?B?bnY1cENIdDZSbDMrVFdaL1ZEcm1ZdnRQdDRTQnU3VXdTeXpHMFdFZXBBN3JE?=
 =?utf-8?B?aGQvTlRBaUVBc2o0Q1lCaDZXdThNY2szcmZMME5BVUJYUWduenZuNy9USWly?=
 =?utf-8?B?WWx3Z3VWdm9aaDc4Z0RNY3ovVmN5L0h0OFZoRXpaTk9VZDg3K3JoRjNxeG44?=
 =?utf-8?B?TmtucHZObjBtSUF2QWRHbjVtQThIYjdRQm1SL3ZGa3RBT3ZBYWRrNVhsZ0Jl?=
 =?utf-8?B?Y3pOR2VZNS8xekYvK09sY3lHeWhlSC9KZys5NVFyVytiZllZOFJOamtHaG1G?=
 =?utf-8?B?VmxXVUdwc0IyQ3E1bUFSM2J6c29ySDhULzdReE8vUWtkV2ZXZm5veDRaWkpl?=
 =?utf-8?B?V1RnVldTUjk0T25Zam9tcVVLRUFNOWhWNkhoUDc5eVNxbmNqUlFxR2ppSTlT?=
 =?utf-8?B?dDJKUGlDUGw0THJZTk5uMXVWb1l5bFBoYUd2TmF5SklSTDAzQWY3M1A2a1cr?=
 =?utf-8?B?V3NOVHFNUVQrcHM3RWZRT0w2bE05VVlCNWhZWWszVzJqZVpoOFpTWFo3cDZR?=
 =?utf-8?B?ZXlvQXg2c1dUTHZ3SitFeUU3NkxXMy8zRERmVWZpTGFUWDJCeTVTRS9NUjl0?=
 =?utf-8?B?RUIzQlpyYVNvTDB1bkNEK055QmxudVUzYUpFMkZodG9HcEVmU0pEamFZWFRI?=
 =?utf-8?B?OG1yaTBMSnNLc3VubEUrTGcxQXJCdE92MmhNOVBTWkt0UTM3eDJoQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf02e5d-564f-43bf-7873-08df4ba46679
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:02:37.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpTO1s8oKrxTXFL+VchWgXE/csKyTv0dpJIBfPpwLJ1cFAidw4JfdowseddNtPCrxbNtETAVu150dHf3nvkxTKpirAnOyH0QOyVc1VG2nyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12035
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 10:02:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5540



On 11/26/26 5:09 AM, Trevor Woerner wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This adds support for the NPU (Neural Processing Unit) found on the
> RK3588(S).
> 
> The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
> Device Tree nodes (so not all RK3588 devices supported upstream
> necessarily have the NPU declared properly!) and a userspace driver in
> mesa (teflon delegate with rocket gallium driver).
> 
> This adds a config fragment for linux-rockchip kernels such that the
> disabled-by-default Rocket driver is built and enables the Rocket
> gallium mesa driver with the teflon delegate, but only when the user
> requests its support.
> 
> This was tested by running the following:
> 
> """
> wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
> 
> TEFLON_DEBUG=verbose python3 classification.py \
> 	     -i /usr/share/label_image/grace_hopper.bmp \
> 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
> 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
> 	     -e /usr/lib/libteflon.so
> """
> 
> from an image built with meta-tensorflow's tensorflow-lite, mesa's
> libteflon, meta-openembedded's python3-pillow and OE-Core's
> python3-numpy packages.
> 
> Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
> currently supported in the kernel.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> AI-Generated: codex/claude-opus 5.5 (max)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v3:
> - rebase onto current master; it needed git am --3way against the kernel
>    config fragment list
> - gate the fragment and the mesa PACKAGECONFIG with
>    bb.utils.to_boolean(d.getVar(...)) rather than oe.utils.vartrue().
>    vartrue() passes the variable name as a string literal, which
>    bitbake's code parser does not track, so the do_kernel_configme
>    signature did not change when ENABLE_UPSTREAM_RKNPU was toggled and
>    nothing rebuilt in either direction. This idiom is tracked and matches
>    the other knobs in the layer
> - drop the kernel version from the README note, which said v7.0 while
>    the layer builds 7.2

Why I added the kernel version is because "at the time of writing" means 
nothing to the user unless they go dig into the git history, then 
compare the date to the one in openembedded-core, and then check the 
linux-yocto kernel recipe version at that point in time.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
