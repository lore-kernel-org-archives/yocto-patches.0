Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283DEC25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:47:07 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.91])
 by mx.groups.io with SMTP id smtpd.web10.10046.1718113619286761765
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 06:47:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=SxAqDnjI;
 spf=pass (domain: cherry.de, ip: 40.107.13.91, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKA5TIQ3l1To33akjbtIa9Sw9cgM2gIYu2oqGz14zsFxTM5fQVyLq9iBz/T+x82V95AzMPqztgPlUK/4aD8BDA+cIb7kT6rQuZEkrsDeRieWUL2rd26V1KoZAqOjgyjkPp5ZVPv5E4VeEA7Ob3wuPKv9KLOkJjaZw3adduyJaIyQCwnztNHu66wE6/Jfj6allvM89nvzt55z9dSjcg7TJIcOtCNUJdj11Q3DbC3EJTJiEKZbLP97UZ9Dcdxh/rT4Z5aFE+F2WsionC+8aSc/akJOjnLsHADMzzxxa24AYI6D0Gb+Jgl3XsBpZ7BNSMJZDxoDFC15aSC7f5+2b5gTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4xjJ/zq267smu/IRmYZ0EL4LcFHAHTtpxMItp/AGI8=;
 b=e5wGf2gj6sx1Pcc1HRxPBCEqSMy3iBDfMJv+YydVBwAqNovNBTNDNX4dAQIadJ8YwpFmY4ePLW0wvOdNvp8dJRUxQtz4iT4I4bw9Omp68faxHqY12odoKyPFA7VEOU0fxaf03hJTHKKUYd915RtfWjktx14IDHu8sN80YutxqOa4oT+DgWCNo9vdqziPfyMoikd5o++ksPEl3w8cz0v4i9BRnrN54BZXFYIubq+u02T6P5Ps3FsZWklrBiW4ynxliAK4HQdt50ww5jjpIBzLdESi1CSxwOYe2kD2JZU4hIvFkBx9rVk8XEmKYoHfpXwSEw8WjX3fbkkIvdFOZmWt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4xjJ/zq267smu/IRmYZ0EL4LcFHAHTtpxMItp/AGI8=;
 b=SxAqDnjIWI0wvLyRFcTurvZxcMgzDTuvKYEaQrAcgi+K2CuXLiVHi3+sjrrCxow8v98QaNLTo0O3HHf9+tf2kQUILuWnQ+pcxfz3OBU9zPNMucJKV4nZ8BAdM+VOvf2aoMfW4K3V5Z5uOOQ0ryn6BsR3pVMpF1WozRL06gHr0OQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:46:49 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:46:53 +0000
Message-ID: <b5cc2a36-3aca-492e-b726-c6f27abe12df@cherry.de>
Date: Tue, 11 Jun 2024 15:46:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip 0/2] enable Panfrost on
 RK3328 and RK3568
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
 <20240611132944.GA39107@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611132944.GA39107@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: ce05f0db-93f1-48ae-ec9f-08dc8a1cf40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cW83Sjk3NE1zUm5rTEZqaGxzTXZTUWZRSjJnOTlybFVkNzk2ZzFqY3QzMjVQ?=
 =?utf-8?B?eDhlNmtsNWllQVlnLzdXQzJKYk9QL1BvbHF2T1FpRUQyQmlaN0lnTDJheEdh?=
 =?utf-8?B?NTJmQ1JvT2U3L3o5WE9vVk1DRThsL1h5VUJkR253OFg4aEV1cjhPUEFucW04?=
 =?utf-8?B?clBNK3VNdEVHK1ZhZjZHL3hUYUZsNzJvQnJJcmVlQ2lxNEhJTkhyaWhPTlg2?=
 =?utf-8?B?T2ZRb281b0VzZW05MzVFNDV0QlBUNHVDdW0wRnd4L21EQm9RWENYSy9WWHJS?=
 =?utf-8?B?VXd6RGJoK0NGVm5ZakkvbjNNSmJPWE04RkxRbWdwREdaSWpQRVlOaHJ0Skd3?=
 =?utf-8?B?dXViMUdmMVplbWRpOHRKalpGZEVuaE9TU0xGbmRxWk1pU2JRem1MMjlxRlpj?=
 =?utf-8?B?WXRzejlIQS91YVBjaHdGVGVFU3l6MVM1cWMyWnkvL3l4VS8zZVQxOWtCMmZj?=
 =?utf-8?B?Y3VOVFZTNkp4ZHBMN28yelVrVEFNM1VXelFzTC9WWENPWG1RWkMxckU1OTBp?=
 =?utf-8?B?ZlNoc3lId0pFemgrRENQSGdZTnZpVUcycTVYSzh6YllUNkV4TVIxOVlsZFE4?=
 =?utf-8?B?YjFJbU1UYXFwd0tzZEVWbWZzQWZYVHM4NnlGdWZ1dnZ1MjZVZnphTzJISWU2?=
 =?utf-8?B?ekVDRmhZM1p2REo1NlZ6S0F3MEZQaTBrQWY0V1ZJc25sMEthWnRVTlRQQ3do?=
 =?utf-8?B?RHFTSnFsaGtDYm82dXJ1RmtPdzFPSTczOEk4OHVkSjZTdCtLLytJdThBOEI5?=
 =?utf-8?B?YnF5N1lQbU5KU0pKTVdmUll4T1MyYVlFdUc3bWYwaWJ0d3ExT010NTVCbUs3?=
 =?utf-8?B?Z0JPV2F5MzJTcjZ4aHEwMVBoWCtVRXY4cU4wT1I5L3FPN0FjTUJUNGM1aXVO?=
 =?utf-8?B?Y2pBZG41QUhnSmZ5WWdqKy9lMDV4eEpOT2VaaE11TUpMRi82cTRuRkt4K3l3?=
 =?utf-8?B?YTNYSlNuVzJwQnJTZ3RuS3JsVmpCMFYxMzhqU0NqWWNJS2ZPYVl1WTVpRGUw?=
 =?utf-8?B?SjB6d2VQUUZxYTJqSjQwMWF2dHh3Q0F0RDlYU3F2MTBkWG9VazU5NTNtc0xT?=
 =?utf-8?B?eUxxZmRWcU5Oc2pwQms0Mlk3ME4zZGVWcGVCS2d0K2kwS3RrQnFLSVl1cU1G?=
 =?utf-8?B?VkRnblI3Sk9qSUhTSWEwTkYyQ2x4bjY0K2wwMjNNRTU0TlJjZDQ1Y1lVL0tG?=
 =?utf-8?B?cC9LeE43cytDbHRYQmVQQVdtYzN6YUYrOXJRYmNDMG5yYnpVeWppSTVQWFdN?=
 =?utf-8?B?WEdrV0hyZSttd01uTUdqUk9xckpPaVgvMUZMQWxmc3YxRlhPcHlUVHB3Y21R?=
 =?utf-8?B?ZmlZcjJ0UmRTdUt4Y2pEOGVzNUtJS0Z3RWRib2NkR3VDSEFUYVRUVEJFZ05H?=
 =?utf-8?B?NVVKSlY4RGZuejZjTW9mQ2UyUllSbi8rYnprVUJDQms1a0ZrUk5iSUZiS2Zs?=
 =?utf-8?B?NDFOZFR0R1U1ZXpyaDBOMUc2QkRVUE85bCswZzZRYzBUanJ5SktielNqTTd4?=
 =?utf-8?B?bzdEcEcrWXA3REtXbVBFNy9ZQ2xoNHNUZnF4YjFkNWRXbk02aXZPK3gwV3RK?=
 =?utf-8?B?K3VSTlQ3ZDd1SW1ILzlwQTdtbnBDVkpjOFZMMzB3R1ZkMEpEL05ReXB6Q1N3?=
 =?utf-8?B?RGF0WjJEYmxYZ0EvK2ZVc3VyTGlOT2RXbFdjc3FpbmxUVXNtcmNWSy80MVJv?=
 =?utf-8?B?ZjhzMU90WkpxbWZ6b3hSU3Y4N0szSVI0YXIwREF4ajJSZldFaHA4QUlIMWJ6?=
 =?utf-8?Q?Ou4hICtQ7pWPPnoyJTeBPZTzqGePzSA5lEPt5Ln?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NWNlSUNySmZaTlc4MExxL1JRc3RGZ1BuaE9LSXhwbzE2R2JnZzFZd2p0RXlN?=
 =?utf-8?B?MUxSN1lPbGdaQUVNbmZZbkpjWGZBUFNHc3A3aW9PUWt2cC8rT0hNZXlJVkIx?=
 =?utf-8?B?eHdRRVpObytjbW1GUFNBVFJtYnN2RHZpdzY5NVFQQWcyOWlNM0lEWFZPOGdC?=
 =?utf-8?B?NzdPZUFQZUduc2tmS3Irb3kxRFBMYzNMOTZZVHJjN1hNWW1qZEhsNlRNeDZV?=
 =?utf-8?B?cTMzcHRkSGcyRjRlNlZDQ3h2KzVwaEdJWVkwRnJOTmZUWkxxcHdvM2FZaVdm?=
 =?utf-8?B?YkJvVnRmVXNSQkhlYWdQQzhqMFV4NU5lQnJ6a2tZOFBkdlFKckJNUHdXcTE0?=
 =?utf-8?B?dDZPVm1wSW1oQ2NxM2NLbkJnNEROV3dvU0dKTDBvdjZCbG5aUjdiNG9ndWs5?=
 =?utf-8?B?NjAvODEzVjVSWk53QlI3c1paeEVZdmpudDJOdTUxSWt1ZStXZTdBTUdTanV2?=
 =?utf-8?B?UjVwQnp2ajFhR281eGJqdWtyVHBBTktwanR1UFBnNE9tM0xIbTlkSlUrd1Jz?=
 =?utf-8?B?OFFkeTFlMG9DOVVIQzlWK3hiK3prR0ZCeVB1czJjQ095ZVg3U0s2b3psU2xN?=
 =?utf-8?B?cC9uVTlTQ21VM0lLVXhDN0c1MWVtd2laVVdKVzdVSDl3VUJlcmo3MjZGa1Fn?=
 =?utf-8?B?S2hJSHY5UTNoaXNQQ1QyR09zditxNUM4MGwxT0RCdmhldTIzQzNSUFd5M0F5?=
 =?utf-8?B?akpHenlDTWdwMGRzeis5TkEwZm82eUpvbDFGU3liQWdXbytsK0xYVlhkdURX?=
 =?utf-8?B?Tkdua0ZvZHNkOStwazZGNFN3S3crNVVlM0tNZ2ZsS3F5amt4dFRxVDVyVzRI?=
 =?utf-8?B?bFR6VGVhRUZZSm43ZWxST3g5RjFST2ovT0Q4d0Q2SnNnTWYyTU5vcEJoMGtv?=
 =?utf-8?B?UFhwQ3dCcGhZZ0ZVSityYzhZZzNyOVhQYVR4b2dFaG40MDRGNDJWdVJlaFN6?=
 =?utf-8?B?MkczUUR1NXBoaXNTTkprYmtNRkNhRnduT2pKRm8yenBPLzZ5RDV3cG5tRkxx?=
 =?utf-8?B?QVR6WW5Odk1xQXNNdktFM3A1cDNJNjBjOTFwT0VyVjd3TTNOY2tpS3loM2pI?=
 =?utf-8?B?TFplNysxRnFwZHROQXFOOHowL0Q4NGFLajBnb1BvbEZoL1F6UnVhWFJDSXNU?=
 =?utf-8?B?UHY2S04yWC9FaW1nU0tpWjlYeDF1NGZDWlFmTmcwaXFXL2lLbkhiT3FUTTZs?=
 =?utf-8?B?OTV2VDBjOXhEc3pneWpTaW9ZQjRWclRoWEJidkVJVGtOQ0dKNEVsU29wak0z?=
 =?utf-8?B?dEJuMnJ1UUViYTJ5bEFxQTc5WmFrWTZVdUp4c0MzUitCM1pCSUF6NG9xdWh5?=
 =?utf-8?B?VVYvTVQvKzkzV3FKeFhZZlZXeEdjSnhRWG5BQ1o1R0ZjRTZuYTFpUDkwczhp?=
 =?utf-8?B?WlZGRXRwZ3hiR1ZBeE9iS2IyREdJRW00UEF2L3JhSEhWT2p3SjdQY2dvazha?=
 =?utf-8?B?ZTk1Y1RqQkVlSW8wNUcvdVVXOHR1M0Vrd1ovR2UzQVY1aHZla0JvakpwOHpT?=
 =?utf-8?B?Z0E3NGpWenV2VmwrdEdPNTZTd1pSUThpT2JhRWVkRlpkY1UzRkpid0JPL0JR?=
 =?utf-8?B?OEExdW42SkR5K2g0ZFVId2x2MEpqcTlmMUdiV3U5aStzTk9RanFvcjdqMkxo?=
 =?utf-8?B?NVg4VjRuSE4vUlVKdU45SVJuNVcza2xuallTK1FQbHBhMjJWd0lCdmNidjEw?=
 =?utf-8?B?WTRLaEV4Qld3VGlrZHlXc0dBblFZclJ3WDZrZnQzdkNVTmFZbjlkSzhiUWpI?=
 =?utf-8?B?NkRHWTMwVzM4VllnUFhDOFIrRnFCTlY3YkswS3JybVNGeE95TXJwY0FVNFhV?=
 =?utf-8?B?YmRkak1OZW9RYytuWjgwK2lDcm5mbG82K1RXakdHbDk5NHU4OExoUmdQVU1K?=
 =?utf-8?B?TS9sMWNYRGlMb24vbHBDNVpCNEdNQk1YWUFqVVhGYm1TbFZKYytVbWg0SEZQ?=
 =?utf-8?B?aU9YRS81LzgxQlFyMUpYRXg5M1V0bmI4bnZ3Tk94bUZNMVpNQmo3OXA2aWxN?=
 =?utf-8?B?KzBHYWJJdnYxbDN6SFNrL1BtSFNJSGtWYjJYZ1RORitYclJiZzJTczhWS1E0?=
 =?utf-8?B?anJpT1hrMlozaTRsNEk5ZjdMZ283TlhQYkNiR3dPbG1tNTZCeDIydkxEaldk?=
 =?utf-8?B?QWRQZDRIQytOR1NpWlF3ZVNSTkl0NTdBU3l5UC80T0dpU3dtU0RUZnY4dTZu?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ce05f0db-93f1-48ae-ec9f-08dc8a1cf40a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:46:53.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A493UfMj3hAohfi8Uvj8aU/SJOe8Fmt3x9YsXZZL658QqCG8M4HaUf5skxC/GokHozlGX2QYq064YbfMEIHyj1mTEi6ensp/TEJC5ufcbGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 13:47:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/296

Hi Trevor,

On 6/11/24 3:29 PM, Trevor Woerner wrote:
> On Fri 2024-05-31 @ 02:48:13 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Note: I do not have access to any RK3328 or RK3568 device so I could
>> not test those patches.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Quentin Schulz (2):
>>        mesa: enable lima on all rk3328 boards
>>        mesa: build panfrost for RK3568 boards
>>
>>   recipes-graphics/mesa/mesa_%.bbappend | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> ---
>> base-commit: 3381d6af6eabfb532da16863b785a95abba6b9e8
>> change-id: 20240531-mesa-panfrost-f975f1251b6c
> 
> I have a couple rk3328-based boards, but the rock64 is the only one of these
> that has a video output device (hdmi). So I guess if someone really wants to
> build a graphics-based image for an rk3328-based board that doesn't have a
> video dongle, then I guess they would want panfrost too (?)
> 

The NanoPi R2S and RockPiE seem to be the only ones with no video output 
at all (the display subsystem is even disabled in the DTS for the NanoPi).

In any case, it should technically be possible to use the GPU without 
any video output, though I haven't managed to make my RK3588 boards work 
without DSI or HDMI support with Panthor so no clue how this should work :/

Not everything done by the GPU is for displaying stuff (could be used 
for maths stuff, openCL and the likes, on headless systems).

> It's been a long time since I've done any graphics stuff, I have a rock-3a
> that is rk3568-based but couldn't get x11 nor weston/wayland working. I
> probably need to do more fiddling.
> 

I only use kmscube for my tests. You basically only need to make sure 
that the renderer isn't LLVMPipe or swrast and you're good to go.

> Neither of these patches interfere with the build so I'm okay adding them.
> Would you also want them on scarthgap as well?

I have no personal or professional interest in those patches so up to 
you, it's just that I'll need some patches for RK3588 Panthor once we 
publish a downstream kernel with support for it (there's already one but 
I don't want people to start using it, so not creating a recipe just now 
:) ), and this patch series will then probably conflict with it in the 
git context, but nothing too difficult to deal with :)

So, up to you!

Cheers,
Quentin

