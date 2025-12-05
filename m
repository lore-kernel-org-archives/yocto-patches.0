Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA8BD2F7D7
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 10:20:20 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2498.1764930010356643202
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 02:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EZFOScpu;
 spf=pass (domain: cherry.de, ip: 40.107.130.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RupIuE4Rl7b3ajyw2NQSdcgeirS35kER0WuPGdSBx5vb16ix3+GN2bu/UjEIR5nJVrmFQotspy8kFOvPJ0SeMg7uokXbK0mNoJh4q/zs8pzLxPsvQZZBBrXtbgEPg/FDinYpTS03SX34u6n0KYPK7FXoCZislZlWD88TohCN/JnST5+dC21Qxvwi6p7VKu+KkMsmVeY4yvMYWEZsWISeQj+31szezTFukG1rP9jBzRU/59Tt570kTlM61hASiPV5WGo5Jc5+mWgYuOjOjL/rWNvM5Y/r4uUzECOEkp9Z2JV05oM3pcXS9ciqkG8nbszWxxyms6xKx5LGbLUMcDMZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwZREVfj+WVELwAPwv7b/RGoZq/zDnI5vGV1+PayMK8=;
 b=K7N4Ni8YXWQpwnhBpV2cC6SpvLN8tqGQNuVJo060uiAH/g1N8jlfYEHJgr3GDuEmlU58c/0Oei0r/L+rsHzg0o45Jsmf10mRvybP6tpaW3ouZC0CO6rTUqq/WNkDBYU4XUqmXZGmXoSyC66YkTX4PzLSgIlp567lQnMyQNP9asePArIiJ6vYlcoXri8eECrnT1duS/1NaIFGJ7Lm/MO2i5C5t7soQRJEkTJsPO/uNjkfQEU0LYFOTmf4xcihgoxIMCelldPFk8a58aoplLYsJ1xCj0nP+SyoCdu09o5/SFw0Ys0AMzX0ZHoDh71i3seUlIrpoKeC/6BeRSG6+iGHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZREVfj+WVELwAPwv7b/RGoZq/zDnI5vGV1+PayMK8=;
 b=EZFOScpuFtI7EiXCf6XzGPLYapjTpghLu3dfPeYxv0bgS/oTb1EX+IP8xQ9OftHvpG6af2AFKb+98NduJNJcT5PjhWIFpvTHZZGKcu/8tEly/Ms5y1xhayQD3nhgKvkag7CPS4BMZZopbl6XiBZWcBmiBpARhbsy/7C7OZABNso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 10:20:05 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 10:20:05 +0000
Message-ID: <5231dede-ba3c-44d3-9d22-ef5cb13440c1@cherry.de>
Date: Fri, 5 Dec 2025 11:20:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/2]
 remove-non-rockchip-arch-arm64: remove new arches
To: yocto-patches@lists.yoctoproject.org
References: <20251205033715.8852-1-twoerner@gmail.com>
 <20251205033715.8852-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251205033715.8852-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: baca9648-3a68-4c6e-153b-08de33e7dc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y3NNdE14MFNsR1IyaUpLVER0WmdsRUVDOVFhakVzZmF5ZW9mbGQrMmpzaTR3?=
 =?utf-8?B?MjZqMW93SHJvR1NLdGdaTDh6UWdXL1R1NXp1dGl5MmtDQjZ3ZS9COXZCc2l3?=
 =?utf-8?B?K2M1T3hvdmhjV3RqVHVENENqYkRvYlgxRE1hY0Z2QTFkOUUrSHdtMGtHT2JE?=
 =?utf-8?B?Szdoc3hyODZKTVdRaXQvWXpCZkxLYnZqMGZQWlBuREEzZ3hvblZVRjRNRGpS?=
 =?utf-8?B?U2tab29rUWtTbU84K0w1YldXS015cDdYbWFDQnByZEJDZ2F3eTZWMDVVNFVm?=
 =?utf-8?B?Zy9ucWVJS3pWQ29EUVA4UGZHaGZUckU4c0tCK0tUZ1Y2anhwQWEwaHRGc2w1?=
 =?utf-8?B?UHhSZndtU3pCNHJIVWJxZ0IzNFpCSVhIc0xnNGJXbjBKakhqSG1UT2lsbmVx?=
 =?utf-8?B?L1N1VGV2bTVReWZxOFFlYjdzS05LdVVMa2lsMjcwTEZTcXJQRWFXYnNXMzBs?=
 =?utf-8?B?T2tlVTBTNzZqSkwwdGtHOW9wQ3UzcVZsNnc5Zmp5MVBXYjFVUkNSdGJ1UUEr?=
 =?utf-8?B?bEtIK282UE9OK1QwWFhwMThqRkxOV2pBNGN2R1J1dERULzVTakZSeXZ4N3Vu?=
 =?utf-8?B?eGxvdzR3bEh1VFFiVzdDYndseEx5aTIyYzJjYTVXdFNmZDErbzRneEZSemtJ?=
 =?utf-8?B?VG05OXNGTkhsSzBhbENFem81c2ExTzNxTmpqR21RRDk1VzkyeXJYc05JVkpM?=
 =?utf-8?B?WWRNSkEzRXpQT1dNY2dXY0E0UXpJWFZ4WW9wNHlJS1VGYml5MG9veFZ0RzdS?=
 =?utf-8?B?RWFzb05Ib25sQkpBSHVMUlRHZmFTSTJCYkowU1Q1alhodm9RWjNRYTR5MnZx?=
 =?utf-8?B?Ym54WE5FeWhoeXhzemtCcFdZUllndVcyUXNodG5laHdSUUNzaWZvWTZ6WU1h?=
 =?utf-8?B?SVBiZFdqdHNHNVhabG91VWFkNTRoUFhtRVVOQTUwSUVHSkdiZWYwYjV2Qlh4?=
 =?utf-8?B?NDQwNGR2YTJhLzBZM2l6V2ptVlltamdleGEwUTRjY1BjSTZCcHRIVy83QkZn?=
 =?utf-8?B?N1VCK05OdkN3aFI0djZCeHhSUDVFUjZud1d5eTcxMmZKbE5VbTFkdlBkclI1?=
 =?utf-8?B?Mk9uTldRMEVONGNhVVlpaFdMWVMvN2JpYWgxdTFGRHppRUhCcC9MSFk1aWNj?=
 =?utf-8?B?Y1RWM2ZvSjhWdzRDdFgzckNvUUQxM2hwdTNqRVBvL0ppZ0ltSTkzWFUySzll?=
 =?utf-8?B?cCtGektEcTk3RUVidmNMcWpXellmZndhZUYvRUR3cFczT0hIZ2lsTytjQmty?=
 =?utf-8?B?SG5pSDJpNDAvQi9idkZGSlNTOG1LS2tSQlVrNlFvOEJVbzF3N0svMVV2ZzVJ?=
 =?utf-8?B?TTk2aUlFZDRBM0pyRGhIWGR5TDBINThLOE5VOGp2RUJ5MDk0b1U4YUFWakFB?=
 =?utf-8?B?NXU2azhZaDViYWNwc2orVkhYeFpFbEp1dEo0c2pHdnRkOXJld3huZkxadGJv?=
 =?utf-8?B?bTBNYmZxNyt0NEc3YzcreWFWanBWOVFLT1VRdWMxLzhidnJNV1pHUXlzSHRv?=
 =?utf-8?B?SzZ5Vmc3dlk4a1FSM0hOS25ZNnZJeVhlNm02RzVZcmovYmdteWU5N2E5Um1Q?=
 =?utf-8?B?UllzaHBTR0kvZjdVYWk0T3BFK3FBTEJOMmw3dDJnS0g4K0xFMGNkbzJnZ3Uz?=
 =?utf-8?B?TmNMTHY2R1RabXJYVGRFTnU2U2l2V3dWR2xydXo5RUxsdzJZZnZKa1hGeVY3?=
 =?utf-8?B?Nm1oT2lJSkR4RkE2RWlJNjRudVliWEZhekJSUGpvbGJ0UGhkTGdPK0phOWRa?=
 =?utf-8?B?c3JvU01RM2QxMG01Tml4U3FUeisrb3VCTHhsVU42VnkwanduTmxDU3FaWjlG?=
 =?utf-8?B?ODJTK1FuL1hDd0JaOHo2TUdwbHZxTXNrNzdaUGtUeFVpSG1pNEgrbDFUVXVW?=
 =?utf-8?B?cGNJUmxsQkJndTBRRTlQdmdML3d0c0JCaVJXOGtmbDg3RS9IKzJGVHZ1STJo?=
 =?utf-8?Q?x826JAzSlzU+EDa7XRH/BsOJOA5L2W2b?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWswZDcwb25jR3pzTUYraEE3UmpFeHpuUStaMm9CWktaL2paZlgvQTBtdnZl?=
 =?utf-8?B?RmpiZjVRclJtZlBwZHg0ZmMrYTg1eTRZRDBwbzR3cmd0dVlTUHN1Ky9iekZm?=
 =?utf-8?B?bi9RWUZ3R1NmS1ZsUEx0VGVtS2d3ZUpHM0RzRlYxRnlITUVCTFlVRUdhemta?=
 =?utf-8?B?T09NQ0QrdXZ2OFQxRU0rQ3BZWWJkSmo1c2dvNXhXOXdVRWFhWVkrQjkwWmJQ?=
 =?utf-8?B?WFdJalFrYTJuVTJZWi9Wam1oWDNNbE5kSEhONExIcXluM3VRQ0pSUEZ4anF0?=
 =?utf-8?B?MXViYTJ2WFFtcGZBdXQ5UUtTV2U3R0FhVGNWQVljcVF1cG1sa1dZYXNqUzE5?=
 =?utf-8?B?M2NJNVZwVm9iWFNpZnVHTW90STcvRDVVcE5RZkZ1YWFjODJLOVR1WkptejBT?=
 =?utf-8?B?eGNGTjZtYkN0dGxidVJER3oxb1cvZ2NPOUluVnBIWHFpUjhkUEVseDNPelhw?=
 =?utf-8?B?M2wrMEJaK2lON2h1SlFLenJHc3ZETFByQld3WGcwamlBajJJeXhkdlhvYXVT?=
 =?utf-8?B?OUJ5Z2pYcWR1YVpkNlNzY2tvUzVscEZYM3pkWVdreC9aRElYTUpQS25ZUWho?=
 =?utf-8?B?bitlWlRSaFVIN2JGNWU1RFQ3S0dMTTNReUVSU2JPQ3pYTmthRExydjZJdjNV?=
 =?utf-8?B?SmhDQk90THB4VUdZZlo0dXg5MHdBZ1MreGt6eHg1RjI2NGYyZ3U1K042UGVO?=
 =?utf-8?B?RWVnRDFoUm9LMjZHZWNyQWlnRXhOMEtxd1NtM25scm8yTFJZbmlFdmxYS2pn?=
 =?utf-8?B?SUMrbkhEenEzNndEQlp3RGVPNXM2N0MyUUVxNzk3M2VoU0o3VTRKMGdhZE5L?=
 =?utf-8?B?TkdCSzJkU0hNQWhEbmxPVFVUL0R6dlArc1NYTTJEQS90TkV6cHJsNUlZYUFW?=
 =?utf-8?B?eE9vRDJpV0ZYS0N5YnN0SlhpeTlyRkIrV2thc3hHbHA1YndnRkxUbWU2NXJR?=
 =?utf-8?B?QW5ocjBDS1E2NlJRZFZYUnNGMlRnSk53dm0wOTFGOTkrakhDYXpYWERZRXRN?=
 =?utf-8?B?N0VMMW1RU2VXaStCb2laTXFYanBoK3hrbWR5cVo1NFZVL1E1SzN5UkN5cHIz?=
 =?utf-8?B?RGZmZ3Fndmh4TTd4ajRqZHFYbG0xSjhIVGltclRXWW5kWFhzNDVkaTFSZFZk?=
 =?utf-8?B?dXZ1QlprT3hvUHZLSzF0ZkZaTWphM2phUDQ5RERBTWtUbm1aMm5Eck9tSVVX?=
 =?utf-8?B?YXdZMy9TcFJvTGwvNTduVDJVcGF3d3c3SC9lbFBJMWVOVDFvRmR4U2d2eUt6?=
 =?utf-8?B?SUROYUZ1cWpoTjc5STF6QmduZElvZHZWRGhtUENmR0srazVrS0ZaVDFWOHl4?=
 =?utf-8?B?TlpiU0djNi8xWUgyOE10K21LaGpEZDh5eVZ3VmxJOXhOUWptT1EvR2lINEYz?=
 =?utf-8?B?dTIrQWMvdXpMV2FqS3N1OE81OHVoR285ZmRSQysrMUozeEVuWktQK2JVc1Ry?=
 =?utf-8?B?c05ZbkkzdHMrUU9TWWJHd3VqT3llUlZ0dkJRU2dNUDJIK0JFNTZzQlhnTUZP?=
 =?utf-8?B?ZUR1bVVFcVRHNXRlVmxZdGZnUUdhdjBaN0NOcGczcWtGNzNWd1VTWTdiNTFR?=
 =?utf-8?B?dmw1QnVjS2pYeHkyTURTd21VOHNEVHgyRmZUdUxlOWhrRlU2eGdjcTFGQ1Fk?=
 =?utf-8?B?MlJRRVdhZzNrRXNGUkdpd0ZJdEltT3V0NXh3WVE0bW0vYUNaNHRKU0RPcUpn?=
 =?utf-8?B?UStWSTBqQll4Qld2d2JPZWFMYjlUUXZOYmE1UkNwVm13Ui9KWlNSenJyWjRG?=
 =?utf-8?B?M3RnUm41R0ptY1pUcVJWNG5ueWx1M01yOEJYOFkzS3FHb2FQL1YrL0hLRmhK?=
 =?utf-8?B?c0tHSDJ2NytWaFJLZ2x2M1JJMVhWbjV3bzRrVUhsZWgrNGFnL1I0SHRRdW1x?=
 =?utf-8?B?N1VIbVkzVjRON2RGQXRKZEs5OVZCak53MHBVQjVLa3BNVlBnc1krNXZrWXRj?=
 =?utf-8?B?d3N0enNjekpBY0ZodUVLNCtjRkphL0NJaTA0ZUIyMTM0QlBlVkVqa1ptYnNX?=
 =?utf-8?B?b21LT2kyUi90RlU5TUNYd25NSmVYWU5nUTBLYUJoWWJWTitRZCtORlRXMU5o?=
 =?utf-8?B?bCtPUWJjcUlyT0RVOVdMVlhwdTdjT2w3UmRBMkdZRVBIM3dWQ2VBYlo4QVpG?=
 =?utf-8?B?Z0FzVG4vclNUN2UycG9sZnpBMU9xWFRJSXY2d2EyZlJEMnR1UUdLNlRXQ3F0?=
 =?utf-8?Q?Db5oSpnPKXTusHtZZgKs2zQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: baca9648-3a68-4c6e-153b-08de33e7dc13
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:20:05.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJoxVqO3Q1vqgN0ywCcvMrEhIZXIBxcQ3Q5rYrq8sgQI2HQACBAhJN049I8tt1NXgKPzi2sRyB0Mv8XTLGuglUeUlwyfhhiRBEhSuZhdsbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9258
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 10:20:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2742

Hi Trevor,

On 12/5/25 4:37 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Over time more architectures are supported by the linux kernel,
> architectures unrelated to rockchip. Therefore remove these as well from
> the kernel config to help keep its size small.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

