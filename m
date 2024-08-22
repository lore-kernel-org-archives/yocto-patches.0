Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FAC3DA4A
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 12:38:23 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.18])
 by mx.groups.io with SMTP id smtpd.web10.12429.1724330296281134097
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Aug 2024 05:38:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=VLrP7QMt;
 spf=pass (domain: cherry.de, ip: 52.101.65.18, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNP/W6dq/JWo1SwbrwKlYTaxQwKsP3E7NZanhmXNZI5tY2zo8DMrZX5Kv0QLvC9sdptrNOyQgIOu/6B589PW+qOhnKC6PjQlIg2udPjszodkRCFhuaCm8a+7GVehl1Gcwl6ORPqOkm9ybdkFv/o6Bkf1SKprgnpQhElP/t7uzhJvSBevSKIoynI4H6HGbY0h3CYm+YWSnRAtRFmTamGES26096H8R+8fVxmMV/Q7X1KgwK4UQJfoEJyk4bfNGBI94rnr6y58vDTew93Tqc1qLDz3iful4zbc1FXygqKp7M4qri8fM13osKD7HTc4OGriuXwdxVJsxApIeWZQIT/7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5TWq4BqgbbZAcylOBsCt/2rkLBnfMMzrsxcM8JmqOo=;
 b=yEBwLy0L7y9pSW5Z9vQHQCuaIchKdbs4jULCE22PUBHGJKAfIyMWhwEPASOcGubPIYRGN7/BH+kTtPU/c5nZQQQCEI8UZlLBm855QNO0hI1AlD7dDohtk6mVMNyROVL7fRj8ZKkVzsoJZKlxWeqw+KEYc7rs12i0YuqPtuGH2QBC54afxemQ7n7F/87dFuTSWOn8AqgTprI23KWpeMHMuKCAPjblB1rEKieWmfT5a4skPbA9uVeJ688QSc3bgC8fyrXcd0PbMIQdo5mXTYV5Ntui/ANRbEvM/9o4xGPj4Ae07e74ZLcaG6DKU+yl8SDmYnT0M02JfaX95OkjSpXmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5TWq4BqgbbZAcylOBsCt/2rkLBnfMMzrsxcM8JmqOo=;
 b=VLrP7QMtaYYlwarqo/2WVxMQBKm7Bhr15lii3E0iGz81pIB+eJyRRzHdjAB/6SQnfiHWbDzFTFdC7sdDfruJ+iG+S9rLy7/EAJViSf0vmQVUCSZ3H8mxtesbYQ4RnOdebK7ZKPNCO4cJEaUZ1LT7SaCKmCXZMs57v5h4hm06nzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10719.eurprd04.prod.outlook.com (2603:10a6:10:580::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 12:38:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 12:38:13 +0000
Message-ID: <d29f0a9a-bab3-4f73-9b9e-361909b95092@cherry.de>
Date: Thu, 22 Aug 2024 14:38:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 3/9] rk3399: enable
 gstreamer v4l2codecs support
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
 <20240820-gst-hantro-v1-3-335c4eaf8e8b@cherry.de>
 <b6d2f95b-ebb8-436a-8644-fb63f8126c56@cherry.de>
 <20240821044243.GA1194@localhost>
 <91225d4e-ba39-4775-a312-835c6cf39548@cherry.de>
 <20240822122328.GA24992@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240822122328.GA24992@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0280.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10719:EE_
X-MS-Office365-Filtering-Correlation-Id: 968ff716-7447-492b-1de0-08dcc2a749bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c1NSaGNuL056UUsxU1piTTlsMVBpNG45d2Q5dlBjbEF3c3krbFljdVRFM3lO?=
 =?utf-8?B?WWhVSjVaV2JLczBXSVNobmlNWXoyL3hZaUVrUWMrc2N4Q2djQ1pyZFpWd3R0?=
 =?utf-8?B?eE8xMitNRVltRURTK3lzWTRqeTdDS2Y0dzdVK2dKUGw0L2hXb01HYkNpVSt0?=
 =?utf-8?B?TU1FeFZTMXFVaFRoUWNQOTlrYi9RZlVocG9qYmlNT0RjUHZiZTROZWxtdkN0?=
 =?utf-8?B?SVNRNythQnMweTZ6cXZLWDFHMmpNWE5qMnJGMGk1NDRBSUtjMG1ZSzJEcEVt?=
 =?utf-8?B?cWNpOFNGTTBIWDRSaXR6RTFXK3QvNitvTkkxRm9PM3FVWklXSTN4bmdjWDIw?=
 =?utf-8?B?REJGaEFpbnVIeW56NWt6V1BROXJFa0VIZDBCSjN4Z1hseVc1M0NtRkk4ZmF0?=
 =?utf-8?B?NnRTTmhyWmM1ME50OSt4ZmNKL3d3VVhaOXVDdDRCOFgxMUxoTGcwU0NtcWUr?=
 =?utf-8?B?N2JsVEd0NXhpaUlDc25KSTlkYWhVSFZadFB6NkVxTUQrVldPUHhBcW1pRXQz?=
 =?utf-8?B?QlJQQU9pU3JNYmxENWVCVnVsWmNINXl2dUpjZUpEU2U0dUE1T2Ivdm5vb2Zy?=
 =?utf-8?B?UjNSWFBZcHBhd0w5U1M1WTF0eEJoYmpVOUJyOEdFWHMrbVFDYjg2Q3V3ZDRi?=
 =?utf-8?B?d0tHRHlyTytYMElwNHJ1MCsxNjFpUXF1YzdUYnppNHJ4RWxXbVl3NW1ZeUdo?=
 =?utf-8?B?OVVDL3Rxc3RzSk93ZTlXd0ZOK3k5NzliQWFnaGlUTDhuN1lwejExUEtwalJM?=
 =?utf-8?B?RWJoYThXRkFyNjQ5bWl2eDNPYVFZa1pHa0gwZlJUTGs0cFpXOEtRWUZUZGNY?=
 =?utf-8?B?S1M2N0lHRUNobGhTQnFTNmQxeVVBSmNtUkhMNjhIZ25lVjBPaVBEaE9JbXZR?=
 =?utf-8?B?WnR3OHRIMWRVTGlhbGsxTVVvL3F4em9Cd05MS2swaE1qQWtFZkdWQXB1OXhF?=
 =?utf-8?B?dVlvNkszTWtkd3VMNXg2aFdqYjJhRE1vY2xxWWJIRGNub0s1U2c3K24yUS9J?=
 =?utf-8?B?UkFKMEU5ZGErVGQ2dkd1VVVUc0ZRNEh3ZFdpbWJJZWdwTzc0U3FNeHJoUnQw?=
 =?utf-8?B?RFZjaGM3Nncva2N6RFBLMGFQR0MrNDBRRG5XRFIrdWxoS2Y0L0hmUUhKWWJG?=
 =?utf-8?B?TlJZRkJYNDdqNjVmbExVV1RoSnppcDBUMkphdm5tTW1jRlNQYisyeGRIQlpx?=
 =?utf-8?B?OTlGdG8zVzF0dUtWeUhPblVsaFhUc09XQ3RkMmc0MWFNVE4zb1VQNXBxRVFp?=
 =?utf-8?B?WlFDVkh6MFFMNThzOEpFTVRCM2kzaERrT2hGSXYwVFZpQmYrTEVRbEVjRDR6?=
 =?utf-8?B?ZzV1dHU5Q3JIa1lZZTVsdS9IZmQ1dWppWXlyNjBpR241OU5mS2lXNG1zMklL?=
 =?utf-8?B?OXBMZ0diNURzTzYvcUlPd0REcjlMdm5hQ29maXFzcWM3TXk3VnNGb1B6THNa?=
 =?utf-8?B?WUhiNTREWmxuV3dXWkQ5UlZsMGpneVh6ejBOU3VVRE9RWXJHbFJUVmNXaldR?=
 =?utf-8?B?M0hIWDN5MHJGOVMwa3lHbXIwdHVTT3BkMEVJSXpqbldva0oyTlZDVnZWT1Jq?=
 =?utf-8?B?aGJGRkJ2WlgzaVlGSDRtSjlBTG8xY0ZJU3ZxZ1Q1YmZlSmpFYUFwTDRwVUMx?=
 =?utf-8?B?NGNIV2RXTWY5V3Q3Z0EvYy9DbmxUQmtXaVE3UnZQckNrQmhCREV6Ulk4VGRw?=
 =?utf-8?B?cUdBRWJ6QU9wVXdha2ZzMlp3YUE5VVVxNUlOSGhhcmtId256eE9EOUhuMmVx?=
 =?utf-8?Q?NzGcp+zEHTSrkF5xo8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0ExN21OSGpzTS8yWG1RbzBBT3JrZlhhT3B4WGdUdXdLenZYUHZ2TmoyZ0xK?=
 =?utf-8?B?YXZZek1GUTlYYWNndldHcENTb0lNSUk3ZS9pRnJ6TVoxbGhIWTloNVNnMDBF?=
 =?utf-8?B?c3RIL3U4dmUxMnJmY3NzZUg3STN6Y1FJTW5uNFZxcnBKTG5FdnJQdEt5TFB2?=
 =?utf-8?B?RDZTSlVDTytBSHhxMlBacmtOSjQ1MExBV2ZmTXJFeTF3MVYzcmdNd3FITWJX?=
 =?utf-8?B?Z3ppc29ydlRIVWltNWxCcmtaK2F4TUlZUndwOWFuUGtjUXZPSmd3VENUQTBm?=
 =?utf-8?B?UW1BUGtjbnhueHl3VmxBTGJneHp6bmdxZXg4MkxNYk0vblBpN1hWSW1qdkZp?=
 =?utf-8?B?b0lMTFowM0JNL0dTckp6WURPYVRvZ2s1Y0tHNElUdWthMWtoWEdwYjBPRnYv?=
 =?utf-8?B?VWhZNi9tTThTdXpia0ZabTJhOHBXM2tyZ2NyNU1EV1JSZ2xZNVlwbFo1YkFV?=
 =?utf-8?B?aElETHR5aUEzNE9XZHBESlhqNmpWSlUvamxXY0lkNXdCTEtsODFIdG5kVkVL?=
 =?utf-8?B?djF4d2EydXBpNmI0VkdJOW5MUkllRWNxLzVZcDhZcGs4TXpQTXZLM2V4eE5T?=
 =?utf-8?B?N01KSHdONEVhblhCVm5zQjFtU1habTh0aUxoczk1R2ZFUTNMNmtDazNieFJP?=
 =?utf-8?B?OEdMWk56d0tNWGJYdnYrK3J3NFFnNVlzeXdpTlpsZW55M3cwWG9xM2l2RW5u?=
 =?utf-8?B?WmpWSGFtejF3L0txUDE2Y0s3bFQrWGJGOU1xc2lET0VBcldGVVRZL2lJYTRa?=
 =?utf-8?B?WWFvWXZ6VHdPZkw4ejN4MUdBTUtPamtqS01Ec0YzaDJRMk8vTUFmOWFEeTRJ?=
 =?utf-8?B?QWRUU2VmMHprRnpva3F4cmRDeG01SGlEOGVMRk5JazdwbVkzMFE0TXJwb01w?=
 =?utf-8?B?V3VSMVl5dFpISWUySzEzMDNNMFRWSEY5SU1taEF5WW8yNWN3RnBvbDYzVVdk?=
 =?utf-8?B?K3VuWUdSY1Qwb01tZEhCdDZkbnhkQWpHVGNLT3FKRnZUV3ErWlV6dUpkVXgr?=
 =?utf-8?B?dTRWZStlNm9jNDc2VC9RTGxvcGpkUE9CY0FpVTJUWUF2eTVFRXp1dWVtbzdZ?=
 =?utf-8?B?ZTRwVXBDbVNPS3VIdGtieDNFOStOMk1waWIyTFFqdmk5cG85NXMyMUFZTGdY?=
 =?utf-8?B?RW1velo1ZGE5bWhpRTBHQmJ0eGpYa0VpYWY3aHV1d1hXeWVmU3l3WFNZMU5T?=
 =?utf-8?B?TXA0RTdzakVnSVhrNE1iUWVwU08za0x3RkVKUEVFa3VTU0VSRnIzYU5lRzcx?=
 =?utf-8?B?NTk5cElPejFnSGhCRFRHbUZIejBNUnp5Z0diWVVTN2FMVWFWVW0yNXRWQ3Z0?=
 =?utf-8?B?MHpQM0NndmlQb01GQSsvNGRkRVBlQVZTUlJGSFFuY1BrM1BzcjlFS2drTmw4?=
 =?utf-8?B?dXk1a2tUeG8xeEdrZFBrdVpVQ3c1NnpYNnZwVzdtWWFINjJrN1VkdjJudks0?=
 =?utf-8?B?UW1vUzJzMGF0dGtNZ3h1MEhjeEdWNHI5eWRhY3lOQisyWkpyRm9EVHRRaFN2?=
 =?utf-8?B?SjVFRm9tanExMlFMamU2ZjBDZFZqU25jMlJXcHk1VmFOZm1FN08waTNuQVF6?=
 =?utf-8?B?bWRtOFBZZVJRVFhhUDh6cUlsbmIzR0tES25xUHRVMDlqMk5TZG84amRJN3lL?=
 =?utf-8?B?cXUySFh1SzY3Tk9yUTVlMlBMTUVBdGw0a3l3aHczRjFlNTVLMnVJeFNHYVhF?=
 =?utf-8?B?V1gvY01nOWhTZndoV0Rjejk3WVZQa05NOXBwYU1uUEJ0RFUyRjFmSXZlVGdv?=
 =?utf-8?B?b3RuUWJ2aDFxRnZBMWhxYmR3UG00NlVLczRjM3NTQmxWQkpNRktnU0pXVjhk?=
 =?utf-8?B?V3JXQWFnT05Sdm81WXpGdFlXYzVyVUMwQlZ6NmdvU0kvK1NuOXpMVXhkcEZa?=
 =?utf-8?B?NEJkNTQ3Z1JGSHNSYjNRanc5eFRIOXpBVUcxYkk4Qk9ablFNOGZNRkxGY0JE?=
 =?utf-8?B?SUI2dysrYzNoS3JYWHZIMUR0bHg5SDhEbmpSTGVESkpiTVo2WjRMS3gxZndt?=
 =?utf-8?B?cDlBZkV2dzFQd0Y4MGQza1NycC90ZUZVU0IrTGRxWHNvMVlTYUQxUHN6L3gr?=
 =?utf-8?B?bEZ4U2V0c3BYR2RCY0kvK21XUzFzZUl3WUtTWXpDQVcwRlJrTGtvL3JoeGx4?=
 =?utf-8?B?dGRQelNXdWJkQW84QVJkcCszRlppOTRZc3Q4OHhiVW4wYnQ3b1R6RHJyQmJF?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ff716-7447-492b-1de0-08dcc2a749bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:38:13.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q094G/8+9TKYGw5Nhei6mslayNhqFNgGPcoLhTlODzKq+grVhrdOdUxeZDELabSppPcbO3bLY6jQqd0al3mg8VfnW7DIiHDB4i2sDIPr2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10719
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 12:38:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/550

Hi Trevor,

On 8/22/24 2:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>>
>>>>
>>>> On 8/20/24 2:56 PM, Quentin Schulz wrote:
>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>
>>>>> RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
>>>>> v4l2codecs plugin can be built.
>>>>>
>>>>
>>>> RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
>>>> and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
>>>> supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
>>>> sure the naming of the variable is proper? Should we go for
>>>> HAS_STATELESS_VPU instead?
>>>
>>> What about 2 knobs:
>>> 	1. HAS_HANTRO
>>> 	2. HAS_RKVDEC
>>> ?
>>>
>>> Does gstreamer have knobs for both sets?
>>>
>>
>> They are both stateless VPUs, supported by the same kernel API I believe. So
>> the same meson option is used, v4l2codecs, so I don't think we need to have
>> two separate knobs for those? At least, I used the same gstreamer plugin for
>> decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
>> RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
>> an RKVDECv2, which likely is also stateless?
> 
> Is this something the user will definitely always want on (i.e. it won't
> work without it) or should we allow the user the choose whether they want it
> enabled or not?
> 

Considering that the only other tool I'm aware of for decoding is ffmpeg 
and it does not currently support stateless VPUs 
(https://ffmpeg.org/pipermail/ffmpeg-devel/2024-August/332034.html), if 
one wants to do decoding on upstream kernel on Rockchip boards, they'll 
need the v4l2codecs PACKAGECONFIG option for gst-plugins-bad recipe 
selected.

They could also disable it for their board if they want to by redefining 
HAS_HANTRO variable in their own config file? Or in a distro, etc.

> Personally I would rather see one patch to add this one feature, rather than
> 8.
> 

Those were separate patches for multiple reasons:
- I only tested on 2 vanilla upstream kernel (RK3399, PX30)
- I only tested on 1 downstream upstream-based kernel (RK3588)
- the rest is untested (not even built)
- All patches except the one for RK3588(s) could be backported to other 
branches (e.g. scarthgap); this turned out to be incorrect because the 
:rockchip OVERRIDES isn't available in that branch (but we can fix this 
:) ).

I wanted to provide also the context for tests I've performed on those 
boards in the commit log. It could be quite long if I put all tests for 
all SoC in the same commit log (but that's fine with me).

> Should we add a note in the README about this, or perhaps the gstreamer
> bbappend?
> 

What exactly would you like to see there?

Cheers,
Quentin

