Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11096.1795687973887418981
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Nov 2026 02:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DnPVTqNk;
 spf=pass (domain: cherry.de, ip: 52.101.84.47, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfgV5SDQzZfcMBmXubYZjwCKEsuOsYCQbTTaLV/KPmi108xDsbbnMquwCHrAoj4lBseeOkuRSTi8o/7Lm4Yt59b/I2g2EgKNX7DOTXhrYqSlkFZWGScZzoiV+Y6z7E0BN3ur25hZV8FxRhaszDjaNi9hFT4/uT/c+/gJASBdWaM3Udadc1jgzEkVdsxyETAbI2DCmLxfQB2pU+vH+d8P3WO763V1kxIaft1YK9sWdVY/na92dsUzGfGrUa+XJz4JileYx1StqIVwwYEf0SfAnKm5RpCM+IelRQYEUIR/pwigmVjknYmOGNhfxRwFbhD0FrL1rvaLC72Nz43oHasZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1WK+iDL3IPkSRBHEmubNK3WgkWx8Xr9SHiB6E0Ci74=;
 b=UcZnUpvfxVPFs7HsOxZO4oagc7uEEW5lbeK/j+8TVWqQNMMREkEnSDm8XS1Ol3caScqH4E+IttRy3VLik4zmwL7Veu0yjuzJrfKUfnl5g+HoWq0ABGMwyMNwL0A30BGSDP00PIacFVODVynhnOnxxztWWhLSJ4wZ+Hben7I2o4hcZ0aRhVymryy/d0g1GYj26zBQztdu6er5QxEsOLiOFL887+r76mIa0N7BiX3O2v6+JF7Wpz5wZpio3vDwwZmstLunvxFPnQc+flg4iHW6gc0E1cwYLtNRtYKnqkEIiT1B+JPLyQsOHLuf44kWLAoqRl2ZAc9Ga4oo8jkspQV9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1WK+iDL3IPkSRBHEmubNK3WgkWx8Xr9SHiB6E0Ci74=;
 b=DnPVTqNkOfjEEjFp6vEZXMsXF7isBxh4pbwgGdM6fXQ5jKHEjk+6UM988QukZ0VZNM9fnwicipSQ9QCmyf2SETeD7npXLqvYrx/tZWfKL0sGPx9ei6F3uGeXqHnEvVpsMa99ZglST9CkCQYB8UAUMKcy47AbOnOtgTDDyw4kgiI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR2PPF523F792B1.eurprd04.prod.outlook.com (2603:10a6:2d0::c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Thu, 26 Nov
 2026 10:12:48 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:12:48 +0000
Message-ID: <1b510a78-f4bc-4b62-a35d-ee05b2867065@cherry.de>
Date: Thu, 26 Nov 2026 11:12:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
To: yocto-patches@lists.yoctoproject.org
References: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
 <awRfVnmgA5cTr4Xo@localhost.localdomain>
 <43f032c6-5d8a-4a1b-a0f5-8bf30873d0a9@cherry.de>
 <awW03AUKpQ04Ixvj@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <awW03AUKpQ04Ixvj@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR2PPF523F792B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4fa90a-36c4-4a7b-43fd-08df4ba5d287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|5023799004|56012099006|11063799006|4143699003|261021133027099003|261022075727099003|261021121427099003|261028144727099003|261026121527099003|261022105027099003|261021130227099003|261021123027099003|261022113327099003|261021135927099003|261026130827099003|261022115727099003|261026140227099003|261026135527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info: I93NcJDMfnSU+lYbR0O+PME/PX33Uq71VMmhIS89V1A6F9cD5P11ZCHvLkq3KhIK1fPTHfa550JrLipXv1TIdzxz6qCf0ysumiMh+OaaI/PlpPkunAQKkONG1twUp+eJ+5aQk2Y+pEe120hihgYZmf35jWOZNJ8cSIL/66j2VMHTZL0YUfAqzjTtTGSuk8HGoefFbGyOLmAj+0I3GrkzX2fpPhGi3s3o1dNA8ApcEjiPgE72egCvwhk4/NOTVUFWb2IBK35b0sLbIQxP1liC1iV/VnxSdb+QG477wxaPX+9d/GVwhilsbHYhZf1uxdFLGZdoZ2y3gz+Oj3O1W8aI3kVX5/Dj7ZnhR/3n7V5ghH/wh4Ktdn9Xn3ciQjbS0LcQAttK9EEp8+dzzRvxLj2MtnXLhWCOVXnuDtbuB2F5U088mMaK20XP/SLBqwlNmCORzjvXvGrI+v9q6V4fiOsoZj98RsDlgsefnRr/LTr8z69CSW3csj3G2rZHqrFVac/up2oJY7thsIwlWcvPfZlNh2MKRk+pRiYXfO+CtEi73nJfaMh6E6ZO55V2h6zPfOfkofJtjiHCsZ8XLQVrDYA025UCeamTTWLRhYCjrBmoIrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(261021133027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021130227099003)(261021123027099003)(261022113327099003)(261021135927099003)(261026130827099003)(261022115727099003)(261026140227099003)(261026135527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZUWDQrRzJpR01OM2xIY3QrS0QxOGcwNW11MENXd3NNUy95YVBXalZwajhD?=
 =?utf-8?B?TEMvUS9RN0pRNnE5azVwV0V0TXhXcElzbE5tRUhkeGl5eHM4YVhYa0FJaVJr?=
 =?utf-8?B?RGNRRks2WTQvUTlQMnQ3S1FiTGpGR3BqdFE2Y3lzTE1HZGpOcGNZNW8xQkti?=
 =?utf-8?B?bkpuNUZIdktLaXg5dllUSmtJRFZVcUNjOUdhZC9mbFhkSk9JNk5GYnRQc1BC?=
 =?utf-8?B?alRpSGl3ZEhmNXlURmh3V0lRRnpLci9RRkdWallNZERqelgrUDA1elVvcnE2?=
 =?utf-8?B?REkyZVNJQi83QzhVbEU0NXhWN1ZpUHpRQlRaempvLzI2UVpRV3kxSWh3UVNw?=
 =?utf-8?B?aTRHcVVUdVZCZGxJN2QyZDNyTXlsdWZpeWFxOFhVWEhxbUFNT0VSTTYxV0JK?=
 =?utf-8?B?L0lRaUhQRmtZMkdXVGlqbFNQN0VOUlZUUlhlMTliTXdGWHkvRG9hbXp0c1RO?=
 =?utf-8?B?SmE2SnZIQVl5TTBJUnBPT0s0UE4rc2N3UnR0bWs4S2hXeURRQ0VLd0RFb29n?=
 =?utf-8?B?VHVIL2c5bmVSTkk5T2tzVnpteFErWTNybHRod285MlRyUmNnRjRhbW9reUM5?=
 =?utf-8?B?MXg5ZWZBb3g0RGE1WmlMWm00VmJnZHFKaTN1RW03eHVmMlBhU1d2di96MmJk?=
 =?utf-8?B?RTM1QTRCdjNiODJ4dkV0bHZvYmxlQkxld1dWdDhLaGdGUTJRMk5OZTFVOGIy?=
 =?utf-8?B?Mml1R2owM01OTEt5UnFZUHNCTDVRN1QrcmxwWVhYVXUvZ3JmdjBrWXlqaGRm?=
 =?utf-8?B?aEp1K25nZzlvUHhnVnFvTEFtWi9ZQzRMYW9uZnhZV3NwQkZHTXFxZVRwclhG?=
 =?utf-8?B?QWp0Um96Y2Q5YjJRSlF6VHVzMUwwTDNMT2dzRHFDSFVaL2tqYjcxQUl4ZGZ4?=
 =?utf-8?B?c3RnanRyZjZaZlZPNW12eFA4SVVTcG81UHlNK0ludmlWMWtuQW5qdGhDQmtZ?=
 =?utf-8?B?cXdtM1FmZXV4ZDlYMlJxVnk0NDZ0WHBPUEc0dHg5TXFEZmlvR3lRN1BaMC90?=
 =?utf-8?B?M0wzdkVtemk0VXQ0M3c5S3lLNnM4OXlyek4vVytVcCs3SlFEQXgzWklia2o4?=
 =?utf-8?B?cVpib2JIajJxZWpQcXNOK2RIb3ZwWnp5Q2cyM3EzYnY1NnRYbVJqaEg5dkZ5?=
 =?utf-8?B?MG83YUVIVDNuZHNaS3lrU3pZUlRPeS9jY3EyR1lHc2NDNndjekQ0cUttUlFu?=
 =?utf-8?B?UStkdEJxSktBM1phdTJvaGtqY2d2QXVENmNlSlNva2VZd2FvR2JwZktsYzAy?=
 =?utf-8?B?akVQU0xocGJpSlROWDVQVlVUd0VrSnBIbDFnUEs5ejlPbVcwTWFRaGJ4MXc0?=
 =?utf-8?B?Yy9UYTZRdExVZmJlYUtsZGEvVkFUQlV0Q3JvZndCMVpsdTFpeStPSG1pNENG?=
 =?utf-8?B?a0daL041U0ZzTG4wL1Z0R0pKOS9VKzZRTUVON1lsa0xFeE80aXA4MngrMGM2?=
 =?utf-8?B?OGJlZ2FPNERLdTNuaFJvaFRobXExUFE4d1grZjFTOVFOL0MvanlqSWc5cy90?=
 =?utf-8?B?WXhlUHprQ2NoaUxRN21GWXpjL2ErQnB3bHk1Q0VGcCsvRXdnN0p2QlpDVzlr?=
 =?utf-8?B?M2NqTUVYSmU2STFsVEd1T3cwNDdRN2p1MXFtV05Vemx4anRGSUFad2g5bDF0?=
 =?utf-8?B?bzF0aE1EWm82N25xM0JBOFBOLy9zY003STIxbDFMdUR6Q3BsV2RacGVwaWZv?=
 =?utf-8?B?RUhrb3VOVTFSejZpQWVjb3hHbStVNnI3YXE3aTMweWJRdEtxckZsbE5nZjNO?=
 =?utf-8?B?ZnBrTkVZVW01NC9HUXRWT2VONHV0YUhGQlhSOXpGU2pVdHRVVmZFQ1hza1Rm?=
 =?utf-8?B?R1pmdHVyWENWakdaL3U3bzg3NVFmRHk0NmFVclA1d0cwaXFEWDlsUEc1S0VX?=
 =?utf-8?B?TnRmYy9OUzVGemtzeHBXS0tucGFVdHc5NkYrS1BtWUZWcFNjM3cvTitCOHRC?=
 =?utf-8?B?V1VTQ3E1bll2NVVnOEFQT1EzRzFHdkNFSlFXc2Z1NU8wQ1R5RlJtcHdLSDV3?=
 =?utf-8?B?WGs1c0FaMi8rZjNQNE5iTVp2RkZjdS9oQ015NmRtNTFQTkYyT043U3kzQ1d6?=
 =?utf-8?B?c1ArWlFCTCtqVkxSWHgrUUg4ZFJrenplUTN6NnBKTytna08wVkpyT2M1b1d4?=
 =?utf-8?B?ZTRnaGRHa2lCVDljckRYeTlFRWlOeitNUlNkUnpjTjdOelhnc1hMNjFkUWhR?=
 =?utf-8?B?RmtqSjRrTkxjYlk3QkdHV0ZVMlN5TDRyRTZtN0VCaG02OUk2MXlnUjkrYnBn?=
 =?utf-8?B?ZEQrUDU1QUxQTS9QV3hNakxiQ1JSMDB3anlrNVZvSjZsUFNqeGpIam9lUFNx?=
 =?utf-8?B?eWVoeW9ZNnIram9adXRGWE0reEhaYlVZNHZOTXljZnVNRURkZko0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4fa90a-36c4-4a7b-43fd-08df4ba5d287
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:12:48.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mL1b14tCsOix9H5BJ3FIgO3ITvL0qgjistheIqjU0LkpagbFvex3HKQGiqlbITq9DZw1v6sKN4SP3hzAnQKM0k4JGCn6B4edyl4NGScb9D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PPF523F792B1
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Nov 2026 10:12:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5541

Hi Trevor,

On 11/24/26 5:01 PM, Trevor Woerner via yocto-patches wrote:
> On Mon 2026-11-23 @ 05:01:58 PM, Quentin Schulz wrote:
>> Hi Trevor,
>>
>> On 11/23/26 4:44 PM, Trevor Woerner wrote:
>>> On Thu 2026-04-23 @ 06:19:37 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> This adds support for the NPU (Neural Processing Unit) found on the
>>>> RK3588(S).
>>>>
>>>> The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
>>>> Device Tree nodes (so not all RK3588 devices supported upstream
>>>> necessarily have the NPU declared properly!) and a userspace driver in
>>>> mesa (teflon delegate with rocket gallium driver).
>>>>
>>>> This adds a config fragment for linux-rockchip kernels such that the
>>>> disabled-by-default Rocket driver is built and enables the Rocket
>>>> gallium mesa driver with the teflon delegate, but only when the user
>>>> requests its support.
>>>>
>>>> This was tested by running the following:
>>>>
>>>> """
>>>> wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
>>>>
>>>> TEFLON_DEBUG=verbose python3 classification.py \
>>>> 	     -i /usr/share/label_image/grace_hopper.bmp \
>>>> 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
>>>> 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
>>>> 	     -e /usr/lib/libteflon.so
>>>> """
>>>>
>>>> from an image built with meta-tensorflow's tensorflow-lite, mesa's
>>>> libteflon, meta-openembedded's python3-pillow and OE-Core's
>>>> python3-numpy packages.
>>>>
>>>> Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
>>>> currently supported in the kernel.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>> This was tested on RK3588 Jaguar with linux-yocto 6.18 +
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f
>>>>
>>>> Note this (lightly) depends on
>>>> https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
>>>> being merged in meta-tensorflow. Another option is to simply add
>>>> "tensorflow" to DISTRO_FEATURES to pass the (useless) check.
>>>> ---
>>>> Changes in v2:
>>>> - switched to oe.utils.vartrue from bb.utils.to_boolean
>>>> - driver now built-in instead of as module since the necessary patches
>>>>     have been backported to the 6.18 stable kernel version currently in
>>>>     OE-Core via linux-yocto_6.18,
>>>> - updated commit log now that meta-tensorflow is usable without hacks,
>>>>     and filepaths for input files to classification.py have changed with
>>>>     newer tflite,
>>>> - reworded README to specify libteflon needs to be installed in the
>>>>     image manually but the mesa rocket driver and teflon delegate are
>>>>     automatically built if the variable is properly set,
>>>> - Link to v1: https://lore.kernel.org/yocto-patches/20260128-rknn-v1-1-363d7ef2c16c@cherry.de/
>>>> ---
>>>>    README                                               | 20 ++++++++++++++++++++
>>>>    recipes-graphics/mesa/mesa.bbappend                  |  4 ++++
>>>>    recipes-kernel/linux/linux-rockchip.inc              |  1 +
>>>>    .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg       |  2 ++
>>>>    .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc       |  1 +
>>>>    5 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/README b/README
>>>> index c2697d1..6d9db9b 100644
>>>> --- a/README
>>>> +++ b/README
>>>> @@ -222,6 +222,26 @@ Notes:
>>>>    	NOTE: this variable must be set before any include/require in the
>>>>    	      machine configuration file
>>>> +  Neural Processing Unit (NPU)
>>>> +
>>>> +	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
>>>> +	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
>>>> +	to use Rocket instead. At the time of writing (Linux kernel v7.0), only
>>>> +	RK3588's NPU is supported upstream.
>>>> +
>>>> +	This NPU is an AI hardware-accelerator. You can enable its support by
>>>> +	setting:
>>>> +
>>>> +		ENABLE_UPSTREAM_RKNPU = "1"
>>>> +
>>>> +	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+) and
>>>> +	RKNN Device Tree nodes
>>>> +	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438).
>>>> +	The mesa userspace driver (rocket gallium driver) and teflon delegate
>>>> +	are automatically compiled when this option is enabled. You need to add
>>>> +	the libteflon package to your image to be able to use the teflon
>>>> +	delegate.
>>>> +
>>>>    U-Boot Environment:
>>>>    ------------------
>>>>    	In order to configure U-Boot to be able to store its environment into the
>>>> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
>>>> index d9e7c08..69a210f 100644
>>>> --- a/recipes-graphics/mesa/mesa.bbappend
>>>> +++ b/recipes-graphics/mesa/mesa.bbappend
>>>> @@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
>>>>    PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
>>>>    PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
>>>> +# Enable teflon for upstream RKNPU/rocket support
>>>> +# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
>>>> +PACKAGECONFIG:append:rk3588s = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' teflon rocket', '', d)}"
>>>> +
>>>>    # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
>>>>    RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
>>>> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
>>>> index 6c62e84..dc30327 100644
>>>> --- a/recipes-kernel/linux/linux-rockchip.inc
>>>> +++ b/recipes-kernel/linux/linux-rockchip.inc
>>>> @@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>>>>    KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>>>>    KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
>>>> +KERNEL_FEATURES:append:rockchip = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' bsp/rockchip/rocket-npu.scc', '', d)}"
>>>
>>> I was looking to merge this patch the other day; it still applies
>>> (with small adjustments) and i can build-test using rock-5a.
>>> Unfortunately vartrue() isn't how i want it implemented. Toggling
>>> ENABLE_UPSTREAM_RKNPU rebuilds nothing, in either direction, so
>>> whichever state you build first is the one you keep until a cleansstate.
>>> The do_kernel_configme signature is identical with the knob set and
>>> unset:
>>>
>>>     knob off   9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
>>>     knob on    9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
>>>
>>> vartrue() passes the variable name as a string literal, which bitbake's
>>> code parser does not track. A [vardeps] flag papers over it, but I would
>>> rather not carry that kludge in the layer. bb.utils.contains() works as
>>> expected and the README already documents the knob as "1", so it is a
>>> drop-in replacement:
>>>
>>>     KERNEL_FEATURES:append:rockchip = "${@bb.utils.contains('ENABLE_UPSTREAM_RKNPU', '1', ' bsp/rockchip/rocket-npu.scc', '', d)}"
>>>
>>>     knob off   bf89f310b03cafa01f0a4b130fcda233bb9ff2689e6575d8fe77ac3d9aa95806
>>>     knob on    7733dbcc030a79f18343e605afd13363f38a60a3d47c0eb1c7d9247f12b6135f
>>>
>>> The mesa.bbappend PACKAGECONFIG line needs the same change.
>>>
>>> Bug 3890 got contains() tracked back in 2013, and the visitorcode hook
>>> added to bitbake in 2024 would be the modern way to cover the oe.utils
>>> helpers, but nobody has wired them up.
>>>
>>
>> Can you please open a bug so that this is known? We already have users of
>> vartrue in OE-Core, most of which do not actually add the variable to
>> vardeps varflag, so we would have an issue there as well.
> 
> I looked into it before filing, and I don't think there is a bug.
> BitBake works out a task's dependencies from the variable names it can
> see in the metadata, and a name passed to a function as a string is
> not one of them [1]. The BitBake manual covers exactly this case:
> [vardeps] is for when "a function refers to a variable in a manner that
> does not allow BitBake to automatically determine that the variable is
> referred to" [2]. vartrue() is such a function, so a variable holding
> its result needs the [vardeps] if a task reads it.
> 
> A missing [vardeps] is only a problem when nothing else carries the
> variable into the task, though, and for most of the OE-Core users
> something does. DEBUG_BUILD is already a direct dependency of every one
> of those tasks I checked, through the [vardeps] on SELECTED_OPTIMIZATION
> and BUILD_OPTIMIZATION in bitbake.conf [3], so toggling it rebuilds
> them [4].
> 
> webkitgtk is where you are right. Its variables are only caught because
> they also change DEPENDS, and for GIDOCGEN_ENABLED that happens only
> when it is exactly "True" [5]: GIDOCGEN_ENABLED = "1" turns the
> documentation build on in EXTRA_OECMAKE [6] without changing any
> webkitgtk signature [7], since webkitgtk declares no [vardeps] of its
> own.
> 

All the above can be resumed to: "It's not a bug, you only need another 
unrelated part of the code to add the dependency". This sounds very much 
like a bug to me. We shouldn't need to rely on another part of the code 
doing it for us. Or it should really be documented but that sounds like 
an enormous and unnecessary footgun.

Cheers,
Quentin
