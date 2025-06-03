Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04509C5AE59
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 15:52:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.71])
 by mx.groups.io with SMTP id smtpd.web10.15214.1748965926575853789
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 08:52:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Ao9IdYKl;
 spf=pass (domain: cherry.de, ip: 40.107.159.71, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X01DSOdL2DTVGvpCIk6ZueUEb8cP0MrMd3dgtWaZjUWBoctseSJ1zFFiJNbmqwlYy6J0QN4Ae2GZusPdZhiuVJpsT29Ws1u51V5ZeGmvCdt+5QJrRb6mObF10bzYX3niZe6miN9X+EQTiW21QdveenR88jUepfxkIgRcEen0IXmHJe1AIuxV1QD+KPtnDn4YeaabgPeJX0EhNtVFMMznUMyh1C+0n41XOcbt2u5YLwDbmJK38WTzvuqR8mSUAZyk/gb6Kk1jCP4qBDu0kNLv820JxP/X0HaDmClQGurO0CSg/vua4ulWq/H5Tz2B5l1rfbDhTm/NWRA6u44CgwHxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWka7hkITUyiXGBJNRA+iuvKxnxyal5mE+cqRjQ54j0=;
 b=e69plEVhep2l3RE8Bli8sPrCIDBf0/kiiiewrtqQ098CoWOMcNmyV78VN58UvVgIuJz4rKIGdPJLMfXRw4n8IWLyEsKETiI07cOQ8M9Ns9pf2X57s6KwovpSKF/GVJNsuz37+Qn9JkMtYxjcJevPGlpDksbHL2zYZMeQ3wTMUNwCcUl56pQihchLiwXr9Zgkf2MxgPUVSxyUf3XfyfQqd5Zl6pzyPVvv/80gN+MJ3Z/PspU/SmU6EgZ/B8lKiBm0kjcXqcc3gqUB3xEzx/ONwm1HJ7vBWl/locEWa4iku3d8qqZeAUnWUfJm7ZstKpgehvD7Q3CDUzLE+C+XNrdwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWka7hkITUyiXGBJNRA+iuvKxnxyal5mE+cqRjQ54j0=;
 b=Ao9IdYKl/hVgV1H7otyRHeLqFa8twYxt3yxO+8Ze+DqxK5YAFQ/K9JpH6tcgxwX+vyYuwRFn/9URFlti5Qth76oxy3TK7ViqXRZIM8j5ba8BSJm8jaPId0UnxV58YvHrwITxqDjq3nFWyvn9iq+jJiBxBfo0EcbWqQLDXV+EDHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 3 Jun
 2025 15:52:00 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 15:52:00 +0000
Message-ID: <1f601696-1ac4-44e3-9ab1-ada5ebb453d0@cherry.de>
Date: Tue, 3 Jun 2025 17:51:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
To: yocto-patches@lists.yoctoproject.org
References: <20250530172156.7199-1-twoerner@gmail.com>
 <2c631d6e-9296-4c4e-bcf8-13add7ee8ddf@cherry.de>
 <20250603154627.GA31087@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250603154627.GA31087@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0170.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI1PR04MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9319e8-67b0-4ef5-8d45-08dda2b693fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QjcwUFJmSGJYRzZUaDZTRWF4MVh3VlYxTHpxYTZ0QXpUSGhETG5kWnUxeVpq?=
 =?utf-8?B?eFU3QVdZeVFJMVRER21QbUg5NlBsRjZQenZTUTZUajhLelM1Rko1eGRqc0ht?=
 =?utf-8?B?T3ByRG5ZMFgxZStzeTVhVUxjcGYzZ3oydVpkTXRsWDdBUXVLeS85VEM0RW9Y?=
 =?utf-8?B?K2RzMSsxN3VQUnZnejBlU1ZpLytzOEMvZmJqMUkycFA1MzJpTlJxR0V4cXZU?=
 =?utf-8?B?WFlQT3FFdit4MmZjNjZUczU5WnNjSVhDcm04WkVUa0xMUElSUVdrK1pRM1lk?=
 =?utf-8?B?YTlXS0VhSzU4azVJNkVZVnZiakxlaWJKM1pUZXhkNC9EcWNYb1RaR20zamxD?=
 =?utf-8?B?blVYVlRId0ZQNzBONW1haHAySWxobzhpRFQxRXpOME5IeERiZ2x3ZmRid2pj?=
 =?utf-8?B?a1FYcWhSb3dDQ0JCWHZqZ0NGM1BPQXRxUkl5MFprQ3BVK2RHdTlISEZxbFRY?=
 =?utf-8?B?MmxrV1V0L2dWWWhVRmNzOWJHQ3NTUngxQ0xwQ25nVkszVCtnNVRudGJ4TEpI?=
 =?utf-8?B?S3oxblZucjFXQlRnNzdWTDJLNGFvREVxaTBZMlpiWmRLeFhTUUpSclBPODQ0?=
 =?utf-8?B?aWJZaEpqQmZJaDNncWhOdDBxRmQxTm0xQXQ2RSthWXlISUlZZCt4YmpxMUVv?=
 =?utf-8?B?elZTSWRVSXgvZDM0VE54cDlBN2xISURaRHU2Z2IwaGJEZDNOaXQxdVZGZ296?=
 =?utf-8?B?NkNaemw2NVFlcXliMy9sblBEc0tHZ3Z4NVZUK2RiOFZwMFBQSWI0anRDY1kx?=
 =?utf-8?B?T0pReVZJZExuY21kZGdHd3U4Qmw4UDFTdE5MZFpiVTVNWGdBWlZpV0M4VCtj?=
 =?utf-8?B?US9xbTJPcjJhRHBhU2lRNGxLcjllNkZBNW9kTDZNWDVJM1FJWDg5b2djN28w?=
 =?utf-8?B?WVBEVktWU2hGTi9YL254OFQzeXVRUnprMDk1Y2kxdm8rSm5KYTJQQzkyZ3NY?=
 =?utf-8?B?TkwwcThNU0VPaC9UYUhCSG8waDBjRmRna0E3NjNwZEwrS3J5cnk4NTJTcXpY?=
 =?utf-8?B?OUJXb1gxQm9wbFhZQVh1VFUycmRwYzh3OERJQUtZT21UVlBraDZBY1lVOTcx?=
 =?utf-8?B?NkxGd3pRdXRkSkIzaDVOUE9Rc2ZHckduNFdSOTE2bGdwanBYdFl0dC92SjJq?=
 =?utf-8?B?aytpa1owUHFwVm1MUXk4ZDVWY2dhQ3MrcmdNVVlNeGNUd3lQckpGampRMVJh?=
 =?utf-8?B?N04rUURDN0l6V1NrRnlCUllIMVIvRlZEb1dkZW5uYkpQL1g4NTJOUE1hTnFr?=
 =?utf-8?B?WXF6VUplbjZjYmVyaEZDQkxZcGdKV1hHcDkxbTFJNWpHa3pjMFVxeFFnNFcz?=
 =?utf-8?B?UG1NelhDT2Fnd1hiRUl3WDFOdjQ4YWQzZG9GWDJ1ZjRSS1hzNlFodklRdmtx?=
 =?utf-8?B?alp4ZENMZm1sakVnbzFrTzlmQ2VNZ1JOUk16OWl0V2k5blhtY3hUTUl6NkdH?=
 =?utf-8?B?bWxVa0REc2lLdmwzdGV3TngyN1pHeTF6YjRVYXUxb2JMaS9tMXFLOFpqTzlt?=
 =?utf-8?B?YXRmeTN0cEhoL1dzOXV0bUVzeGNyRHhOaEdTa3AvWlZtQkIwRFJrckhTZDBy?=
 =?utf-8?B?Uk9menpNYktvekkwdlB4b0JzY3JHQ0MrNjk3K0lJOWFRVnJtcC91V2ZvUDQ5?=
 =?utf-8?B?L1JxUFlia0tlUkRldDVGdzkvclRzTlh5cXRIM21NMTRac0I0ZHlLN25IaDcy?=
 =?utf-8?B?OUFtZ1laSGxMdktLT2tra3lMWG1qZy80ZkdVZnVtOTBJanAraUIyOTR2NkpC?=
 =?utf-8?B?UkZNcXNaVUFWVFkweGU5c1VvM0FaZXVjN3plVXVvQVZiVkZHNyszYSt0RkZ0?=
 =?utf-8?Q?ag/hbVDIrrckxVPhlssmwCDxR+q8cFOT/LW/M=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U21SRE9ibkEwRXZyQUdEVCtMYlJEZjVZUUtraUVBcFdIaTdFbFVBbjRVUFZh?=
 =?utf-8?B?YllQcGNoWnRrOU9TUFhlYlN2ODZxb3JyYzhsNlloZnBSNnA0WlB4ZDBzTzRp?=
 =?utf-8?B?YXMyRFcvclpodWxVcWpBcUNmODNmYkcxalJ6UmpXMHRkNVhpTEgzMkpUZi9O?=
 =?utf-8?B?b0hYQWgxVkwrTVIxWFlYMTNXUm93dytCSE9RRk5QQTc2QU1pMWt3VzZKbUJo?=
 =?utf-8?B?T1BYU0JpSEpheUluOFdXRTVrbmFGRWNhWFQyeXdUZjd2c3JGWDQ2RFVscmsv?=
 =?utf-8?B?VGpzaDhnbGkxdWU5b3JacWd4cy9URE5pVGpRRFl6UmpsTCtRelFsamxCYzA5?=
 =?utf-8?B?Y0NpWFFFVDlRbGZFck5uODhsTHBNY2gvbU1tNVdSSDUrKzZUOFVMb01ZbTZq?=
 =?utf-8?B?OUovYWJqWnMwUy9BNWhBY3Y4QmMzaEZQSzQrUGZJM1hwOExpZnZPZCtsTXZM?=
 =?utf-8?B?aFZnUXFrL0svK3h1VHBJc3MraFVma2x6WjZlWElQNlovbUNpWFlnb3VIZVFl?=
 =?utf-8?B?SG9xVk9BT2JLQ3FMQWtibmhsajJNYWkzUWQvZUdMNmRQWW9ObE5lelM0dytV?=
 =?utf-8?B?SmoyZnlZeHR6STZkcFZabUhUNjM1RTFsemlQaW9ZYUVLcUFJUFpsc2xlOEds?=
 =?utf-8?B?TXF4UFFieUM2UGtDU0xFOVFwK09vb3NIbms0d2FXWXgxUE85c1JtcThsWE1H?=
 =?utf-8?B?Y0I4QnlUdU5sN1lqL29acElKTUVwSjdobHVIaWxKang4SUFJbUpRZGsvcUxy?=
 =?utf-8?B?N1dqRXBUVXlWOWtBbEFNRnlaN3lmd2p2clVZSlN1ak9TSkdJVFhObUk3OVha?=
 =?utf-8?B?UEJ2VGdEMExFeC9sU1VEMWNTVEp5alU4WFdvTkJaRFZ0cGt1bFBhK1QydUdR?=
 =?utf-8?B?NnRwUURLOUJTNmtyNkhucVUvQzBjNmx4RVVsZGxia0NpYVFWcXc5QkdhVU80?=
 =?utf-8?B?Z2I4dk1xVGREeHlCVnFtRzVPeG9FNlpKMHhMTWl3ZDkwSDduSS9SeEE1ZTJC?=
 =?utf-8?B?UWxlS09jMFc4SWRNRnIvemIrVG5RVmpSZ0Q4eTcweTBDdDZEdlFkL2o3UHBq?=
 =?utf-8?B?V3A1M1h0UHY0SlV4dEttbHBlUE95L0xuaXVueENjaHlqWmlDNjR1Ymd0eGxC?=
 =?utf-8?B?Z0FtUldnN01XVTVIMy9KbGpxaVUrUFpoK1luY2Y2dDhMRTdqOVJ1WUJENHpx?=
 =?utf-8?B?NlFGT0N5WjVqRWFYQnp4UEo3Mk5OY2UzYmttalI5M2thOS9FTExseTlzTlZo?=
 =?utf-8?B?WWtsN3JJUndjL0hvSk5ySGVKc3ZZUVAvb01OTWFSWmd3bFRuUndjWm9lZUxv?=
 =?utf-8?B?M1NqdVJIN2RKZE9maWZJdThGWEtuVlhkQTB5dkVzVEVuK2toUFU3QlNCT3d1?=
 =?utf-8?B?YnU0dzhQcGJldjcrUVNlZEdxQTE4YkFzOEJlbkR0cjY0b2Q0WVZ1NnZCZjU1?=
 =?utf-8?B?bWJLVDJSN2RZZmVYSjN0ZXlFSUkvTlZMbWxWNGdFWDZ1SXVnWExvZWQycHpi?=
 =?utf-8?B?ZVR0djh1bEhXZmdCTENmNyt1N0dmTTU1THpFMGFtU0dTeHV4MGN0ZEhJUjM2?=
 =?utf-8?B?V0xsdWx1c1d4TmJ1M2t0TXlnSjdod0dObVZkY3d1ZGZ1bFJYWFNlblZLai9p?=
 =?utf-8?B?bDdTVVNZNEZUd1VHT2VsSzd1Z0Zub25nV1J2a2FQeEVicEV3OWJFSHBMdzF1?=
 =?utf-8?B?R2NqcEZTWFJMN0pyclRYVTVmcjJDS3pOcWNDSkh6eGlYdFVnaFBvWDJad1Qw?=
 =?utf-8?B?MEFQQ2Rjb2tjbXBEbnZXbDhwcThtRzF4TzNCdmJOQUphdHdCY2tLOXVGM2pU?=
 =?utf-8?B?b2g0WWc3RzVNQ085V3ovN2YrWnE0bElZTFM5ZU0rUUhyRlJEZVVxR25xYTQy?=
 =?utf-8?B?MHh5WVF5bFdPVW1WcTZlQmdQdENHZ2U3RTdlUS9IVnJhRjRTOGRrekdGc1Nw?=
 =?utf-8?B?S1QvVHhmLzN3OTFSemk3bFVNMCtmMTJtdW05TG9OdlQ3ZUp3bGs1clZHSGFL?=
 =?utf-8?B?N2tabDNMOGxDeCtUZmRMMHV0VWcxQlFJSGdORnpkeGordHBJMkVES1pIYzRp?=
 =?utf-8?B?TTZQZnFua0NsSXdyaXhkcjdVNWdLQytqOHNCLzV2SUpzRGhRS251UjEwRmJ2?=
 =?utf-8?B?T0V4Yi9hL3FiRWNsZnZsNWZkMHE2azJxNVdyTExCVFdZUkNONnV1Smh0VXlX?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9319e8-67b0-4ef5-8d45-08dda2b693fc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:52:00.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RejIMbrI1S/VnYI1rxbP0LnthrSUZ0A5tRZsqmGC3B2KcyqFWM9QQUlyDC1Dl6mX738YYFWsh0Sy86AX8wBbBvYETuKfvqJUdAyVx2Q4yOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 15:52:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1611

Hi Trevor,

On 6/3/25 5:46 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Mon 2025-06-02 @ 02:39:58 PM, Quentin Schulz via lists.yoctoproject.org wrote:
[...]
>> On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>>> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
>>> index f22280754a14..9e9bf9afc4a0 100644
>>> --- a/recipes-graphics/mesa/mesa.bbappend
>>> +++ b/recipes-graphics/mesa/mesa.bbappend
>>> @@ -1,9 +1,4 @@
>>> -PACKAGECONFIG:append:rk3288 = " panfrost"
>>> -PACKAGECONFIG:append:rk3328 = " lima"
>>> -PACKAGECONFIG:append:rk3399 = " panfrost"
>>> -PACKAGECONFIG:append:rk3566 = " panfrost"
>>> -PACKAGECONFIG:append:rk3568 = " panfrost"
>>> -PACKAGECONFIG:append:rk3588s = " panfrost"
>>
>> It seems like this is based on my Panthor patch series but it isn't
>> explicitly listed in the dependency of this patch series?
> 
> True; what's the easiest way to express this?
> 

If you use b4, 
https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies

Otherwise just in the cover-letter say that it depends on another series 
and then provide the link on lore.kernel.org or patchwork or wherever 
someone can get the patches :)

>> I'm fine if you
>> want to take over my patch series, but I guess it'd make sense to have the
>> patches (even reworked/squashed/fixed up) as part of this patch series now?
> 
> I was just going to add this update (whatever form it takes) immediately after
> applying your patches. Your patches worked at the time they were submitted, so
> I'm okay applying your patches on their own, then adding something else as a
> separate commit.
> 

Meh, they don't work at all anymore, so the pedantic me doesn't like 
merging patches we know are broken :) (but I'm not the one hitting the 
merge button, so that isn't something I need to worry about :) ).

Cheers,
Quentin

