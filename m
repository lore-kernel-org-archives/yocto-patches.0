Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1AC54FB3
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 20:14:49 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.43])
 by mx.groups.io with SMTP id smtpd.web10.2537.1748549687492030234
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 May 2025 13:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=gcWa6knx;
 spf=pass (domain: axis.com, ip: 52.101.71.43, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qD90MoeO8TEo9S/x68yITXqaAPALeLGcPXyFXFq5zTIyYqNuPEmZQ6WFYsYF2aT8YGpjIVMDbI+WNPxL6nKwcMVucvSZUxFfLUXggaxV0iwszku2ZZIqXs7+MAL88C+U6teWcQLZRp1wU0B5Hn0tPnPvsRJ07gtP2n/mpiyNODVVVWgIdB3UthRues/QvC4OG6BpNgTq2WVMpIs7AyIGxU+1poiDl89BEcwwpCHyJSNXYkXU+B7Ado3zDwLQHVd+IoptKJzJlBjHZlZu9UtJrryprjcjC7pZYugnhrkkRaL/mMGhsA6XU5+WD/QnZ/S6sNKpTbb3sLdBfOLPGEBGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sful1hAPySAxStJo6QTmTNVA+pNuSM01YpSRE3hQ6o0=;
 b=FfS4uomkGFp2D8IWUnqOA2SzltI+Pa9EBYDhW1L1IgjVggAdJiPug5Ft9q/Bu2Rolpst49/rKw4yCjCuH8+H45tfbHmaIIARlTFNONJLWc6qAuR3NLh/lyAe30gQJgGHSRLbFrhTQ0Oze1kUPNh34tp9MFvDn6B++ProVitBXD2ghY7q0VhvQcWHh8n6WtGTexib2BjzLmVG9KVeBm5nZCoJWWhQhIh+0zHKRuVRAaWZ+69k5qU19sg7kDA7h/7BQUN60k1PpxQe/g7ViBDvgB63tVkpJOxw0HEh10lQUe24G87poETbTS4r7ZcZCjpxbOIbk8fGUm6Qh4fszQzpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sful1hAPySAxStJo6QTmTNVA+pNuSM01YpSRE3hQ6o0=;
 b=gcWa6knxQQPkFTbZ6DKxChxMuf7IhczK3GD/Jz72vaBVe2WdtJ3U2Tr8woCD5XHHAi8/+E+4VjepqIw6N6gMezZJMw1LnUQZA1dm+acTZ/XL9kp5U2NvTdtC+XZRVH5CClMrQXgFjH3gFEdPWWc1i6ClNes4mhj5z9/WUJYBwOw=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by VI1PR02MB6239.eurprd02.prod.outlook.com (2603:10a6:800:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:14:42 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 20:14:41 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [yocto-autobuilder2] [PATCH] schedulers: Fix bug
 in scheduler started job coverage
Thread-Topic: [yocto-patches] [yocto-autobuilder2] [PATCH] schedulers: Fix bug
 in scheduler started job coverage
Thread-Index: AQHb0IoXH63ceKrl/E+OcSCjlW+kzrPqCxpw
Date: Thu, 29 May 2025 20:14:41 +0000
Message-ID: 
 <DB5PR02MB10213084EEDAA4761E6711C88EF66A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250529110852.3072969-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250529110852.3072969-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|VI1PR02MB6239:EE_
x-ms-office365-filtering-correlation-id: 685d64ce-8eb3-46d3-a7a4-08dd9eed7250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?GNSFK0y9CRwHufgn+qa507fQ1ZH+SBKWb5dKXtJjTLOwWDMVs2+dgSE8V3G1?=
 =?us-ascii?Q?qninwBcEw5N3vJRkeM5DU8ppdf9gQUJli+vzy6+VUGGLlGhFO2i1SMHbB3no?=
 =?us-ascii?Q?4pIxJAoj69qZXzyvTs+3D8fyo2caOyOncs9HNP49pVnRpaHZBQwNxEgM7YpL?=
 =?us-ascii?Q?jIF37ZU/M0YP29vZ9m4684WtJtYzxakSQlxZAnbRA+oUGcP2/bVy0/alt8rp?=
 =?us-ascii?Q?N0HwRhtvLzmMMIKYx68YTpoDGYkvenfAwRV+gWUQZRCBphiX4C6HGE/E0Cdu?=
 =?us-ascii?Q?xpnbYLllTVuKn0XsoNUxSZYdBzyN3GESVoRfmTD12BOoU1ZetwUXwnJiVYs+?=
 =?us-ascii?Q?lsNdpMSlzVE5UTHpxseRKRWVB1L6W7SPCCUs0XOxd0Kup39Zckq7x+2t5kvC?=
 =?us-ascii?Q?fIXA0iMFWZNp+/FnoEnOWipSUNX36pcOykZukem3ID6e4QtTR9jJ8GlUTTp2?=
 =?us-ascii?Q?c0n1snkbvEUswKqtIp0NACTwhvAm8SpyBzoBA/7GiGtmAVx9pkSg2FFjyHLA?=
 =?us-ascii?Q?Up1y8/WDnnprI6pZjkzyXMxcYNOuitu25PW/eGTDXQq4sPR+3fxocl8lzvoL?=
 =?us-ascii?Q?CFnb+A0KJcvRmngEt/U1x8w/TEuMOt7Q4ZjLv19K4CjpIEdyq03DilnngoEd?=
 =?us-ascii?Q?Fn31jXVhsYgwy4MCOhlQirYCNej9EnDPIi5APRawjCdaCAy2zNMUYWUOWAmE?=
 =?us-ascii?Q?AZePdEOqPrQtnUZv3gGQYJ/nFjoc23y445HMM14cJcl6dpUne1Eaj7tOBo4k?=
 =?us-ascii?Q?C24heFYZBGnMi3sjuulFGVbY0rGi3i9MG2QotkEVvTgEHvlt4txAFYDI0ChQ?=
 =?us-ascii?Q?br+nzu+YqAIvbwoZyXMqtjbsvw8HkETTlA46uPhWnkPoLJViTPk0Mk4UDyQ+?=
 =?us-ascii?Q?5UIpd3sJp7Mer2VyFexVjOqwuHroTHdKD0gMHoYDFIWeZPMJDOcQDqjAgyn9?=
 =?us-ascii?Q?aw6YYtoA+SnqVMswzBb343Q4QIy+AuTqGDjsvipqNsNgl5eP8xL0FwWRxUs1?=
 =?us-ascii?Q?yLPlyZfF4UVDaqhNZ5q5fdp0hc8YZAiBw891DTyMcxWHkf0Setm6JVndbSUn?=
 =?us-ascii?Q?WZSeJVLn3n+jevqYclFPLfo15slp/eU84UWPA6hDo/xbcyxsSXukGm+aSYt8?=
 =?us-ascii?Q?FZH0vhmYcjoVpG1F83qk4ieJ7kbGVMFVccu38gD8s1obYdmRgFW9MvI5kjwe?=
 =?us-ascii?Q?B/47dxEpFjgw/yOpqrmyvjWstZyB8agbco4LgiDIXjWxonuErFdsODwXUpfD?=
 =?us-ascii?Q?KYz8UEf3Kt+iYFBHGTtlFCQVEyPdZH3ATn9op/apRcCkgLtUfX2ciICOOQf5?=
 =?us-ascii?Q?TXpbOXSlbWZo65r0SGNoOXH/A1b0PGEpnJMHstCo6TNRvq0xPpKlrSvBx3Yi?=
 =?us-ascii?Q?HgQQjlrXFDYnp+rZ4tZ8LnZprNcYO7bXrohb/IAsHBvYYEA7BFcHPidVoo9O?=
 =?us-ascii?Q?vqRWyThNNXEfqr6897RWqc+GqMR3X5+t/mfql7NfppQOWwbhApeyVw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?F0m9jGw3i1RwEMsPqD0TZNwbUAs9zuVEQ2IxPy6PjaprLg/sx2Lg3H8AlG/l?=
 =?us-ascii?Q?8umWe84HWYMWQcS/9ykFqvUMnRANqfp+TG0tmi0JuPXZZHI/qPWtzJ9jYrYt?=
 =?us-ascii?Q?+6PNcljLpcrC+84Hsku6/OqHZbrDo0qSFID7PwCfXCJonBxeFulYLONOQwvm?=
 =?us-ascii?Q?0HBZA2XH+xcJCHkt4CGaj0np6yAfl7HXX7jcY6geVIEl3edvysKj3ggwMdy1?=
 =?us-ascii?Q?5mnmdDpWv01JTY/RezTNOhCR7uAhHZCY0au16VbeJnSqEkH2/N7+5ybt99Wl?=
 =?us-ascii?Q?96+fRHC04X1kxUe7t6vcaMWkw6cQgT0g2E2JST+E1oc4Gw4G+M4dMGey5+zf?=
 =?us-ascii?Q?IZqHJZc+cdhS2iJHbt+qADW4Q84XOv3gh3zdHfUGNMWzGU7BtAiolmdfCW52?=
 =?us-ascii?Q?ciXX5VbyadSS1qIjEda8HLf5aQb9BWfDKGcHlAATnsKM7bWKS5aXL/BLogZp?=
 =?us-ascii?Q?duwtle0nHE3N36RlOzgg0RZ/rMdxHjpuU9yGuLHhgQRBYYxkZKi4B1yf38rl?=
 =?us-ascii?Q?UmJDx+hhFlFuZfeG7UuNLQM+zMN5vgh+IsfHfxgj1IJ7bq2kU5D0v8WLmgv6?=
 =?us-ascii?Q?Cy2LujvDwf9uHcKGAd+DKUpWv4K5WorDDqmXFRcKcARrp/9oBZePst4inq64?=
 =?us-ascii?Q?3S1+ZEfEsRa2gMaCFRk1S4qEivRgADZSyONxeFfaGV3CBG2HVb6w0u1fB3BJ?=
 =?us-ascii?Q?GuaN4zoa9LJkEBFN90ypY+sSMtfgzw1jEaRYJCYJgnmjzhe0C0zBjbvf6nHf?=
 =?us-ascii?Q?WsNhH6SH+IhII75mHnI9mFs8OuXncDo181ezaYixxZ0hrEVpkqZRYev4Gp0l?=
 =?us-ascii?Q?b9+r8BRluiwGU3hCDBlg27VDvqyAqPx9A2gygKO4BX1PuzckwLWe+Ovfro0K?=
 =?us-ascii?Q?NKeqTNlmt5VDLDMFSEg7dZyCvkcv2bFtuZltNiie42fw06CrVc+fGJkabgvb?=
 =?us-ascii?Q?yFbNiZcOlWwlZLeSDZpulI/f4oDy7PgjpwW1sRMnH2h7oReKb3tTB/yvhlnd?=
 =?us-ascii?Q?HD2yiZl8Gecy8okI1t/RMF+JgKCtHJgQWj1EKuov8mX9L1o0QUwZOO/nEeHU?=
 =?us-ascii?Q?SJ+W82i6yM1uwbTNrQI/c7B3+b6u5nkoK7WVFDnCaVlio0XHSAfFVXhY8qkt?=
 =?us-ascii?Q?LkkVBDCYGWeJAsrd8pFnRXHmuGMdhJ7N76koWfaTWEt28Zf/asFCkZwcJuZG?=
 =?us-ascii?Q?coWkPV8HL/+rUbrw0HHgCi3uJOD6EgRc9XmhuJfgTHOqqb1ca5pyWWII4+it?=
 =?us-ascii?Q?8imocijPKpnUgTh5DrJ2jjttpZUME6ylWyyC7Ysdsdu+IC0cr8TjssavamYj?=
 =?us-ascii?Q?kF4MdSGc4OSpzPkoDr7PUBzunFvDdcx9/Ctk9qnJrSqLSp4t+N/TwLJAVPCo?=
 =?us-ascii?Q?jaHYAQsUcDNSaYeTpMFqwbx/ZXi7Spvlv55lM0eHGbpMw1PZ6YJC+4Fg0c8+?=
 =?us-ascii?Q?FGkrMuL/IEJa07IJQOvsVabCBvn5CPQlJ30t1Qkx/IcsRQQbUGmj/JxwCWEd?=
 =?us-ascii?Q?e+zvybCfJriRXrGMBG9fVF70+NNP47dCoufhBRPLWv8nMH1hfZzPnSFLeliQ?=
 =?us-ascii?Q?hIeiYF8l9ql6zRfCZGE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d64ce-8eb3-46d3-a7a4-08dd9eed7250
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 20:14:41.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6FzZpo1lOcYlwvIp0rDYSZj1DH52SR460rUdEsLw8r8NUZXkME8CeA93AqLYeC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6239
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 20:14:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1598

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org> On Behalf Of Richard Purdie via lists.yoctoproject.org
> Sent: den 29 maj 2025 13:09
> To: yocto-patches@lists.yoctoproject.org
> Subject: [yocto-patches] [yocto-autobuilder2] [PATCH] schedulers: Fix bug=
 in scheduler started job coverage
>=20
> Jobs started by the nightly scheduler were failing as sourcestamps are em=
pty for these.
> This meant that additional branch specific target triggers were not being=
 handled and
> jobs were being missed.
>=20
> Switch to using the yo_build_branch property which was the original inten=
tion and

yo_build_branch -> yp_build_branch

> should always be set, fixing the jobs being started.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  schedulers.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/schedulers.py b/schedulers.py
> index 3f0289e8..122149c6 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -430,7 +430,7 @@ for builder in config.subbuilders:
>  @util.renderer
>  def builderNamesFromConfigQuick(props):
>      #log.msg("builderNames: Sourcestamp %s, props %s" % (str(props.sourc=
estamps), str(props)))
> -    yp_branch =3D props.sourcestamps[0]['branch']
> +    yp_branch =3D props.getProperty('yp_build_branch')
>=20
>      builders =3D config.trigger_builders_wait_quick
>      for b in config.trigger_builders_wait_quick_releases:
> @@ -443,7 +443,7 @@ def builderNamesFromConfigQuick(props):
>  @util.renderer
>  def builderNamesFromConfigFull(props):
>      #log.msg("builderNames: Sourcestamp %s, props %s" % (str(props.sourc=
estamps), str(props)))
> -    yp_branch =3D props.sourcestamps[0]['branch']
> +    yp_branch =3D props.getProperty('yp_build_branch')
>=20
>      builders =3D config.trigger_builders_wait_full
>      for b in config.trigger_builders_wait_full_releases:
>=20
>=20

//Peter

