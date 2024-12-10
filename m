Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65480E77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 16:37:40 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.58])
 by mx.groups.io with SMTP id smtpd.web11.15018.1733848654626622903
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 08:37:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=nGLCAFwT;
 spf=pass (domain: cherry.de, ip: 40.107.20.58, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQkftGKw7+tkQk31M9kF8tbDkHhlxgMJ+fh8oyMapaCkrD1YPur+89MVGB1Zo6kuDjKQLam/yUxWMt4vbQsMs5OIPuHSHY7Ga73iXPdjGd4hCZRv/S5+QBxheb/QgnS4/8k14HZ0AgaEbh73tWZ/c9yNEC3oOdP+O4QYdbxvGetsEcG5z9g/cp4hBCskMU6u7k3uHt+TEIFT8+R4cdyGjZv62krlGCmd1NQ8QIdC05Jk2XaXJyOfbVkgFsDGtkjjuJBaljzmYMS2F5ZGBEGKAJgF7z8o3uwTWgWpziYI+ukwfLX+PebdcrRRGulyZ2ewEQXLArdqjuFBk9QRld5RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef8MmBnZlaN8WyGh/nS/yVNoWJ3h42SXVGtaRxdDcQs=;
 b=qiZyOXeRjiWUOQlg9aJhNf1i3xobPTY+0G5Lj83g0e3NDYAVLfAOHJKuAEcXCQqAY4i47bQ4N/4ngcV0DZeAmdJE5Y82RQBuLErWG7ilGP9Ps02d0myj7A5wz41jz+ec8BZgK4tZJEMAj1mpGsz5D8uKXBocA529RW/Bju5CeMCAhbO7fJwFhHOvtEw0QYWQkuZV4XS9bPeAx09MN97QYxIGWA7kxNIXwdtedDbZVE77evrp/dnqaJYZHlcOq6ars8pd0nh3Gm3yJCLIN9QFnN7BsUiUC3ciAm4S8prYMsTnam0d928D8hDv7PAxOqqRz9LSaU+AU8SCwHPFt2tR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef8MmBnZlaN8WyGh/nS/yVNoWJ3h42SXVGtaRxdDcQs=;
 b=nGLCAFwTlimNE80Xz+9Hv+HmThfG2n/tqGeP8uzrXrMqUFu6jfZBhZq2bd9IweXeO/IYwuLVGOuqF3JAweCgweZp6Tid69eTptPzuWVkMGRkbXK079jU5XIGzAElySaJBhHglxiVVI8RzDBzMeoVzuAcG1HXJDBgp9Wsi6Pi4Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8779.eurprd04.prod.outlook.com (2603:10a6:20b:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 16:37:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:37:31 +0000
Message-ID: <94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de>
Date: Tue, 10 Dec 2024 17:37:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
 yocto-patches@lists.yoctoproject.org
CC: Trevor Woerner <twoerner@gmail.com>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
 <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
 <de2a1774-cdad-440b-be04-7eed6207c741@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <de2a1774-cdad-440b-be04-7eed6207c741@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: ad732b4c-9b63-4e39-4d6d-08dd1938f108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3yJbsUQabH518RaYrdUOsQWUJQerbDzhOgFIHlIh+yWMjOpe8DT9092ATdrj?=
 =?us-ascii?Q?eYfZP00CLNqbT4NyjkoK5TlOqZwM+syCpjLfwtcI0JmBznFgVu+dgFIpDIC3?=
 =?us-ascii?Q?yYVTvTlaBK3f3DpCh/yZJoiRvedI87u+b1Ce3i2GZyIxOJdpqLJsCSaFkrXh?=
 =?us-ascii?Q?RoqoTjL3fZHIcYRjF+1IsMr1R9hUue3g9QAMRifGeHUAxSfRnBURF8QhIk6I?=
 =?us-ascii?Q?pIFbLZeyK68MsD6cEk2NRdsdHQHTFZP/e0EuTE+tuZBWJwmZgZkoRG9mYH1z?=
 =?us-ascii?Q?BNZaVl47pTudD5qSUm7hDea/JziJCP+1Tha3qiCu/XVKcnhk8FUjpoXydSHx?=
 =?us-ascii?Q?J7j3EWEHRfpfNqQMfJAkEIRS62P786GDz+8plrYRmINT92oJIITzDYQUTupd?=
 =?us-ascii?Q?opaIB2+enyJMZW++oEhxHkqf9akiu5sJwK1Meb2+NCJsFoDpDWpZQlFWwVh7?=
 =?us-ascii?Q?rJirPA7E0mfSp/O/f4JmXW4tHwztLg1ICTlqYUuSXw7usBKsWBPmxwi2pFwU?=
 =?us-ascii?Q?X03rv10VUfIsX8due2ldK9Yq+IE+z3hW1Wqe02zo7qTnuDjdcspcx7mxUyYL?=
 =?us-ascii?Q?h+pE1alm9uGaJYmXfODODFYSQVZ2ikXDj3JgoYAfTYyGhMpV1ErGtkyYfMe2?=
 =?us-ascii?Q?rH6Ql+aHIE3VVRE5ZJ7Li6+KYwAYGsRmXImu9i/lABhLV1UaUPjJxuCBJYld?=
 =?us-ascii?Q?BgGU8tZSjCsG7MNo6HpYP9eSDKGlPXayj66Xf/8K0QOBXhk7YP9aLY/RvCJy?=
 =?us-ascii?Q?hVCUT2YhIIPTph5Q0wA9+ZRr3jD/H10KckVa5UE+xaz/U7F5QZzmF30adeuV?=
 =?us-ascii?Q?RX7zmHiwsk5ph6CbaUZLF0kS+r+hLBGaJCZNoq98TmY996QEeIsSDeeqvRTl?=
 =?us-ascii?Q?eIbRe6w3Ywc+NJvVfdExsjqWU8c3+7arsDaHjrsaO5DG7qLx2P4r+iFH1lCq?=
 =?us-ascii?Q?Uo6wgFawDJHFbQu3/FRr6TLJCg8dSdfr2CCqx4QglTWS6gjpUyJUF9T3Gh4o?=
 =?us-ascii?Q?fE6Yua2A6TGnfw+g/K7T2qO7BNTkl/jCaHzUx2CgW/YBNFPbgJtG/dUctYCr?=
 =?us-ascii?Q?4znX2dXMptpfdTdnOHmux0gLCdaOlpSIuaW5zvdbRLtXLzEfKnlyEYkk7IWA?=
 =?us-ascii?Q?mzcQnwKFm28d41CXOkPc8zq2jPrWe3GD8Vj1zik/My8w5uaxnkadOedWTj25?=
 =?us-ascii?Q?YlN+D9cxaE3I+V2/F75ipdO7OJzf8+USJsjCpFC75KM/b8491Hvpr3ZAJoks?=
 =?us-ascii?Q?hXJJxexU9Zmgk5mQ5LMQ1e19vwRB8FemZ6ogiaB6fJwptls0RoL/bnFH9lUV?=
 =?us-ascii?Q?pDU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lpolykbVHBtm4qScwHfSD45HSnNvs1ZX/wCZnPD/GMdyR8m92DtfUnZRlPRA?=
 =?us-ascii?Q?R6wU5feRPg4BI4eI45dH/rOP1NwpEWBUxbtpG9cMMGvqzl2+KCaZLODMyWwJ?=
 =?us-ascii?Q?W658QmLcQpGclSlBk4Buu2yysEAymgaEjrWGEje8P4DayUB4Khw0aZ34fgkC?=
 =?us-ascii?Q?i21YNjYPxmzOhC1dityiBo4zUQJdujMRFATJUIRI1vxfQjkMqCtHenl26EFJ?=
 =?us-ascii?Q?/FET18cP8PrlNHclgaF8oRDuDYuCvOmy96F8eduaf4oSm+LI+JrD2P5SGcow?=
 =?us-ascii?Q?EHnHur8F5aqVHh7+Q5pnJib9hG3q0SXIj0bnCocnO0fjL0DbR1kAGPLAJVjd?=
 =?us-ascii?Q?Hbzg1ZOUIKXAiSTSwRWY8IYCS5O9EQW10ZZ5h9KbqH+lfpax8h0iWd9d7BI/?=
 =?us-ascii?Q?KbMikGFJJDMsmTYie/3EhB/kU4CAsHHA7HrTslBhyom51J9NVnRAa0i3qCRz?=
 =?us-ascii?Q?oiG0zFID09XP8Mf6cfVRHNcosi/tO1yAGvVKDhpE3Sx5PrdwMirS2l6Y/eTV?=
 =?us-ascii?Q?WYSweZu8DYCUURnnEUbHL9AV2d8xKXPJxBrmnWbMtr7lysuZU/ES7yYJlS+1?=
 =?us-ascii?Q?y+VWsm28XL9dWjFSK+39wdIUw8IFSelD2DV8s2XJ3K+yOmW/Dl8ewSfBtQgo?=
 =?us-ascii?Q?Mdj0qq5XmZx9MjRtJLMCV0ewXgR8hG3eajdZYFidzr4+ZHnNReSV5KdO+9Vu?=
 =?us-ascii?Q?zd4nE8WYUXgtRlXfY/IGQpaIDk4L+XE36Slg4Il6sQMLnjGd5EpwpxjUf07t?=
 =?us-ascii?Q?XIZKIRqqHB8B2W2mZ9CcZP3LEkUTgItRjfbRWOQevwLEBokSBql3t+8gaTa+?=
 =?us-ascii?Q?fqa3oSFyXDLBcg38GlPScinJsWlZwtjRtgK2ezbS3YkJjJ6exHxp0pjhwtmZ?=
 =?us-ascii?Q?9VOJaorKxQXHa9e7XdDCl5iSr70zLML0NXKhXf0rYzKgGISbrm5mis6VpuQC?=
 =?us-ascii?Q?4Q57smManVd3cQEWp7Dq9bE2jXvN6mU9uZXnbsZoPiOA5AuXqJx3UxsxueiG?=
 =?us-ascii?Q?qEId6S22nL5asrvMReEMawHBMi15/ItYijDSB0v8o4n16V5YkIll8O7W05X3?=
 =?us-ascii?Q?3MOjz96MUAk3dyEIQ1kPvxpUJXv/esx32QvXm6gBM8yZcETNqqo6E+HPXlv/?=
 =?us-ascii?Q?FdIwIq/KhsKvR9F2anNrg1XEFAvLN97f+D03jyBe0X53u4UGqHlL0i/7IPth?=
 =?us-ascii?Q?TV7DwSV5WQFSAst899K+G1xucb9aH9sIgt61GkfzBc6iUvz8x4c0btfcNAPm?=
 =?us-ascii?Q?jATesTgfUgIafayzSCkmWNhiXl1mX7219ZwmjGo/SlK3kCZV7ZRvu5DCWC16?=
 =?us-ascii?Q?2t19QG2VzQgzYSvYRxK5T9sDySD8igkongAUaCEmONOYloylqTCQDEvZAK1x?=
 =?us-ascii?Q?isw2cgpbnWQ2bhTAtJDyfp5ZoXFargeqDTRrYcZRz7mDOMDumFxMYhmVZQ4n?=
 =?us-ascii?Q?HiEqwwOGZNK6kwU0HArJAg66XfXQ1Tw09PCH5WikDpkPwUQySG4saZ4Gjmgx?=
 =?us-ascii?Q?xXo2/VgqYqa7UMl5Ce2LIHwZlQJ6z20Rn5JiJVwRGteG+McrZN/qUsQjOvB3?=
 =?us-ascii?Q?tWH86tpfpNAE7ruhExe43ja005Jyw0ig/NUbPzC9JF1VTXgojXmssQFXbI0s?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ad732b4c-9b63-4e39-4d6d-08dd1938f108
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:37:31.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxEVvp1fvieVsYbG8jfp8chRExYKDyRpw1R66P8Y2+3PfW00d5mMwqezUxQL6xBTEj//9GmmUlFicLoY1WrLFSxCUQIsuDe+nB9fX+Hq2Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8779
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 16:37:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/883

Hi Oleksii,

On 12/10/24 5:16 PM, Oleksii Kurochko wrote:
> Hello Quentin,
>=20
> On 12/9/24 4:22 PM, Quentin Schulz wrote:
>> Hi Oleksii,
>>
>> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
>>> [You don't often get email from=20
>>> oleksii.kurochko=3Dgmail.com@lists.yoctoproject.org. Learn why this is=
=20
>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> During the fetch stage of u-boot for radxa-zero-3, the following=20
>>> issue occurs:
>>> =C2=A0=C2=A0 Unable to find revision 8cdf606e616baa36751f3b4adcfaefc781=
126c8c=20
>>> in branch
>>> =C2=A0=C2=A0 rk3xxx-2024.07 even from upstream
>>>
>>> This happens because the hash of the head commit for the=20
>>> rk3xxx-2024.07 branch
>>> is different from the one specified in the recipe.
>>> This can be verified by running the following command in
>>> <yocto>/build/tmp/work/radxa_zero_3e-poky-linux/u-boot/2024.01/git:
>>> =C2=A0=C2=A0 $ git rev-list -n 1 rk3xxx-2024.07
>>> =C2=A0=C2=A0=C2=A0=C2=A0 2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead
>>>
>>> Update the SRCREV to the hash of the current head commit=20
>>> corresponding to
>>> the rk3xxx-2024.07 branch.
>>>
>>> Fixes: e0b13fe834b5("radxa-zero-3{e|w}: add")
>>> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
>>> ---
>>> =C2=A0 recipes-bsp/u-boot/u-boot_%.bbappend | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-=20
>>> boot/u-boot_%.bbappend
>>> index c939a48..9432e2b 100644
>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> @@ -3,8 +3,8 @@ require u-boot-rockchip.inc
>>> =C2=A0 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
>>>
>>> =C2=A0 SRC_URI:radxa-zero-3 =3D "git://github.com/Kwiboo/u-boot-=20
>>> rockchip.git;protocol=3Dhttps;branch=3Drk3xxx-2024.07;name=3DKwiboo"
>>> -SRCREV:radxa-zero-3 =3D "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> -SRCREV:radxa-zero-3:rk-u-boot-env =3D=20
>>> "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> +SRCREV:radxa-zero-3 =3D "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>>> +SRCREV:radxa-zero-3:rk-u-boot-env =3D=20
>>> "2e2ae1fb69a25217640bfe2fb9abaf9f4fbacead"
>>>
>>
>> Master poky now has v2024.10 and at a glance it seems the Zero 3E/W is=20
>> supported, so maybe we could simply ditch those overrides for master=20
>> branch in meta-rockchip?
>=20
> This is first time when I started to work with rockchip so I need
> some time what is the difference between Kwiboo's u-boot and upstream one=
.
>=20

Welcome to the community then :)

https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-2024.07/ about=20
~30 patches on top of upstream 2024.07.

Kwiboo is known for upstreaming his work so it's a good idea to check=20
upstream every now and then. I don't think Kwiboo is guaranteeing his=20
branches won't be rebased (and if he did, it has already happened here :) )=
.

Another option is to ask Trevor or someone else to have a git repo with=20
commit 8cdf606e616baa36751f3b4adcfaefc781126c8c hosted somewhere=20
publicly and point at there while they guarantee they will never delete,=20
remove or rebase the branch or repo.

> If there is no any specific patches and the difference is only that some=
=20
> patches haven't been upstreamed then I prefer this approach. Otherwise ..=
.
>=20

I would personally just build upstream and see what's broken there (if=20
there's something broken).

>>
>> Other release branches should probably get a fix similar to the one in=20
>> this patch though. Or ideally just download the patches from that tree=20
>> and apply them on top of v2024.07 for styhead (we would need a new=20
>> release branch for that though). Scarthgap has v2024.01 so that's a=20
>> bit too old to apply patches destined to 2024.07. But we could maybe=20
>> point to v2024.07 upstream+patches instead of pointing to Jonas=20
>> (Kwiboo)'s personal git repo.
>> What do you think? Trevor, an opinion here?
>=20
> ...=C2=A0 v2024.07 upstream + patches will be the best one option we coul=
d=20
> have now.
>=20
> I have the small issue here. At the moment I don't have radxa-zero-3=20
> board so I can check only build. My target is RV1103 SoC for which I=20
> want to add support to Yocto. But
> I think that I can start in parallel update u-boot recipe for radxa-=20
> zero-3 too and then ask someone to test on a board.

It would be nice if Trevor still has in his DL_DIR in his build bots the=20
archive for the commit that isn't reachable anymore. Then he can=20
generate the patches on top of v2024.07 and it'll essentially be the=20
exact same code as here and even guaranteed to not disappear.

Then you don't need to be able to boot it if it's essentially the same=20
patches on the same base.

There doesn't seem to be support for RV1103 in the kernel right now and=20
since we use the kernel device tree in U-Boot, there's probably going to=20
be some work there. Do you know how similar RV1103 to RV1108 and RV1109=20
maybe?=20
https://lore.kernel.org/linux-rockchip/a5d4f421-5120-4421-944e-d39d67e482bb=
@linumiz.com/=20
seems like someone is creating some board on that SoC as well, maybe=20
there'll be patches at some point?

I would recommend getting familiar with compiling and flashing the=20
kernel and U-Boot manually on your RV1103 device before trying to=20
compile them within Yocto, especially if there are patches to write for=20
both to be able to boot upstream. For downstream (vendor kernel for=20
example), that's a different topic :)

Cheers,
Quentin

