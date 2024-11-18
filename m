Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180BD49205
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 09:36:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.73])
 by mx.groups.io with SMTP id smtpd.web10.36799.1731922599204438652
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 01:36:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=I1DpTNLc;
 spf=pass (domain: cherry.de, ip: 40.107.22.73, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc4cTnCKN5kH2T/pudFIKUoDO4JnNQlE2TFFJGnlBofurkjshnOGfC8nYvansZnoeUJ0O3IwvuWIGH+HxsyJ0Fq7xm0IPyBV01cqbXhqALf69bMta7VfP4on+efRWVokmq3/lOQVu35qSlE2vFDCZGYF4DbMn4GBdRwDk2XigEGRfbT2DF+gWf3h7smVUb1Zb50eSirwPZIwlR+o5p3yjEmkLyWss+pEfwYpdkc+oAM+f1WpkTSPJhoG9KuLVpZYotpdIn4+nWk7hePZEMPbFgzLTuB0yDWJ0V3q3HaJHYMyRCj6udx790exwdBdQDN70Xk0n1/Ivc2zzD7FBUSiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1EIzwhmymaegzzQczzz+H5qTGzRj4ADAcrXIqTMouI=;
 b=YB2AEgGWL8ZSKQ4gbVm3GZWFajl6XJUaspcHYh3gVXgR7tRvSgDnDrAR0GcEl70gJD9Ghu8kGIQw5ob/q8aTfGvBCn5zjE1McBODuegKyi93kaksL1Vqtj2wu489NZ2kI0d01+BgUDMYnUT+kOG5VfJ/hLGUdS6RowXyQlAvYKlvW2RYOhDz6ALG5hJZ27D/1VrSfgJIgClhGaKcPCkfOVrcD0uwQBICENTiiVIUqbVuozA2rlhwqjOOPG57qGxnM7HEtcR/gZCZwo7vSkiQnJv3Svr1nV6l2V34D3Qv6riqs2F+rQxpHGqRWRpNAaxYi9NrvQTIVQT+6MONMpdXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1EIzwhmymaegzzQczzz+H5qTGzRj4ADAcrXIqTMouI=;
 b=I1DpTNLcejbyeTGZSzaF6UnnoUpKkGI6nIkV6MXSvyADmp/SMbeGXf9KzRC7JDmn4gCJ1uZXYnYd+6KcadTxkEPH9dqmzcDbMOq9XNMP1ujF2588C6JSvpZpk+BYRqZeZ/QSVIWcqqP24wg9ZZYRmsP0tNMBlqqwzdStMc5YGQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAXPR04MB9490.eurprd04.prod.outlook.com (2603:10a6:102:2c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 09:36:34 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 09:36:34 +0000
Message-ID: <a12190f3-6a16-4419-bd7e-d624c5071c10@cherry.de>
Date: Mon, 18 Nov 2024 10:36:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
To: yocto-patches@lists.yoctoproject.org
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
 <fb559dfd-97a7-43ff-812f-ed20952fc526@cherry.de>
 <80bd8690-9f33-4fa1-b7cd-054e2bb8b1ab@trifork.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <80bd8690-9f33-4fa1-b7cd-054e2bb8b1ab@trifork.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAXPR04MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fe03db-248c-49af-27c5-08dd07b47dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sB3udoE4I6o8VxYO/ZArlOEyMb1EmSIfxDVvaa/5KsoSSIiZsAGm18azWXDW?=
 =?us-ascii?Q?BLaDDW8k891PnbL97cJmn/HdOaln5YrOxgHokExAGV7bXV4wgd37z5WXIPV+?=
 =?us-ascii?Q?yCO6a7JmD+Scn566YCphXLuc6VDmxvOOKy0hHB9z4MhUtZwZAVDkpo1f+ZS6?=
 =?us-ascii?Q?U6/yVkOy6w5GlZFPvDI3MZHy0UGll09hhsMn7/XFKUb3N36MUOyopY08AN0S?=
 =?us-ascii?Q?QOaS7UBIRPyGu+cMh5NjrRnjutz9IvUEEW/+tHf2H6Az3A9ZOEmTP8epNcTv?=
 =?us-ascii?Q?+IioMUbuNUoLxpOXw6kFhW0I9djMpErLTYyw9un80+QYsWf2tT29BeOztYz4?=
 =?us-ascii?Q?9O1TjjVZrYckYY6WKB6HIuwan40jxa5ZTU83ZuhmKt/QFvxBFGmx5XrC0/U0?=
 =?us-ascii?Q?0wOIHoRxevsfaCgfd2LcTFcp/gRymG6RVM8C9UKk8P1/EMFaKi5izqbYlv7L?=
 =?us-ascii?Q?4YLrR38wews9PJ7uSGV5OQBdSGlgA3MhDTrWbIC5gYIBhtA+1NwLBgKHGWmn?=
 =?us-ascii?Q?vBs18xKmUiKPxiC9CdQ/4s2dD5OTle3fnc7Vrpdp1/tly4ES9NOnL53RudjN?=
 =?us-ascii?Q?oWmxBV0ChNNBBRthDtGL2V48f3+lctzUgeTSvVXeyO+VzSCvJFb0h4S3bMAb?=
 =?us-ascii?Q?7Gp1/JoFKjMXjkHnupxuRHozB7dHhKyW1VLOTG2Il3toBSS5O3r4JZnRkRVS?=
 =?us-ascii?Q?TkO68mQCPrjaQBrme1o3q4dPBWjUm607yleKmqGFNTPx5RCQ+UvmUQJBTIva?=
 =?us-ascii?Q?LVtxXVwvo9k800q6KLGnwj35LJxgTDrVmzy/kHnu3Or7Zyb43R96RbIAsjzy?=
 =?us-ascii?Q?erEJURaPrbdjlONn9mdbb2J4UVBmlaAH/ceTT952jsRME8VcZjTAXuR8wSHn?=
 =?us-ascii?Q?wwHBmtN6mYG0/hx5p9VGO7KtPcrdlSDqoTI4t3zhoT6B6bnrhUuftuyIXe9P?=
 =?us-ascii?Q?6AP2Sw7JnBk11L7pFnOCUAoz0UJq8iFMydHly0RmBse+nefUntoAsTfVh1sK?=
 =?us-ascii?Q?X6Xgn7dYseq/5RUKELAs7WGW2+6Z93wlpgKyStdYCmh7Jn66TFkuWlURv/sE?=
 =?us-ascii?Q?HtDHpnBdBLBH4KTEXYE5QykgRWU6T6WCMnnX1FvsrJ5Ia0BgRk9JA11IP3zG?=
 =?us-ascii?Q?oCQtcaFnTEjV/8KNYJWHJNyqKgDmFmf9K7jqYe/SF6jZDlgOXh02/8cCNd3Y?=
 =?us-ascii?Q?r3m/fuWoIgsP+zMR83h6Hh4qH9XVvN1YrMhFeB9hI+LpVMg9fAPwY1L6y91g?=
 =?us-ascii?Q?lteRVeMW7gjzARQHMOWm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wGBdn54Hg7N3TXQHL6bnzQUSrq01PdFaO4vR4dw/AzBywxOXBpt67pjgdC0j?=
 =?us-ascii?Q?Rnz6fvizDKUhcTJGkgTsMZ1XuM7psTLEhniXGIXDsXgB+sJf9dtLAUGg9Xax?=
 =?us-ascii?Q?GdHKFJOze1QGaLjEAb0wcpCgZYE7DiXIXSV+6rgqNVLExRQ07QoJsXw0COUM?=
 =?us-ascii?Q?P+I1+utCDZyVo6Ez6pO319ZU//kFbPoevrxm0hhkFtBwXBDKmNRh3lwtUV7b?=
 =?us-ascii?Q?BDthBy5ghmyBjORSRukycKjUWodDxRFURoq8Bpoc68H7NgGzfBds0OSd+9gN?=
 =?us-ascii?Q?bALvTdoCvyVmppG9yIiEDR76zPMCs92ByRSp/FImhKmImva7caCEn4hoZEjS?=
 =?us-ascii?Q?eDCxugN2fwQzyFL6rlbuNIGQireZt3cXIIyeGNvsjHZVPM/Rg18F5dsXhIQC?=
 =?us-ascii?Q?7tATGmX4x0zJVbGe9u6N09IMTIrvyyNmlwGp4G/hvPAmkrWms36QeGG3kcJR?=
 =?us-ascii?Q?5TIDJL0aaOh04/6aNHLToFnX9BXTw6oXx6IJeEOXn9b+ZF64nBUk6iZD21BI?=
 =?us-ascii?Q?5FZTinaS+F9jL0jcwEY1ObbhR53Hqk2RrfJ2UEyPgnBjX2mMgLpZVYy9oMPd?=
 =?us-ascii?Q?yyiHUd3my+NEj/CyrzNsj/ayayqTE0/AvTEz8uJNNHBX7Y9uY2VLLAjD8xcd?=
 =?us-ascii?Q?tFGTl+P5IpK2s3XqINnWp5InkEgpL4erx/7ojZun8wnQHlp52Q8HReyzq6Qu?=
 =?us-ascii?Q?TfP1G4QgLJIu4jQp6A92LQqn3R9PEyQY59ewX3D+UfApsFc6vR3qo1WOHzP2?=
 =?us-ascii?Q?q90Uy8rB9AhM38nT4GJssFk2N9aVbLsVlyv59m+j6ahQ7+/8RJUop4iyIxU9?=
 =?us-ascii?Q?dWdDk7bYpeVfrLItjecYfHf7HpPOIigLjyYiWfhAdj88XBjbseEG7mN2jBQB?=
 =?us-ascii?Q?pebrx9cWMPDTDJMyZPsF20AB9A8T71K2GUGwIU5fAGnv7/ZuAxWy/jN/xhT4?=
 =?us-ascii?Q?0Zy5XQBxV3ZouvG42aDiOKhm6h6Zq5X2WVnwzR+VTwKXVMIyKB1nMGyUMd/z?=
 =?us-ascii?Q?d0GSmF0D1Xfl9QUlMUZ/KkRibA60koljd4LJrolJ33h4qZ9b4bDwh9o1IOCv?=
 =?us-ascii?Q?J76oCi38tkwX+8oNygukdol0zamfGQ0zLWkbzk4MtFOLGsLCeLEcRxmY3kht?=
 =?us-ascii?Q?JeY+04KEQ6KMy4i3MDzp50hOFlEDS0twkHTn/QI+U8BvTFsCHJTBLyf0LpWG?=
 =?us-ascii?Q?V0zK/rJhC6hKO/LALwQX4G5JJJ7gVZ3ec8s/+4XY3hPi3Gc/7U04OKsdwtG+?=
 =?us-ascii?Q?vsR6VXc9d7XpMuYld25ts9P42CrWCT/WpiT4nw5OUUVcpM8TQIDQcAvDmsjK?=
 =?us-ascii?Q?36ns1F5/9lTOyyaczGx1DoLID/k4FpPTozNgvvmSoFYVTu01tVnZJpzANA58?=
 =?us-ascii?Q?BUbNXmQgtHMTlT6525uV2ESKaCaKcV7CrJFGYYH7rFa5JX4ZBAwUqbw2+axi?=
 =?us-ascii?Q?Ir//GDXItddWPxuwuQgmT0w72Fugrqgx3suDKPjjfltPk7xU1B1uC4lPUEtX?=
 =?us-ascii?Q?q/EjsQUCp33FFgBI9ucQLADG1+sz6epyLhSxLMNZC+bwHZO7KMsdtfzaqoeY?=
 =?us-ascii?Q?5MQaQhlbkmkZgRkX94PGunAVI84f5fD3e+gXaRaE?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fe03db-248c-49af-27c5-08dd07b47dac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:36:34.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWOeGJHAFJ2in/xO9XAe9LisCL891xaearOA4JDJJ6M5tG02bTgordRgZ4GscTUhrx2NHLJ/RB0iWZTl8ngfdeMQmY7vVu9X3Vzk4ApePUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9490
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 09:36:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/816

Hi Paul,

On 11/18/24 9:04 AM, Paul M. Bendixen via lists.yoctoproject.org wrote:
> [You don't often get email from pbe=3Dtrifork.com@lists.yoctoproject.org.=
 Learn why this is important at https://aka.ms/LearnAboutSenderIdentificati=
on ]
>=20
> On 15.11.2024 15.59, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Paul,
>>
>> Please version your patches when sending (usually -v N with N being
>> the proper version number should be enough), a vN will then appear
>> next to [PATCH in the mail subject. That is necessary for maintainers
>> and reviewers to not have to figure out which one mail is the latest
>> and greatest patch you've sent and they should review or merge.
>>
> Ok, makes sense, couldn't find that anywhere but will change for next tim=
e.
>=20
>> I can also recommend using b4 which does a lot of things automatically
>> for you :)
> Thanks for the tip, I'll check it out.
>>
>> See comment inline.
>>
>> On 11/15/24 3:51 PM, Paul M. Bendixen via lists.yoctoproject.org wrote:
>>> [You don't often get email from
>>> pbe=3Dtrifork.com@lists.yoctoproject.org. Learn why this is important
>>> at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> The SOQuartz is a RK3566 based compute module and parts of Quartz64
>>> series
>>> The Model-A base board is one possible board that supports it
>>>
>>> Website:
>>>        https://pine64.org/devices/soquartz/
>>> Wiki:
>>>        https://wiki.pine64.org/wiki/SOQuartz
>>>
>>> Specs:
>>> - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz
>>> - Mali-G52 2EE Bifrost GPU@800MHz
>>> - Raspberry Pi 4 CM form factor
>>> - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.
>>> - optional eMMC from 8GB to 128GB
>>> - optional 128Mb SPI Flash
>>> - 10/100/1000Mbps Ethernet
>>> - WiFi 802.11 b/g/n/ac with Bluetooth 5.0
>>>
>>> Exposed preripherals:
>>> - 1x HDMI
>>> - 2x DSI
>>> - 1x eDP
>>> - 1x LVDS
>>> - 1x CSI 4-line
>>> - 1x Ethernet
>>> - 1x USB 2.0 OTG
>>> - 1x SD
>>> - 1x PCIe 1-line
>>> - 28x GPIO
>>>
>>> Model-A baseboard:
>>> - 1x microSD - bootable
>>> - 1x HDMI Port
>>> - 2x USB A 2.0 Host
>>> - 1x USB C 2.0 Host
>>> - 1x 5 pin USB expansion
>>> - 1x Ethernet w. PoE
>>> - 1x 40 pole Pi2 compatible GPIO
>>> - 1x MiPi-CSI 2 lanes
>>> - 1x MiPi-CSI 4 lanes
>>> - 1x MiPi-DSI 2 lanes
>>> - 1x MiPi-DSI 4 lanes
>>> - 1x PCIe open ended
>>>
>>> Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>
>>> ---
>>>     README                                      |=C2=A0 1 +
>>>     conf/machine/include/soquartz.inc           | 15 +++++++++++++++
>>>     conf/machine/soquartz-model-a.conf          | 12 ++++++++++++
>>>     recipes-kernel/linux/linux-yocto_%.bbappend |=C2=A0 1 +
>>>     4 files changed, 29 insertions(+)
>>>     create mode 100644 conf/machine/include/soquartz.inc
>>>     create mode 100644 conf/machine/soquartz-model-a.conf
>>>
>>> diff --git a/README b/README
>>> index 09f8691..85ab2ec 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -45,6 +45,7 @@ Status of supported boards:
>>>                 rock-pi-e
>>>                 rock-pi-s
>>>                 rock64
>>> +            soquartz (on model A base board)
>>>
>>>         builds:
>>>             32-bit:
>>> diff --git a/conf/machine/include/soquartz.inc
>>> b/conf/machine/include/soquartz.inc
>>> new file mode 100644
>>> index 0000000..6714efc
>>> --- /dev/null
>>> +++ b/conf/machine/include/soquartz.inc
>>> @@ -0,0 +1,15 @@
>>> +#Copyright (C) Trifork A/S 2024
>>> +# Released under the MIT license (see COPYING.MIT for the terms)
>>> +
>>> +# Common override for basing a SOQuartz design on
>>> +# https://wiki.pine64.org/wiki/SOQuartz
>>> +
>>> +MACHINEOVERRIDES =3D. "soquartz:"
>>> +
>>> +require conf/machine/include/rk3566.inc
>>> +
>>> +# A machine using this baseboard could use these options or overload
>>> them
>>
>> I think it is actually required to set those variables in a machine
>> configuration file since nothing else defines a default? And since
>> those are now commented out (as they should).
>>
>> So I'm just nitpicking on the phrasing here. I wouldn't necessarily
>> send a new version just for that, but maybe Trevor will have a
>> different opinion (or fix it when merging).
>>
> English is not my first language, but I was trying to convey that if

Me neither :)

> starting a new board, these could be used as a starting point.
> Could you suggest wording that would convey that more clearly? (maybe I
> just did)
>=20

To **me**, *could* means the ability to do something, or something that=20
is possible to happen. Not required, just recommended, maybe will=20
happen, maybe not.

*should* has multiple meanings, mostly depending on the context I guess.=20
It indicates a "more" recommended way than could.

Basically I see it in this order of "necessity"

might, may, could, should, shall/must

shall/must is a pretty rare occurrence - and more "legalese" speak to me=20
- but is technically the right verb to use to convey that one REALLY=20
does need to do that thing we're talking about.

Here what I'm disputing is that it is absolutely required for a machine=20
including soquartz.inc to provide those two variables otherwise it=20
simply won't work (haven't checked but I believe that's the case). So=20
"suggesting" to do it with "could" is a bit misleading. "must" probably=20
would be better here.

https://learn-english-today.com/lessons/lesson_contents/verbs/modals.html=20
or https://english.lingolia.com/en/grammar/verbs/modal-verbs I guess=20
that could help?

Anyway, the fact that the variables are here and with the small comment,=20
people would probably get what they are supposed to do with it,=20
especially with the model-a machine config as an example :)

Cheers,
Quentin

