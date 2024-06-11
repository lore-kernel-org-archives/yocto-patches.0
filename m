Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E591C27C75
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 15:28:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.125])
 by mx.groups.io with SMTP id smtpd.web10.12627.1718119729715913657
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 08:28:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=J6s3GokB;
 spf=pass (domain: cherry.de, ip: 40.107.21.125, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITiw8yk2Kfw9EalZBJmX3yCQ/x4hb4epEDcpRrNOBGmBUUbslgN6R0oL3eQld1saTv0lz4hgHdM4d4hEOms7BJxK2QEjOCy6gKJj78BwFi8EnjDDzlN8fHtFgeAZp4GPo7Fm5z77WpuB6Do2cEzLLTniNZujECXvMdgdjMlNCmU3SB8oIrJOyB2C+Spvszu1fGAI19LxPqLaHXmUOzNtE1IRV7sNez31S8Q7CNENbq5m51r67jABo8VgCFHfgHnGpq7qmQMtDyJKSlviGk8kDws0vggsptP9NOXOY+vmKU5xIL+GK36m7Dbs6Gq9Wlml09JpKwa6OvtIOqaaQZVZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6tEOBSN1Xcz+CwCr8Q8vz4m5YORdaogtYSvBvQ07Mo=;
 b=RTTYfWssJ2dQJpVbGBA7+XAGhuSfr0/oQhtX39BkuFHw81MwtdzpeJK6ti+WUPod9v76i8DtVQOk7ofbvBWyAqlqW4/a7+hfHqHA8mZthtfNB8VSaSg27BFOZSWn1vLfRtsNEBcbIu8gkjAAm6E7JvfeX4pHFpdF1f2Z505hJcEOfge34/B0GkQHTXmeRCK2DLrIHd5YX5GIQbodGrk4G/3m1w2SYKAhnC1q2l4mJijdgFiGVN/ZBrKtZJa2T+HmL5lk5ZVeR23OwO+j/HY2+igaREd4hw6+SF19xtRG5Ey/5nVOR0TtV0eg/FGlTy1wETI2Dce1nQHPHtww3DwATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6tEOBSN1Xcz+CwCr8Q8vz4m5YORdaogtYSvBvQ07Mo=;
 b=J6s3GokBEDJZlCaoqrgMr6qE2mfxYfsgWy2L8E59Akv+OG/WxoJr1vrbCfNLryivLU6eXS7+je6ZDb+6BKk4jKmlzZFDde6je1NNOQp93nYwt6xYsHI+ZaYyIH0o25y2i1NKP0koWodLI+xOebTIQqJKcbXjqK1D6+qaD1xuXBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB7678.eurprd04.prod.outlook.com (2603:10a6:102:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 15:28:40 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 15:28:44 +0000
Message-ID: <c1540463-c436-480d-a71c-58b6a3125a69@cherry.de>
Date: Tue, 11 Jun 2024 17:28:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] user-selectable wic format
To: yocto-patches@lists.yoctoproject.org
References: <20240611141540.4209-1-twoerner@gmail.com>
 <61fc0c47-d17b-4254-832a-83c4c9d37c97@cherry.de>
 <20240611151313.GB7654@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611151313.GB7654@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::15) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: efee7fa6-b0d3-4ba2-cc81-08dc8a2b2e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZWFxWFVsYkJpV08vWW5RKzluVTFhZ0hLRGd2T3F2YUYwdlZLL2w4TlVQZ3dw?=
 =?utf-8?B?eEd2Y2dZbWNXd0VWdWdISE9SNDB2SU0vWUZLdlFIRmZvUi9aUElXNWVxNHBo?=
 =?utf-8?B?MTVwOFBPbVpHMDB2ZkFWTmtvWUNqVFpJSmt3VFVRdSt5OWhsSk5tYUkyUVpR?=
 =?utf-8?B?RXNmZmVQL0J1QjZncXp2WWdZcFo2OGJ5dHdxd1g2NTQxZHdETmlHTm1teWlj?=
 =?utf-8?B?Qk5rTEM3TDY5U2RFb1FWZVJlbU1LbzJnQllScGxvVUUvVUYrQjVZWW5rN0Jj?=
 =?utf-8?B?b3RnR0xWSFBBY0JDS2lmbVhYajNPNFgzOVBIeU5rODNEcnZLaGZDZit1RXRU?=
 =?utf-8?B?K2gzYkVaQTdkNUhxNi9zTlRiNC8wQXE1V2ZtZCthdzhNVmF3VzdQM29QZGFr?=
 =?utf-8?B?Vkt6bXlyZXpJY3JFQ2k1Tlc2cCtWQXVaei9neWtwSGN2SytLM3hQYVdSZ2tZ?=
 =?utf-8?B?U20rcVpmTUllbUJKZTFKWGRZdHFuNUYrVFZzSG0wZnNzYmhCbjFLaS9XUDk3?=
 =?utf-8?B?YjRlcHE3emtPckN2MWQ1SjFUSGpZUVpJeUFmc05UV2FZZWwzOTNLZWVzRG5O?=
 =?utf-8?B?NmZYWCtQdCs3Rk42Q3F3Rms0VkhORm9CbXJKaEIyazZPYXRSVnp2dmFydnNC?=
 =?utf-8?B?ay90clRDcE5IdEt6UFduT3M1UXM1eEdjMVJ0a0NiWlc0dW0zK3hCdlFoUFJo?=
 =?utf-8?B?NHVuL1Q4NDlLVGkwYitXTGpObFptVVovNXRFbld6cHZyQk1JU1hLZjhQdjVt?=
 =?utf-8?B?TXdqZmMvVkxscjZPUEhiTVgvd2hTSTAzQXlwNmc1ZHVKYnd0dGt2YzduZm96?=
 =?utf-8?B?ZGRnc0FKZnUrL05WVEhOZ0ZpT0ovRUZPcGJjVjhLRW5hSHhVamM0dkozYzEy?=
 =?utf-8?B?MDNQdEtEVnVOOC95S0sxYmdzMjBNRXByY2oxd1JCZ1BqSVJmT01hL0ZsTFBl?=
 =?utf-8?B?TmFMUmE1cjU0R1RHb1JJRUVsbjRYdUpaVENLNlpTd1NZbnE3bTU3cGF3eDI1?=
 =?utf-8?B?UCtQTnpISEplRkhHZElESFZ6dW5kK01iYXN0MlFzeTRpZDJSRXd1ZXUwUjdK?=
 =?utf-8?B?bzRNSk54WTJsb2hIZU1WOVdzK2V0aWRWT0JQM0ZtVlpQdHJwQkFaUzgwcUNq?=
 =?utf-8?B?elFpWFl1TEdqQkkybTREb0UzMWRjaHRZNnRzZVI2ejNnSUY4anVDSmRxeEJL?=
 =?utf-8?B?dW1jSG0yT2ZXajNaaWJ3MnRlTnFyWFVtd0ptZ1VERlBIVDJkdk14SVBnWkcr?=
 =?utf-8?B?TVdVeXdqTURqRzRRa2xqU3VoS2JRM09pN2pyQU5qWktmaWdPOCtucDkrNHNk?=
 =?utf-8?B?L01KMGUxWllPTCtXQWk2ZEd4YU00Q3FaMkNTbm11K1FoSm1ucGNKZXlpclZi?=
 =?utf-8?B?Q0wyc1I1eERNaDlUN0cvY3NYbS83MXNBbWxONmEyL3h2NHFIUmpnWC9MVU9x?=
 =?utf-8?B?cmxma2tUKzNjQnVGdWVHaVE0OXNaVnJLQy9jL0xVUkVXcllHV1QvZHNsZGdD?=
 =?utf-8?B?cjU4NmxhVURJSUpxQkZCMGw4Y3RWTVRDbFNENVhWV3NtMUxFbGFHZnRRRG92?=
 =?utf-8?B?d0RtY2REV1RMM2NWNWxqdzRGclMrTXdlWGVYSm5pQ1pLOXJaYlcwL0p0TEhJ?=
 =?utf-8?B?clZGSmh0THgyRXc1TzEweEw4M3k3Q09aWG5NRVdlQzhHWUFJenI2YlZ2eGhh?=
 =?utf-8?Q?z9kVJqaWZDRjnuRL99Ud?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlBqNDZYa3VIbmJOWUU0QXdyZnZaTlFuSHJIdGtycGZTM052YmtxVDZDQi9F?=
 =?utf-8?B?RXhtQ0JZcWQzdG5hbWdPZ1JVRkl5YzVWUlF1V3NPcXpZU3F0OVh5VWJLQU9i?=
 =?utf-8?B?U1NXQnVQZHBUMjFtQVlQK25mYjROMWhObVQ4VnYyZjBVNFo5WXp5WnYyMEZ1?=
 =?utf-8?B?NGwwWWhtd0RaZHYvYVZuODZJRFRKem15VTZBRzhrMmFobUcrOHJPcXlFZC9y?=
 =?utf-8?B?Y2hLcXNzd09NcFRLSXJEd2ZWam9QenE1S085WGkrY3VnQ0dBbmZneDQwc0d4?=
 =?utf-8?B?VXpuUTEwanAraHRwSW1kSnhXaU40SFFzcWN2VytOQm9SWWNzOUpvT3BuL1dU?=
 =?utf-8?B?d3ZYek0zRElPZklYRU5nS0FKdGViZHFQMFlDbXJXQnQ4ZnR5bTlzRldQVHdT?=
 =?utf-8?B?a3FhM1FtMnliRDdEK3owcE1ldStsVXU1dW9vSXRtZjZvM1BUSnR6bFBibXNi?=
 =?utf-8?B?d2tKc3hGdTUzaEJkbnU1YU1XdDl4RmZtbzhQbFVTcjl3ZjdVZTlUV3VJUWxD?=
 =?utf-8?B?QWNHUGdvZWxXbm1YR3ZQanVBRlhUVldoZk1YY3VQNWozNXZRVjVKNFJZYjY2?=
 =?utf-8?B?M1Y5dlhMRU9GWFZvWFNDUVcvRWR5RndYRlBZb29pS2dzdmg0UEpMeFBobnFX?=
 =?utf-8?B?dndZaGFFSTNzYzBYTk9Namh0RGJkdlVrUXhjQU9vY3NxT0J3d0c2MkNlcEg5?=
 =?utf-8?B?aHE1dFZlNzBYQi9JY3Uwb0dxbVVzekJ2SFFtWU05bjdEUHZYTEpUNkFTR3pV?=
 =?utf-8?B?Uy9lYWcyYTBRamxOYmo1UWZtZ1VlTHAyYXJwSitCeVBxamhpK2F0R3hhckdD?=
 =?utf-8?B?N0xQejBrLzlUL1F4VGFpZU5adlczNFZvYy9kclVJUU1iMUJvT1lJUHRUZ1Ry?=
 =?utf-8?B?amdXakdhQWkrcVRKMXRucnVtYWdjcE4yd1ZrcFJ1ckRON05zU1RJUEpaaFYw?=
 =?utf-8?B?MDF6WVhiZnBwMDNuVVM2OFgvQndnc0QwSk14T2p3eGZXMmZxQzY2Qk5MdGJF?=
 =?utf-8?B?OXVYckpSTERLR09YVis2VVZJNUhLNDN1Y3RIeUJhNkZ5Z0FTb1MzWXBRU0c2?=
 =?utf-8?B?ZzloOUdnKzU2VHVFSHI1c0FhaU9IRS9sZXgrT0tHWUtHMjBDTHBmSHhzcThM?=
 =?utf-8?B?SWhxaml0ZWtnNVdJT0l1Q0tpWWhSei94c2FvVlF4d0xTTVZQeFVoWnVjTXUz?=
 =?utf-8?B?VmZpQWpJR1VBRUUvdGxqMnVSdjRsdnRjLzBjeVlEaDVOUmJLcEkxM242c1Nm?=
 =?utf-8?B?M2JzTTBwaVJhQ2k0bWh0VXNtQWs4VmY3MUhLeDlhOHVlV1puYTM2eFB6TFdI?=
 =?utf-8?B?aGNvNzVXd2tKSDRuUXcrSlFRbTlSd25IRml1ZWo2cUd4N1BoZkJ3alZiTC9F?=
 =?utf-8?B?aTNvNnBFVm9BcngrRFRaNDNXbjFZV3E5SlQxbUMzY21OcWpTQXBOYkVJYVMr?=
 =?utf-8?B?QzB0b0ljVVVPb296N1Q3VUJBOWdqeDh4cTNmeTJZdUllNzEwd1p5RVJqcWZP?=
 =?utf-8?B?NlJ6dkhZUmJDbHNtODhNV3VxTG1vd3BpcWRYNWFjZEFjaXk2cllEampmN1Y4?=
 =?utf-8?B?NHVpQ3lLd1hRTGxUSFFTa0dxY0VqcUQ4bGw4UDVDbWJGQUlra1dTVkgxMVpv?=
 =?utf-8?B?R1BuVS9xR3VOOFNEdjgxcFFxN1FrcXRnYjFsMkZNcTQzVHozejBKVTBjbWlh?=
 =?utf-8?B?SXJtb3YyMG05N04wTFduNFZPTlZYSzZ4a2t3L0pVOTViZGl5bUdHRko2amlV?=
 =?utf-8?B?VjNWWXozazAzKzgrMUV1ZUVnY3hmaFdKN3Y2MmtRaTJ1amYvQnNxNEhmclNo?=
 =?utf-8?B?YjUxNW83MFRYdDJ1UXRSQkdiTVVMZ051ekZFOXgyRVJQN2hmcHlKQ0ZJamho?=
 =?utf-8?B?dVhCS2tNd2dWbDR6Mmo3VVd6a3kveU8wRHpUMlE1OHBaRXp1YnNnZjE5Qmlt?=
 =?utf-8?B?WDliRklHdDNIN1ZnVWhHRHBndEdaR3o1cjJEZ09ySzA2VnRNVUxIa0JNM0JG?=
 =?utf-8?B?L3ExOWI3OVY0MUY5bHlNQkR2a01xN05XbXRYRFB0M0lJUGo4cUk2bWFJTlpj?=
 =?utf-8?B?ZzhJV1BpTGNhZkQ3dURWYmhsN2JFeGFOVnJwOFZkMjB3TzFVQjRVaDhJREQx?=
 =?utf-8?B?L3k5dkVINEJraXV6OFloZlJ3VThnWlAvUUFvcmZFaE1EaWdtS2VOdi9Bamla?=
 =?utf-8?B?YXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: efee7fa6-b0d3-4ba2-cc81-08dc8a2b2e55
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 15:28:44.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTaHYX2yP4JAi/dZfPlc2NyV5Ub1aLKC0nSljp3dU+gOcR6LzUFck5vXKGHjvkDsULBI0e7buf6MSzT6cBG5/M7JTvsUCl33ZLGdT++eYP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7678
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 15:28:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/307

Hi Trevor,

On 6/11/24 5:13 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Tue 2024-06-11 @ 04:31:26 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 6/11/24 4:15 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> Allow the user to choose their preferred wic image format.
>>>
>>
>> Can you provide some use case for this?
> 
> In order to build a wic.xz image the build has to first create a wic image,
> then compress it as an extra step. On a slow machine this extra step takes
> a noticeable amount of time.
> 
> On my local, slow build machine I prefer wic images since it saves build time
> not having to do the compression and since everything is local, there's no
> over-the-internet xfer time to consider.
> 
> When I build using some remote, fast build machine, the extra time spent doing
> the extra step of compressing is recuperated by the savings in transfer time
> retrieving the image from the remote. Therefore I prefer to make wic.xz
> images. Building wic images on remote machines would lead to very long xfer
> times to download the image artifact.
> 
> If I simply do:
> 
> 	IMAGE_FSTYPES += "wic.xz"
> 
> in my conf/local.conf then MACHINEs that don't normally build wic images will
> fail. So the only way to build wic.xz images on remote builds is to tweak the
> meta-rockchip:conf/machine/include/rockchip-wic.inc file. So I'm always
> carrying this tweak for every remote build that I do.
> 
> So I could simply modify conf/machine/includes/rockchip-wic.inc to set it to
> wic.xz but that wouldn't suit my use-case since I could then have to tweak it
> again for any local builds. Besides, I could never guess what preferred wic
> version others would prefer and I don't want to be changing it every other
> week.
> 
> So this patch maintains the existing behaviour completely, and when I do a
> build on a remote machine I can simply set
> 
> 	WIC_FSTYPE = "wic.xz"
> 
> in my conf/local.conf without having to tweak the layer.
> 
> And if others want compression but would prefer bz2 or gzip (or whatever) then
> then can specify it however they wish.
> 
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>    conf/machine/include/rockchip-wic.inc | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
>>> index dab61d83ed2c..eb895cd0b4ad 100644
>>> --- a/conf/machine/include/rockchip-wic.inc
>>> +++ b/conf/machine/include/rockchip-wic.inc
>>> @@ -5,7 +5,8 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
>>>    SPL_BINARY ?= "idbloader.img"
>>> -IMAGE_FSTYPES += "wic wic.bmap"
>>> +WIC_FSTYPE ?= "wic"
>>> +IMAGE_FSTYPES += "${WIC_FSTYPE} wic.bmap"
>>
>> Would this be a way to NOT have wic in IMAGE_FSTYPES? What are we trying to
>> achieve here?
>>
>> If so, shouldn't we also not build wic.bmap there?
> 
> The goal isn't to not build a wic image, the point is to allow the user to
> specify which type of wic image (i.e. with or without compression and if with
> compression, which one?).
> 
> I guess I could do:
> 
> 	WIC_COMPRESSION ?= ""
> 	IMAGE_FSTYPES += "wic${WIC_COMPRESSION} wic.bmap"
> 
> And then specify:
> 
> 	WIC_COMPRESSION = ".xz"
> 
> in my conf/local.conf?
> 

Thanks for taking the time to explain your use case :)

I was about to suggest this :)

Should we allow multiple values in WIC_COMPRESSION?

Also maybe it should be named "EXTENSION" instead since we have the dot 
in there?

Additionally, I don't see wic.xz in IMAGE_TYPES in 
https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/image_types.bbclass, 
is xz really working? If so, why do we need to specify wic.gz and all 
the others in IMAGE_TYPES? Maybe we do not?

Cheers,
Quentin

