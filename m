Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9046BC52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 08:32:12 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.46])
 by mx.groups.io with SMTP id smtpd.web11.15440.1724229127191225550
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 01:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=RIOzzAW2;
 spf=pass (domain: cherry.de, ip: 52.101.67.46, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHqfUr6bt3EzSZZVdoh7UXJMQxj8JRme+W0BTeuZ3dmu3HT2fOy7d9iNDPuXUtKhaQ7hu5OPiKtMu/zlqk+KkJrRjSHJhOA8Q3DXtAPPkr/dCq3ArEbL0dDbENuqX6pSby+C1R6s5PIqi0K4QG3uGHS9sm57nyDbON/eIlvfYhcNzVn5tvjsK8WA30Bxf/X1W8owtmJ67VA50YtFuPwRCCjopvi8y7oOVJ2PHdh7Xq9dyC5Vgnnh9EQGdgw9XD6QpdE4oaR8dvwFD9NurXqFYnNoggNW+mevNc4ziBgJfCXbhUvPqb9nr8HytyqAcmAoWwe6nHfymd/D+r+Uc35WGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B07lBo7Hy8seJG8Uc9Qk+KsfUjrBv0Kx2gbqbxaLaUU=;
 b=ojEL0YYe0MxryVmwj9NFruB1+HAVD9e5WRrwVaOYRkpeoKrKWQG8zG8W4Ng21MSPbwx3q4j5Moy4bhWTgfyrx8nDirswvp/deVGwZqwc9YSokINA1P3HldoVuABwtrE+oIfSMofJQhdDN4cqIfERlDfsbiLqZJrGqrtF3YgNr4Cx1GmLiY0uRP11vktT1q9lpxF7gtoMKlTNh8VVjHBcUVznONtXlHY6mV5WBlLF6752qEa1BEaQmKRHcZ55/tmDplsi6PaF4dCm9Z5uGptzs+HRSFmPs/QCk/pG6PZcaeTRIddoJAlCZ100N/N0lIXEonHjSQFF68jvn/+KLXsflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B07lBo7Hy8seJG8Uc9Qk+KsfUjrBv0Kx2gbqbxaLaUU=;
 b=RIOzzAW2jTpFcj+C8lIpna0NfgyuuOmAHYANVtVrJIa+pklyeOPoBAGaJhveZ7XyHcevvCPgowm45kn6DH73QQXqMfsJxpMQD6C+skeAHssrrayaEsGsLldIw6Ian1jaWG3OsM7lt749fTiY0kL65aW5su3h3zNvmy+2Fb4LJpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10895.eurprd04.prod.outlook.com (2603:10a6:150:20b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 08:31:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 08:31:42 +0000
Message-ID: <9aa9a649-1310-40ed-a5d1-ad59e6c016de@cherry.de>
Date: Wed, 21 Aug 2024 10:31:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] rk3328: fix SPI
To: yocto-patches@lists.yoctoproject.org
References: <20240821044419.2792-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240821044419.2792-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10895:EE_
X-MS-Office365-Filtering-Correlation-Id: 944bd958-f381-4f2c-ac4e-08dcc1bbaf62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nlk4aXBxZGNoblRGcExXK2U4U3lmTUlqOTFWQTFHMFdlVHBlM3BwMHQxS1l6?=
 =?utf-8?B?Wi9WNVMxUGxHRUFycUs1NXltcE9qT2p6cExNdXFlVXpmSWJidjNsbm9TTHVO?=
 =?utf-8?B?UEJlQ01RdVR0citrN3p3MWJYbHdHd3hxU0V3VzhEZlVkd1BKa2YzZE9JbHMv?=
 =?utf-8?B?RlRqREYxNlMwNjQ0SGVPRDY2cmNjQlE5aUhPS2d2Rm9BektMSUZvdkVsWFNl?=
 =?utf-8?B?b0w1T2pDS3ExYnVQWUZvZWdTV0NjV0s0c2Z3bmxyNlYrWTZ1Mm5ncDRBYkxI?=
 =?utf-8?B?M0JQWi9jMmQrUXRzd1NlSStMaGxCRkJncU9BYTA4RGllUkJWZU01ZTE2K2pG?=
 =?utf-8?B?Q0JPK0tGL1BEcGJVYjRNUStjbUdPeExZUEV3WEp2MFZmSVNQYkpHa2Rqc2VN?=
 =?utf-8?B?MHZLUHpqMFNlRjBTY2NTOVpKMU9lNGZreUZQNHpGa0ZWNi9teE42VGlmR1hG?=
 =?utf-8?B?QmNaUUREUVRYYkJnSlhJOVJjc3VqaFNZd29Hdld6WTlhTjNkcnJnQlp4VDQr?=
 =?utf-8?B?bGxNUUtveS9CaGtjQnF5Z1h4dmdtRjdKd1VqaTBqaU1DWWE5eDdrUXgydTJG?=
 =?utf-8?B?Mkd2eFVueGY0emF5bkV0ekpyTDVQVmp1Yy9mdHV0cEE1RU1qYWI4dFNydFAy?=
 =?utf-8?B?WDhuTUQ2SE1nR3FtVmlvbm40Wld0bEJZanh6VHZXcFZUcFR2dXh0UzhRSUJv?=
 =?utf-8?B?UERPQXYzUU9ZRC9sNFg3MFh1ME5TcHd4SDNYRVlGekJpK0ZPc1lPanVuRHZN?=
 =?utf-8?B?blNzT1drRWNPS0g0TG1WYjUvYUtGaWFwa1FHc2NVYmxkRElNYmxCd21JaDhq?=
 =?utf-8?B?ck5FYzVEeUpUK29id0Mvb2M3MVdyS3JmcTdpczBPOUdadlowNHdiSVhDNkJq?=
 =?utf-8?B?Yk1UaDg1d25lbXh2ZWFqd2g2N3hyWDNWZitwc05wRnc5NENLbzYxd2ZnUUpT?=
 =?utf-8?B?V2htVCtHM21YNUFHSTFGZkwzKzVjYjVYVUljek1Qbkd5NWsySGxFVlV0czUw?=
 =?utf-8?B?d0RFUWgvMElvKzhuRFNSL3JLZVhjYWVSY1JYZmwvQmFySCtmWmZzMll0QVhr?=
 =?utf-8?B?YUxZYVM5YUR3WmUwem4wUkkwMVJhekNNek1nckE2UFIxNlViU3lyVUJoaWlG?=
 =?utf-8?B?K3ZEWkZTZXIxOWRsOHVsbGNJdTJlQWdPV2gwOVI3THkzYUpTTjJObmtMTVEr?=
 =?utf-8?B?cGpneGhtQjJuRFNkNnhrOEdKK0RMWEpaL2RrVmhCZ2ViL0VTOXhERWxSVVVx?=
 =?utf-8?B?MENxOVhOamhteWhiVUt5Vm53MUZ4K21EeGhXV25iZytoWWdWRzNWMTRCZnUx?=
 =?utf-8?B?dEljd1VCZFZaU1R0MWU3eXdIbWZuZjVocTZOWGk5cW9jamszRlc3anZ2YnRX?=
 =?utf-8?B?d3dQYmt3R2Z5b2JPQTdGY0NtOTBRNDNBZmRWRXBlWXFXOTVVSTFIaXBvUnhv?=
 =?utf-8?B?V1lJdkJkZnpRK213WHNHelZSQk5FSXJkc0hGOVZYODA5cjhEUThTNUczV0dF?=
 =?utf-8?B?NzJWYVp0OFdVMitHNHhWZTl2OXhlbTJZWlFwQkw5NmhiRktIcFJaVlFSTXkw?=
 =?utf-8?B?cG5lSGhZMjRSa0g0Uml5ZXVmZmlMVm9LQW9pU2R1TDRVSFE0OW1KQU5MVFlK?=
 =?utf-8?B?cS9KVDE3dmNoL1hOZkNLVWRZaDd6ai93OVFFZlVtQ1o0WDl0UXU2cThNeVpI?=
 =?utf-8?B?LzdmK1FxbExqenoxalRlaHJsZ2NHYVZQeU8vM1U3QkcxbUxtWVZ6YWxkSTlQ?=
 =?utf-8?B?MXJzWGtHSW01a0t2TGtrd3ZQQXh5ckZ1L0RGbkVrbHRHMXJyeit1TTZaSG1Z?=
 =?utf-8?B?L2UzNDVKR3FZUm9yU09BQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bksxOWFDT0trUUdWR1JvNzFqTGVRdUVYY09zU3lQdnBFdXB4STA2VytNOEpm?=
 =?utf-8?B?ZVVoT3R6OTdGOG1CM3E1SVlUMTN3WkFNVkxRbERaaVpDK09URWFKL3dxQUw4?=
 =?utf-8?B?WFZEaFlQK3pnZ3VnVy9NR0F4QkZqelBQQXUzZHlObDdaS0xDL2ZnMHZpSktB?=
 =?utf-8?B?SGk5OTBpUXdBdWtPenpzcWdGb3kxZkFxMEZ0ZjM2eTVSRFRZNVBYSCtUd3hh?=
 =?utf-8?B?R1NUMkN0NDZGMEtWOHNOeTJaN20zN2JhSVVlWVNrYlZvMExWaENyT0wxYUpX?=
 =?utf-8?B?MlhxbEtaQXVnUXhlMmc0a3VSK0lRRUhFYnVYZm0vTmtPbXptOWtzMjQrRFpp?=
 =?utf-8?B?TDY1c3hTZE54dzJVbytwcTlNNnRFeEE1d1dpVFh0MkVuNEwwcjZCSXZVaGJ6?=
 =?utf-8?B?TndxUHhQNC9GT05oLzQ1VGc4WHpXR2tHSXhyQmJtY1Q1NEJpNXR6d242Nmxh?=
 =?utf-8?B?a3lIQ2pKYWNmOEtBallyRkI5bXFYOUNtMkhmaGQxOUdkWEZlK1ZjZUtPOTJM?=
 =?utf-8?B?Q1lsa0ZVcUR5QmhJcEp5Tmw1d3ZRVks4Y2N3UVdiYVMvb0t5azBURUJxM2tu?=
 =?utf-8?B?YlJqcXFCOERpSHoxZCtqSkdHQ09Sc05TZ2lqVytPaFhYbmRCZXI3VVR5OXd1?=
 =?utf-8?B?NXdoekE4K0dHT1hEK0g1aThMb0JNMkhTVW05TVVBYVhwTDdwN0k2YjhMdGVT?=
 =?utf-8?B?THZsRGlDYTRidldPTy9ENExuZCt1cEUvL0krd0FOTVpzOGFvaUZBR2MyY2xR?=
 =?utf-8?B?MWRld0tLVVA1bUl0MVFhbFlCNjkrQ0N4ZEcyNlJtOXc1WDI0ams0aTdGb0hU?=
 =?utf-8?B?U1BxZDRpRWlsSDJDVXRxOW50RHRVQ2FRUXVwZDZUSzVoUWhia2VXcDlIVVBE?=
 =?utf-8?B?cUJRQzBLMjlHenpraWVDVFZ4b1AyTXBPNTE4TTBFMFdPaCt6c2VHNTlRYzhR?=
 =?utf-8?B?U2NRQk5iYUtrb01RRTQ2KzdRZDJ3SmZRaWZjRjJ6RlFucXV5UUxFdXB3aXA4?=
 =?utf-8?B?SnN4MHBLa3E0R3VFeWF5eTN2bzNGZ01naTZIakpzYTFreC9BRGM5SnJpSytV?=
 =?utf-8?B?dU1VWi9oUGJ2V0U4OEZFRFhuQ3QzcSt1UGxVeVA4NW5KOUxVU0hWRmJFME5Z?=
 =?utf-8?B?YStXcmYwbDRiWXhlcDhFZWovanRONlFERUJ3TGFwTHh6SFQzUVRoVUFjUjR5?=
 =?utf-8?B?cEMzdjlDRzU2UkdRaXhjR0JjdlgwWndsVDF2aGsxbS85TUpBV0swTlkzN1E1?=
 =?utf-8?B?eGdheFFFQ3FmQ1JtNUJvcjdaUjdwUEhkRFRWSDdBTHZUMmRmdGNqMmhQbVU5?=
 =?utf-8?B?Yk4zemNvcG9Ia2dkUi94bER2TmJsTlZzK2l1VkhVVE1OTUh3K1p6M3NwdHF4?=
 =?utf-8?B?SEx4NW5zRng5dWJqamhHcE40M0VkUkp4OUw0NmNCMm9SMFdRd2F3dm9GM29x?=
 =?utf-8?B?R1JpL0M3dkFINGZjdzVvd1RlRkp2YVNEOFE1eG4wTk44a0FoU1UxbWRDdk5a?=
 =?utf-8?B?WEE5UVJROExZK3FnYjdmVHpRaGtaMHpUQ1k0bi9CdFZ1cWVEejZRUmhWT2lu?=
 =?utf-8?B?ZkxwblFnSWlWb0VBUUo2cXRUajAzUVhFaWJ3cUVEY1J6ZkhqM0Z4U3E0M00w?=
 =?utf-8?B?S3ZtRG0rL3VjWGlHYWlSa2k2SVI3YVFaSlk1N3Bxdi9hNkxob3NoenA5Q00z?=
 =?utf-8?B?dm04L1dWU3F0NUEySmJkOHhIOG5ObHFhMmsvdlU2QWlCL1REOUlsZktyK0Iv?=
 =?utf-8?B?cUtoR2xjcEcvakxxdEZsT2k5L2NKOHo3YnUwUmg2djBTSUt6NzR0SmNFbmJP?=
 =?utf-8?B?TzNrbE96WGxqMDhLVmRVSnU3d2ZQYjhyT0FLbzlKbkM0M2JzYlBlY0xqZ2Ix?=
 =?utf-8?B?WHVmVUZYR20zYkJ1QmJ6OFRaZVpiVkV3cWRNeWlYM2tHUmJJWXlHU1lCbnBV?=
 =?utf-8?B?bjV0S2x2ZHY1VFRpRnBXSWFXajRBRmkrcHdDN3lsWTdndTBpMkx1S2tqSHpI?=
 =?utf-8?B?R0xMck1yTFg0NDhrSWFVVjVGdjJ0bkZocjNQaG9vRFhZaEk4dml3TEQvelBx?=
 =?utf-8?B?M0pTdXM0OU5xUW81YUlrZjVHNXdvUkJuUW5TYUljdk5lblV5ZHhvVHk1YlQr?=
 =?utf-8?B?S2U3Nm83aFZUaGUydTE3UGRubE5PT2J5Z1hENzBMR3o5TCtTMEpXallKWFpn?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 944bd958-f381-4f2c-ac4e-08dcc1bbaf62
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:31:42.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OexT2jN4E+JaZZ9IkZpdqa9gbuIrRT0J4ObSVuCZnNpo5s8nMnwLeIuQkQYg/Ow6G+bJidT4xb+vD1GzBohp0nFfDUeQ0AkWD4EgHNvmpLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10895
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 08:32:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/539

Hi Trevor,

On 8/21/24 6:44 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> The latest linux-yocto broke SPI for RK3328 devices. Add the submitted fix.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   ...-correct-RK3328-iomux-width-flag-for.patch | 50 +++++++++++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend   |  1 +
>   2 files changed, 51 insertions(+)
>   create mode 100644 recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
> 
> diff --git a/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch b/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
> new file mode 100644
> index 000000000000..36071511c2a8
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch
> @@ -0,0 +1,50 @@
> +From ed875ae5b8ca511c11d227c0d9c6d2d13a2e6c15 Mon Sep 17 00:00:00 2001
> +From: Huang-Huang Bao <i@eh5.me>
> +Date: Tue,  9 Jul 2024 18:54:28 +0800
> +Subject: [PATCH] pinctrl: rockchip: correct RK3328 iomux width flag for
> + GPIO2-B pins
> +
> +The base iomux offsets for each GPIO pin line are accumulatively
> +calculated based off iomux width flag in rockchip_pinctrl_get_soc_data.
> +If the iomux width flag is one of IOMUX_WIDTH_4BIT, IOMUX_WIDTH_3BIT or
> +IOMUX_WIDTH_2BIT, the base offset for next pin line would increase by 8
> +bytes, otherwise it would increase by 4 bytes.
> +
> +Despite most of GPIO2-B iomux have 2-bit data width, which can be fit
> +into 4 bytes space with write mask, it actually take 8 bytes width for
> +whole GPIO2-B line.
> +
> +Commit e8448a6c817c ("pinctrl: rockchip: fix pinmux bits for RK3328
> +GPIO2-B pins") wrongly set iomux width flag to 0, causing all base
> +iomux offset for line after GPIO2-B to be calculated wrong. Fix the
> +iomux width flag to IOMUX_WIDTH_2BIT so the offset after GPIO2-B is
> +correctly increased by 8, matching the actual width of GPIO2-B iomux.
> +
> +Upstream-Status: Submitted

Please provide the link to the patch (between square brackets I believe?).

I personally like to have the original commit log only appended with 
stuff we add, e.g. Upstream-Status: tag after the last Signed-off-by? 
But that's really just a matter of taste :)

Looks good to me otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

