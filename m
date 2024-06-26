Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F67C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 16:11:22 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.123])
 by mx.groups.io with SMTP id smtpd.web11.31417.1719418278289811225
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 09:11:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=loPVAIw8;
 spf=pass (domain: cherry.de, ip: 40.107.22.123, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWV6QXziX3P26itgfklZDmmlrxv9neFOvp1JBxZwEZ0ZCrbNYzNg48qFyhDoYcqTkYbTJbkbPynh/Cj7+8hXmWeEip83XsdBvPm+sCtMQeKK3APPFtQtGmmEgyYZJzM/n6DMawEtfFCAVJ/a+LIZbTCS5oRD41hN0nj18bvti1Xe7xGADPUnR4pPi0kXksJ4hxIxn8S3dufnT020U6B4zgiMX6RuGipUY26B5HCmSk8VgCZv/XqJVgGNG6d51EVHcTTYBa2zbB2JnDPIk5u4Qr1REMt9B8eKbCxQqQTLBNq9/A/nI4ScQFG3V1CNly/35R0T/bsVKFRJDFnRN28oLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UZec6YJIxs3WO7Dt8GJlnnX7PfISY8blamd9pROz9w=;
 b=oM3OeOkgwjYGFHV0Y10Sb+VWiSrYtrdNQisn1v+4sSDjBuEHOX5uQNOC8PUJ5MwGn0BUCTSnqMP/mlK3N+wXPJaq9ji0l9I5/XkfGoPAi2zZ0SnnvlK6875877uZERuAC6SrZmuRdNM7GxtExQM96S1zgsZVEPvMb8nq/9RU818VD5oMhu0cNCaAYJLRgMlKW9BeNr5drwh3kZE6nN/Odo3E+gEawZKO2+kFSt39G3U7I3JGSapk6EZYSmcOG9kFoJJcHYFKjsv/QZ0V85hWam7pAWb+4MT5YKFs+NuD/p2F+S/nyzOpTSQQ9yFVBB+ElBBbIMbBJrgjG6yceCpH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UZec6YJIxs3WO7Dt8GJlnnX7PfISY8blamd9pROz9w=;
 b=loPVAIw8ilIOw3YU4HpWxx2JqZdKcTFv4+Pq7GYiIMYIlUfdtwKTagFdRafiSSsrTuT85iyoTVZBKNj4Fc4MywSlTI2QpHSgqkMvzff13gmlN31g+hlg2xqwbNMBe7QQg4gKWxciGc6fO4jD9iTzaypRF+CCwNxibJL9DMJNUpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 16:11:13 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:11:13 +0000
Message-ID: <476c7971-11b6-4a28-b731-afffefd0890b@cherry.de>
Date: Wed, 26 Jun 2024 18:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240626135632.1623-1-twoerner@gmail.com>
 <daeccf50-cf37-4ca7-8f08-0daaccf33502@cherry.de>
 <20240626154644.GA22782@localhost> <20240626155309.GA24963@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240626155309.GA24963@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::26) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7501ee4a-8da8-44b9-b420-08dc95fa99e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SGxlSEhEVEVZWE9sMU85M0R2N0Z1RE53bjZNTXdxTUc5Q2FkdzJyQkhxdW8z?=
 =?utf-8?B?b1BnTlh5ZEJTdnBrc2I0eDhYTWZzQ2tqenhWMml4MGY1Y0hhNGY0c3BibE0r?=
 =?utf-8?B?dmVuM3RZRFUxQ0ZXc0lyUGthSWsyN0kremhGTHlZZEhIUkZNamkzUCtKdWdH?=
 =?utf-8?B?L3NqRlRhS2Zmc1M1RkFCdkxhYWlTc1ZXQXlFWDdOME5rL29BTHhtUFI5V2hF?=
 =?utf-8?B?dTRxOGovQWRVSVlXSVlobkxZVGNlNnVwcE9ENUVHU3hoQmlQRGVKdE1QN1ZP?=
 =?utf-8?B?Zkp0ejI3dDIyNlUwS1lFM0RCeVJ0aFNxa2ZuODFxOE1kdVFnRG13NzhsWjEv?=
 =?utf-8?B?L09TbE1MYWJ6U2l4SWhXOGkwWldmdHg3QzVWS2NOakgrOTFjMm9RcFRZQmRm?=
 =?utf-8?B?Sm1QKzdEdDMxVXN1dlZ6ekNrRzFtZ3dReVNSdE9abEZ6N09RMmVGNWJpbFR2?=
 =?utf-8?B?Y1N6RUJ0ZENBRklIWFJMYkk1ZXpja1dMaFhTaURKQmM4L0RRYnZscWI1NEk2?=
 =?utf-8?B?d01kRGFTZGROODB5RllGVm9uVENjQ0JnSkR2eGlsMGVZb1lmbEpOU0JTckRV?=
 =?utf-8?B?dDJMYlhHR3gvS0V1T2VkRWM5a1N6QXEzTDBBUHh5U3Bsd1pHRnVwREdZLzl4?=
 =?utf-8?B?eTk2SW16TVRTdzhZOEZ1WkNVcUZZM2tuSmRpYW0vR2VoRzlwUkpUUHIwQUJE?=
 =?utf-8?B?VDR1WWRFVE9aYlhRUlRaZXZCSTJFWDkxQ0lUcXhvYWFJdmlEM2FmbUlqb0k1?=
 =?utf-8?B?U2FBOVlkZ01uYTQ2SGRoazFHcEhFMU81MTFzTWhEM01DSlNyRlNNSkIxaDIv?=
 =?utf-8?B?ak5WOVJpKytGbjZtRWZpZHIxUXdISVd1cUVSbUNRMzFGQ0tNMXhtaEJqRnRR?=
 =?utf-8?B?SmJ2OXlQZ0pEdmhrcVl2S3MwYTlnaUkyMXd6NXJ0M003bENEb3IrdjFaRTRM?=
 =?utf-8?B?STVUenJRMGpvb3NwTGNPUnhaYkZKSjNiR1hCNnF2eVdsUytqSFRBdFp2QWxr?=
 =?utf-8?B?ZkI2UHhKa1F5Z3U2bmtnbVJxME5GNGhaNERYcy8wbGJraWtHOFVodVVocnRm?=
 =?utf-8?B?ZEM4ZVVPVEZ5TmNFUzVxM01pSnlKNmxYbmc1U0IzTTVOUUpVcWpPaXZDOVZ3?=
 =?utf-8?B?MFlGc3FyYTB4eUZ5QUR0eXVoMS92VWFUd211UlZkcW9XZEs2RTAzRUxraXlK?=
 =?utf-8?B?NXZuNXh5NXc4ZFJFK3BXeE1kUzVOQkFGWEE2cUJkUWhpSlNXcm5oM2c0SEN2?=
 =?utf-8?B?RHREOGFxYzJ6bGpVMXJodVVsa3YxY3BPOU9CYjdETjk3bks5eU92azlSbVdp?=
 =?utf-8?B?T0FCUG1jejl5NWdNdngxclhWRC93SHV5dUVuYndpTkVJRXlUTjVVc2RwY0pG?=
 =?utf-8?B?a1VTZ0N2UitubWcwdjBRK09ZVzlMaDRxS05GaTRvajhrWDNzZm9XdkFEOVc5?=
 =?utf-8?B?TWZUQ0xmUEx5R3NTVFR4QUtrSU1USmIxbGlJMU5vSE1MWGd4N3U1WXhTSlo1?=
 =?utf-8?B?d1FWM2Z1WTk1UWc2Ym9NUUlxQTNiYXNaUVlWdlUvalR4YVdtL0RkcTQ3cUNm?=
 =?utf-8?B?OVFTV1hJNnBramhkRDlkeTFkL04yL0dRVVBrWU54Ri8zT3ZmWmVReElFaDAv?=
 =?utf-8?B?WkFWb2J6UXZ1d1JyY21OQUJ4Q0NzWVE3dlplZ1JqclV1NFJYYTkrSkxrc2F0?=
 =?utf-8?B?ZmU3M2JqNVdwYWxnaHZzSVdaUWNuVXVxclFMbmhHbXZ3Nk1jb2xDMityOVdj?=
 =?utf-8?Q?47CjkoGHOop/AMxz6U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anM3MFhCT0VlcDRRZERkUVkySzRJamZEYWZlMk53bTFEYmtLTnlKcVJabjha?=
 =?utf-8?B?Y2VCWXA2RlZXVFVkeUU2QU5JeDdyY0tWYllaNWswVlZzRTJGR3ZMTkVGSjk0?=
 =?utf-8?B?UkJTL2tWQzlKWWwxRTA0a3RYQ3o0NG9ZeS9uUmFVa3MrOStuaWNHMEorMHc5?=
 =?utf-8?B?MkdJYVZMcVd4V2RoSGZDTkdTK21IZjhDY080QnB3NStqRFdyZ3ZCK1JuSHlX?=
 =?utf-8?B?U05xYlhJR1I1ZGFUQlF5RWZjS2svbnQyeExXdEdaY1RPMkU0RUNObnljZ203?=
 =?utf-8?B?N0dGQm4wSHVMQzB4T3RWNThKbTFueDI3THl2RC9MdnpZMHpRNE9hSGp6NnNj?=
 =?utf-8?B?NlhjNlZBclF3cm14WjJMTUo3OW5Ub3hkb28ybXBsdGwyMXBsREpObjMwaDhP?=
 =?utf-8?B?SUNCK0NSRVpYYnNhVFVhRGxzUDNlcnFpNytiOHk3L3dhbkZMa1cvSThMWHJL?=
 =?utf-8?B?UXRCSFZZK0I5bjlLbWZoZUlmWmQzdUZQMHhlTTBNUm5yZ0NvZmREdndYVCsr?=
 =?utf-8?B?VXRTTzdQaC9GR2ltbVppMllSK1M3ZzNHMm04ODNGcXpBOVVNRS91elQzT1ZY?=
 =?utf-8?B?eHB6MjJHcEhWRjNZbnV5NE1sRnllNGg0Si9IcE42ak1MY3RTQTA0a3JPZ2xG?=
 =?utf-8?B?TUFVNGpjNVdlbEVtTFFVYnM2NEo4K0VTdG5FTUNwcUtsUjZ3cEhlUHA2d1lq?=
 =?utf-8?B?VUFwckgvRjZaejZqNkdxaEJ6ZUEyU3BHUkJObVdyaGxFU3lUUW5CTi9MWEh5?=
 =?utf-8?B?TkFBTzkxd3BmWTJQYllvemZrYUV0S2FXcFcwSFY4VVlsQUM1VWhWak5zc1NH?=
 =?utf-8?B?cy9tWDFORjkrTUtTR3lDVkY1SmtRZE9WcGF3c2thQ2ZKenNxbUtsY0JvR1po?=
 =?utf-8?B?TUZhTlkwY2Fyb0lkbmFmdXNhb3pjaHRYenN5VC9wMk5NUlBVaXc4WHF3ZXpR?=
 =?utf-8?B?endzSGFwREpiS2dkS3ZBSmU1cWlrRUcrWkkyUkN5ZmNDUTJPUzhXVmZQMzBo?=
 =?utf-8?B?RUpjbnRod2dnU3RyWGNqR2hZVlRRZU9nMi8wRlpXZlM4TFJ3TVM3TEZxMml6?=
 =?utf-8?B?V0lTMlVocit2SVFPemxVSWVIdU1IZmZPbC9vMFhPQXMzZXNhdGM4SExiNURY?=
 =?utf-8?B?c0w5eXRKRjVtWGl5UW5xc214ZXdJcS9hbmgvNm9qRUhqeisrTFZMNDVYTWRa?=
 =?utf-8?B?USt3TThOdmVCSmgwWm4xYVRTMnl2SGRmL1JFdDFFM1lGUlliSjZDc1I3b2VB?=
 =?utf-8?B?N0FjUVlBOUtLRndzM0tXejdRS0xxU0dlT1JEdGhVL2FHYlRRSHhCS0JJUjIr?=
 =?utf-8?B?MUhWZWdxdXF4Zis2N2N4QXlVMTZ3aWczdWpXbWN5bGtYYTFMaW13SmlTaTNs?=
 =?utf-8?B?c0t2ZHNOZHUzSDlWRkR2enhjamxnWDU2eWhLd0hyeS91aGdnUHVWemc5NThs?=
 =?utf-8?B?NHBjOGNjSjRZZXlCOWxIZ2Fud0plZWk1ZG85M3pTWFhaNHY4SHlpOTVTcGdv?=
 =?utf-8?B?OTYxNHdrbXROSm5wN3BoUEhxVUVHdlhnTXJvOXJQalVSbUx4Z0g3YnFGVWZy?=
 =?utf-8?B?bHBoSCtpZjdkUThrUjFXeHFzaUF0bW9kdlE2a1VNNXNiYlJ0NGt2NEhjSnh5?=
 =?utf-8?B?cGtBVHhYME9IQ3J2NnZNT3JoKzBxNGg0SjRMbG1MV29HOUtSSk1icHp2cng4?=
 =?utf-8?B?TEx3ZUpqbDN6MTc0bDBER2crSVNTcnBnUXZCN1FCZWtOendPWXh6ZmNTemVn?=
 =?utf-8?B?bjNLeEwrRWVBL2dQVnJRS1Fka1h5YnRtbTNMVi95NFRFSE5Ba3k5ZDE2TW5h?=
 =?utf-8?B?Ni83aE9VbFNnM1Mxa3J6MHkxMWlNVnZnYm1zTzY2MVpNSzJqUVZ3cWppSDNF?=
 =?utf-8?B?b3VXZFJQaXFpQ3dTWGEwOVp0UVliTWlxbDhWNUcvd25xcElNdVhaVFZvdkYz?=
 =?utf-8?B?UExHZ3UxRGorVEdRUEtuWnArTGtVODVmcmY0Q1dYditoVEtjS1ZmZjlJZ0JH?=
 =?utf-8?B?VkZNVngrdE9RaUwxSnozTnhCbVpqNHRFV2VjMzlBbHpCcnEwYXRYcncrNmhl?=
 =?utf-8?B?UFFYcXZtdUx3cXhXT0pRdFp0TWN0SElPQ3VpWnBBRDI4OVlwa3I5ZjkrT0dh?=
 =?utf-8?B?SHViQkZma05tOGtOaWhTcVljbWJua2NEekNoSnh4S1dkWUtGclpzYUEza1I5?=
 =?utf-8?Q?ydueVsAPFZEWhO9kEWyGmSQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7501ee4a-8da8-44b9-b420-08dc95fa99e1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:11:13.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k1MF5JMRf9EI3IrQUlWWEYRkN+8Dfsp0VWi1N1/n7cIJtKTOuX3djqCVYsBKqYwFrm66aAgO365X/eDfwf45yrXHLrzHhY0fyuuF/vEI04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 16:11:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/384

Hi Trevor,

On 6/26/24 5:53 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Wed 2024-06-26 @ 11:46:44 AM, Trevor Woerner wrote:
>> On Wed 2024-06-26 @ 05:09:14 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>> Hi Trevor,
>>>
>>> On 6/26/24 3:56 PM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>>>> +do_compile:append:rk-rauc-demo() {
>>>> +	# create boot script
>>>> +	sed -e 's|@@KERNEL_BOOTFILE@@|${UBOOT_EXTLINUX_KERNEL_IMAGE}|' \
>>>> +	    "${UNPACKDIR}/boot.cmd.in" > "${UNPACKDIR}/boot.cmd"
>>>> +	mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${UNPACKDIR}/boot.cmd" ${UNPACKDIR}/boot.scr
>>>> +
>>>
>>> Richard has said today he'd prefer we don't use UNPACKDIR for that kind of
>>> things, c.f. https://lore.kernel.org/openembedded-core/20240623213254.3215897-1-leon.anavi@konsulko.com/T/#md4b10cea4af07c1a2e5be43e4ee8c8b1fbc6e420
>>> (though we "agreed" later in the thread to use ${B} instead of the
>>> originally suggested ${WORKDIR}).
>>
>> Alright.
> 
> Actually... I have to do it that way so that the parent u-boot recipe picks up
> this file "automatically". See the "install" line in u-boot.inc in oe-core.
> 

I only see it using UNPACKDIR for fw_env.config and I don't think we're 
writing this here in this patch? Though we do write it in 
rk_generate_env already (in a previous patch)...

I think meta-rockchip is fine for now due to this code path only being 
run whenever rk-u-boot-env OVERRIDE is there AND the fact that we have 
an append for this OVERRIDE in SRC_URI. Which means if we unset it, 
do_fetch will run again, and it should delete UNPACKDIR then. So no 
poisoning **today**.

It is an interesting question though... I'm wondering if recipes 
shouldn't copy their files from UNPACKDIR to S/B before using them 
instead of directly getting them from UNPACKDIR, so they could be 
overridden by bbappend without poisoning UNPACKDIR between builds. It 
feels like this WORKDIR->UNPACKDIR migration fixed one issue (patches in 
SRC_URI being removed but still being applied) but not everything. I 
don't have a suggestion right now though :/

> Are our other uses of UNPACKDIR in meta-rockchip okay? If not I could submit
> another patch to fix them up (and fixup any of the ones related to this patch
> as part of a v4).
> 

In the current state, I think it's fine. We should rather fix the 
upstream u-boot recipe to fix the use of UNPACKDIR for getting 
fw_env.config?

[...]

>>>> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
>>>> new file mode 100644
>>>> index 000000000000..281eb2c4de91
>>>> --- /dev/null
>>>> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
>>>> @@ -0,0 +1,7 @@
>>>> +inherit rk-rauc-demo-features-check
>>>> +
>>>> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
>>>> +
>>>
>>> I would recommend renaming the directory to rauc-conf here, but that's just
>>> up to one's preference.
>>
>> Hmm... the rauc-conf recipe is in the rauc diretory in meta-rauc so I followed
>> how the parent layer was doing it. I think I prefer it this way; makes it
>> slightly easier to find the thing the bbappend is appending when both the
>> parent and child layers use the same directory structure.
>>

I usually try to avoid using files/ except when I want two recipes or 
bbappends for different recipes to share the same files. But matching 
the original recipe layout is a good justification :)

Cheers,
Quentin

