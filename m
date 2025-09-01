Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9621CA0FF0
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 11:56:09 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.24])
 by mx.groups.io with SMTP id smtpd.web10.49406.1756727768345197857
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 04:56:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=cMYmAkd5;
 spf=pass (domain: cherry.de, ip: 52.101.83.24, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhIibbatn+Sw2C4mmOOxzVR2JxQP3n75XzAJsah9LKuWwgEtatqcPCjeXt/edtOPZt6bHVKQ9wL/yFG1izxvJRoADAwXMRUkpbuNB5fnEA+c5Lx5E5YSf1OrrhChjKdRG0mYO26XBfAmboMEslwL8eGCx0/9G3bdGEt9PhhA9gClJvSsO0oZX2KF1pY0EEqBDxuhULMFMiW8EzQfhn+Y1DJOnk746sUImqFGqAFq/YwuoOE2JIRPeHXLxGrSjBXNOPXBkZkSL5SMBf8jpjVELdhQaY4CLtECBCYjXF63ApTCuO3Qj4VdpsK1ZdKdI1hlixvGHPWIox2tTVxQ7DuXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1+3IoCvO7MGPXIeMb6R/Ao+u2Qzo73v54DNLdV7kqs=;
 b=Ra2ezr8FXVqEo7WNJ/mJ4ENNRgWHC2oD5ugU/IVWQayRyfQVuPOihLO4HiWqm05HYPXyeU/JpvdOxz/6S9pgOFCPfxRWFhYs0zQuT1DKN0QuGS0d/YuJl9/B15AtigK1HRbTR80L9L+v5Ru+qSzeJkkYFnkwRav/cznMh//ep4zN5PNiAVsnzTekVf73iQ5UY+bQu9lQPH9q+vbxY4zsIFhOvvSOP/aG3dA7k/ubkVF4cw3tlSaAKgHmVyqnEufyqeAq3eQKRUpROsvlTlYmGUAS9OKf+MQAVjhoLzVx7D0cVZ7TNLSJ1JwnJmwMMSh+wZmrdGfPGJzgbb55re97xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1+3IoCvO7MGPXIeMb6R/Ao+u2Qzo73v54DNLdV7kqs=;
 b=cMYmAkd5BR6LRAeURx8FUkwEiJo9cN4DFq3YOAvMC4+WyUu2CSicREGyeQM6IJRrKnVGAbKkvumddWqbQqQ11GS7ZxdJnX8IHjX/zqmTttxyXBGPEFokgL9hwkKuA5aq/rb6jCELa5hJBqN7R/hA1fR2+n9qvmklkKb1Zz0vF9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 11:56:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 11:56:02 +0000
Message-ID: <210a351c-7b46-47bd-a3b4-533a7284ad2d@cherry.de>
Date: Mon, 1 Sep 2025 13:56:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/4] linux-yocto bbappend:
 sort
To: yocto-patches@lists.yoctoproject.org
References: <20250831114105.27494-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250831114105.27494-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a092b3-6671-4831-2057-08dde94e85f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WjUwNlp4azJlNHlqUjYrT1cxNm5veHc2V3VoR0crb2JrNEZudHhoYmEzLzAw?=
 =?utf-8?B?QnZWNGtuWWVGY3ptQkRubXAxTlhBK1VNRkRmUndHbWxuRFg5eGxlK2RoK0RC?=
 =?utf-8?B?bUo4MjZyc0szc2hBZkZOc1g5cTQ0eTlwRjlGempWdWVoRlV4S3hvdjNqU3VL?=
 =?utf-8?B?eHREdlROTE1uQ0Z0dzkxK0JOYXg0Z0hFRXhRcXFjR1B6cHBFaHMvUUFNeXFu?=
 =?utf-8?B?dndQSjJGbnZlV1BZT3dHTkpUd1RSajNNNGF1YmNqbUNjUkRZcXF3bUtVdXVX?=
 =?utf-8?B?MnhZM2gwaGhnRkhPeUY5cExTL3NWWWM2ckNxU1BaM2JSM1NrQy91dGYxQXNF?=
 =?utf-8?B?T1kxRkgvUzRBczROTm9kdnhUVEsxdERZN3RqTWQ2c3B0QzhnaUpJdkp0U3o4?=
 =?utf-8?B?YWhJWG9mTUJXYUluQnhRT3kxZzRFOHRNamlOYTJUY2NHdW8raExhWGJ0M2lS?=
 =?utf-8?B?WFQwbXZKZ3I0RWhaZE13YkFycjIzNys3czFUYmdqYkt4UUgrVUR4aHVMVldw?=
 =?utf-8?B?bTdZcFlUME5mU3Z6Z3R1aGpNcmMyT2tRUUExVlRPY2ZTbXF1WkJhVmpMR2tO?=
 =?utf-8?B?RjFqczJGYWJUbUZNZlJib1RTOGRPRWw4VFFLVUlIRW9IK1BYRW5xMmdkQS9C?=
 =?utf-8?B?RjU2emMzanJVN0J6QTRhZjdFUy9ZaWZvbFhkSFV3SzBWWG15NHZ2UHViQTNm?=
 =?utf-8?B?NHR5OHc2VXJlMHJmemFMWmN0NmpYVkd6YWNPc2RXQWphZDl3VUZnOUNjbEpz?=
 =?utf-8?B?aUw1T2tWZUlvQ0p4Y0V4UnVZakFsV21FYmJyRjhkcVk2VkQ2UFNqZzdTS0VP?=
 =?utf-8?B?UDU3ZngrUUlBckRuc0toZG1wNkdwbnl5NWxNcFBVeVhrZG54WURmVDVmbXNF?=
 =?utf-8?B?cVFVRUVDV24zREVEejQ1YWN0UVE5WEVLMU5uN3VLZlpOSWsxVkFEYmx6dVR0?=
 =?utf-8?B?MlRWcG9jYng1SWwycjBZdG9sbUgwSlpHSGgxMG1kMjBwQWliN2hrZnFtSmNY?=
 =?utf-8?B?MG15Tm1ZVjJEQ2FrWFFvWUxnaGZVeEt2dkxCZmc2NFZRUU1PYUtDaDY4dloz?=
 =?utf-8?B?ZWtyWStBTzNzUHNwdkhRdUJiMW45ZjhlcHJIVHdmOVkvOWE4M2FYQ0FEZ2Ju?=
 =?utf-8?B?Q2N6cW5ZMnJ4OWcxSFY3TkxDdWVwUXJCOUhYQlRTMDRVdjhDSHpvNTFCaHpM?=
 =?utf-8?B?enJkbUI5NmMzbFZzV3NEU1ZoeDlKNWFuS2VneUdNdkdDYXpWRjlZSzROVFBv?=
 =?utf-8?B?bEt4S0NhTVhHa0ppTGhtQWFnZ3RBQ1EzaGNHcktzYXhwQ0hhODF2VkJxaGpm?=
 =?utf-8?B?TDhGall6T21TMjF3MndjWlFwK1RnT2VRVzlQeHNwNG5xamJNYXhRRllLR216?=
 =?utf-8?B?dWtHVldhcC84UTkrWVQ3RFI1MHNZYXVpZ1F3QnVjQkNnaDVXWHFvalhTeER6?=
 =?utf-8?B?ak5KYWk5V0RGSG9TNHR5STdBeCs1WTd3MVVnbk1RK2h4TUpaMnJhOU0ySFZL?=
 =?utf-8?B?dTZCd1JaUmlBTzNRVkRza0V4QnJ6bTZLNlNMMDYrWlRjT3Z4Ri9DeVdYY3Jj?=
 =?utf-8?B?U3dJZ2hpYVZOWW1HTlFQTDZPT1hOZCtzMVYzZEdyK0NPSUxJcER4MHJ2ZitM?=
 =?utf-8?B?OStDdjQ4TWdFVlNnUFNxUDJxd3NQSzhPTmt2VGhVaDQ3ZXAxMmxkYktPQWxs?=
 =?utf-8?B?OFdlVFcrUG9RTG1PTlZTS0VibStCWnpmL3k3eVVYQjJNcGw3aG43UFR0c251?=
 =?utf-8?B?YmRYWGh0K3ZtUXF5bkdacDBDKysyclNGTllIVzIxVTBOUE16SjZHaEgvNDBM?=
 =?utf-8?B?ekpRRGdpVEJhL2hTc3lHcTBRS1dRWFRsTVB0MGZJMkIyVHlnMEViQnF4Yk1k?=
 =?utf-8?B?OXYvQSszUXErZEI3cnBBSUFjTUxRNjNwdU5yU2tSVmJMLysvTjNMT09BZVNj?=
 =?utf-8?Q?N02BtVbSNmY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTlVeXZiYmxaeGNFcUd5eGdJdW9LS1lUVVpOSGZKcTRrUVpYTjlOZWpXQTNX?=
 =?utf-8?B?dUlISTJ4OUZZZ001dkEyTWVCTS9WTDcrYlZlTDlIN01leTVTM0ZyYUdqTDFy?=
 =?utf-8?B?a05ZOFBSbTIrZkhPYmJQYnQ1VUdDY1phWWF0Z08rUWxsUjRiQlZCN21lcFU5?=
 =?utf-8?B?RFFiS1MwNWhMMktxVjg4U3QzandkVmpyUUoyUVU4RnF6UW1FbjQyMFpldFBS?=
 =?utf-8?B?bFphNEVTdlVBQWpBaHpqNVpwclc3QS9Pam1FeEE1VWNXZTB5eVdNSFppSjNO?=
 =?utf-8?B?SUdiREd0TjYrcWJDeUhtaExTa1BHUW5OeXpONmE0QS9LaEZobTRmNGlieGt2?=
 =?utf-8?B?OFRJL0Y2TmFrdjZLQWFsOXFvWlFKTnVIV1g3UWt3ODBkYlhNRXVLNkwvWk1W?=
 =?utf-8?B?a3dETkN2U2pCVldKZUFuQnlyRGlZNkE5UGNvNEFKcURXNzllZ3gvKzJzazlB?=
 =?utf-8?B?T21PdmRxUzFGYTJRdWFVOWtyajhYMWVVRDc5NWZ1aTdkUElwTHV5REZiMGto?=
 =?utf-8?B?TjA0WGxOUnhudlRFZXQwdk4ydmV1NnRxZ3QxNklJNC9uSUVPNFp0cWZuMm12?=
 =?utf-8?B?R1lrcjE5MEtCYStLaDFWK2J3cVVhWnFRb25PYUxJM3A5dmluVnJRYnFaemlQ?=
 =?utf-8?B?Q29nL0RiMi8xbW8zYlVtY2hUUmdPUjlINU1LcEZZN21MaS9maE5NUHJESWxn?=
 =?utf-8?B?djJZTjZFWEd4Z0lnaGNHeC9oK0VKYlcxRi9DdU9ET045enJ5RFVtYUFtTGdW?=
 =?utf-8?B?MkhQMjZVQkFNQnFHTC9ZV3ozMlFQYWFaZjlDRmU0NXp2MVk3YmhUZVJMYmwv?=
 =?utf-8?B?c0Nib2hJWmhuc0lNd28za2ZRSUM0MXBQTFZIa2I1QUNQYUp4RUlibE5CeVYw?=
 =?utf-8?B?a0d2VW94Z3R5UWtkUGRYd1YwclphU0JNMUorTWc4ZFo3YTlpcmRCUFZWcU1i?=
 =?utf-8?B?YmM3WVZ2L0RGamtSeDlVYWZ1eExpOTd6MjNXc1huWDBDVnB1QVB3K1krZW0r?=
 =?utf-8?B?cXhTS2tDLzJ0ZUhSNzRISTJ5cVhJak5XN3FPeS8xb212NFhpQmVHdkh0akhM?=
 =?utf-8?B?cDlmTjlGSFU0cjhCMHFTbDI4c2FxdzhNdXE2WDJJb2NXb3Yra296ZVQxdkxG?=
 =?utf-8?B?VkNYZUdoK3RmYmI0UTVIaUVHYWN1T1ltTEIwZzhFcWt6bitRZEZGeEhDMjJm?=
 =?utf-8?B?SitYbVExdmlpb1BiWjRERlV5K3UzaVFNUVRqcUlTNndqOXNRUldyS2J2MVNO?=
 =?utf-8?B?bHNLK29UQS9sQ1czYlNRVGVIdFI1cW9pOFpKM2dtTHdKVzdzQ3RFZ1hFNlgw?=
 =?utf-8?B?WGdaWkJuRkVWZFlWNVNZcmZqb1VqZkp2NUJBVjdkNlVZc0JjTkhuN1FITDVX?=
 =?utf-8?B?QmtTcmY3TVZmTmY4ODA5NHNyb3RqL2M3NnBZeWRHSGllTnlraWNPNUQrUC9o?=
 =?utf-8?B?WitZZ1pydmpGNWxNeDZVYmlHRmxNNi9yZTNucVRlaWV1ZTcwckNadW1CTGxI?=
 =?utf-8?B?QjZsTnh0akNpbGdlbU5EM0QvZHJpTHhpditaVnllSEQzcVNjczhOalRHL29j?=
 =?utf-8?B?U2Q3WXRUV1lRZVJjN0VLN3ZLTkJVZUpLWW12M1BhQU15Q242WFE4N3FKcGdI?=
 =?utf-8?B?TGd6d0l1bnFENWVTeTNGS2syam10TGdHeFJwM0hmb2lyVWdkc3RLaHhxZ3FX?=
 =?utf-8?B?RTg1U00yQkJZV3RPdkt3Y3FQSnJxVUxReXBUckdvczRNNFFhL09KdlZOUy8x?=
 =?utf-8?B?M2didlFMRkM1dS9WNWVtVlppOUhBYjZsWkY1V05RVDBGTU0zbmlFQUNqSk5H?=
 =?utf-8?B?YUJiZTl4SWxZY2ZVek16SU5UbDBYVVpJSUNpWDJNSlIvaEk0Zy9OeHRQbmMv?=
 =?utf-8?B?bVN0bEcyNTRSM1Z5OGQ1YVljTGxFc3VJZTZndEFoS3pkUmVoWkw0MVFnWlBh?=
 =?utf-8?B?LzRaYVNNS1V0TlFYVklGZ2k3VGh4M1R5WEgzeSttcW1Jak9yRHNiM1lFbVk3?=
 =?utf-8?B?K3hKNTNPajI0VnlkSEN5UTNmTWNWcFJRMks0YTRIVS9XOExKby9tZ1pDUVRt?=
 =?utf-8?B?Mnk1bUJZbG9QcnVJcVd3WHlobGV6akxlMk5NbWNVUVNrZWFMOUZmelMzZUpj?=
 =?utf-8?B?SllJc2VNTGQ3WXRXcHpxVFJFVHZSdzByaGhvYmV3bnUzaWJNUnpRMHp5aExq?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a092b3-6671-4831-2057-08dde94e85f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:56:02.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MaMMFCgw1pbyl/lm2WfRtkURCZcDSh3xSlmzNXufWupVOyiEQ86/bBCX7vxuizlDvBmHzMGR9qG92RU2Axsl2CaQeQusA6gHAGeZHrwRYXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 11:56:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2102

Hi Trevor,

On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Separate the entires into lists of 32 vs 64 bit machines,


It would be most welcome to have a comment in linux-yocto_%.bbappend to 
explain this :)

> then sort each
> list.
> 

I did the change manually and ended up with the same diff so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

