Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C040D2F7D5
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 10:19:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2560.1764929952061662020
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Dec 2025 02:19:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EDRTo4Wh;
 spf=pass (domain: cherry.de, ip: 40.107.159.10, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npq+RUsnWZUmf6flVfTlP+fqF7iNvJj1QfJQM/Bm44BuJ1qZw2RpLMfhx4Dz8gM1E6v+A7QJLHN8KtNnZZi5lwKNZIJy3NXiFJCp/iP2yCdLnmur37jApW9OQK5POA3CMgtSgt+Egnp2JyqQyVPr3d5XcyCzVIhoU0T4NJ6TLIAEwV4ILsozhyCbKJU3BBIKLuc3upqsPcwis5vhkIdN5TdBTzgqOb+id5mAh6HQlhtdyz6UpOBIgTtl5N/Ber4n78r7GDx8N2DYU83Go9Y/lqufp8yYShAG5p1KYlfV/vm0zoiPVPGL0cERLofIOyiBqvdMojfNvcYkTHjJkxGrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNZ46ThmwtFyFB4D7MpzYbzoLvj2zjsBuKJ+qqe38To=;
 b=mv223/MMbMYRn4IMYkcaxiHBOCNbY2NVWF6yv831bw8Z85l/bupRP2tFsMH9wqyHGSlgcwdm/3dtn2O4PreIbkj++c0545qyt9t1tcpHUdzI4SroSZ/w0dGLSwDGRchmeCes+s+vs9rEyca5BgsDkTStxgclcqkEtEXFz3J8OK1qwhsfPTpoS3rDEekKo35SJUGcLuvlum3w8f3S2Go6IYIshPKgwhMF2Ta3hMSpQ37h/t7Y/guoN3VeU18WdwbfyHrFOxyEcN2ADCK2Qk4Bo1WnMMQWaMxfzgeBWGLCsiSfybAEiXlaBtRF15c5cPrU432jFduJy+yUHlAGlnjS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNZ46ThmwtFyFB4D7MpzYbzoLvj2zjsBuKJ+qqe38To=;
 b=EDRTo4Wh1W94x0AVvxwIwoZswa7Bw+7Ta8q+8R0qzLll5JRS4Yrcl85q2wui6DCrMAokd+lyn8JNEhogFaCJMxSKZkNxunsrQbs87iIJfkZWgNhHwGTUxyQCgxfh/5FteelzfjS03J6zVXHd8dY3037VPvJf5FHaa3vRKCiTl2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10896.eurprd04.prod.outlook.com (2603:10a6:150:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 10:19:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 10:19:07 +0000
Message-ID: <b7a6d600-2459-4a69-9f6f-d6e014ac2f1e@cherry.de>
Date: Fri, 5 Dec 2025 11:18:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/2] make rockchip kernel
 tweaks easier to use
To: yocto-patches@lists.yoctoproject.org
References: <20251205033715.8852-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://quentin.schulz%40cherry.de@outlook.office365.com/Sent Items
In-Reply-To: <20251205033715.8852-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10896:EE_
X-MS-Office365-Filtering-Correlation-Id: df1024b9-c2c0-47f6-8a92-08de33e7b990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZWw5bUljZUtmeXJTZlBReGZneE51dWlBRDRhRVpGMlV1TXh6ZkgwSk5EclBl?=
 =?utf-8?B?L2Nvb2htQ3hzNk9jSTYybHBvdUhOVWVtYjZUMHJ2ODRLc25MY0pnMWM4Zy9w?=
 =?utf-8?B?UFdQcm9LWVAraGtKZy9nWmV1cEZvdHYwOUtta0RxbnRScGVvRUJtamp5UE0y?=
 =?utf-8?B?cHJveWhjTnpnZGhjVFVuaURiOXJ3eDJzdGJtNVVMWlJNRHp6SS9vVDlwc0VB?=
 =?utf-8?B?ZlVPR0MwRzVITDhaelA0dW0zd1lPNVFIejVwZE5ERE1GU0VZdDFYc3Mrd2lX?=
 =?utf-8?B?a25DSVlzTmR0ZU1aZGtZNFhCMFRCczlYUk52VmRuU240Y21BQURvODZpbjRt?=
 =?utf-8?B?VHlYc0VwNTVzSklYR0JGcTVKb1dJT0RBaGhJUmtWNXd0YmUrSlNRemNsK2pV?=
 =?utf-8?B?REVjbng0aWVKWGUranY1Nm9BUFpsLy8yaUp4TzlkdkpnUGpXZTA1eSs2a0U5?=
 =?utf-8?B?ZkRZdC9Wbmk1Mmc2STBTRVVKQml5VUF1dFVvcmdkVUVpY2FQYm11SXhmNWtT?=
 =?utf-8?B?RngrNTY5VGNNOTJWNkVzdXZvS0tiQWxmR2FiM0w3dkhqTTBSYnZENlNFQ2VJ?=
 =?utf-8?B?RThJVWhmTEV2RTlEaEdjaXJYRloyRThPTElkbXVxckZtSGJHa3ZiQXN2R29i?=
 =?utf-8?B?YzBBNmx2QmpQRjRObkt4MWR2UXIvWlJ4dDd1dVhMM1Nnd2pubk1iSys4OWsy?=
 =?utf-8?B?MStJUTdVZUE4M0UrcTZiZVBYWXBaZW5HL3Izb2JlWVg0eUFDcGdUcWRteWV3?=
 =?utf-8?B?MjhTYUFtZE1HNFpEaU5uUkZiSlZsazRoUWlHRFo4ZFVTeUxTUTMzM05BV1VT?=
 =?utf-8?B?alpad2ZFcEtyejRtWTVKWUtNNWVaMEZjb2FHSlJiTG54L3pIQ0lvRVYwNGlC?=
 =?utf-8?B?R09MMmp5UmlSM0ZCOHRKOUY5Ylh6WUdBZGhORjhVdW5laEJVRUUreXNvNi9C?=
 =?utf-8?B?WGNYSmxvcW5zOWxsaVZJRlRFRFhjd2ZjOUptTngyR2xoNVAzYmxaTHdmaENo?=
 =?utf-8?B?RDJuNUtWanlMYjJXVG11T3hFWU5Zd0xXeG9UU3VLWlFPaG52SnB4ZzJiS1NL?=
 =?utf-8?B?SE5ldzY2ZENPdXZkL21qSFYwK2gwenA3bnRxa2NvWEp1MWgxRlRRWmdyWmdv?=
 =?utf-8?B?ODNoTjhyVTYvSmRqNnR1WWNUbWhlQXZHYjBzcXd1UU5WUDZSVnQrRGhXTjh5?=
 =?utf-8?B?elNkRkNITmt4ZTZrM29wZnAycW0xbnB4TUxmY0l4dWxpL3VlMXUxN3F1cyti?=
 =?utf-8?B?NllGT1Y3a0lDUnRkMkRHM1VTb1VmUm8wVkxxRXhhQ0V4cFBRUnJxV0phRUVl?=
 =?utf-8?B?SkJvam1rWjY1ck8rMHBwTnlRZ2ZHS1VpQS9YVUQvaGU0cHR2Q25UWlc1bFpu?=
 =?utf-8?B?aVlhVGl5YVhFZENVZCtlN3FyRzRRUFI3N1M4VFZqMzVrdng3SDRUZnE1OUd4?=
 =?utf-8?B?UFpsSnU0ZU5LU05VZHRydlV3MGhKcmh5YXpTaUswTHA5Wk1wbktHTnRCMWM2?=
 =?utf-8?B?OE9TaUZScy9vV1A3bDFlR3lYbDdkOHg2OGM3TDMyNXpPVTJ6VkdwaG9TcWg0?=
 =?utf-8?B?VGE5OVk1bk5KUVpxRS9xeVBaRE5ZNndsYmg5cjFuNm8vWDd4SnpBaitCeDJH?=
 =?utf-8?B?V09jVGd6ZGV2Z3c3Y0FrNkxiUExqQjZQNHRzN1Y1QzZoOFFoTzVLVGNTQ0Jn?=
 =?utf-8?B?Ri94YlBkTWxTOVQ0WExETjk3QkpMRUhmWVdBZ1AxclRMV05PaXhSMlV3VkE1?=
 =?utf-8?B?QTZ6RWNVQjhhQndxeTBxVlJoQVhuU3FjNE5aZkd4a3BOTXdJcjM5emp0ZWFF?=
 =?utf-8?B?ckdXVTI4T2lmN1FRaExIU3FFSWo0eVlMdHRqY2VNMU5SOGFJWGJ6N0Z3WjZK?=
 =?utf-8?B?c2V4ay95NFVqblN4dEowaFF3bW4yWmFjbmZRaTQvZDM4Q1BUR0R6Ulh6bDVE?=
 =?utf-8?Q?yb3deiN9RtSTuplr1XuEfre/uJE/cCTs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0FqTWhidWcwYUJvSkJUWkhsN2JQU3VJUEkvZ3pQWUtna25CTjY2ZHJvL0pP?=
 =?utf-8?B?MkhPVUJqWUpKN3pFSVRocmdKazJ6S2IrcWFSdWNEMWNaTWN4UlB3WG1sTEEw?=
 =?utf-8?B?US9mMHhpUFBtUjdFUnlOU29XNUFRYXloQkI0TGxVSEdlN2ovb01mV2ZqNThp?=
 =?utf-8?B?N3Q5S2ZJMk5WelZnU0VWR3dwZFJCOSs3T3QrR2JJeVRVYkxxUzVpbnNCZmRM?=
 =?utf-8?B?bDlKS2VkSEEvaWlqVXduZzdWVjBoa3R2NnJJOVV4bWU0WlFKcHZsMVFidS8x?=
 =?utf-8?B?SnZYNFlzNzY4S08zZmtBcDA0QSs5bUV5WW92blNhVFFVVWxDa1prSUczZmor?=
 =?utf-8?B?cFVpWFNuUXRvaFBPQWFTWDl6cDZSbVZLVlE4NG1tenk1SjA3Zm1Jdy8vd25W?=
 =?utf-8?B?aFVjMTl2ZVBQc0lKMElWaWxTVnB3ektEdGpCTHVDK01nZlZXMnJ6QjFIc2JP?=
 =?utf-8?B?M1doVEhlUWpaaytML0kraGxSYkJmMGN6OE9aeG4xdGZmcVdWRHd2Z2Z6VFhK?=
 =?utf-8?B?ZXQ3SEM4aG5qNTdlMDRHd2NNdWlvTlI0ZEU4Y3NRR2dyQ3EwMFU1blB1TWov?=
 =?utf-8?B?NGJ1U1JqOElMWlQvMWxtOGRHZFQyZEJaNzNTQk5JdFBrbkhSRi96WUVFZlZ2?=
 =?utf-8?B?cnAwVWtEYWNEbURWTXIrQVpZYStvWTI1Y2xNN2ZVOHU3UzdPMHh1dXYrZFVK?=
 =?utf-8?B?NTFZZ0M1NW1Sc0dPYkp0d1JLcDVFWU8xVk4ya3FvUVlLUmJyUW91OTZiL0hy?=
 =?utf-8?B?dG0zaEZBdjZJK09nYm9ndXBIY1lPUi9tbWJ1T2VacHlNVklMdmlJWFhSbG5p?=
 =?utf-8?B?MmNDcThQWkZRYWhzTUJBdmNPZ1VZbFQ0L3A1RmM0c1dHQ2Y3SFlsYnluamJk?=
 =?utf-8?B?b0swaXI4eS9SSys0c2dVeW1kdWRycWlIZDVYZnZweXJDcUFFcUZiWFcrQVFT?=
 =?utf-8?B?ZGMrS0Jucm56OHgxREJOU1pMaFJyUzQ3VHJFMC9QZVBSSktyd1M4YnBvcEZT?=
 =?utf-8?B?NnVwaytxVDRWZDRkRmI4Q1dYc3Vyb2Irbk40UXVLYnJrZ2E4SFV1RkxzQlZL?=
 =?utf-8?B?dWJ0ZG8yODNSV1E0SVhHR2hsNG11MndtTGlMTUk2SzMvaEhPRVo2dmI4QTRh?=
 =?utf-8?B?Sks3b1o0MnVKdmxzMzAyMEE4Z1BjQ1doN0JsVnNpOHpMMGlzQWVVbHoyaE9h?=
 =?utf-8?B?c1RuMEtpc3NKMjRRR21MeTRvV2xXZEkzTUhEekhWbVhCbEVXUXJGRG5FZ3BH?=
 =?utf-8?B?QkIrK0lHaHMwcERod2Y5N3FudkdCMXk5L0hIc2ZiSFhxblNiVFk4OFozWnRp?=
 =?utf-8?B?SlRsSlQwb0xpdEpnVS9zb3hNd1hGaW1FN08xTGpsZEhVNVdnWkhmYjBwUUZR?=
 =?utf-8?B?N0RkZXl4NExpdE9zaFFWWmFJSDlvc1NzOVpxUXJrbTNMUjU2bGJPRUptS1h1?=
 =?utf-8?B?aWhkMkdyTFh5TW5oWUJWd0wrQUdnbDRYZDgvZEgzWjdtMVpzdk1kaEtJdTY4?=
 =?utf-8?B?a21lMkUwQmt4eUhwRWZKNG9xUi9JTGsxUnNPeXQ0TEV2d1hjRDBtZzdFenhl?=
 =?utf-8?B?bVBjRmo3ZXFpR21tY0pieUs4UlVXUU1HRVplLytVdFJpK1ZETUpqK0loc2FF?=
 =?utf-8?B?SUYwaVhpVmF2T1BqeUhIT3ZkRHNoSTJ6eE5VbHNMY2tLLzVWdGcwK091cGN4?=
 =?utf-8?B?ZTloVXdGeEVWVlBiQ1Jrb2dxWGM2UlB3OEl3OEhyeHdCaUZGSC9hOHBRWmhO?=
 =?utf-8?B?MUFET0d6RGZGQ0lRN3ZxVy9WcEN5a1MwbWVHcUEySTZ0dlp0M1M2cnpRempk?=
 =?utf-8?B?eUdra0NDaVpLS2hMajVEV1RPT0hpVUVoZmNYT1k2V2NIZU9nTHpiSllQK2g0?=
 =?utf-8?B?andZZzVYWTdtQjZWNXpVSlJsQUlwTXVTKzdEbFl6UmJBMG12REtRVW82ZURx?=
 =?utf-8?B?VVdlZDFNTm5IWU14a0V5NTRqWHA5OTRWdWRXWS9VWW82cUhkTlMwTVVWMDE0?=
 =?utf-8?B?bXNrSUs0b3IzQkY3Ri96MitYOWxaemtHL1lnSWRkR0tSbjkwNjBOU3RuZlpU?=
 =?utf-8?B?ZFFDVzNaZ3Z2OFV6bzdCV0cyNzB2V2pqZUtWMnBvSzlJSk1RQ1I4QVFkWGVM?=
 =?utf-8?B?ck5vQkxRNU41ajZyM2M0SUI0VHVoNm00ckFKY2oxNENBdHZWWEpoWkp6MXBO?=
 =?utf-8?Q?DZ/b4MVP5Q3n9DLfDPdbf9E=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df1024b9-c2c0-47f6-8a92-08de33e7b990
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 10:19:07.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGnNEEObePWxgQSBjmjfSoP32suJ8uMggI0FootMfUsXaAfH13ZDm+mfyy1kHmq/mYAac7s6UX9+ievK/lrqln7lSn4vf/pMOOKTeFgVOKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10896
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Dec 2025 10:19:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2741

Hi Trevor,

On 12/5/25 4:37 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> If linux-yocto is used with this layer, these rockchip tweaks are
> available automatically. However, if the user wishes to use their own
> linux kernel recipe, these rockchip tweaks are cumbersome since the
> MACHINE definition wants to include them. Reorganize how these tweaks
> are provided to make them easier to work with when using custom recipes.
> 

I don't understand the issue here, specifically the "these rockchip 
tweaks are cumbersome since the MACHINE definition wants to include 
them" part of it. Can you clarify? The change looks zero sum to me so 
I'm not sure what's helping here?

> Nothing needs to be changed when using linux-yocto. Otherwise simply
> provide the following line (or something similar which has the same
> effect) in any custom linux kernel recipe:
> 
> 	require recipes-kernel/linux/linux-rockchip.inc
> 

Are you sure this is a good idea? I'm not convinced having config 
fragments spanning multiple kernel versions is a good idea. Not a 
blocker though, and the patch does seem fine to me.

Cheers,
Quentin

