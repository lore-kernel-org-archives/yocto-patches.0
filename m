Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B6BC5321D
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 15:35:23 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.39])
 by mx.groups.io with SMTP id smtpd.web10.55934.1724686519438261740
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Aug 2024 08:35:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=kTOgnIJ4;
 spf=pass (domain: cherry.de, ip: 52.101.69.39, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnWH2p7rytx1sStwWkiqtEFBW4dtv99yxg0M5r1uVGxY8Ue19RVblrcj+eo/zbqZK/0xwNabmNYVMiFyTxHspUfB044OIG0F+bq2id9AQZn0f8jOhL01MCL8S57ceKXZQnc8YAuZAmhRXDmv9mGRu5SE/VpRiBoRwbm/DT2YCwWiGEwIifK872IuQxJzlvot+B2X3XMx0/xo6C2HyoIMZ1akukYkjXpmVakDoIkyfT4Fq2EseAJWJXH3dswzdEpiIyfQAQn2sdsHEQNY1ROslkJgyCuvNKXuoeXail3mIjRz9bOT4yq1t0ZXKbczL9iG39fbrH54zgE+HkD7sJx2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXwsBFN+KmNe5aHqSS/UNj0v6VPELweHhCilwEgRoaI=;
 b=mDD2Dk2wPJiofMq99A0kv+9ZzmW0DquOBZTyFF3RM/zpUfljMZdNKj7y8g6aObERaQR5piIM/bkn1qtKyaEHlstGyPOdt+7yvHlC8HQshmgWl2bRo2+PEqMbDSADSJiSQ5uhLGo668qBvGEnm1cOKIZuLu1zX5pkofHQYIz4y2hOd6xpSe+ExsBU6QMFwtG0Gv0leogCYAfRNNhdZg7kAJtFWepWgOLciN3dGNKnZYzFEEAtq9yINzl8Kz8y1nTa9AHeBG8EFg644fZErIerN/5xhxnCVUSTYDcRwoelWt60jRE/PFIodcDGdclDDF43LnhqkGdTaTqxzpenXYrHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXwsBFN+KmNe5aHqSS/UNj0v6VPELweHhCilwEgRoaI=;
 b=kTOgnIJ4Iq9Jq6i13WXrrqYVyu7OY7WvsnsjkQjVFevreXdGVxuRsktWGmlfrbKWA8TIYjzhobrj9q+7q6fRYecEno+9to1PAyIUG4T2qPXmgOSJXu85aMkc+OMiMQeTQzkcdZJFdM4lCaGhg24nrBUzZ0JrGQecc4AQsqoQLVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA2PR04MB10422.eurprd04.prod.outlook.com (2603:10a6:102:417::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 26 Aug
 2024 15:35:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 15:35:15 +0000
Message-ID: <be2e3176-18a9-44f6-843f-d52c43e1df39@cherry.de>
Date: Mon, 26 Aug 2024 17:35:14 +0200
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
 <d29f0a9a-bab3-4f73-9b9e-361909b95092@cherry.de>
 <20240823135520.GB28691@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240823135520.GB28691@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR02CA0069.eurprd02.prod.outlook.com
 (2603:10a6:802:14::40) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA2PR04MB10422:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbdaec4-b371-41b4-ac3c-08dcc5e4aee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QU1sN29QdGxPc2FLc2I3QVNYdzA5a05jbWFoUUVPQUhpM0hTUkRicFBuaXFR?=
 =?utf-8?B?VTVFZ1JLNG03LzlaZzBXaHFHWGx1OFVWSCtFdW9qemtPYmRQZ1Q4MmJGLzh5?=
 =?utf-8?B?NkZtTVdOZHVMVTRESTRtbUlXL1lGdk9MSFRDMExJc09pUEJTak9GcDc2L0tN?=
 =?utf-8?B?WWdhTEM1OEhIckhwUTZ0VUUwTTJvSk5hdUpDbVBuTi9NZWtzcXV0NlRZZ0cy?=
 =?utf-8?B?RmU3QlZ5bWhxaFRVN01wTXhIVEpVb21WY2NxeS9sR1Q4RVNnTHVhTHZ3cGZk?=
 =?utf-8?B?Snk1TWpRMG0xYXk0Vm9lcWpVd09xRHpuYWhWL3R4M3JSSXJ5WTVuWkswRFlt?=
 =?utf-8?B?bzhCWlFpV01KbUo1bEs2b0l0SEhmcmdlbXFOWW5QUDRTNi9STTNqVi9VNEZ6?=
 =?utf-8?B?Ym1zUEZid0pnU21LZjE0cjNiQzdML1UwMmxZUm9jaFZoWHozT3dOZWtzb3Fy?=
 =?utf-8?B?NjN2RTZNdVNRQWhQeTNYbGhkaDVIenk2YUJKOWdWVmtTeUwyUUIrUHo5bUtv?=
 =?utf-8?B?N3hLZ0twaW83OVEveldyV2RGN2pKK2lMdVY0S0VWZS9pV2dWTHNWeGFHbnVB?=
 =?utf-8?B?OG5RaUc5ek0wRG5kcGxiOXpQWStqbjFqMWF4SXQxSCtTNFA4dlJudzlVR3I3?=
 =?utf-8?B?aVV0T3luc3VOSUZqNHdNSUtSMXpMV0VlUEQ0M1l0Y0xRSzEyOHNKUnhkY1Q3?=
 =?utf-8?B?K25uOXhjclRWd0RRdHR1Y1VPWjdVdVM5a3N5SVQzVnVkRVJ2NXQ4RzdxZ2hp?=
 =?utf-8?B?dkJiYmliYzZ4ZmVaMncxWTZ5eG9hNHp2NWJNSDU5bW1obC84SlQydjdmQUd1?=
 =?utf-8?B?bkVYZmpEdE5tM0ovQzJrSmQ5ODBtOHhqaElWMlo2bFVQNHYzZG1JSWNteUlr?=
 =?utf-8?B?cDZHbWtobWd6YU9ZQWNFdlNtQURrYTlHT3U5NjVDUndHMEMzaWJmSjEvRkNh?=
 =?utf-8?B?RVlzYTlqdXJ2OWV2WEVSbXlua1IvQmdBWURVR1NxaVFjR29Gc1l2dUFtbnVS?=
 =?utf-8?B?dUZPU0t2eVBkaGU2SGhXczU4eWduTlpMMGVoTzd4b0s1ZHJZVEhHY1RrSXdF?=
 =?utf-8?B?eUI5ekhCZjVTRTB4djBlbVJCc0lPbW9XTzNtZkpTZzQvYlRHYmVUb2U0SjN0?=
 =?utf-8?B?VldCbzliTEJTNGhkY1VRQnVEcDZYOUZZQXZ1QVcwcmtCL3NSVEVZQmdYZXpz?=
 =?utf-8?B?Vktva2FXaUhybHJuY2ovUU5OYVNoVVdEczFVaGRncmtyaHVDZHJxc3dvcnhN?=
 =?utf-8?B?c3lDRTZ4S29ISGs5SnlIVlFCLzJKL2J5NlYrOVlqYnVma1EwM3J6Sjl6REhz?=
 =?utf-8?B?eU5INndxajlFbGx5b0NKVkxUbC8vWWRaQlBmMnFTdHVsdmVpRDFkNkJ1elhP?=
 =?utf-8?B?MHQvRTkxeHYrVEVmdEd6V21LZW9LSldvOGd3ZjJVZ2tsRm1kSkxsWkZleUE5?=
 =?utf-8?B?OGUva1FhOHMrbkNaUURicS81NWVqeTBPdXdLY3M3SE9WQVZSdldTSlN5TUJ4?=
 =?utf-8?B?L0FFS3hjSEpxQnQyK1VkeDRKK3AxSnl6dVo2alFmUjNVMldDVU5kSXFrdzdh?=
 =?utf-8?B?WVgvaU1FcXlHd3Y5L20wZUJicDJvT1lHZVFZRGdrZ3cyY0RqMjllczJOTEJi?=
 =?utf-8?B?b2htSDFYdTIvTHBaeStMbElqQmkrdENrcU5jYjdWbWVWVDAvOHcxNEtNWm9X?=
 =?utf-8?B?d0NDeWR3QjRvQUpza2hwSE13eG5qTDZKSTlyRTIxSEI2VmVMMmhDQ29obmpj?=
 =?utf-8?Q?p4lDtZwAUk6wR3CQLQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czE1eXNkNXZuWGhjODcvaGQ1UllydTNaNkNVRnFDdWFWcll0T3h1MENBT2d3?=
 =?utf-8?B?WWpONU5xeUQrdTFUNm5LbUZXNHQ5dG1vVjZLNmpqaTR2d3JyeUpUUzZpN0Ry?=
 =?utf-8?B?aHB6cEMyMUlxWU5PZVpMdGNZWE9BS2FUcUlnSmh2WGFmbk5qRnVPSkxBSGtG?=
 =?utf-8?B?VDA4WTFZMWdYc1FYTHRycVQxcXI2YzJzQThUTDJTMFE3MmRma2h6QWJjWnFX?=
 =?utf-8?B?NGJxUUNOMGY4azUySDM1eExPM1Yvd2tnZ0VxT3NpN3Z4M0VyQ2lqYnVtVisy?=
 =?utf-8?B?RzcxdkxzSEVpbk1EdzRzbTc2TTMrd2pKUFF6M2lQdGxnbmFtMHpSZ3pRSzJy?=
 =?utf-8?B?enRtWGV0QlFZYVprdDBOZFQyWkx6RnJvSHRUWDVldDVjZ1cxZ1RsWC9IVUtk?=
 =?utf-8?B?NUprQ0FZKzZ0TlVLOHNKbHgzd3lGam1vMElFWCtmVFJBU2hna3JlOTN5UU9N?=
 =?utf-8?B?MndJWXZEaHBHSWFVYWRtZVdRdzA1OEhzcGszRWR3cjY5ZHM2cjV6cnhRTEY0?=
 =?utf-8?B?THM2OGpiZUNvbkFnVzROSm5BRVpoRmlNWWZDbklvNzV4bXN3NXhRWTZ6bkxz?=
 =?utf-8?B?ajFWQmlJak9Sb1VCczFYZHN6RzhOTm1OYmhKWGNHUlhFcWtTZnF4eWh6REVB?=
 =?utf-8?B?K0JvYzVINEpiTmtlejVmMEplT1hiTFE4MlZ4cmVNU1p1ODAycXVBbFRjTkFL?=
 =?utf-8?B?cTF6TTFzVzZ3SkVEUVZPYTBOSUkwN05hTVlPRkhCY2Z6elpWMkZyWnl5RERw?=
 =?utf-8?B?QlFVRnhXZ25PT1RSek03RDFvZVZXWUpIRXR2RGNtdlB4R1g5OVhYN21EcHJ2?=
 =?utf-8?B?bUxSSjVDNitzeE5QMVVnQXlWWm9pMCtpbUZENDdVV1Q4T3JuSzVhZVJ6Qlp1?=
 =?utf-8?B?TG5pU3BmTjNNQitDK3JnbkFwWmhFa0pVWWRnNjZUNjZaWmY2OE1VUlFhUFFj?=
 =?utf-8?B?bGVWMFp6end1RGNGNzV3VElDWmJEWHZKRXphZjZhUHZSZ2Jpai8xMVVnbkhX?=
 =?utf-8?B?UVNXdlY3ZGpSc213UHZJNVhwcWlDT3JaNjVmYzNsaHlqeVZYSCtuRVhDMlVt?=
 =?utf-8?B?aEVBaDVNaUhxWkxoMFRQWW1CMnhHbTZrWUQ1MGNrM0hNdUkwVXJCcE1obzJD?=
 =?utf-8?B?RzBGSkZMOHpsQngxUWE5Sk5FdERYZUcvbFZpWTZOalJxaTRyeWVkZWo2akRp?=
 =?utf-8?B?cXJzN2VzREJKOXp2VWJEaWFOcGUvT3FvaWZPMC9DZHV3VFI0b3h1VzdZcm81?=
 =?utf-8?B?RWZJeWlqbkZ2SGE5ZW0xdTJyZnhUWjFEYms4SzNzbVhIeTMyMkk1SUVqV2Z6?=
 =?utf-8?B?a0dyUkt3UzdDOE0xN2hJZ1VtUlNXb1dMWmpLTGp3Ky82cWFhc0s3dDBMTjVw?=
 =?utf-8?B?Qnh5cGg4dER3azlkMXlwVG1QR091UDhoMDhTVFJOeDZlK3IwNWRadUJMcWdG?=
 =?utf-8?B?bjNYc09VSk95WDNIRkovZnhCRU1KMFVBanA3dkdLVFpjNXZ4bzlwazNQUUVK?=
 =?utf-8?B?ZXlPMWNreTRiR3liL0RmYUJUMEczVEw4UkNaM3YvSERkTjE4MTZtRjFjL2pk?=
 =?utf-8?B?cnJSbHpMZUFXZUFqUGwzTzI3enZySmVoOXQ4b0t2T3IrQWJSS3dodkMxOG5X?=
 =?utf-8?B?RlhYVWlOanF4aWxROFlYeGE4QVllSVdsR2NwNjlwRitZUnVlalYvMkdHVVhT?=
 =?utf-8?B?Skg5L2hwSGhMaDFORTNwZFdkWTVNOGhpc2c3SFBRWE4vUlk4eWRDNWdqbGcv?=
 =?utf-8?B?Qkd6ZUhCd05qUkJnWTErWTdEYnlzUlcyS3JOU3hxR0ZIRGNqcGpMcTJxMWJl?=
 =?utf-8?B?SnRFRkRCN0E1M0tPR1JrOUpXRzdzWm1TdnN1bWxCWU9MRFZwWlhma295VHRW?=
 =?utf-8?B?WWsxQ2pmbHh2Wmdwd0czT2Rma0hFdHF6V3FoWTZYaWJKWlZ2amRnR2pGTmMr?=
 =?utf-8?B?Zk1kV0VJTVVTcDlUS0pPcGN6UEptcWh2LzBPbklIbjkwMFI3MlRKUlgzUHhn?=
 =?utf-8?B?azB3Y1pOb1VWaTFjTzRydFh3akNGanVGMnVkWnhkc01PRFhjbloxeEdrOHlH?=
 =?utf-8?B?L3JaTm9yUG90QkhiTVFiZ1RMellDU0NmNUI5QmJyazZxWVJUME9qMCtybWdI?=
 =?utf-8?B?Y0pjZER0NEZJaGk3K0lOR2ViWHZGYWdVdUVyRGZuTG9GUDI5b1U5cW8yeEV3?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbdaec4-b371-41b4-ac3c-08dcc5e4aee7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:35:15.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgmnQzKz6pIO2uNL3BQpETe0relUy/wZXQ+qrsn1AqPfYj0p+MUExfXBr5k8kVJuEE+53uJcNBz5o0pAhuL7Y6bx8LlmlDyw34L/QT65Jz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10422
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Aug 2024 15:35:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/563

Hi Trevor,

On 8/23/24 3:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2024-08-22 @ 02:38:11 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 8/22/24 2:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>> Hi Trevor,
>>>>
>>>> On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>>>>> On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>>>>
>>>>>>
>>>>>> On 8/20/24 2:56 PM, Quentin Schulz wrote:
>>>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>>
>>>>>>> RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
>>>>>>> v4l2codecs plugin can be built.
>>>>>>>
>>>>>>
>>>>>> RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
>>>>>> and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
>>>>>> supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
>>>>>> sure the naming of the variable is proper? Should we go for
>>>>>> HAS_STATELESS_VPU instead?
>>>>>
>>>>> What about 2 knobs:
>>>>> 	1. HAS_HANTRO
>>>>> 	2. HAS_RKVDEC
>>>>> ?
>>>>>
>>>>> Does gstreamer have knobs for both sets?
>>>>>
>>>>
>>>> They are both stateless VPUs, supported by the same kernel API I believe. So
>>>> the same meson option is used, v4l2codecs, so I don't think we need to have
>>>> two separate knobs for those? At least, I used the same gstreamer plugin for
>>>> decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
>>>> RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
>>>> an RKVDECv2, which likely is also stateless?
>>>
>>> Is this something the user will definitely always want on (i.e. it won't
>>> work without it) or should we allow the user the choose whether they want it
>>> enabled or not?
>>>
>>
>> Considering that the only other tool I'm aware of for decoding is ffmpeg and
>> it does not currently support stateless VPUs
>> (https://ffmpeg.org/pipermail/ffmpeg-devel/2024-August/332034.html), if one
>> wants to do decoding on upstream kernel on Rockchip boards, they'll need the
>> v4l2codecs PACKAGECONFIG option for gst-plugins-bad recipe selected.
>>
>> They could also disable it for their board if they want to by redefining
>> HAS_HANTRO variable in their own config file? Or in a distro, etc.
> 
> I just wanted to make sure the = in the patches wasn't going to prevent them
> from doing that.
> 

Well, it does. So thanks for bringing this up :)

>>
>>> Personally I would rather see one patch to add this one feature, rather than
>>> 8.
>>>
>>
>> Those were separate patches for multiple reasons:
>> - I only tested on 2 vanilla upstream kernel (RK3399, PX30)
>> - I only tested on 1 downstream upstream-based kernel (RK3588)
>> - the rest is untested (not even built)
>> - All patches except the one for RK3588(s) could be backported to other
>> branches (e.g. scarthgap); this turned out to be incorrect because the
>> :rockchip OVERRIDES isn't available in that branch (but we can fix this :)
>> ).
>>
>> I wanted to provide also the context for tests I've performed on those
>> boards in the commit log. It could be quite long if I put all tests for all
>> SoC in the same commit log (but that's fine with me).
> 
> Have you seen the size of some of my commit messages? ;-) I don't mind a large
> commit message. I've build-tested your patchset against all rockchip MACHINEs
> and it builds fine. When it comes time to backport, the patch can be adjusted
> as necessary.
> 

ACK, will do.

>>> Should we add a note in the README about this, or perhaps the gstreamer
>>> bbappend?
>>>
>>
>> What exactly would you like to see there?
> 
> Nobody starts by reading the README, but if a user is browsing the MACHINE
> files, notices the HANTRO line and is looking for a quick understanding, they
> might reach for the README file then? You know that HANTRO refers to something
> to do with video decoding, does everybody? Even if all you do is duplicate the
> commit message from 1/9 that would be great.
> 

Fair point, the hardest part is now to come up with a proper name for 
the variable that is not misleading.

Something like:

UPSTREAM_STATELESS_VPU ?= "1"

maybe?

I would still add a comment in the README as requested.

Cheers,
Quentin

