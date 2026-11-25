Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46920.1795627437729316964
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 09:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=T6zsTfoX;
 spf=pass (domain: cherry.de, ip: 52.101.65.5, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZVL6APuaaML4xg6cdct3YZ0PRrHwB1rF8SI/F7UtOhdXSs30x7GadudaJwiaUwm9bWOQajDo7M9pfZYNWRfnOMpsxrfnRH1akuHLwAzs+9Skl/meb/cBQWYG3DJYhDpRPx4l1fJWHHOZV94l5qCK+lZ5XIWqDi0TnTVKX+lp1mGE4A7knPHjKYujvP+EHi9/BmLgycehyOJwYrU+VtFiBq3lWD4n6/kLWYJ3vJ+uykzTpkv3sUxPtEaeXxo/E+rVycDZ28D89uxX0cREcEFfZxAh52yt2QsLAspD1hCkrbIY+8bJrq2YEjGwtxqstIVdAJX3enkFsF8NwQ7lZzISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIzGlTpKweBfwci4p21xX0bifIz7dHRIzwPaFL2wtnE=;
 b=DAEy/r4xBuMTYKQnYG33WelukrIjiuMILnuAJiDZ+fP7/Q3IVfHXp3sISxebAjV9yKZSDt84ltNl3TNn+GLyzfY6nBnh9CSGn3utUNjAVKyTTzSUoVI76St1HAP1w4el8g9JUOUxMZZAU8YqCuqmqvYmx8/fJ40hz71aSRsBH8I92kyA+akZimOJBMRyAbkMpB6HFj4WQr5tmhSrCx4YEQ+uZU66ua5/Qk/LyJ/5QXuJpAUfrZWfB0CZ1L9xf06a28ln7oBHwXQMz0bCQ80G2Bo/IIEfrZrl1O2QCgSnCUEbo8WstLywetrCuLCS+zBKe0ZsRauPkUg7qgpbaTtdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIzGlTpKweBfwci4p21xX0bifIz7dHRIzwPaFL2wtnE=;
 b=T6zsTfoXhqlocxcZbv6p36ICqi5B+Evqh7YqmM8Mz8dov9t3Jq8RRtwYzhkVNCLvgQQQyCokK/WhkdiDfuBn8IkRYIC+AA9i1FzYHCti1j+pxKHr+J+gi4s2bL9E4cYlHZsWGl6IfrMYUIpeJvOcogha+zLGfro8+g8LQWqPy8g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB684476.eurprd04.prod.outlook.com (2603:10a6:190:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:23:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:23:52 +0000
Message-ID: <8c26b39c-c7ca-4c5e-a97b-770d940e911b@cherry.de>
Date: Wed, 25 Nov 2026 18:23:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [psplash][PATCH] .b4-config: add file
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20261125-add-b4-config-v1-1-369bba9f4af0@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125-add-b4-config-v1-1-369bba9f4af0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0181.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::38) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB684476:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf38374-116d-43af-2c4f-08df4b18e004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261102123227099003|261009221227099003|261028144727099003|261009220027099003|261022105027099003|261009223027099003|261026140227099003|261009223327099003|10067099003|261009221727099003;
X-Microsoft-Antispam-Message-Info: rulza0OiKoBwKLUuEIy3CKFkfEjtUKn8sxjdInmfN+yFakYQwuHdPYByf3RwMAR7CRn3M2BjjT/4eXxEUwdmrLuHwDLWpomu4YfZkcOkqgbOyWTmsRHfZHfzP4b+VDY+N4BtTCHrvl5ataOoHF8tpMeiGbqwwl0Tpig/OQAKcphAzt5/WKqvcE2gsImY4lp9cB5J7VKqrLoXEs3/Xw/hh3NM6SLTHmWnyJOBHxCRRZ9DYm2BBnfiF/hL6BoNG6pTG86/NU/IC8x+NLmOua9mZgP9yW/ZRv9V4LJAj2oIKV35bVMjKGUjzKi657e02crrhd7YwChrW1qVxDa4SXBkwuKcF+vchoxbMNoRhiet9CfxjlbSjEsPB9o/6hu7/X6Bi+asqGXrLFGLpSrhF7R46ISaiSyR4nSL+B/1P+fWmr9ZbLVqj3dioG1Ol4T0Wwp2A3ngyqhc89Paec+Xv4/oKeoytPTmw9hECICmVXbNXqUOGWnkvTxtBQvufM6ikBwOsioFVzBcl3tKFCZtdNzjs13utdrEQ4I5DdOPStv0uPGHL+7HaHOmoegyFtybE9O5ipVnlXvJf64AXfOxer0uZ5XqxuVsEI9swf3k8CO188iwFfE7Rgc1t+G9NX3JAdDrBdoTgh40mKkpg3mHlpde7t5hpMt5dgIEBfLvpvmx2Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009221227099003)(261028144727099003)(261009220027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261009223327099003)(10067099003)(261009221727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1M1QTU1T1BCVnVBNVgwUS9lSXlYSWMrOUNDZFZ0MmZteXgvbnpzbVdoUjJv?=
 =?utf-8?B?N0E0cXNwNC9kSk9CbVRvL2RPUFVhRUhYbVV6bjB5TDBPWnFnSGhWZ0VKdUg1?=
 =?utf-8?B?YlVkK0NhcnZmcURRQVY1S2ZrYlJKeWZ6NHVQRGpzQk5WYkZ4SmVzS3UzcTQv?=
 =?utf-8?B?L3ZkblVqcXdpYm42VEE2RmxjMnkvS0RPRTVjS2RKNng1S0gzQlpMalRtQlcv?=
 =?utf-8?B?UEJ2VXRXN0ZWZFQ2Vmt5VGdNbTN5MUVib213a01aMUVicHNFZ2NtZUMzbXlF?=
 =?utf-8?B?ckJPcWJBRDNUa3c2aGNieXNQTEpEZEdRMXMrQ3dmcWYvRmgzd1I3OU51d1dp?=
 =?utf-8?B?c3VUcWtyYTEzUW5SWWlvZ1pYN3l4Mm1TQTNqamorTmZHOTZ5SmpYdWJFaTkz?=
 =?utf-8?B?Yi9pbXhpUjROdzY0a2JLN1B3VTVXei9sbVFwVE5wNUFzWlgwMjFReHpva0h3?=
 =?utf-8?B?bU5wWWVjSGRCVnBRdHU0L09UZlNNdEhGNWJYYWxaUlZnY1daYWdSakRDUEJE?=
 =?utf-8?B?OGJZMnhIVzE1UTk3UnhYUGpZc3B2Y0NWbkJEejFkNXFjWit2OGRjSjYrNFR3?=
 =?utf-8?B?S0pGYkxiU0hSY1ZLWXR0MndrZ3BhNFNISFFkaG5la2FhQXhYNDQ5MVpITkNF?=
 =?utf-8?B?TWpmNWllTklBRnYvcWdwRk1xU0tiN25KSElQSnRFUGRUOGdtckRxMFZSWitS?=
 =?utf-8?B?YnNwZWdFL3YxdC8vck9WT05SMzVyYlFvWDNnZUdqelBnaU1SRDRja2NnOHBD?=
 =?utf-8?B?NEFCa21qa2VISDBWdWx3WUxFWjBNTkV0cTFKVGJsMkxHaTl0WE45U3JVczg4?=
 =?utf-8?B?UkxqWG43WjdMOVlyTGNBQjhKN3pwb25rcStDRjE1dGZsamtlQmJzQ1VWMXZ3?=
 =?utf-8?B?VElnY2UrWVV0VkdkUWY2Q2FjRHZCNG41dWhWa3pZTTJVN0RUZ3p3dk5OMVdy?=
 =?utf-8?B?Slh2aVZOVmNkK3pvSkFBZTVnKzBhb0hqdWlEdWtib3czVExjVmZsQ05aN3V4?=
 =?utf-8?B?K2JlbEc5TFBxaDg0WVBrSEh2emRmVU9VQ2tybHVtRkppeVU2NmczbHY1cEg3?=
 =?utf-8?B?NHpLZ3lPbGdMSGxoWHB2cUhMcGg0bXd0UHBqU1VKd3h1MDVHTGg4Q2lNZjkx?=
 =?utf-8?B?SlBqNnZjMlhQK1pUNFdwTXN3REM2YTduMGhFbHZBSkRXenB3OXduWHVOU3U0?=
 =?utf-8?B?NlB6TkNpYW10cFNiOGJaelBYY1piL2tPZ3JDNFdSWmpTNVB3U1FoYmxjKzlm?=
 =?utf-8?B?Y0VHbWpYOHBxdU16QStEK1Y3VktGZjFwUW1hVjFQRzVEeU5GQXUyS1J5M3pk?=
 =?utf-8?B?RnBkSUFoWjc0d2pNaHk1eDViK1BXK0lJOHVXcm16N0Z2eEpGZWk5Nk95RDZ3?=
 =?utf-8?B?WXhteEhMaEpSU09TakxxS2F2bkVoSXQ2UWYrOXUzWjF4b05vREwzaDE5L01j?=
 =?utf-8?B?emtQWVJUUjVUS3JueS9YNTdaOXBvMXk1bVh1TE5QUFBuOXB5cUd3eTcwY29L?=
 =?utf-8?B?NHVwOUxoNVMrRGZmMHNJYVNVd3J1RCsvVm1xTmJxdXJZYnUxR01xaDlFakFt?=
 =?utf-8?B?UnFGazhlT3ZEVThxMmxrVk0vMVlQZ3IxRnRlS09TRjlpcTR2NVZhREJaaWk0?=
 =?utf-8?B?ekdibGJNeXdLa2pHVnRYSDVXOFl2cVg1VVZHNlhpYnpBdEZ5c2k4ZVdpN1Jq?=
 =?utf-8?B?SFZsRkh0azFTS1dMMko4bXg1TzNTVDBwZTIwYnpwRXRsYmhLQXhLNVc4V1Rq?=
 =?utf-8?B?aXFwVTh5STVDTGw5cXBqVytsN0NvUEcyQStjM3Rmbkp6SVlIZFVyczlBVm9y?=
 =?utf-8?B?SHkxc1JNc2Y0K2krdk9kSzNHbjY5M1lib3gxdFlSL2dVL3Q3TklabTE5V1hn?=
 =?utf-8?B?Qk5nS1NrM2x0K0Y1QVB0VUxKaFdvclNzWWkxdC9sMno1bDdwU1IycmVyVlBC?=
 =?utf-8?B?WFJ5d29pTXp3K0hoeTdUdDQwalBSaFp2Yi81VnV5RXpEcmhjRzBYWEh2b2x5?=
 =?utf-8?B?d0lqUmJaT0M1aUVBNTE3V3VVNGU0THQ0UHIxSjNVTC9GUStxbWRpWkRsQzNY?=
 =?utf-8?B?RllMay9qOFpqcEY3dWhZTWZaYnZmZmtTazBFaUNEcU83c2Q0VW9wOTV2UTNu?=
 =?utf-8?B?SVdWL0lJRi9WVER4STIrdG9IT1dibE1mM3M4VkxYOVIzRjl0NE5tUGs3T1FZ?=
 =?utf-8?B?OGJhYWNxQjR5T0JFVzlzMGJTY2JsaWxaaGlFSEE2am5uY3hKNUhWb3NES0li?=
 =?utf-8?B?ajBONXVhd2x3RnpEVStkalBBdGl1djhERHpOOW9rQnhlSm8rRDBHSFF1SFNm?=
 =?utf-8?B?ajk2YXh2TWdZRU1sVWNvbEl4Vzc0UER0TGtkT2dWRThZcThzRER0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf38374-116d-43af-2c4f-08df4b18e004
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:23:52.2192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8KWkGQmtNvpMscIAlWZey4uroLUGGiNIHk+hBgEVUAWa2jtMa/HYRDSMikH0ae7IQ33rJjPyrJ9oabkiCHqG+VTxEYl9ldULhizMIJO2cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB684476
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 17:24:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5517

Hi Antonin,

On 11/25/26 5:27 PM, Antonin Godard via yocto-patches wrote:
> The .b4-config allows configuring b4 properly when sending patches to
> mailing. Inspired by the one on openembedded-core, add the file to the
> root of the repository.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .b4-config | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000..66bedda
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,4 @@
> +[b4]
> +  send-series-to = yocto-patches@lists.yoctoproject.org
> +  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
> +  send-presubject = [psplash]

suggestion: use send-prefixes instead

send-presubject is only available since v0.15, send-prefixes since v0.11 
(and what we have in meta-rockchip, yocto-autobuilder-helper, 
yocto-autobuilder2, wic, ....

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
