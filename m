Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD04C27C53
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 11:56:13 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.97])
 by mx.groups.io with SMTP id smtpd.web10.19056.1718798164736189803
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 04:56:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Zokkpg3m;
 spf=pass (domain: cherry.de, ip: 40.107.8.97, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF303eIz5c01fel47NJEPgIMF9hjytwU+21+QrSvy+sUtDoSYZ3Cb6XPqb3TekE+uEQH1VsunE7Hnhu3PjNmWj3REDCbpytqxt4CfI1HIWorkJEpAt6lgKVq7UNZUpEYvdrvIi5wdaWko9Q2uHkax48YKKy43Pqi163Wk1K+5KuGEv0YaV0ymFvIg2yxpw2Dih0xn0/nCnDn/oSV0QcPqLfZXxUILUbYL8jWW70AGv3De1Eq0fjLdgrdBVJjaCaJqbnuolBC84gcNp0xyCmX0kb/5L0/CAo1oqpZTgD/1+54ogqUweMpTd/YxkuZxMuflj4SJtBspedQEYmSWH+b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQGvCrIo8mhRuVF5mPq/JoNuDPkbiVfwelj6LvKhdnY=;
 b=oMeYIhLflhnTglPlQdCCibZYRCeU60cRPbnT9urV/o3AAYvu9B1RIn4esx51zUTI67fxLV76eGafo1h1+8rRuCk1xersy5uPbOxHgkrI9O1Al3rf7WmeYQofMUiGx2V04Lm1MUsAcAybmJ+h8tQWL6eQ9VlZYpHBhhAnJDT0DlCRyP9aP7O6F8Ikwk+2RTbgNaVy1ToRfSJrYscwSgfDqOuXO738sI6tn6VU54EMpi5AtVkbjyYYpwLAhyM8JyREnNVpi2hOtH85mc3ROWPkFg5jtCsq8g7Yva9/k2nXNW1yO9pqQiB4hG63Qf01uveciYe794XXAZYhJJzD1oxNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQGvCrIo8mhRuVF5mPq/JoNuDPkbiVfwelj6LvKhdnY=;
 b=Zokkpg3mX96t8E/RFVPMjbU7AO4RUhbEMN/50dq0zkhQQuXSbG4pl7uF+lrtBxKr4+xSw22VU4QewsRuc06dLCQl6onS3gTqVX4+uayI3mdV9uWy7blLYxBKmWe7vig8qLXiJ1KxrGMZUmmM89Pvmy/nROE1YBLmydumskpvff4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8496.eurprd04.prod.outlook.com (2603:10a6:10:2c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 11:56:00 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:56:00 +0000
Message-ID: <f08a3f8d-2928-4a00-8671-09f991ab55f0@cherry.de>
Date: Wed, 19 Jun 2024 13:55:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-4-twoerner@gmail.com>
 <87a55431-aad6-44e5-a897-2b98f9bc77d2@cherry.de>
 <20240619045259.GA6665@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240619045259.GA6665@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: e9814984-902a-427f-c312-08dc9056c986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0Z0T21vRFRPaGFVdG9hbkZxalJFckFFQ2wxRW8rWSswbTU2NldaaHhWUUpn?=
 =?utf-8?B?Uko5TnNkdmJkTXA1NHZNZFMxcHFSc0NPUGtRWEt6dXRlRlRMVElxeWVnS0Rr?=
 =?utf-8?B?YWc0WDhSS0JGdHNXcmhhME55Y0FFaFpSMlBQc1ZrWmZVUE9OTzJGVmFVV3RY?=
 =?utf-8?B?TFNRZGQ4a2xidUQyME91T3ZxaFVYQWV6WHp5dXVHZFZaSnI2eW1ORUxvQS9O?=
 =?utf-8?B?MldtdW0xaE83OE1xbGRhQVdtUlBoYTg5T3BWUUEvS3ZPRWRMOWxpUWdzNUhx?=
 =?utf-8?B?Umt4b1NTc0xyeThTTUVTMVk0Q2dWc010N05MSUNMcG80Unh0U2czRExEcHc4?=
 =?utf-8?B?dmh4T2ZqeHE3MkJIZVMrVHBSRUtma1JZSytQL0xyVGJ2NmZKY296Q2R1Q1BI?=
 =?utf-8?B?NW92dEZXTERwY2lzNGRaZCtjdExIVTE3VTZLV1VUNUlXWjR1c3Y2TURJdlhq?=
 =?utf-8?B?bUVzdytWa3BscSttQXJxay9ZWGtIQXVmQkRmT0QvVjBCendpZ3RacFVyQWh4?=
 =?utf-8?B?c29SQWF3cUxIY2ZjdVBPbzBoaURGeE15aHErOVRBNkJHTno3RkZsZnhic1E5?=
 =?utf-8?B?TVNOVkI3OVlzMkNPSnhuVmtMWG1zdEsraVN0OUwwbzVEbUZHTnV3bGlwSzdr?=
 =?utf-8?B?em5TZy9UY2lLUDZwL1N1Z2d6T1Z6bVNQUTBTQStvRnhycG45bkxTTzY5bkpW?=
 =?utf-8?B?ejRrU1g1K1BnS2RCRmZPVk1MN2tVS05sM24zNVJOT01OZnVnbFFIWFVURVA1?=
 =?utf-8?B?VWpYWUJPeHZoeFMvQnVBUmtlaHdPVzVZcGpyVG01RFQ0eSsyQVVtV21xOGVn?=
 =?utf-8?B?eEVqSUlwUkdPQUkzVng2eEZpS2luS0RISnE1K1paWSthK0MxeTJWbmRjM3ZN?=
 =?utf-8?B?citTd244LzRJWjNOdElLdHMwV2h3ZFlRS0srV0VvMHpaTU5LdCt0STdUSUdL?=
 =?utf-8?B?YUlnU05rKzdTTHgxMFJTS3JoR2RGdWVSM0FXTmdwUUh4RW83RURUL00vVEgv?=
 =?utf-8?B?a3VGTEo2ZDA3Yy9HZlpUV3A0R0d1bGc1cmQ1eUR6OVJtSFdGNHhKMFRMRGNC?=
 =?utf-8?B?ZU5RaG9OVHY4cm5zQUpycXlTeFlPd1hZU2pGR1kyNC9EWjNjMXZrMTNOQ3Ux?=
 =?utf-8?B?Sm9sWWQyT3pSaEZ2WUJFSXE0R0xTTUFCWGFlWjVLekJvYnRQZ0lmRnlYQWRl?=
 =?utf-8?B?Wno2ZTFuYnpMeUxMcGVBMnFQNThRN21VTk8yYnhLei81Rm9jdGtYK0xHTTFG?=
 =?utf-8?B?UDkzblREUEtzdk1zQUtTL3p6REtHbzdLeTVLWXFnS0tRVFFwVGZyMkxsTS9s?=
 =?utf-8?B?bE1peTBWZmpUbmMxMlh2cWlwdjVaNW1MeFhOdHpIbFp1Wndzdk9obkczdGZv?=
 =?utf-8?B?NzlWUjRXZkRrd1lBYWp6YXhXWEJzNW1qQ3ZDb1BaV3NXNU1EVU1mSUhBNjlD?=
 =?utf-8?B?MFFQSDRwSmdKUmZ6UEg0V3Flcm1UMEdHclI3UmtEYTVQRWFYdys0bDhiNVNi?=
 =?utf-8?B?VkhXaEJKc0QwQ29zTm5MODVSdUFKMkloeW8yTFRxQWFCcEEwcWdGVGlXVlk5?=
 =?utf-8?B?aEhJZlRRRkJxZDV1cDYwa0dQNFE0eTRSaThLc3Y4KzFOTzNKQjBGZGwzOG0z?=
 =?utf-8?B?TDRPZG1UMGpQU2ZqVnI3SWtVNldydTBVeEpZQWdlSkJ4RjEvMUF4YmorclRK?=
 =?utf-8?B?dEZXVndsSElBZ01ZaFR2RCtQSlpRMXQyVnNkZ2ZTMDFBQzF6eC9ObVg0WUtp?=
 =?utf-8?Q?tJxDh26EyP8t7aYzbg+KbA/bybi74pHD6pbguYB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHZUclhlNEVkUnRxeGQvRlFnQm1KZXRuRmZ0SHRUaCtmd0JFcFBGT1lIcFdo?=
 =?utf-8?B?Ym9FUHFaRElhZklmMU9xWEgrbWZNU3JESVVIVTVxaDErVlc5cVNhalYwVU5E?=
 =?utf-8?B?cVNUK053cFNDQ05qRTZ1R2dhZ0dyMEdiTnNTd00yWE1RTG90NG9oTTcrUnhn?=
 =?utf-8?B?bjYzNWQ0RDF0QjN2dlNsdXpCNnlpK1AraTBGMUxkL1JjUUhXT3VUVlp0RTJ1?=
 =?utf-8?B?S1luZHgvNU5qMzBQWld3MUw1TzFTZjkzOGt2Q0MxODRCNHhuRkhmL2MxWmtD?=
 =?utf-8?B?RGlsVCt1b1BJbUlVWEJmUWs0c3o5dEp4Vnk5aEVIbGZTajR1ZDNGSml4NERa?=
 =?utf-8?B?V0pnZnhWbXpmTGtjdWN0TlFpOVBiRzdXc2p0SUVSNkxmSENianJxc1FsZXdX?=
 =?utf-8?B?NEQ5YlZCK0NVYU9IOURtOFV5RUV6WC9LVTI3N2NkWGZqRDlBMytNb3llZy9I?=
 =?utf-8?B?UXZxbTdzdWZLcDdBUmJJQ05CVVJERVkzZ2JLenVXcnhXTE00VkdDTzd0M20y?=
 =?utf-8?B?WkZ6Mk1oK3BscGQ5dG4wRzBTbG1TK29wZG9seVlYVjBjaHFaYWJIOTJCWXlu?=
 =?utf-8?B?S2F1aFMwOGxkYmlUbHdDTnNTeFpEdnhyK2Q3TkFIMzcrbUI3a0dKc2VnKzVI?=
 =?utf-8?B?OVhRbUZFTlhIR0Y1TDVqY25NSHl6Z3BOSGhrcUh1VlNIbFl5Nm5pWmVmaTlj?=
 =?utf-8?B?NzhwNUljZzBBNG8zYnhkTWRrOXYvaEdEUkQ4RlJhUTJFcEV5VDFpa0JnYzZL?=
 =?utf-8?B?d2dUTkI5dnV4cDMzL3FPQVE4TzZxRmNudmNaRzdWSXJibzZDMlhOQllML3Y4?=
 =?utf-8?B?bmh0M1NXcnlRRUdwZDR2UFg1S2JYRytBeVdQQmV5VVowVFdpRXU2cU11bTZt?=
 =?utf-8?B?MFd5T1Q1VTBMcnZZbHpTUTNBZ2RJZjl2MVRnM0d1WG02b3hMTFpKVVVCcDVF?=
 =?utf-8?B?ZTFoVkNBRFZnMVhaZGhrd0h1VzVHbVZXTFUwQTB2T1RDbEI0eG42R0ZnSWhh?=
 =?utf-8?B?Y1Y0RFdjYzFnSW0xNEtOcm9SSTAvSkxKd0s1d09ETXg0Tk00VmR3WnhOTk8w?=
 =?utf-8?B?MTU1MVNDazloOEJkSWRlVCtxQWhmRnBXMVQ4NlJMenJpU1llY2pMaFhOWkxT?=
 =?utf-8?B?ek9mY0w5TWVsdHlDcVJaVkZUbENERXN0U09KeW9SZmY5VmNDdFlsL3VXTjIw?=
 =?utf-8?B?QWhkTDFFVjJaaHY3aDVsN0FyK3JaVUdKR3NpNHJ2WmtsT2N0b0VFU2o4czhO?=
 =?utf-8?B?WVpOQnp0R1o2c0gyeDlMdlNwVktVVlhNTndLT2c1cTJPdUNTcEV6OFZEOGVa?=
 =?utf-8?B?UEluamJoeW1mNEtSZ3gya1NxYTdRbGVMOHhkVkxTclM2d2t6bUxvNlFDVnQv?=
 =?utf-8?B?dmNBSGpSOUFqUGtZUEhxZndIaXdjQ1dPWXozRFk5TExBQ0E4U1hKdDhrQ1hy?=
 =?utf-8?B?YWc5RmdINk5XdXc3U0sxRWhkZENWUVdhcWVka0VKZ1hBdnF4Nk8rVU9McjRY?=
 =?utf-8?B?SER4eGhpU2tBVGZLZVZPUzcxTFlYcldSZWdUT2VJZ0hUdDJmMG1vUG42bnZi?=
 =?utf-8?B?eXhjZjZyWnpKUm0wbHg1ZTY0MHUvT2pvcGxyNkpiV3JiYlBBdHYyNlVlbU9U?=
 =?utf-8?B?L3ZRb21QMGlhOS90cGxQMk4yYlVHdFpJQmtUajJIeDFwVGlGQkwzNFkrZUNJ?=
 =?utf-8?B?RHkrV290THNVVDVQcGpkM01peXBJWmx1Z2dlYUhqR1RPWXBLMW1PYUZ1V0ZZ?=
 =?utf-8?B?TFhCeHFiYVM3Kzk4d3dSR1AwWEwreVljWDVUczc0TjN6OUtKZE5wVUIrSkZQ?=
 =?utf-8?B?SXZyK2YzbzZmNDd6NGVibFltQnBHUUZ3WWJmeHZtVEZmMGlHb0pNeEVtTEFO?=
 =?utf-8?B?SkM3aFJpTjk0TU9WTnluOUp4TUdBVkdrUkF0RFNvK0lJRzFkbndzaUN0SkZI?=
 =?utf-8?B?TUtoVElSMEQxMWlmVmlMRkNCbVpkejMwVlc4d08zcjRNeFgyRndyemZQc0Zm?=
 =?utf-8?B?a2VVR09JUXpQbGU1Y1k3dlRwVXdGdjhxRTl6TStGeHc5dmp0bkZxN2VuRkV3?=
 =?utf-8?B?NklVZGN6RjA0QVdLZTNRVnVRVUcyKzdNU1BkTFdFN2Z3bGpPSUpjaDdLcCto?=
 =?utf-8?B?WFlsN0NzOG1uSDNMd2ZzNy9uTzU0dWd5Sm1oOFBuRmdlK2dTa21GemFzb0x0?=
 =?utf-8?Q?bxOHi9A4c5xx8kiWasiR4iM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e9814984-902a-427f-c312-08dc9056c986
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:56:00.3234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmL9Ea6BNkMEC+4u3Tqt1simJjEDnr/B/Ru7M5L18grEZcmJekkuxNEvzQrQRHHhspdAnHWYri2dY1hQoJI3kvOl6iomHYyh/ygVZ7XcF64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8496
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 11:56:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/350

Hi Trevor,

On 6/19/24 6:52 AM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>>> diff --git a/classes-recipe/rk-rauc-demo.bbclass b/classes-recipe/rk-rauc-demo.bbclass
>>> new file mode 100644
>>> index 000000000000..25e105b53d09
>>> --- /dev/null
>>> +++ b/classes-recipe/rk-rauc-demo.bbclass
>>> @@ -0,0 +1,8 @@
>>> +inherit features_check
>>> +
>>> +REQUIRED_DISTRO_FEATURES += "systemd rauc"
>>> +REQUIRED_MACHINE_FEATURES += "rk-u-boot-env"
>>> +
>>> +# 'RK_RAUC_DEMO' indicates the user wants to use the
>>> +# rauc demo configuration from this layer
>>> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
>>
>> This very much smells like we should have a DISTRO for this instead no? What
>> made you decide to go for a class?
>>
>> Also, why is here and also in the global class just below? This should be in
>> the global class only to apply to all recipes?
> 
> I want the build to fail if the user doesn't enable "rk-u-boot-env" in
> MACHINE_FEATURES; you can't do RAUC if you can't save the U-Boot environment.
> Second I want the build to fail if the user doesn't specify "rauc" in
> DISTRO_FEATURES; the RAUC layer doens't work unless this is enabled. Therefore
> I want to do a features_check somewhere, and the way features_check is
> implemented means you need a class (?), specifically you need a classes-recipe
> bbclass.
> 
> If you do a features_check in classes/ it will fail because feature_check is
> is oe-core's classes-recipe and it won't be found from a bbclass in classes/.
> Perhaps I did it wrong, but this is what I found.
> 
> Secondly if you look in meta-rauc you see that they're using a similar class
> mechanism for the "rauc" override, is that not a common idiom? I'm simply
> following that example with meta-rockchip's "rk-rauc-demo" override. If
> there's a better way I'm happy to try it.
> 

Can you point at some files? git grep OVERRIDES and git grep 
features_check returns nothing in the master branch of meta-rauc, so I 
probably am not looking in the right places or with the right terms.

[...]
> On the other hand, if you're trying to understand what the partitions are and
> what's available where and with what options, isn't /etc/fstab the first thing
> you look at?
> 

I run `mount` on my running target :)

Cheers,
Quentin

