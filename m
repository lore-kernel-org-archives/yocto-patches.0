Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14602.1795780375128606590
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 03:52:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=IDZEVQIS;
 spf=pass (domain: cherry.de, ip: 40.107.162.7, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7rl4BrJ5LCaOF9V6EG4Csi/0kU13WwAT0TzaJjHlERDfpULKcPFeUgGLPaznff+bi4YAOGLLqoolkTQF/FOGM+WHnx8uIHaeQLbI9kXNu47U0UGsyFkwIexgyd3AT+5WGczi9y/rHAyjQFfVKUPakQ8lgWpmS2CAVih7ZFOgd3kf71QfepuZo4gUqLoacS65coDIoD+J8xLNoI6fLIdcYJuRdV/eA0R+Rk9fVbCMDDZyNPQglq1i//QbXk+WvPGFxAPBRJNDfx/xpfHbp6+r3Wt5fRmg3Or4LRKMEibXiJ64UslwQwvBp62H3aBN/OwZMLZjGaQCL1bbxo1ChXnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdCDM0AZCKjtCiCsqT4BN1Se4xW/ixdMt1Xqh1k1tzM=;
 b=mLUsV59/a6LZ+EfzRxSpSlYoXKSiDpDvxCS7VbycqjjRutxI4OE7RZjBjgfqlDAVnfGGdboCV7f1Ght0UxL8ggK3gO3I58CT0Pe1RGgcJ8oE4yN0cI7yjSNbwpLQBXoo+efRGa/uP4mV/IcE/GugF/0XH6deSETz1AmyIP6QViEXEPgLRcKY2nEKmfpnltigCIeojkKPdUs1OyTq3rSbtJntjFgcxu38yCCf/TW1SIowgXt1Xcs8WcHr+8xclfkzBMBcZzpP+CSHdNxgcg3bOzK7FtqawWr5IrRG0l7dF7dcLBc5DB3/+8dJoNPqDEB8pxCKesFgwdfC9ygCvBFvLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdCDM0AZCKjtCiCsqT4BN1Se4xW/ixdMt1Xqh1k1tzM=;
 b=IDZEVQISfM4J4Pi2Kepsuc2lXiGe4Yc0CWJTIumuYzGGTdItsWO+J3FJxb/T2kyHgDIDf+Qz8XNGHT36g1M2zY5UNbKgfQyTIjOC8s5VVx8oGbkcw+lwi5VL6NvZTCl0LWkxNai1TWfPu0zhxOvYZLkbSVCjqUm+5twD8o+8C0Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:52:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 11:52:50 +0000
Message-ID: <6b21fbb2-cc3f-4553-a6f2-cfb202bdb89e@cherry.de>
Date: Fri, 27 Nov 2026 12:52:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip][PATCH 1/2] kernel: only add the rocket NPU
 fragment on rk3588s
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20261127114049.3566943-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127114049.3566943-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0243.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::31) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e787d3-33c4-467d-9b81-08df4c7cf64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: hsOvVRIyq7rjkF4HAAqHKCMnWy3gFLbNd1npvWBPAN3laT3EBmM4JhaVfX2I7sZLKEghtKCG0yzD0NUXetYV93Ixz7PtYuMedldSsO1HcxrZ59CSEHmYwHJNh+ZMFSzIcJ9o6Eo1Pl9SMzYPWBy1PE+fbGu06XLcCjjDT6+L8QU2atELLky4HnWrbtIN1TyozuhOaQml3WnVgUOZyyfz9RxKmTg8+RJgxtgAHxIzd4gSdiKuGF3FWraAyGTjc0QwywO2KCHkeG2sbKr8LC6GSRO6QOqwKuxe2+bpZ4X+IHd/g9WRmThr2A4npLdVRs1lNgll+OY82BfT0sxGWNDxcO7W2sEW1844ZRB/nl89tuxk16LQGyISdgdhYUuJWKYJTSOS8eYiP2+Fwu7xLUBQxdugaQuayScSOyKBFeF0RVOaSbZ3o+4x2me+bzKUmvlD3P8pZIheKIzQ8JvVDru6gszUGUriML0pgo0MxE+aqyfZkq54QSvwfL2URD6YegCuhIaF0CwDMFH4DmGXDIt1FQPWKRglhyk0gUvJTCiWr/unPixvHERQCW0Z3E8AwsxYuDZzY0yXhLhr3FADLgPE/xnUAWpz7/c9kr7pOnven8QL5KvwbK/ec1fdZt9vYd3gO6BRLBjfganEI3qqOmtdHsoKpldXtnZbUAaJorJKVjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1k4TWlCNWlNSnExeU9WRFF1YzMzVmVBWnVRa1VqOStGU1BaWjlnUXp0eUh1?=
 =?utf-8?B?NTIwL2NLaThUY09ObHlHV3M4KzZtaEtJZ1FPQ1lLZkFpcmRKNmRTRy9nNjVM?=
 =?utf-8?B?ZGhIVVpxejdpYjZNUms0L1hRb1NQZzlML2UvRUtrL3pYMzk3WlNQU20zOVdG?=
 =?utf-8?B?a2FDaWNjMnlxSnpxZk5YYUVxLzVVODByWVFSTkJKQjRMb2pUWEJDdXZaKzZX?=
 =?utf-8?B?YUdoMmhUaXZPd0RINUY4TGNUN2hVblZpWmUrQUF5d2pLY1IzdWtGbGJHVUY3?=
 =?utf-8?B?Q1FJbFhSdFpTb2p3bWtPdmdWcWtLZGtuQXhIdUpEaUtWUERGUkdUTjdZT0pD?=
 =?utf-8?B?MUtQOVFGT2ZYK1V5aFNvc00yVHRrUGtSVjhtUVd4V01DYUZkUis3dzl4dklN?=
 =?utf-8?B?Z2ZrdUFWSG5CbWZ6Y3hySGlNeXdrOE9iYXRjSzYza1B4UTFLY3JHdTVtek9k?=
 =?utf-8?B?amM0STAwUDlQSkJqdFZ0SG51WFcwdGRjMlVkUDNwWlFObkN1UU94RGZ6SnRl?=
 =?utf-8?B?TnNLQ0lTOWlLVkM5cHdaVjM4TEY1Yi9HTVo3cTdZQ2UxOENKN3hZcVhjUTlh?=
 =?utf-8?B?MmtMZFZBOENoK0FwUXNoWE5TaXNnbTU2dDhWcEZnNkhqWER1aTV1eEMzRTJx?=
 =?utf-8?B?TFZhRjlsQjFnRlpmbTNnS2dsUGdoL2JHQmdNTUZzV1FrQzNSQlpVS1E1Tk9P?=
 =?utf-8?B?ZzlXb08rMUNYb0FYdzhLZ1JQTGFTdzdEL3ZEUGNvZ3JMV2FrL0NCVE1lazkw?=
 =?utf-8?B?TG1sOUhhNmxPZXNZMXpEOFhEb0hZb3VKWkwvbURiN1ZwaUJJZDk3RTJkLzlF?=
 =?utf-8?B?cE9BTktvSTFRQ2l5a1V4QlErVzdoa3BFTGF1YUt3dmRkOStzM3hhQWg4K09D?=
 =?utf-8?B?ampPRCtpYll5cmlyRzN1SU9rWjlDdHJKdFdVTCthS0x1cUx3Yk5sK3QzY3pm?=
 =?utf-8?B?SWZKRFc0d2RnMG1BcFFwd3BVeU9CdkhyQy9IeFp1ejFQQ0JpYlhNTVZ1VVRO?=
 =?utf-8?B?aWltUUVNWTZFcUwwQ25XMktTcGI4TVNJTThsM0x3YiszZHhmeVZrQ1hESjNm?=
 =?utf-8?B?cTFJdUNkM0MzYjVQOHJhRHY3bklRaElYUzJZNWZHcWN0UlVSM1JKNEFJWFZB?=
 =?utf-8?B?SVdFNmE4c2RlVWlCM3F1amdKaTRxYjd6UjhSZFVmY3hTVWI4Z2o1MzlVUmxX?=
 =?utf-8?B?VEJmY205YXlWNE90TXhINU9SVk56M2o0TDJmQmNoSXZZbnNyVVZDaDVFTHFz?=
 =?utf-8?B?SmU0bnRiMVU2SCtKcUQwb1BzRDJ2N2pJY1o3MjhncEhpcklzaG51UG1nM1VZ?=
 =?utf-8?B?Zkw4SFE3OWk3cTRvencyT2pYOXYvWlhmMHgvTjhxWVBEUzhCTmZOSHF1TkVu?=
 =?utf-8?B?UjJXdUJiK3RKOHNGRUQ5dDZNMUVaS3AvWkt0V3BVWDJwcEdVK2t0MDRjMmdy?=
 =?utf-8?B?UmVCWjlaUEZydW5TQm0xQ1N3a2RvSUNsN2NvK2ZYZEJVc1N3cVZQc0tEam1R?=
 =?utf-8?B?aE9UamdSOFFNV29mN3dYVEFvemJTNzFuYmFnUExEZHVSbzFzRjBDOUNZb21v?=
 =?utf-8?B?Q0E2cTl0YzVCRWVtL29QVDNZem1LcHB4VklOcEc1dWRxQThOZDV0R1Q5cHE0?=
 =?utf-8?B?bFRTTVVVbFFpNzZNM3FVd0EyQnNoQi9JVkxOYmo4T280MjBhaitUcTVJWkpu?=
 =?utf-8?B?MGtveGdaMFJKalBhZG5MMlJaWTZ3QWo3U0ZobEd3VytXa3lRb1BHTkhObjBk?=
 =?utf-8?B?cGZ1ZElwSFUvYWg3SXg0QlJaR1F4dTFlK081WDkvU0FBbC9BL1RVNkVlUVAx?=
 =?utf-8?B?UmcyY3IvK0lIMHhQTllDNEVMTkxHK05MeXJOMU41SVhmRWRHYzNkTFV5MG1Q?=
 =?utf-8?B?WXJWWXhaY3ZjNml0SVRVYlA1eXhkeWkvckNnQ25oZkQ2bVVYWXhUOW9vUHA3?=
 =?utf-8?B?RnhVWEJVTGNqa09iT0VvemRDbnU4OVRzYllsYm5aL08ybnp0T25LRG5OZEZE?=
 =?utf-8?B?MVl0TlZhOWxNVGh5TjVhV04zSVFXMEw1M2xGQnh1UFdhN1hSOWp6WXBvNG5w?=
 =?utf-8?B?eXdKYW5EeXgyZVFjaVNjZElBcVNKZ2NGcm1tanhZTjhGaDF0aGRDV2FuY0dn?=
 =?utf-8?B?WmNTVXVxWlNseXBCVmNIdUlGY25YcVFmZmZaSjVNVHlGamZ1dUMxK25DejFN?=
 =?utf-8?B?aWw1QXZWUkVZTEFzZ043bG9IWnlQTmJmRERzejB0RXBqTVROcnNLSWVEbXRh?=
 =?utf-8?B?NmNnVzJZVVpxbkZJS3pSZWo3dWlpaXQ0aVNPb1F0VWFOVkdrbHZxbDcwZHVp?=
 =?utf-8?B?OERFRHJoLzRCaFdnV3kyaW9paDBmUWJjTXRBSXJpYjBBdnloaFBJZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e787d3-33c4-467d-9b81-08df4c7cf64c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:52:50.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMGGKwltxWzS5vn4fTrqjThZlSK19ncK8Q7JlBy7wnin1M6Lc7qHKTvkiiCT+VLpMTQrKlFO7UTPsgU69/2SRj6cP91WB/R8y/aC2+fqix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 11:53:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5549

Hi Trevor,

On 11/27/26 12:40 PM, Trevor Woerner wrote:
> The fragment was appended for every rockchip machine, so setting

No? It's clearly only added when you set ENABLE_UPSTREAM_RKNPU boolean. 
Don't set it for SoCs that don't support it?

> ENABLE_UPSTREAM_RKNPU made the kernel config audit warn on all the
> others: the driver only supports RK3588's NPU, and on 32-bit machines it
> cannot be enabled at all. Use the rk3588s override, as the mesa
> PACKAGECONFIG already does.
> 

Mesa probably should be using :rockchip as well. The knob is enough. 
Otherwise every time there'll be a new SoC supported by Rocket, we'll 
need to enable ENABLE_UPSTREAM_RKNPU (or document it's supported) in the 
SoC .inc file, then update linux-rockchip.inc as well as mesa.bbappend 
to add an SoC-specific override, which is totally unnecessary.

The same logic applies to the stateless VPU for example (c.f. 
ENABLE_STATELESS_VPU_GST). We probably also should have a kernel config 
fragment to enable the appropriate stateless video codecs in the kernel 
(hantro, rkvdec, rkvdec2, ...).

> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> AI-Generated: codex/claude-opus 5.5 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-rockchip.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> index f91492ee7968..006d9f0ecf14 100644
> --- a/recipes-kernel/linux/linux-rockchip.inc
> +++ b/recipes-kernel/linux/linux-rockchip.inc
> @@ -37,4 +37,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>   KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
>   KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>   KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_FEATURES:append:rockchip = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
> +KERNEL_FEATURES:append:rk3588s = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"

