Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F3C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 16:09:29 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.68])
 by mx.groups.io with SMTP id smtpd.web10.15718.1748966967611677899
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Jun 2025 09:09:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=dDEumOIy;
 spf=pass (domain: cherry.de, ip: 52.101.71.68, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H766ffNFrDXEvA8e7cw89zjBu5ocAalLGSi8g/WLutGCALM1Madey8G/8K4VNJ+SF6oAqR5Cr9pLxjtP82tIGZ1dYxJqs+2dAwrGVRXGApFLPylwkOtyBhvrt8hYmPeh/hZQfXM31xilkoG14XrsfG0l2Gx7NIh7Tv5AzLNGEyu/jaE1jnu4eUWKV7dSRlRwKTRHhDOnd0XHf+2CTkijo3scq6uB2YqiOCedFZyl9WGswnGJtyZrjR+rSUpKUt6rl3n1kEnOb12cZSE3alU1t8d8mpTRtYd2nXo5mFBbIonxejhLtIXqlzOzo9ZNxsFotc+Ka7ByPRej4sgzztz/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9vy5flks7fKNiVjcUcmirJDcUZ3Z26HjvIhdo4/Yoc=;
 b=lNPnd64HvpYp0DSreyPV2kzAAwW2zV1bKHp5sQiqyWdfYJT3xZm9VV68rWO1tMUS0jZ71yCygMdnYpFs99YVFA27qAQe8im2EflTSN0A/dVrfGmHvPwi7rln92vH0jZvyfnUqyfU+NVMGg3Qpt9ibyRHP3hvucuiJvpFxSkv9FvkVyDB9vtnWBqVc6z3RHS5oRZFB8d5m1wVpsB4smzHSlyrW0i0jniqgL95WszSlIWvTZX2Qic8KsthHMhZo0fAEQBSgkKecLdEPz2MN2cQLBCEQx409BYDoORZk2xy8YGOYME3gh9cn18g7LFD7njxOgMVjYJ/lA4U3S8IkRkQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9vy5flks7fKNiVjcUcmirJDcUZ3Z26HjvIhdo4/Yoc=;
 b=dDEumOIyi1LJNNaE2jyIL6qpXUP0hjmB7VBDcI5Oge0Mt4LTkNJLY/rZMSqgg3OfFiBnztCgkEUg6m2hkxn+M/+KoXG+LOOrNLsr9VqGDbgedE5LTaUn8gHPQ7Lj/OabOlTgiI+pSalNTos8x121+5qT7CGQnaC12FB6X4hAYyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:09:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.018; Tue, 3 Jun 2025
 16:09:23 +0000
Message-ID: <e71d5228-6b89-4506-b30a-66ca0e458c11@cherry.de>
Date: Tue, 3 Jun 2025 18:09:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
To: yocto-patches@lists.yoctoproject.org
References: <20250530172156.7199-1-twoerner@gmail.com>
 <8db48afc-fe3e-46fc-a733-1673548bb749@cherry.de>
 <20250603155253.GB31087@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250603155253.GB31087@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:206:14::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f76cb84-5317-45f4-fa69-08dda2b90142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NG9Tbm5pSjhPRjNTNXowVVQ3aHhkWVFkejRBbUdlMkx1eFl1SDNGNzlGMGpF?=
 =?utf-8?B?TXdFa1A3Tm9nbk5TeGhEYURxblo3TFJFUDhHR0pBS1hvNU5vbFQ2Ni9PSWF2?=
 =?utf-8?B?ZmxvZkhjTy9FVm84Rm1qaERoQ1Fac0JYTUpqUVVJQ0N1MkRiUXRaWmZEd0dY?=
 =?utf-8?B?d2ZrWEdGanV2UjNKMVFaYnROUW9ZdHNpREIxVEpWTTNOOFgvdVFmRUlYdEp4?=
 =?utf-8?B?QlFIN3pORkNSRjJab3JwRkYvcitwV0ovV1ordGQrOC9veklFUnRUaExYNE1M?=
 =?utf-8?B?VFBmUXhEdktHcVNpa0dqeGR5Z0RPNUlmZ2x2eWV2MUdBRnVpdEZmMTMyT01C?=
 =?utf-8?B?Nmx4M2x4TUlNdDg5SzhyRmtWK2NBcnNVRlZMeXRROUhUaW80NEpqYkdzMzVh?=
 =?utf-8?B?b0ZNaE02dHp6L3RsODJvUTZuZDJ0c3BXNUZnUG1UbHFBY3VjVUJvZi9XMVNR?=
 =?utf-8?B?ZjZxRU1PZkhrS3o5VUp0bVIrVVA5U21Jb3pOWENlMHhzT25xYkYrTm1iK3pN?=
 =?utf-8?B?RmQySUphaFJRZVp3NGxQS1A5a3grTmdPc3MyZVJPaUorZ1ZIMWFZWUw3dEhG?=
 =?utf-8?B?d2lPRkRUK2M2WVFNMjJjWkN4UlZWSE4vbFJiTHB1QVpZZGhOTFVhNFRuTzZ3?=
 =?utf-8?B?WVJrNGUwaUl4dkNQNC9ncEFaZHhidUFCNUlVenpaNlUxUk1rc0RSRHpTaFVr?=
 =?utf-8?B?KzFhTHZXenFJWmJsdVM3amo4Q0xKZUNmWUZ1R0srdHZQT28yaDlZM1ZMWE9i?=
 =?utf-8?B?cmozdjFRTk5ncXN6Z3c0REdZVnRwRE91SWNNRUx6c0N1RUpmOEhQS0ZKdERJ?=
 =?utf-8?B?YVhHWm9SNlhVb04zaEwwYmovN1Z0WHdkRzZRem5zbFBuSHRMTXdrZ2N3TEIv?=
 =?utf-8?B?VUJLTGNUVXlHSUlQV1hWYS8xcTVXcE1POWQ5MU5RVWRqS09acVdrdnV5RDhP?=
 =?utf-8?B?YXhDK2xGUzlrRUI4U3cwelNmTUVvakZQOEs4Ylk4T0tBdFhkUFl4T2UweGdz?=
 =?utf-8?B?dnk0aDdjb1dOV0M1N3UyeEt3ZTBmdFNEYXZhQVcyY094Qk1rWGVrUEc0RERE?=
 =?utf-8?B?WjJ1dEVTcUlvQkVGN2EwSW5vV3I0Y1gyeUVPUksxMDArOVZPQXNzZHRsU2xL?=
 =?utf-8?B?cTJTRXB4ZnpscVRSYkxMSmczZnJwdTh4U0k1U2RGTTVPRTNrZHZ0WFU0dWJF?=
 =?utf-8?B?ME5mQS9XV1Ntd3A3ajUreFhqREg4enh2VEYzTDJ4ckMyS2FTTzBGUEdxbzJP?=
 =?utf-8?B?Ni9BaDU0SzZOU3g0MTl0ODlhTHBkSHg4VmVGNlpab0tDQXNzMXo3WlFjcG9S?=
 =?utf-8?B?MER0ZDk0ZzdPT2gyVXNyMk14RnI3TCtlSkFHZDFaL3VwdUJPODV4RTdFVlpD?=
 =?utf-8?B?dGkrUDlzT1ZvQmF1UXJxTU1RU0p1NFdrS1JaQVkvaHZkRUVFM1JtZlE0akht?=
 =?utf-8?B?ZllVcitHMnpmQk1JZ2liQlZTdEp1dTRqSitKZnBxd29LTGZ4aXJQcU13RnA5?=
 =?utf-8?B?L1FqbGNjRmRPQnFwb1g5bHl1bmt4YVF2dDJQelV6ZkFoajVvWXNGd05qTFZi?=
 =?utf-8?B?QzJCWmZOS0dtb3pNVXNpbVBwNG5HcXluK3hGK21TbGZ1QkR0d3JwYjEwcE0w?=
 =?utf-8?B?LzNya1BHaW1FV2ZMWmhjR0lIWml3RExSUCs0akhvVjRhU2pYMG0rdUNKUEZV?=
 =?utf-8?B?Y0JXQjRsNTA3YXVqaHZrYUlMdG5NR0NDLzMxZGZSOTlWMFNnSnRoSWhVdlFM?=
 =?utf-8?B?QmNWV0dScE10bGtpeStnWGRDUGlqUTZOKzRJVmJtUmZEYmkrMURZeVRBRThs?=
 =?utf-8?Q?otmJXYLKhcD9OPymkgK84nvHtOXeEVOPwEpeQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R2FGRUJnd0paT01ibE9qcU5TQTlIU1BxNktwWWVkaXN3di9rUXZVUjNGYVZr?=
 =?utf-8?B?ZmhwQ3pWMW1yVXJNZTVBSU9vb1dQdXU3cFFBWUxXbmplMmRMVC9lMUNIMmRF?=
 =?utf-8?B?Y3Q5eXdTWTRsMWJvRmdZc0dneHprU1Q4cWl6QkZ0VzltcXZmd0UwVU1CZ2pv?=
 =?utf-8?B?WWdBaDduUytmY21GNkowaGpiOU1kaEp6SnFlVUtsSDJ6eVZmOG9lanpYRTRv?=
 =?utf-8?B?SHczZythTVFoamo2ME1YLzFZUi81R0RoZ2FZMXpBRjBWd3ZraG9KTzlvV2lw?=
 =?utf-8?B?eXQ5dm0zWjZsWkdMeTRsSFVXRnJ0NDdNVStLRmdHUTE2QnhFRXd3NjNVUHdK?=
 =?utf-8?B?SWN4ZXNoemZ4c1lWTUtFSEVsVmovS0twdm51Rms0SS91QlEyM0V6ZzAxM2Fj?=
 =?utf-8?B?UGtUb2RCaWJCUkJNTE4walVVWkMzcWdzYWFlYjlnV093c0dqQTAraFlSK3ZL?=
 =?utf-8?B?UHBjVUV1dEtabjZtWVpocTdLY1AwcXo0QXZOeFNsV3k0NHZkcWN6cEFVM1RU?=
 =?utf-8?B?eGYxYXdxL0lGZnpiRmVDREwzNmZOc3JBb3VZdzZZSGZRSm44V0F2QlFXWDAw?=
 =?utf-8?B?TVQwRWxoUnFkSGFSZGFZS01TVjMreHNiclQwbHdCckhxWGsxZXIvd3QzdUxl?=
 =?utf-8?B?bWlWUmFRUnJHQmtpWUVwM1ZNZGY0ZDdrc1c0bExhYnlZbnVXdUkzbUJsdW5v?=
 =?utf-8?B?VUYxYnlNU243eXROZnhRM3RWbVJ5anpReE9ucVVUZUUzbnVuYjBWWWFTTUNY?=
 =?utf-8?B?d0xUTC95K3Y2dDJxWjhubXB3bVM2dWhNN2ppeVhkQk9xdzloTGZ3am40V0VQ?=
 =?utf-8?B?RTVVTFJML1kwYWRSTUNrUStHY25waUlCdVIybVZtOEhRRHp6K3lmRGJOZk9Y?=
 =?utf-8?B?WTRic2t1MG1DYzJvY09EWUNGVUQyN2RpME13OW54d0hyYU5DaG5pZXRzWDBq?=
 =?utf-8?B?djBRell0eUs3VWt4b29nZU5RV0k3V0h6WjJibWNkemh6cE12RytPdXpPdGti?=
 =?utf-8?B?emprMStwOTgwTlBOS2hxSmNTSnk4L0lzS2lqSWZqNytiTmVJMTJwNU95U01s?=
 =?utf-8?B?WVBrNVBESmM5NHNwKzlleUk4UTlHYnNjbTkxNGRpWTFGMHpPWTRHZ1EzaHRo?=
 =?utf-8?B?cVRJa0tPSFNEdmZPSTErYXF5bnljajFhblZPQStYNHNEdSsxek9BNXVheVJW?=
 =?utf-8?B?L0RrcmQ1cGpoM2UvN0dFVTliajJ0Ti9qTEZ3VGx0STZaYkZRbmFHNkNROW4w?=
 =?utf-8?B?cmlXeng3VnRBOEZZM3M3SGcvektoZFBwUnFZdFM5Q1ZsRTJLM1NISTlsWWFQ?=
 =?utf-8?B?bVNsTWNHdmVtL2FWUXhoN24zNTU5ZEpwcTJVM2Mwc1FrVzNtaWVYUlJjSldy?=
 =?utf-8?B?MUs5WmkrcjZKU0trY1NROUlFTjlBVk5uN0tOYmdQZHMzTUxmT1VWbVk0dWVZ?=
 =?utf-8?B?Qjd0M1RkYVZNaS84NDJyb3NaS01Od1BST0ZWclpYa2RzM2dtL0E3WDVrbkdX?=
 =?utf-8?B?dGpvbktwMzc3cXNrRlpDeXpuaUF6N2pOb3locGdGdkZEYXBmazlYeFBNeFY4?=
 =?utf-8?B?SFlOUFo2QXdQYzhGMVljMStRakRBWERheGRqZkNvVGN0VER3VWU1YVQ5enUr?=
 =?utf-8?B?dFFVTDZGdTZUQ0gybkozckhEZWxaOXIyV1Zwd1hmVVFJa1JRSGtVMElsaTN1?=
 =?utf-8?B?SW1wb2Y3bkZTclJZdWUyL09kU0gxQ0U4R3NhMU1hczhLanQ5dW5BbE41LzV1?=
 =?utf-8?B?OFBzVldRb1lhU0NocDVFTmhMZEt6ME44ZFV6QlJrQVBtQS93MnVNTVJ6WTlZ?=
 =?utf-8?B?OVQzNS9qMGFReDVmUE9WUGdlbTVvVVRjVzY2Y0x2bEZNc2xtZ3B4WjVBdmVn?=
 =?utf-8?B?Z3hvMVJhRXYxYXpjWEViUVk3czU4QXdZMGd6M05TdmpPbDI0ZnFLL05ZOTFZ?=
 =?utf-8?B?NXpVSFRvakZUVWIrbHdtbTBMdytsNmFqOWlSUFVpQnBmTDY5VFJjeGI5UnRS?=
 =?utf-8?B?enRhK29TSTBFcXE1dGNxWnBXemVwSnVLQlRuaGN1R21WeVFhQjZRT3VSbldq?=
 =?utf-8?B?Wm5YK1BtZVBCWGtkV0c3OStxYjVxME1ST2ZhLzJtNHBGYjYwZGV2YW9TaGxD?=
 =?utf-8?B?WGxTQ24wUXVsN1RjSTZ4R2wxVXRTcE1kcVExUGNKMzZHV1Y3TmE1OGxXaHBi?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f76cb84-5317-45f4-fa69-08dda2b90142
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:09:23.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWUFuHylZ3gPOnMPNTgApzkRz9zfYY9sk9gjFyqjfoQuUwPBpOG/XTn2YIUi7lwTUeveA550NMEY8g4qVOLa5TBw26GEvYcfJC3j/OQHRdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Jun 2025 16:09:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1614

On 6/3/25 5:52 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Mon 2025-06-02 @ 02:22:12 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> Add a new variable, RK_MESA_DRIVER, to allow the user to choose which mesa
>>> "driver" they want to use for their mesa backend. By default set it to either
>>> "panfrost" or "lima" depending on the SoC family being used.
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>    README                              | 5 +++++
>>>    conf/machine/include/px30.inc       | 1 +
>>>    conf/machine/include/rk3288.inc     | 1 +
>>>    conf/machine/include/rk3328.inc     | 1 +
>>>    conf/machine/include/rk3399.inc     | 1 +
>>>    conf/machine/include/rk3566.inc     | 1 +
>>>    conf/machine/include/rk3568.inc     | 1 +
>>>    conf/machine/include/rk3588s.inc    | 1 +
>>>    recipes-graphics/mesa/mesa.bbappend | 9 ++-------
>>>    9 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/README b/README
>>> index 9672c6ab8d5b..97d06eaefd63 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -159,6 +159,11 @@ Notes:
>>>    	compatible (see Rockchip Media Process Platform (MPP) and
>>>    	downstream gstreamer-rockchip plugin for those kernels).
>>> +  mesa backend
>>> +	Use the variable RK_MESA_DRIVER to select which mesa backend to use
>>> +	for mesa. By default it is set to either "panfrost" or "lima"
>>> +	depending on SoC.
>>> +
>>
>> I don't think it makes sense to make it user modifiable. You cannot pick
>> which driver you want to use as lima will only work with a specific family
>> and panfrost with another one, they don't intersect.
> 
> Right, but what if someone wants to use mali? That's the use-case I had in
> mind for making this user-modifiable.
> 

PREFERRED_PROVIDER for libgles/libgl/... maybe?

In any case, for Rockchip I believe you'd need the rockchip-libmali 
recipe, see 
https://github.com/JeffyCN/meta-rockchip/blob/scarthgap/recipes-graphics/rockchip-libmali/rockchip-libmali.bb, 
for this to be useful?

So I believe you rather want a knob between mesa recipe and libmali 
recipe. I am not sure this is important until we get a libmali recipe?

Cheers,
Quentin

