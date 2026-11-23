Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57090.1795449724945507100
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 08:02:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=h5wAsNdR;
 spf=pass (domain: cherry.de, ip: 52.101.65.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqhQExEHQSaJgDXkZiAmJtRcXgz7j6o6vsJ7tondmjG9phWpbEFTQah+zSa6OjS6RKRMAWcyBj24pTvp55uJxdnz/iVn1mdnY9i2Wd+Ni6EMgXFYGCzDuc6Bo6RLzxrEZoku1P0kb26SQGG5LeOp2w9D8P/nMXg6oD+lOfT8mypLDMNv9FG3cldc8Oe6qzcJjb/RPXopwf03PUv6FcN1zCqq+MaT6u9cvmwOktY3IdsscLDqdgNqMiCFyt/EXXKGJ6AC9NroxXDJCwXFyCMtLBlwT3wikSPP7IA7MsOmKmgvJoJqf9jiZ3LU6TBt/S7JGECnFe69sud4rcVh6iQf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRpUv/BcYzRqOgKF9TUL+BPgLcPlYO+kB1jnyMc1zzo=;
 b=R2lP1nx9J4/6GdVxYwmUbWqauXDUIo4dkNgAtppAeANFKwJVlamOaiGx9LaCct+lUhadGhjH5sfvi524d9VeeHFIUrxZdKX0C00pt3luXQ+SQfMCo3FaHKvpvLlXlkZiYeXSik4xFo4JDmEG1QWzeBJfvNcd6bXpsgSjKSnUK+i3AfucvkgzpreRwcHWEYJ+P2jb/GwPEB8r00jfjP7TXYJ0+8O/uwXf7ol0bwJ/acPKycAttAviIqQFxKhEnd8MsaM2ZRUkA2LHzVWqxUnDYeRrT0Pk6vLMYrULID7DBJrsXm4feIWVaokAvlkbO860uK/YZsMburKppG+xnFvW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRpUv/BcYzRqOgKF9TUL+BPgLcPlYO+kB1jnyMc1zzo=;
 b=h5wAsNdRukVMbf1nhBKSdszeFxq/UFqijA7BsrESLrRFPincnOsofXYr+DJpyLgLavDOXihll/ipiew5a2doF7wrlTK5GgvDqQe6mM8Sl8EailkpSYVY52Ys2yu4u7GgsYIrCa4HVhUhmH/W33BqDhz03XEqzY0nrc2nx9kliZ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by CPHPR04MB771833.eurprd04.prod.outlook.com (2603:10a6:380:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:01:59 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 16:01:59 +0000
Message-ID: <43f032c6-5d8a-4a1b-a0f5-8bf30873d0a9@cherry.de>
Date: Mon, 23 Nov 2026 17:01:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
 <awRfVnmgA5cTr4Xo@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <awRfVnmgA5cTr4Xo@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIUP296CA0024.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::11) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|CPHPR04MB771833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6d1f91-b812-4633-2683-08df497b1b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|261009221227099003|4133799003|56012099006|4143699003|10067099003|5023799004|11063799006|261102123227099003|261026135527099003|261026121527099003|261026130827099003|261021121427099003|261028144727099003|261026140227099003|261021123027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021130227099003|261021135927099003|261021133027099003;
X-Microsoft-Antispam-Message-Info: jsqAhMBPq0dVWyBCVGEnM7/BljNBPNHzzOgXMdYsfGAQTcawDaOf7tsN8HCTdc4K0zDmAb7pnMxQhrrlltid5zAXkWECCQfxoOThspbiIXeJpaiR9GHqS4mJObeXAn4IQsjS7loektqUg46Un4zIydtyyCItOZp5qRikXojKCFblu6m7r1Rz4e9RTREtul0yQISfhCpqRhm0Qb8ZES4tyO9wAOcqQxZOQauE858S0LbivnHCnjc1NvUTgdvHeGUr2QWh4RPz5qDaSkZ/xXYv2m6Gd+oxwGniU8/1572wq6YZTUwGomm2qp+7brdH9rl7ZEItZor6oTfqA+HSgpVUYx9UFwFw6ZYpkD/cWp5gHqqb1UIR9x24IdzA9oJ8dnh2nMhevWTbpbL/1hVp08xxZd/SDkE/Dvdf3kFYPc+la1+M36vAsnXvaeo6ZufdCICHDf9g4QgE8BjA1W2Z8n1xWTFxjANdKLuo0kX9oWx9BoF48TljoP0SjZPNsuzWW4YdsUWh5qsuH6yAUFykQ8j1vYW2w5dMeyQE+RlC9hWo97Xdt5KIRVQaRL4twR60IpceRPiWBaXH4mCnl4b/a2OFN9S9LxUn+4g7s75uvpDGv/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(261009221227099003)(4133799003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006)(261102123227099003)(261026135527099003)(261026121527099003)(261026130827099003)(261021121427099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021130227099003)(261021135927099003)(261021133027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGRXTktYNDFNU3pLQ3ZWMjlXL3dqUmpUeFBocXR3cHZHN2R4NVZtcitCMHN5?=
 =?utf-8?B?enFqbmxOOE95QlpRaStmbGkwUDlobHNTMWdhZHZQY0Q4RlRNOG11Z2IreWNG?=
 =?utf-8?B?YzBUdlBMakxyRDdLcEp1d2ZIc1dBYVQ5VHVuRzF6UDBVRmpsc0UyZDRaYXlv?=
 =?utf-8?B?d29MVVRFWlhhWGkvMGRHbjJMSHp0QlZlYTdwSjE2cWYxZldtS0xVeVZaUk53?=
 =?utf-8?B?aUZtby8zKzZzN2dJdkduRGJ4R2p2aFk5RitHY0IrTlRoZHhDMGQrQmNyU0k3?=
 =?utf-8?B?eGdCRXBBbUxjazQ4aWZZRXpkWGFXMTUrK2lBUU94MFQ2bUVKQ2ExLzM3Yklh?=
 =?utf-8?B?QTUrYlViVHFlMEtnUWtvRlZ2WGdXTVNoQUxwcTBpY291VTRjNEFTangza2VB?=
 =?utf-8?B?MGkrSW4vZFF4Q2lpWXJ1S3djNU1rMmFFczF5Q205S1l4Nm1vS1ZuWFBqUUVB?=
 =?utf-8?B?bklGYjBmZW0vOWNSZXZKY1lRMFh6M0ZPa001RjV2NVdRNTFVMGFacUE5M0t5?=
 =?utf-8?B?aXZaRUJiY1g2WVd5SEthaEVzV3o0U0puZ2JQSWdxTzVKMFlDNnJpYkFPUDRo?=
 =?utf-8?B?Qi80Z2l3R3EwelM3YUFCMzVZdlg2UVpVN2pGMDlyeVFkY0NkalA4TGJTaEtk?=
 =?utf-8?B?MFF2TXNXNkgwNEszZVg2R3R0Q1V0OUMyWDNKYnNqU3dtR3l5aE90ckJ0cng0?=
 =?utf-8?B?Z1krZTNqTVVYNlRYb1Z5c1VpQ3UxN2hlNzNjalRkMTVzRUx0UjlNTndlQUhN?=
 =?utf-8?B?aVBEMGFSK0hsK2lqb3BrUDluekI5VHc4eUJsendaM3d5RGJYajYrYVBjSWh2?=
 =?utf-8?B?ei9KTExwY05QR2YwckNiUjdKaGpDeFlkU1pROXUvK1V3d3pIMTl1SjBjQ1M4?=
 =?utf-8?B?Z2VRK2toc0xDa3l4aE9mRGVjb2ZtYkdQVTRxRDdrV0k2N1dLd21PVWpSdVph?=
 =?utf-8?B?eFBPc3U0enRQTjZrZ0hNNnc2SGlXbGRSRGhrUEZJZkNRTWlhMFpaTWJ5K3h6?=
 =?utf-8?B?cVF3TkFTSGVYblVvREpid2M1eWRoVE9heVA0MGtNRXRqelRMQXM5MEI1dTB6?=
 =?utf-8?B?TCttQVd3OW5yNUtiVXdXU2h1cHc2TDQvZnRRY0djeHlkd2Y2WUtVaDF0TGFO?=
 =?utf-8?B?dGo2K0dhNTI0aHUwKzl1Y2RUbzNuV3ZwbVVJTGcxeGZEbU1neE5Dc3A0alJH?=
 =?utf-8?B?NWdhUThMQ2s3UHFQQld4OFlGUURRb2toTFhiOHRERVNnNmNrM3lCK0JMTVMr?=
 =?utf-8?B?YnVTd0FZYyt5VmU4WDB6YnBrT09RdXFYa2dKaThFUC9Ia21JV0tQdVV0Q3Rp?=
 =?utf-8?B?YnFaNWlZZ0c0WThwUkhnWENGNlVtRUNBRHNVZHhOczQ3aXBreEk2eHIwSVB5?=
 =?utf-8?B?SFd2T2l3UldnaGlRdXA3ZDZvNDBDRGtvc2NpVG43akJIbExKWTMxKytDdSta?=
 =?utf-8?B?UkhtcGxuT0FXMFoxTllINHV2WHdYdWR1Rjl3UFVWUno1OTlXTnNUV2pQMVV5?=
 =?utf-8?B?eXpDSmlvQ2U5d0VjRW5SaUFUalRseTlBcGdQcGgxVDBpaElCa0ErQnFsZFh6?=
 =?utf-8?B?R1JQeXpLS1RpN1Rwc3VhR2Jyb3pubVdhcGJkSlNBRWd4d2Ezb2RDWGJKNHNW?=
 =?utf-8?B?cVhva3JHL1gxZzFvY3FrL3YzZzJOOG5hTUVlK1ZhK3BBRnd0S3dkYi9lSUNh?=
 =?utf-8?B?d2lDbFZONURTbDRaZWUvR0R1aDgwRlhtbzRudUkvK1JENU4zNEFBQ2plcW1H?=
 =?utf-8?B?OHovM2o2TWVxWGhZekE1cVphd0NZRFUzQXMvUHdWaHlncDd0L2JVSnhXMWl2?=
 =?utf-8?B?MjBCbnVMR01WSUdvTUZGWDlYRk9iSFJtYTJoNkphZ2VZYTVGMXVnQVBJN3F0?=
 =?utf-8?B?SlZiZXg2bUd5Rk9NVjlHeWNOY2VFV2dxVjVVSnR5RXV3cHFOK2xwd0hoZDZY?=
 =?utf-8?B?S2VpRVRwN2xxOHp1UUVSVE1CR2lSM296QjJLa1RKK3AzWmsyQW5kcGpwMGVK?=
 =?utf-8?B?ckxlbkhEUkR1SmovdU9QWUFHeGxCR2QraFVxb3FSc1BUbjR3eXZ5eW9iVVZp?=
 =?utf-8?B?N1ZxYU45dDlEc0h2cThQVVp3MEZhQ1FrVEQ0VitxUENPSkxRSE9teCtDUkts?=
 =?utf-8?B?QVdJYXllbXVTSUhmdzZuRXdITFpDblNDMEIyM1VvaE9RZDVCR0didElPS1B5?=
 =?utf-8?B?cVppUWFQTVc5aVc4Q1ZFdWpaVC9zQjI3WTNXY3p6cjBjRHc3T0VReGIxWDFk?=
 =?utf-8?B?MkJvcUNpa1VKeXhsTjk2RVUwNXRjb2Jva2p5VTZwTFBSbU1ORzdvMmhkWG5P?=
 =?utf-8?B?NHhqSW5WbTZETnhtSHRYajFvcjE5MlNWa2ZXSGJpblVZZUIyNkgwdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d1f91-b812-4633-2683-08df497b1b0c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:01:59.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE8tDMy4007t3d/U+KZR4tv9nWTmEwQ9pDOZDhCmWkIpiZv+vdu5bZRN7G0WdeOjNKTCGVP+1RfpIhraSlzezGczeMwWG8wrecBoTTiDTjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPHPR04MB771833
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 16:02:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5492

Hi Trevor,

On 11/23/26 4:44 PM, Trevor Woerner wrote:
> On Thu 2026-04-23 @ 06:19:37 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This adds support for the NPU (Neural Processing Unit) found on the
>> RK3588(S).
>>
>> The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
>> Device Tree nodes (so not all RK3588 devices supported upstream
>> necessarily have the NPU declared properly!) and a userspace driver in
>> mesa (teflon delegate with rocket gallium driver).
>>
>> This adds a config fragment for linux-rockchip kernels such that the
>> disabled-by-default Rocket driver is built and enables the Rocket
>> gallium mesa driver with the teflon delegate, but only when the user
>> requests its support.
>>
>> This was tested by running the following:
>>
>> """
>> wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
>>
>> TEFLON_DEBUG=verbose python3 classification.py \
>> 	     -i /usr/share/label_image/grace_hopper.bmp \
>> 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
>> 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
>> 	     -e /usr/lib/libteflon.so
>> """
>>
>> from an image built with meta-tensorflow's tensorflow-lite, mesa's
>> libteflon, meta-openembedded's python3-pillow and OE-Core's
>> python3-numpy packages.
>>
>> Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
>> currently supported in the kernel.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> This was tested on RK3588 Jaguar with linux-yocto 6.18 +
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f
>>
>> Note this (lightly) depends on
>> https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
>> being merged in meta-tensorflow. Another option is to simply add
>> "tensorflow" to DISTRO_FEATURES to pass the (useless) check.
>> ---
>> Changes in v2:
>> - switched to oe.utils.vartrue from bb.utils.to_boolean
>> - driver now built-in instead of as module since the necessary patches
>>    have been backported to the 6.18 stable kernel version currently in
>>    OE-Core via linux-yocto_6.18,
>> - updated commit log now that meta-tensorflow is usable without hacks,
>>    and filepaths for input files to classification.py have changed with
>>    newer tflite,
>> - reworded README to specify libteflon needs to be installed in the
>>    image manually but the mesa rocket driver and teflon delegate are
>>    automatically built if the variable is properly set,
>> - Link to v1: https://lore.kernel.org/yocto-patches/20260128-rknn-v1-1-363d7ef2c16c@cherry.de/
>> ---
>>   README                                               | 20 ++++++++++++++++++++
>>   recipes-graphics/mesa/mesa.bbappend                  |  4 ++++
>>   recipes-kernel/linux/linux-rockchip.inc              |  1 +
>>   .../rockchip-kmeta/bsp/rockchip/rocket-npu.cfg       |  2 ++
>>   .../rockchip-kmeta/bsp/rockchip/rocket-npu.scc       |  1 +
>>   5 files changed, 28 insertions(+)
>>
>> diff --git a/README b/README
>> index c2697d1..6d9db9b 100644
>> --- a/README
>> +++ b/README
>> @@ -222,6 +222,26 @@ Notes:
>>   	NOTE: this variable must be set before any include/require in the
>>   	      machine configuration file
>>   
>> +  Neural Processing Unit (NPU)
>> +
>> +	The Aarch64 RK35xx SoCs have a Neural Processing Unit (NPU) available.
>> +	It is typically named by Rockchip as RKNPU/RKNN but upstream has decided
>> +	to use Rocket instead. At the time of writing (Linux kernel v7.0), only
>> +	RK3588's NPU is supported upstream.
>> +
>> +	This NPU is an AI hardware-accelerator. You can enable its support by
>> +	setting:
>> +
>> +		ENABLE_UPSTREAM_RKNPU = "1"
>> +
>> +	This requires a kernel driver (CONFIG_DRM_ACCEL_ROCKET, v6.18+) and
>> +	RKNN Device Tree nodes
>> +	(e.g. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=640366d644b1e282771a09c72be37162b6eda438).
>> +	The mesa userspace driver (rocket gallium driver) and teflon delegate
>> +	are automatically compiled when this option is enabled. You need to add
>> +	the libteflon package to your image to be able to use the teflon
>> +	delegate.
>> +
>>   U-Boot Environment:
>>   ------------------
>>   	In order to configure U-Boot to be able to store its environment into the
>> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
>> index d9e7c08..69a210f 100644
>> --- a/recipes-graphics/mesa/mesa.bbappend
>> +++ b/recipes-graphics/mesa/mesa.bbappend
>> @@ -10,5 +10,9 @@ MALI_DRIVER:rk3308 = ""
>>   PACKAGECONFIG:append:rockchip = " ${@bb.utils.filter('MALI_DRIVER', 'lima panfrost', d)}"
>>   PACKAGECONFIG:append:rockchip = "${@bb.utils.contains('MALI_DRIVER', 'panfrost', ' libclc', '', d)}"
>>   
>> +# Enable teflon for upstream RKNPU/rocket support
>> +# Requires CONFIG_DRM_ACCEL_ROCKET in Linux kernel to actually work
>> +PACKAGECONFIG:append:rk3588s = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' teflon rocket', '', d)}"
>> +
>>   # Mali Gen10 (Valhall, supported by Panthor) requires a firmware blob
>>   RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
>> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
>> index 6c62e84..dc30327 100644
>> --- a/recipes-kernel/linux/linux-rockchip.inc
>> +++ b/recipes-kernel/linux/linux-rockchip.inc
>> @@ -36,3 +36,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>>   
>>   KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>>   KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
>> +KERNEL_FEATURES:append:rockchip = "${@oe.utils.vartrue('ENABLE_UPSTREAM_RKNPU', ' bsp/rockchip/rocket-npu.scc', '', d)}"
> 
> I was looking to merge this patch the other day; it still applies
> (with small adjustments) and i can build-test using rock-5a.
> Unfortunately vartrue() isn't how i want it implemented. Toggling
> ENABLE_UPSTREAM_RKNPU rebuilds nothing, in either direction, so
> whichever state you build first is the one you keep until a cleansstate.
> The do_kernel_configme signature is identical with the knob set and
> unset:
> 
>    knob off   9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
>    knob on    9018d9fe1ab2f6e350f9134f5dd8e4877eb76e6ccae962a96ca3e6ae6d4e60b9
> 
> vartrue() passes the variable name as a string literal, which bitbake's
> code parser does not track. A [vardeps] flag papers over it, but I would
> rather not carry that kludge in the layer. bb.utils.contains() works as
> expected and the README already documents the knob as "1", so it is a
> drop-in replacement:
> 
>    KERNEL_FEATURES:append:rockchip = "${@bb.utils.contains('ENABLE_UPSTREAM_RKNPU', '1', ' bsp/rockchip/rocket-npu.scc', '', d)}"
> 
>    knob off   bf89f310b03cafa01f0a4b130fcda233bb9ff2689e6575d8fe77ac3d9aa95806
>    knob on    7733dbcc030a79f18343e605afd13363f38a60a3d47c0eb1c7d9247f12b6135f
> 
> The mesa.bbappend PACKAGECONFIG line needs the same change.
> 
> Bug 3890 got contains() tracked back in 2013, and the visitorcode hook
> added to bitbake in 2024 would be the modern way to cover the oe.utils
> helpers, but nobody has wired them up.
> 

Can you please open a bug so that this is known? We already have users 
of vartrue in OE-Core, most of which do not actually add the variable to 
vardeps varflag, so we would have an issue there as well.

> Would you like to send a v3, or would you rather I make those two
> changes plus the rebase here?
> 

I won't have time to do that any time soon, so please do. Thanks!

Cheers,
Quentin
