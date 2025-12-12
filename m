Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCD1D4922E
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 14:06:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13257.1765548369225791590
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 06:06:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=kOAFk7ND;
 spf=pass (domain: cherry.de, ip: 40.107.130.43, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4EaUqawdePYejfwS9a/FMM260splFvxSMTTXYgsncKz47HfwKTP4G02EC3atOJE9iCSBAqK/EHBt5jmKY8RDIrNH3MFgYVgOHyBewDzH30p2ox233vyOT7ie5wtGd3yEoH+zPukihgDTvHURZC/BHtFop5VfNatFVISp92BX3jttZnI0W35zsBVp22vWWABuVDjS6oE4wmZVYA541wrLqMgFi9KVQZzQL4k9l1Cz82HpR7lpduTugMzlmWwPatyUqUiNTblVzYQ0JNA1xPYsRWQ9l6xRFjN4fpbJ63haPQ3hrTqQq9hThepEfXd2/EP00XyZUnSexXnzS89YfXS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pnW+rkMHJLs30dseKnRyOeoKCxfedPl5gdNQxp79F0=;
 b=Woiqg2lQeBx33MEl77wqfKyDrQwjK9eVNsisJtXl+yKks15ABqariNu00nMrMEsQ+cNe0uTIuQXn2MzaD62z3qEoAZca66DPsTJdv+Uq3lbz9WdEO54xu8va+lTX1KLJZ48+iRvvuAjpdKRQcyVKLzf8eiVrQ7dPamK7jNglTZ7TmLi187a/SC+j+UNHUYIptaOV5N/vvxnK6du5Wrut6bLQYHmSvJAjR+C3JR9B8BV9kRK2ksMdbw5jSwjioN1Qn9CAN60ZiChVsU/QYTLBjGgNwQRvAvIKykIbaOjLqHXoHnzdk95bfA5KaX2dtbJwQ2TI4RcPN70AzFKIo3tktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pnW+rkMHJLs30dseKnRyOeoKCxfedPl5gdNQxp79F0=;
 b=kOAFk7NDkbslGsZtKxhAQLsC4PwhBJbOeIWwjdBHijgiMX35pTqhVzvdTix6okPkl/o0JEE96ITGHNBgHSMCx74ArEC4zry9gGeo3DAIWfCRZshN3QPkCWztQ7bRJZnqb0BVNnqOMO1cIYARVlquCuAuIU8+UjyYjEm4N8GFCa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 14:06:05 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 14:06:05 +0000
Message-ID: <1142de2d-3820-4d2a-b51b-14947b710f3a@cherry.de>
Date: Fri, 12 Dec 2025 15:05:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] provide a filesystem
 overlay example
To: yocto-patches@lists.yoctoproject.org
References: <20251211210332.25509-1-twoerner@gmail.com>
 <12e8c8b3-f1b4-4aaa-abac-9449f9daffd3@cherry.de>
 <20251212134919.GA8875@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251212134919.GA8875@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce0a8f2-a124-488a-30f4-08de39879709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Uwq+Pu8iGu5UM5BXIHbu3ZMfaVkRj7KY0OlzzIV5XjxtYSYuks/OmwgBvaCq?=
 =?us-ascii?Q?eEoYKwP1fI5Sen4BK7KogYdhAqai2Otqr6Y4jvsyo88ohtmJQnxw2CtTRO/3?=
 =?us-ascii?Q?Jr4F74jGWtkqU8ifvYS4pkTURCqFdDA5uTtZVdSZ+t3u8E3xJInYtXlOtjOG?=
 =?us-ascii?Q?mwqGnKuAf3ro6QQcd8tPR3elvv55cDs2c81MKu07Ihsu9Pre0JyRs2KvG45w?=
 =?us-ascii?Q?VvHGK2KUOxEjAKoe3SD99JalWcPF+2n2Sqf0YRjjMAxBvgMIMs4jHJMAswx1?=
 =?us-ascii?Q?wbdPgaLpSX1OM2QdI/sPo+2hCU+g48QYPOPQEjtQ4YoaeL+mlo+0FsyOjksH?=
 =?us-ascii?Q?s82i7ABrivQrRbOLqFnLvnoWkRf+kbbfdGP1YoWnc3KONAnYiEauETYgLl/Y?=
 =?us-ascii?Q?HyvaqD0mcJT3a/hASqVtURNPoXVQpYw3ysUytpAJl8xEy9K0LP71RQLA3kkk?=
 =?us-ascii?Q?ABi8QbpVl/PxVKbJHNBocce0UicXDcyNgbcdQb/bb2wHsivSoqTWGp4efkex?=
 =?us-ascii?Q?Uwxg3b46GrLdX7B0I2iCFGj4VO6m8kfvyRcmyTUKu6fpT3erYJf4x8S4vZch?=
 =?us-ascii?Q?TW1CstaGoS/FToOlMKrSgOl9EqJsNsxeOwxnDSrCozaNKFxtmZgXk/xbfot3?=
 =?us-ascii?Q?jFcE3AxKZkvorpfmaBH7oiFlq9BIC/BWz0hVr3rpGN/cC2w8qGsCTjQvJvtP?=
 =?us-ascii?Q?AivDVs+64SpI+VawOaP/eaKrvQ/XkbonWicQYCPHfy+Ev431EGNffwZTRuuj?=
 =?us-ascii?Q?hfGzf3SAahMlfjy1xKeWHxbFENGDKIKYP9FKNxdpYo6pIl4QfCiwuMeCYUbD?=
 =?us-ascii?Q?LzQ7s7DXO+HFkUe6/n1jd9MTyErCojpo+I7nNuWZE0gJ/3pd3zfMLSHHbc1w?=
 =?us-ascii?Q?U9vCd9ilJCDZV+uiIFXyerTFDcHdsWimUTf15buWrfh7hcpzkalwtWIahnsD?=
 =?us-ascii?Q?17nH2q5EwcIULjMb+6jGXWJyLKpM71/MUJTcWsf8g4sAXZH+qbpxwTI5/sKk?=
 =?us-ascii?Q?6RR3nF5f5rygESyZoxTMJsp9Jwat+/0MBC9vD5lNUlN1c8NtljN2h6lTLU1g?=
 =?us-ascii?Q?pntnwL8quFtglqwBev3pAy/IY2R9HUE3FtAkvpC88ug2nnIhF3GC+0cS7zqn?=
 =?us-ascii?Q?7Kn7iNIhCgxH4wRiNGlpSpzoaZ81XL6mV4mhzfSSv9XxyIFnyoSG78VsVowb?=
 =?us-ascii?Q?unDSrhDLO7Z3EKExeoyfYd9dcQPPDr0DtmibnFUVR88xFhUZCMgWZg6jwwWQ?=
 =?us-ascii?Q?nXoyxhwSS0HzZfu1PCy4ZkMIuIldff+KjmzsAlet28kC8ru7XXd25YHqej+7?=
 =?us-ascii?Q?7xNEverYJ5qwJnzBxVmYfTlKmCxCFa9m7N9PClu/8evljmF5KU9Vb2AAIfY9?=
 =?us-ascii?Q?t2H+WVk5VIPz8wbwPP0LkzXrjXPDrqRKDOH6GCHivhw4JuAH+v81u4RWxfoD?=
 =?us-ascii?Q?aZCucFgSVvHYMOd/0iD1d3pkGoVYf6uJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PUVYoE34tw5NDG+qRas/6i34F9jaDZWz5gtvaI4kvr4JMRp8c4mKcNkOZnzy?=
 =?us-ascii?Q?g6kSVBEfIbAnbLzB9P2hvNVrDeQC8crjAiw2OR26TouChowCyDCyUx4OkeIZ?=
 =?us-ascii?Q?jMZDagUsHVyApTOopQG/D9EcJ0YiDz+LDqSpMC3ZaFSRVSaS7h0MF5euWR3e?=
 =?us-ascii?Q?jcxFZoXP23RC7oPaw2F6+fITT/o2RsHSHpSdNg4zhGx3gCldLLxU0pAo3W5+?=
 =?us-ascii?Q?32YmdRifwFNMjvZFEYi3UcTgRCJt0e4aErs3Yp/xLT3wOi8+5Ja4po2LKXx3?=
 =?us-ascii?Q?3VV00x86dwKVG9DmBohHZt10PFAzqzLWnihd/aE95kHaBCZDNDSDU1ixRrOy?=
 =?us-ascii?Q?VKXgYCyM7aawTBAEbifYgmB9GZh2cZNvQxZ86An98fnRxiPHGPs02nIU2+YO?=
 =?us-ascii?Q?xNGYtBnnsT3cVZaWzyWCyd5Nhv2B0hAYscWuuivzUA8POlA0nxC/Tj/mcrbW?=
 =?us-ascii?Q?rmQ8ti+dZFFPMvtLm5NyiGJOnsMOODfeFn5GlXhSDzio5Eo0q+l/RoqpGuZZ?=
 =?us-ascii?Q?UkFcVGvRne0x+3q6oYc8ln0UVRkApLmrppnPRDKWsBCB9awaa3eQsn9H/bhg?=
 =?us-ascii?Q?6JTy5xGq+IVQLFWfgV7a5D9xLrEG67F5Us5fzfVb4urnhLLZ0RFuz9Nd1fgL?=
 =?us-ascii?Q?/82dKEmf8mRGB2cgbTFNLM39YqrbtA98yW/8MA9suwLFcsAqo3wLWISnXl7V?=
 =?us-ascii?Q?8SE15Rbmmnw/N3iJiZp/jiuIfwUH32fFL8pH12QRX2OQEVH6Kyc5CdjW/zfA?=
 =?us-ascii?Q?DaqV4oDlfQSLhAllTqlSjgi8ZYdItT1ggiXzrkmmlDlQGbfI5QUjEO8CfNyO?=
 =?us-ascii?Q?Rzz/kNReE+3wNFQUI8mLhRumX4Qnwofd5AOW3xyxfL5R+sHExxTJcd7afRDS?=
 =?us-ascii?Q?5p89eUKRdzjpNzS5414xBrq7ON7a9mH3fRjI9lBNW+C470RQqQ1f0n3981oj?=
 =?us-ascii?Q?ya6HVEarE43799wSv4E/wtVmCeGfHmC4ssOz+uVrqWyqny2BSnuJ3g+XpCVO?=
 =?us-ascii?Q?lSwXmy9c3O2lsXtdozX5pJ72TxjjszuBqce5fy2nhjhguPOZcLs0/Okl7yW5?=
 =?us-ascii?Q?9Fs666XNzNAZzlTU7lx63VgD8jWaltGHxsGbS2T8C3D0be5wAVlukk/S3A/O?=
 =?us-ascii?Q?aNWmrEBVKv19zED2p9Eq6B1A14YR69OGtxFQLhiAeC2NyYJGKXVi5ykmxtaj?=
 =?us-ascii?Q?DMva2oHEfTIJJgIKiZnJ2EZ8ECfCsLHmFcH8CFrH5vaPON5N6XhkcyREWx8J?=
 =?us-ascii?Q?x4wwHWh0ZtNi93uggpRvquKiczFsauZLi9CkxxFZknvs0Kh4ONuPPBfM7r5q?=
 =?us-ascii?Q?g8d8WGbJPhavR8596Ky4dxEhEPUlYBh8rO+e/98580QdijFXvoQXWYKDpDG9?=
 =?us-ascii?Q?C1X2D1e3QZB4/TNjH3sPGm9IkuBwZqf2HFZVxRf65Cf6Rc997Zo/ab3geizt?=
 =?us-ascii?Q?GH7IrlQNTTuxZJtDR0lAbAQsIm35AuIjChHeOWRfmowVC0CuEcd7tUFTqlS3?=
 =?us-ascii?Q?FCm6/O7uOQ05moRbUJLB/kJkYppU+7JiK4Cy/VyX8Ysb2mHYQYSggLbkZ82n?=
 =?us-ascii?Q?lEVqHQrA8ArCFjq1mpM6PP4wBPv3V7AIsJXlYnKoB61X0/alJi6R7bTNeMz3?=
 =?us-ascii?Q?3VquDy2rxoZtDgwv+I0SUak=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce0a8f2-a124-488a-30f4-08de39879709
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 14:06:05.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5+xaQW7wlTjJPfaeM0DNIs0e6nUkxiKMVl96QuGSdy8R711dPEWJERJJ1f+xc12o76H7Hsbv0P71xABn6SVE/d5XQmAAP7CPuEPv0z3Eh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 14:06:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2774

Hi Trevor,

On 12/12/25 2:49 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Fri 2025-12-12 @ 11:47:55 AM, Quentin Schulz via lists.yoctoproject.or=
g wrote:
>> Hi Trevor,
>>
>> On 12/11/25 10:03 PM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>> Additionally, CONFIG_OVERLAY_FS support likely needs to be enabled in th=
e
>> kernel for this to work, so mentioning this would be nice? (though we al=
so
>> didn't mention this for the VPU, so... :) ).
>=20
> It's funny I didn't mention this, considering the other email thread in
> progress ;-) The aarch64 defconfig includes:
>=20
> 	CONFIG_OVERLAY_FS=3Dm
>=20
> which is good enough to make this work. It also includes

If one includes kernel-modules in the image ;)

[...]

>>> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/hom=
e.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
>>> new file mode 100644
>>> index 000000000000..d6a384fa9c75
>>> --- /dev/null
>>> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
>>> @@ -0,0 +1,13 @@
>>> +[Unit]
>>> +Description=3DOverlayFS mount for /home to /data/overlay/home
>>> +Requires=3Detc.mount
>>> +After=3Detc.mount
>>> +
>>
>> Why is this not data.mount too?
>=20
> I did this patch one piece at a time. It took me less than an hour from
> start of reading to getting /etc working. It then took me the rest of
> the day to get /home added as well. The problem was with
> ordering/dependencies.
>=20
> If I ordered both /home and /etc overlays after data.mount it would
> always fail; either one or both of the mounts would not appear in the
> `mount` output or (worse) the overlays would appear to be mounted (they
> would show up in the `mount` output) but one or both of the mounts would
> not work.
>=20

That's really odd. Half wondering if this shouldn't be brought up to the=20
systemd community? Not sure exactly what could be going wrong..

> The solution I found was to explicitly order them: data =E2=86=92 etc =E2=
=86=92 home. In
> practice it didn't matter whether home or etc came first, they just
> needed to be strongly ordered.
>=20
> While trying to get this right, sometimes systemd itself would throw a:
>=20
> 	[ SKIP ] Ordering cycle found, skipping Ove=E2=80=A6mount for /etc to /d=
ata/overlay/etc

But there's no circular dependency... That's weird.

>=20
> on boot (sometimes for etc, sometime for home) which at least warned me
> that something went wrong. Other times it didn't give the error, but
> failed anyway.
>=20
> tl;dr: it's a bit finicky ;-)
>=20

This is the kind of information one would want to have in a comment or=20
in the git commit log so that we know *why* something seemingly odd was=20
done. It wasn't a mistake or an oversight, but a work-around for a=20
specific issue.

Cheers,
Quentin

