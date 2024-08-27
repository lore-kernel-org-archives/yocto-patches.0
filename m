Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D2C5472F
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 15:12:23 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.10])
 by mx.groups.io with SMTP id smtpd.web11.80286.1724771538415349664
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Aug 2024 08:12:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JKnMTxcx;
 spf=pass (domain: cherry.de, ip: 52.101.70.10, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGwHmV022WGAyRD75aqRvdeEHJOuPc06qIe1psnGTCDLCzRr9OMe3/RbGeaJWIipaQlGA78Oefqx3bxVo1FWL3Iu01r8/7BHZre21eY9IBcMI9JS7+TSgMCQ4r/ya1qeTaSah7uwbKeiOmiYRrVj03kSxClKzej3TaEnBwMJQ+c/t1L7MwkDipKHtBtZfWAcCmtH3ChxEc+WNenKc1U5y3O8OXHZvFOs47MFHPtOXv6APF8pnre1vRgEfEyTzJ2q5u2xAX9OQjqTYxCB5SNphJHht+7Fyr4S9IkQ+7R/sOF1BffCTcPJI9WKlPy1pogYUsUEUkuHwNDDY5TPXZ5keA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaqV0vb39OjXbVwbIdGuDm6ub0EnAiI9S9WhqqGJe/A=;
 b=h0OL/Jt15xlXRBHkJEL238VGyzkr7/faseqVkqI+gOHyewGXa2m0/c8EQYgh9gNKXFb0/5k5mwLmNL4QJgeAddjJfojkAiw+IFJITvYhcfN3Dtb1SaTqyU4LcJzPv2zNcymqsXfzBkmhKsFDgPqrRvUnj6D8TKBkjGvhQ/RF8DPdZjCZuKt/TkT0vxvlh0JeHKyJKx/XdIJmtyvk7KMYxTZAE3kh6uVIZjtDjT/i/hCJEDb230UsvEUfxu5t8HZU4Oe2U2q7usqXnZaUfx8Uub3vdSGUA7961bOvysgaLTvEkUZwfEe2erFdiT2DmibawzIZweJS27IugfSaxgpNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaqV0vb39OjXbVwbIdGuDm6ub0EnAiI9S9WhqqGJe/A=;
 b=JKnMTxcx+PACp/JmlL0y2YH8/e2iDjXicU/ZdYC02V2aNWsH3iVYeF5IMSprudHQhrDZbOFiVpsfA+gT/kdEboO7c+hEAEbPquaH5RLO3w9c3tqSZcZENutYj0BSAbymTVwdFm/SDDfGX+Xn0IpOmOH7tQqpJOtO/G75MudNPdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10830.eurprd04.prod.outlook.com (2603:10a6:800:260::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Tue, 27 Aug
 2024 15:12:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:12:13 +0000
Message-ID: <c7a3829f-2eba-45d8-9418-937443704d66@cherry.de>
Date: Tue, 27 Aug 2024 17:12:11 +0200
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
 <be2e3176-18a9-44f6-843f-d52c43e1df39@cherry.de>
 <20240827151027.GA29205@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240827151027.GA29205@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10830:EE_
X-MS-Office365-Filtering-Correlation-Id: b594fbf6-0d1a-4f9c-3ebe-08dcc6aaa107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?empuVlZMenM1bzA0Y0VzYm1UaEllam1sQ2J3MTBka1ZKMnF1dFFIUWZhMXRG?=
 =?utf-8?B?MmJVakt3ak1KZnVDSWxqdDBzRHQvdEgya0M0Y0hIeHlidSsybWtNS2x3ZXBj?=
 =?utf-8?B?Q0RNWnhDQTEzb0doWDBKUWlPRkNFTGlhN3JCL0ZhRHRYUWtzV2xWVWRVWXBL?=
 =?utf-8?B?WktMYldBU1E2ZEg4UjJnUERabEtEL2tvbjBXNVNaQ3FScG12RE1rRTU3bkVV?=
 =?utf-8?B?UHFHV0lIa1V0Nnh6NDlLb2ZKZkMwN1k1SzVtbHEyaEhXNldaNDRHUFEvSzh3?=
 =?utf-8?B?WC9ncjRSVzVsNDMvSWRyOXY4Ukh1dkFMTXRIRWZobWEvQ3h0dVBaSUF4T2R4?=
 =?utf-8?B?YkVUdmdkTy83U3pHSDdTOXpNYjl1TVpOY3M0UndOYXhYWVo1ZVJkWWxhVGZi?=
 =?utf-8?B?by9hNGxEUlNFVHRnS0pQdk11aGt2aXhWSllYQkVMYTd4TnJxQVJWUGhkeEtY?=
 =?utf-8?B?TG9VV2RMM1FXZVFQdThmbUVyck5rR0YrRmFHQWxvU25SU2tQeFQ5SjNTSG03?=
 =?utf-8?B?SDZ1Z1BldTRldXRVTXlqbUNKZlhVSGF6cElQb1Brc0l5TXNtNklmOXQ4YjJG?=
 =?utf-8?B?R0RZTUtld1lIL2hyekRqVDEzV2M0b3NRbjd3OFZ1RjFhcnROSVJIZ0FwSXQ2?=
 =?utf-8?B?amVKVW5zOGRpS2loUFVaYktFNWRMcVRlblFNLzY1RFhOc2t4bzlPV1hTd2hN?=
 =?utf-8?B?Z0RyN053M2hCREZYSStuNStmN2djcXdlSUNXd2JHWWEyRGlYTU1vODM5a0s1?=
 =?utf-8?B?ZmVxamVIRldSbkRnRUNNSTJtcmNFTnFpTG82ZzhyY3U1VUNiL3ZhK0IwZnQ5?=
 =?utf-8?B?dzRZcTg4WllOaFJka0RkVnhlOUo1aktrMXc2YjF4VFpCMmdMeDkyeGtoMlly?=
 =?utf-8?B?Mm5yeFZhdGh2VUQ1V0N1S0tSMDVCQTZ5VUdOV2s4RkYyRTRYU09ZNUh5SUNN?=
 =?utf-8?B?UjNJZTFZNVFRa1pYWHcxLzlzb0NpOFBUSXpNZnFYMEE4U3RaTko0c2dkV0cz?=
 =?utf-8?B?bDJEZTcvSUoxaUppeVVsdE9MM2JaeGxQZmJkYisxVWNrSlFLekVJNHV0UTV3?=
 =?utf-8?B?TjA2N1pxR05BMnpxMHpiV0pTZGJVWmtuNkM4VjQ4akdDRzVyNmczVmQvYVdx?=
 =?utf-8?B?Q2lOWVJONGxvWTkyeXFMUFNpN1U5ODZlVzFKY0NmQTZ0MDRLTElNeUF0T3c5?=
 =?utf-8?B?cDFiclpRNEJSUlFMUjN5SjJRajI5OGI5cUE5dkJJakttRUJwYWlkTGJ4TFNF?=
 =?utf-8?B?czBjeEFFcVdqTzdERE5PUW1HbGNoWFBQZklqQ0lLRVFxK1VZbmVQb0pTYmFm?=
 =?utf-8?B?M1llZDlEQkQwTC9Kc0E4bnI3RmtiMnl6MTV5KzVrZHRDWENnZjVDNG9IcVIz?=
 =?utf-8?B?ZnVxZ2NzdklMZkZJdlpZc0xEQjJuSm1vQnBDRFl6SkJsbDlTMHdMcFR3dk1N?=
 =?utf-8?B?UW1mSVNoRWJ4cGpHZGg2dHAxVmZ4Z3czbTE2S3drTEV4TlQxbktrSEZEZFdo?=
 =?utf-8?B?OHljYmNyNzlma0RwaStzY3E5TnBJMVRORVI3UFU4b1dqWHFPRWQ4bGlldE1i?=
 =?utf-8?B?bWRoM3RFdUlnVHlzV2NFSzNLMncvbTRnbEplaktPTytvSnNWYytqaUYrWlBx?=
 =?utf-8?B?WDFMa3JoKzluMzJNbFlsSE1CYVhkZk9NNSswdFVoSWlRb3dEbUZEMjdsSFZv?=
 =?utf-8?B?UWtiZDdRbmJyV2l6U2RVR2RlRisrY2lGcEdBTi9kOTFBSUt6NzFGejAwakJs?=
 =?utf-8?Q?YFhC58Z7hu6UVCVQyU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFdBelg0SWxGeXpzTUx1STJUSWs2NTJhRUdqTm5xbE5QZTAzUkdRUmNoTGNq?=
 =?utf-8?B?UFd6OGlrb2dRbG0rbmduaWd2N1g5MWZmci9RRS9oRmNjVXplam1UbnZxM1dK?=
 =?utf-8?B?KzN4YVpUcElsSElQcFRwRjd6Q2V4VE5UQ2lGRlFob3lCSU80eW9QUEpXR2dK?=
 =?utf-8?B?ck9BS01qNlZUamtSNG9RWEtiazhCZmd5OTdVaGhlWklEV1NQODlVOEFtRzVh?=
 =?utf-8?B?bTlQNk5yNUdlMzE1cko3dUNHMjVUVE9XR0FyU0JzczE1bWZXWWw2VDRoQlhB?=
 =?utf-8?B?SWxsNzJtM1JKclZvb0JNSUp1YWFZR3I0czFMUisrT0MwdmtTQ3NEeC9JaUJF?=
 =?utf-8?B?cUNyN1E1SU1IYjFSaXlzeDNCT0dVYUorSXBwbWFqMUp3amtmczNJSlMzeTVZ?=
 =?utf-8?B?SE1MK3F1K1plUFNuVWdyWFFIZFQvWVY3MmM1alNMMnVkQzlXZXVjcEZ5aXpp?=
 =?utf-8?B?eHdHZnFBc3F2V3ZNVVNmeEtjYzhVSzdoQnhtdHFuR2hMVEtXUFh6YjhCWjU0?=
 =?utf-8?B?TWszMFdEc2VlYktON2F3Ukp1Ym8yM3B5MGNHUmxrMk1hVjBXcEhGK2xGVkZT?=
 =?utf-8?B?UU5RVXVmTU56NTFidWcxaXF2OUpYQkxtdnJJL0dZVkxZMEJJRVpEcnNBQjAz?=
 =?utf-8?B?Qi9yZWNTUE42RUVrallyYmtvTFhORWZ2ODdTREpISitibnUrbjNmQTE4UUIv?=
 =?utf-8?B?bkdCZ3hjdXhxV0VLNGtOeGRrNDNpWlhBNGlUTW9iS0hubTBuWmZTSnBMRTB2?=
 =?utf-8?B?cUZrbUZveDFOK2gxNW9hUDk0VU1sSGlIVFE1WlhZSHpQc3pnRWlQbWxpR212?=
 =?utf-8?B?U0VqcVMwYUJUYTFIeTFTQ1RMMzZua3krdWNtZXlmUGFnTTJWRmxBM1pmRkpL?=
 =?utf-8?B?QnFSOTNTUUM0cGNYS0J4bTMvSFpPL21MTndpaTlPdkZhVldDeHNvUEZvTFFj?=
 =?utf-8?B?KytpVXhrY0tOeTYvQ0svNkxKelpJRDNNbzlaR1djUC8wRUU3MGpwaHJJamRE?=
 =?utf-8?B?b1FmWFFTT2M1d0oxOFd4Qk05ODROdHpvUGJacVFsSjJCbER3VTFXczY0aWhn?=
 =?utf-8?B?Qk0rdVA3bEFSckMyRzZvZHhYNGJpWlA0eXRkRGg4MjVvZDVIUXp4NEE5ejZK?=
 =?utf-8?B?cnlpa3loYTJkRXU5L3EvbnJGdU1GaVdjcDRHNlltWWFWRUJZUVNyL3dwREpw?=
 =?utf-8?B?T2V0OFJ4LzQvU0szcjErdTF5T205eGJvWDJHQ0MveWFlN1MxekxuQ3VweUp3?=
 =?utf-8?B?cm11WTQ0ZFdkQ2o1TElockFjZFV6MkxJeU9lOWp1SnljSVF1RWRGS0prNStz?=
 =?utf-8?B?T1pBWG16SDM2YlpxY2NpKzg5NnprR0Q4Z1BrY2M0dWRDRXJXbWZqTFBYbWlw?=
 =?utf-8?B?cllyaGQ3a05EWU0rYVZ5OXJQTTRtVlUwTHRWMk4weEhBVzRVdHFveTZ4dmFL?=
 =?utf-8?B?K0hpVC9tZms2b3FqVjBVTmxKQzBoRHJtc1hyUHdqK25KajdoVVBwNTZxM3Vw?=
 =?utf-8?B?Q3BiYU1vM0xud05LN2pDNU8rODBhemNIVmxtcGN5Um5NYlAxVENMdGgyV0Zo?=
 =?utf-8?B?Z1VkbE4ySVNLTEtRRDdVdnp6aVV2RXpyMld5VTh5b0kzQlVDcmZyVktaL0N5?=
 =?utf-8?B?MU1KS0JhMHlGSTlrNGV1c0xyU2QwY3FSSmQrcGE0aHlQVDN3VmNQL00zQXdV?=
 =?utf-8?B?U05ITnBvV3B5TzdxTGY4OWJLSkZabWhYb3ZaUUpqWllMWEEyd3JOVnVPRURv?=
 =?utf-8?B?bVFzRWR0Nm0wK2FLVlhKZkJGS1cwVXVoTjc4VFVkU2YxdFRTWURzeFVTT3pT?=
 =?utf-8?B?akZOaFk2cEJXMGFEU1pOU3hEaWpzeVNsSzVKNEZYMVNwaTQvcHY0eWNYSklZ?=
 =?utf-8?B?WTNxSmwxWDVWNFVQQTRzcGhRVFcyYVp2aitHQm1aTERteGdZUEwwVFpGWmVr?=
 =?utf-8?B?UmpsRmZsRW1EcS9nZXNkUXdoYkJNVllHWVhBRmNlUnp2d3F0bEU3c05TVjRG?=
 =?utf-8?B?Sk9COEo4aUNIYjcrNGJGL1pKYjFwMkx1Q0xMR25EUGdjbmRmK3loVVlzbVFk?=
 =?utf-8?B?ZllHQW0yWklJZnJlVW9ldy9qSlU5V0FMQkJkeFNRWHI1RkFPSURBYk41OFY3?=
 =?utf-8?B?OTVlVlpEWmJJcVNaendiRmUxcTBQbmZqRDZrcm14Zk04bUZSczJ4MkhZS1ZP?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b594fbf6-0d1a-4f9c-3ebe-08dcc6aaa107
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:12:13.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbOcpaI98SQwr3BM4ScBs07PKKWFAUlJziGOA1GBesHVpdB7DEw57SzOhpT0tag9X2qQn3W070kfMO8TSPnc8FFYB8YZ8rItHp7bSOEqFF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10830
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Aug 2024 15:12:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/565

Hi Trevor,

On 8/27/24 5:10 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Mon 2024-08-26 @ 05:35:14 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 8/23/24 3:55 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> On Thu 2024-08-22 @ 02:38:11 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>> Hi Trevor,
>>>>
>>>> On 8/22/24 2:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>>>> On Wed 2024-08-21 @ 10:17:52 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>>>> Hi Trevor,
>>>>>>
>>>>>> On 8/21/24 6:42 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>>>>>>> On Tue 2024-08-20 @ 03:48:16 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/20/24 2:56 PM, Quentin Schulz wrote:
>>>>>>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>>>>>>
>>>>>>>>> RK3399 has a Hantro VPU, so let's set HAS_HANTRO so that gstreamer
>>>>>>>>> v4l2codecs plugin can be built.
>>>>>>>>>
>>>>>>>>
>>>>>>>> RK3399 actually also has an RKVDEC VPU which is used for decoding H.264, VP9
>>>>>>>> and H.265. Currently, rkvdec supports H.264 and VP9 decoding, while Hantro
>>>>>>>> supports VP8 and MPEG2 decoding as well as JPEG encoding. Therefore, I'm not
>>>>>>>> sure the naming of the variable is proper? Should we go for
>>>>>>>> HAS_STATELESS_VPU instead?
>>>>>>>
>>>>>>> What about 2 knobs:
>>>>>>> 	1. HAS_HANTRO
>>>>>>> 	2. HAS_RKVDEC
>>>>>>> ?
>>>>>>>
>>>>>>> Does gstreamer have knobs for both sets?
>>>>>>>
>>>>>>
>>>>>> They are both stateless VPUs, supported by the same kernel API I believe. So
>>>>>> the same meson option is used, v4l2codecs, so I don't think we need to have
>>>>>> two separate knobs for those? At least, I used the same gstreamer plugin for
>>>>>> decoding h264 on PX30 and RK3399 and PX30 uses Hantro while RK3399 uses
>>>>>> RKVDEC for that. Similarly, RK3562, RK356x and RK3588(s) all seems to have
>>>>>> an RKVDECv2, which likely is also stateless?
>>>>>
>>>>> Is this something the user will definitely always want on (i.e. it won't
>>>>> work without it) or should we allow the user the choose whether they want it
>>>>> enabled or not?
>>>>>
>>>>
>>>> Considering that the only other tool I'm aware of for decoding is ffmpeg and
>>>> it does not currently support stateless VPUs
>>>> (https://ffmpeg.org/pipermail/ffmpeg-devel/2024-August/332034.html), if one
>>>> wants to do decoding on upstream kernel on Rockchip boards, they'll need the
>>>> v4l2codecs PACKAGECONFIG option for gst-plugins-bad recipe selected.
>>>>
>>>> They could also disable it for their board if they want to by redefining
>>>> HAS_HANTRO variable in their own config file? Or in a distro, etc.
>>>
>>> I just wanted to make sure the = in the patches wasn't going to prevent them
>>> from doing that.
>>>
>>
>> Well, it does. So thanks for bringing this up :)
>>
>>>>
>>>>> Personally I would rather see one patch to add this one feature, rather than
>>>>> 8.
>>>>>
>>>>
>>>> Those were separate patches for multiple reasons:
>>>> - I only tested on 2 vanilla upstream kernel (RK3399, PX30)
>>>> - I only tested on 1 downstream upstream-based kernel (RK3588)
>>>> - the rest is untested (not even built)
>>>> - All patches except the one for RK3588(s) could be backported to other
>>>> branches (e.g. scarthgap); this turned out to be incorrect because the
>>>> :rockchip OVERRIDES isn't available in that branch (but we can fix this :)
>>>> ).
>>>>
>>>> I wanted to provide also the context for tests I've performed on those
>>>> boards in the commit log. It could be quite long if I put all tests for all
>>>> SoC in the same commit log (but that's fine with me).
>>>
>>> Have you seen the size of some of my commit messages? ;-) I don't mind a large
>>> commit message. I've build-tested your patchset against all rockchip MACHINEs
>>> and it builds fine. When it comes time to backport, the patch can be adjusted
>>> as necessary.
>>>
>>
>> ACK, will do.
>>
>>>>> Should we add a note in the README about this, or perhaps the gstreamer
>>>>> bbappend?
>>>>>
>>>>
>>>> What exactly would you like to see there?
>>>
>>> Nobody starts by reading the README, but if a user is browsing the MACHINE
>>> files, notices the HANTRO line and is looking for a quick understanding, they
>>> might reach for the README file then? You know that HANTRO refers to something
>>> to do with video decoding, does everybody? Even if all you do is duplicate the
>>> commit message from 1/9 that would be great.
>>>
>>
>> Fair point, the hardest part is now to come up with a proper name for the
>> variable that is not misleading.
>>
>> Something like:
>>
>> UPSTREAM_STATELESS_VPU ?= "1"
>>
>> maybe?
> 
> If one reads the text that scrolls past while booting, the word Hantro does
> show up on devices that have it. Could the variable include the string
> "hantro" in it somewhere?
> 

That;s the thing... not all Rockchip stateless VPUs are called Hantro :) 
Some are called rkvdec, some rkvdec2, some hantro. Some SoCs have 
multiple of those :)

It;s a wonderful mess :)

Cheers,
Quentin

