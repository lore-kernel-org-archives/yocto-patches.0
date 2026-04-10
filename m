Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04EF459F4
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 15:18:56 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.158636.1775834327650247633
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Apr 2026 08:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HzpvpmHa;
 spf=pass (domain: siemens.com, ip: 52.101.65.16, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w03yjlcOEEJF/WKSgpn20S3Qt4QdmUy3tguSQJqkOYaAdE363pulICtnHSvDUj3xE2eQe77o3Gilj8GSyM0k+rNlNdOjz+uN6Ep+BKWELIX0g2AmFHI+TmMwGAfBhnRmm6gSefXbnUkQSXOBEtjLYWT1Y8I9gmmDwWwI88ZDTyDw+oBVeCaPMBmJBbTaeODqgoGagG4WC64OSioMs84Xdhl28ygekf+ieKT5Pc1KB9h28QBVA+BZSdZtJhQ4yphT/bwuorfPeJOhYAn3+uL6Qjbkf8bVqWM6clrmPam2ECXzCvVwsuBTmseh+iT52eeRW66jWnbA/U0i9FeLXGXxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u2NFODpbnhvZxXaQtHI5pArsefjIbdV25SF9TbtURA=;
 b=DC2sSKGDl15iN/uv+1cz2/6lIRGdl7ppndwqnFVGKZ/LZtFtaKDuyRLCZSFxkHDsc2hq6wjHdv60Q062M/FzsucMMUCsEKmrhm4ADZPfSLbqKXXyj/gPHAmAbyDCYQpio6vo5PyEspELd113lOGl2b9PS6oYWArRoSyvySUsZTEUEIcDFFDhTeLSpykiL1W763+/4MN/0t7uo5YSwaWNKn4jvcQuM6s5XzwOW2qVz7sgtMnIEGIqN0d6WipomT3EvQw6ilox4uzZdAaAy1t1dCH5PjkeQLvvg5ViGLaXtyCgkhXwI7i8fg4QtW8i6W4P8T0Pvhu7z4a08ofJAFeKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u2NFODpbnhvZxXaQtHI5pArsefjIbdV25SF9TbtURA=;
 b=HzpvpmHav+C9cJUcVKXxMKCJkUsJJQxxUJoJ0XnUh+Eowjn/zhbRMD6EueSecb+dQ6svwt4Vzqt89fxglmAGE1X0zXufgZwVx289/n4kFaLLye4U58ojbuMqkTrrTNTWZDHyt2U9dyyy7RzeBINIpDaPFHV8/5J5fs2fxHO9WSqEEYXWdSEo2VmxBJQf6Zu2aAFAsC1Ew7LjjnlWcmrPed4quWRUij93teiwpo5XXaW3ADMHGwx/87c8VMbRQGYQHCYEKf9EO299FTqdobZBVqNQ7ktRNKFtIeKxo4isSJfIWOY3vOYtdX3JUAd9IjfACYz/ZXc6qmbjshIIEwQV+A==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by AS4PR10MB5443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 15:18:44 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 15:18:43 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.1 ->
 1.26.2
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.1 ->
 1.26.2
Thread-Index: AQHcyEGeL2LnmZk/+UKnIcGLqcLM97XYaeLw
Date: Fri, 10 Apr 2026 15:18:43 +0000
Message-ID: 
 <AS1PR10MB5697B061ECD8B3D1A68AF99FFD592@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260409165420.2968025-1-peter.marko@siemens.com>
In-Reply-To: <20260409165420.2968025-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5bb21a51-f811-4877-a0b8-1806d323675d;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-04-10T15:17:51Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|AS4PR10MB5443:EE_
x-ms-office365-filtering-correlation-id: 2a793f1f-c6d3-4761-cbee-08de97147447
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003|55112099003;
x-microsoft-antispam-message-info: 
 e5iCg6DOubXzrBQJhSkwUDwcw/ZaMW6CpMMCjrcwDbN++W1uABcxYOS8Bf/vYo8vp0MZg/fV1fKiuTmbbhiTnRWQ/cDeTCwD52EE6AjeNKFgaMQjr/U5a0k5+QppGpvWxBjEyWDNcw5svihB5Q9JtZvtPdxujxoQck3APo+PZnJT6+NHvlBXepaHT4GTAbpIkNUGPsAxAzsrirC3Oy6vckWfFMy0BJUo4piX+X12xvo2i7GlO9YoYWRwGRQ/U8dLJwHqch85oIi7oEpOTj1OxmmVmKxrHNJtMwYz8kPmm+DMrXPS+TqgiK1ubBaTc5v2i8sMVrzk4U9wPsAeros2/SxgfwgIVhbkkPJmLgRMOLyAhZuuZfs0498ncmMIgk45YLfNvZxmHHtEkn/i1z78BVW57FFfksMoDXS5OkNkWYHQYC4rksyEF7TbaarXBMV7rGNjcEuKe4MymSRKoNoXLG6Ff2RP7f1a7w0s5XnCnyc6IEgwOlqVt6F4mlqk5HIcgEVGopJ2ATuzlp1vpsd7XDoUmroEJ6GtuKnPqETX6fa1I3P60ZZFv5oCrj4HcCu32yjoU49TEwigXaqV4leb+XR7kfVMLfoJE98YmvBN4N3MEj1v6z7mClzTtSNb10bQlMGzfUaZvuJV1O7OYHI4pjM7PBi/9JQERtmMdw89POKn+Wm0efZtNAVeMOIFGt3ZlZddfIscgQHGZPElvnAANMZ6lsRIDJF8eT5iRoBuF4U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UgpCbO+ICVcuk1Gbrq5oNQIxh+xSTpVV3HMzdMpHi6I7+IRTFTKOxM8z9EIS?=
 =?us-ascii?Q?IYzCUTlB8UqaZbqgPIa4jScWHH0ZLom+COlPtmEUK5VVbHs/BLrbuYNC/Hik?=
 =?us-ascii?Q?YlpE9qz0dwzuSux+D9Jp2M5Ocrn8Iu+EFPmiaCpykivMXw70vF/oIYI9v2Tw?=
 =?us-ascii?Q?Tcy8I01W+tyl7RaoiUuEKulQLie4Fjql2PEw2DB4DIFPLsEI9XhTisEbPdFC?=
 =?us-ascii?Q?pC+gwV98tKvcabthIDUf4A64T1agWJIOWb0olj8HOS5XNMeTTLwR2aXNQ4VG?=
 =?us-ascii?Q?i8ut0f7F8ozeF7J9jVmnd2LmkFFZSmVBQcMnflCkVPc8AvZA2o4ANgWNe6yQ?=
 =?us-ascii?Q?pnz0+dDOV/JOm3D3UYLCwTm43O8QFiZYAZKxvQtoYpXgCpS5VSHoUfb5yM8W?=
 =?us-ascii?Q?P2N2pFA3q9aeNziEqreETSK7p5+eUW9ReNILq1rYfmjJn3cjVqucojS6NiKL?=
 =?us-ascii?Q?rcTsgZ+xF/N4wrkNA/vUuyLroGknHbLymzb3bxBz9ZEVZ1tAxtxzzC27alBH?=
 =?us-ascii?Q?mXkLri81GJ8x5XW0C3imBdA7zWVw8omw1jqvKkU0y+LkprQbx0F+44Q1Vb8e?=
 =?us-ascii?Q?gs06W3xfmGELSVdIJQ6vQsTvBFJGNSvAr+3DBtLDnM0a4FEAbjjf8gGrQwh0?=
 =?us-ascii?Q?WZ76CKljLWUAXFnsI8q173y9NmMXTVJmvcKf9Cbd/z/s6E9AaEVaubadkR3C?=
 =?us-ascii?Q?UYRHQjje4PkVoQShwpooDUAFd+Fo9DT76M0P2lJ+C+pdJh4t8wrgZYkc3nW5?=
 =?us-ascii?Q?OmDiuIDfU+k9F2goMjQjRj4rXsOcmCf1TrpWh5hInzTGMCjoshL5qvN6LDia?=
 =?us-ascii?Q?QTgXGT3HwlBBgG2jQkfLIWZPj4pWKZGbmzpv1kjjTwsXERYFJ484kpMsSTb/?=
 =?us-ascii?Q?3cd2xmdxVHsH+Hak+IBmHcybrmzq1IGxF8Mtqq5WU5V9oofBw9fHWQJLaa7W?=
 =?us-ascii?Q?i2iBlQU4n3ZYIpNo3aqbVb8VGoxD/DqouAILqGmNhgt8Xbd9G1XoIsGenKvG?=
 =?us-ascii?Q?l719rqKmRjbwPbbYEYE9G5YTvO2tXiZ8D+sNe0SR+Qdtr1R/Gx2IEqEbeM8K?=
 =?us-ascii?Q?0N9xHwuOWLmxHexXTm+7kRwKshFn0eiIIYXBivmH9TobRZctDV/rjS2WqWP6?=
 =?us-ascii?Q?OiONGIPyiWzgCrx817aMYevGfand8Mvr+nsXl4JBsuVBg7n5FSB8wUOCfP8H?=
 =?us-ascii?Q?q3USTeHx+3+AuZTcN1uPU89KhczZKVayFYdBIfal/aeMfkhmGRHMt7FSyr6M?=
 =?us-ascii?Q?rtBE5mJ8pIUqgY+dpyT99kKLpS2MpjFRR9mBLj9z7S6xYjT/1Tbfw6gHSOFX?=
 =?us-ascii?Q?G0o2Z644Vodz1f+SsvFS45t9HC9djJ9FNrbSdJvLJG7A3mAkngjbrqnDJtWk?=
 =?us-ascii?Q?1DkbfvmVle00nNdItY93ki8O707MrDz10aTUfviGWrrl/WUsMNzP2PY4ZkKj?=
 =?us-ascii?Q?YGdh+X/Befl6y+y6bZshp0vySMlhR7bkaolx5yzB4h5ulgbHGdLXCAf3DOn9?=
 =?us-ascii?Q?RLrRcggQB1uj0H2jgMHru2sCiKKe/0F4ymSxgLKWoxLuCV98iKXbte4B2Qk6?=
 =?us-ascii?Q?Q+OgRrg8LeSNj7PMzA47pixCHs0PGawGhdBGEMB2k5GeZKPgtUBUsX0fqoWU?=
 =?us-ascii?Q?VWwW908iWtNU+H4oNpxfE/I6A2SEYedDxjR+L2f55Lc1NLkIpskk/xtzvykj?=
 =?us-ascii?Q?4hVehanU+aD+3R1LXQXqthlH4yixwa2dh0aIFJVE0IviV/i4vLw203Nrqcap?=
 =?us-ascii?Q?Tn6gWL44jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a793f1f-c6d3-4761-cbee-08de97147447
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 15:18:43.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PwOU62EFfQV9RWCCbjEzLVLLqCc4tVW20YJl6bLk06D2Hg3uWoUBK3E3fsJ+1jwbG6jB/l9Wpj0VzxGjV0tJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5443
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Apr 2026 15:18:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3688

This is now merged.

Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Thursday, April 9, 2026 6:54 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.1 -> 1.2=
6.2
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.26.x release [1]:
>=20
> $ git --no-pager log --oneline go1.26.1..go1.26.2
> 9c8bf0e72a (tag: go1.26.2) [release-branch.go1.26] go1.26.2
> 096f21b1c5 [release-branch.go1.26] cmd/go: disallow cgo trust boundary by=
pass
> 7cafb4140d [release-branch.go1.26] crypto/tls: prevent deadlock when clie=
nt
> sends multiple key update messages
> a34b5e4d55 [release-branch.go1.26] archive/tar: limit the number of old G=
NU
> sparse format entries
> c4b4bd7b3a [release-branch.go1.26] cmd/compile: fix loopbce overflow chec=
k
> logic
> 3a4577a268 [release-branch.go1.26] cmd/compile: fix mem access overlap
> detection
> ceb4da6626 [release-branch.go1.26] crypto/x509: fix wildcard constraint m=
ap case
> sensitivity
> babb1c32c2 [release-branch.go1.26] html/template: properly track JS templ=
ate
> literal brace depth across contexts
> b6176f459a [release-branch.go1.26] internal/syscall/unix: properly suppor=
t
> AT_SYMLINK_NOFOLLOW on Linux
> 917949cc1d [release-branch.go1.26] net/url: permit colons in the host
> subcomponent of non-http/https URLs
> 7b4ed1d7d9 [release-branch.go1.26] crypto/x509: fix signature checking li=
mit
> 8028a51430 [release-branch.go1.26] crypto/x509: hoist policy pruning out =
of loop
> 4ef278779f [release-branch.go1.26] runtime/race: apply LLVM zero-initiali=
zation fix
> 608303dd6e [release-branch.go1.26] cmd/link: skip special symbols for lab=
el
> symbol generation
> e27183eff8 [release-branch.go1.26] cmd/compile: fix internal compiler err=
or: bad
> write barrier type
> 98d4c11d8f [release-branch.go1.26] cmd/compile: treat all zero-sized valu=
es as
> SSA-able
> cce667a91e [release-branch.go1.26] cmd/compile: handle zero-sized values =
more
> generally
> 3206e141fb [release-branch.go1.26] net/url: reattach package doc comment
> 82b95c14ec [release-branch.go1.26] cmd/compile: ternary rewrite of rewrit=
e
> should skip, not panic
> f14d3a8e91 [release-branch.go1.26] cmd/compile: skip race detector test f=
ailure
> for unsupported VMA
> 68f42c591d [release-branch.go1.26] cmd/compile: gate instrumentEnterExit =
on
> NoRaceFunc check
> 9fe1db7e7e [release-branch.go1.26] runtime: fix value of ENOSYS on mips f=
rom
> 38 to 89
> 08edcb8d3f [release-branch.go1.26] test/fixedbugs: remove issue46234 test
> timeout
> 895fbaecf5 [release-branch.go1.26] doc: remove template use in godebug.md
> 26548d4981 [release-branch.go1.26] cmd/fix: pull in CL 755980
> 12bf7d8cd2 [release-branch.go1.26] builtin: incorporate all feedback into=
 doc string
> for new
> 943235a5e5 [release-branch.go1.26] builtin: update new function comment
> 1a44be4cec [release-branch.go1.26] internal/poll: move rsan to heap on wi=
ndows
> 3bf3014fe7 [release-branch.go1.26] test/convert5: skip mipsle
> e29f35511d [release-branch.go1.26] cmd/go/internal/cache: update trim tim=
estamp
> before trimming
> 2b01132c9f [release-branch.go1.26] runtime/poll: fix race condition in Wi=
ndow's
> SendFile
> ba8c3d07a7 [release-branch.go1.26] net/http: restore accidentally removed
> package doc
> 99df9bdb2a [release-branch.go1.26] net: correctly handle non-nil empty cm=
sg
> buffer on windows
> ace2cf6652 [release-branch.go1.26] cmd/compile/internal/typecheck: simpli=
fy
> tcSliceHeader
> 1368bc269e [release-branch.go1.26] cmd/compile: fix bloop test
> 840d86c060 [release-branch.go1.26] runtime: fix printfloat, printcomplex =
buffer
> sizes
>=20
> Fixes CVE-2026-32282, CVE-2026-32289, CVE-2026-33810, CVE-2026-27144,
>       CVE-2026-27143, CVE-2026-32288, CVE-2026-32283, CVE-2026-27140,
>       CVE-2026-32280 and CVE-2026-32281.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.26.1...go1.26.2
> [2] https://groups.google.com/g/golang-announce/c/0uYbvbPZRWU
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.26.1.inc =3D> go-1.26.2.inc}      | 2 +-
>  ...binary-native_1.26.1.bb =3D> go-binary-native_1.26.2.bb} | 6 +++---
>  ...oss-canadian_1.26.1.bb =3D> go-cross-canadian_1.26.2.bb} | 0
>  .../go/{go-cross_1.26.1.bb =3D> go-cross_1.26.2.bb}         | 0
>  .../go/{go-crosssdk_1.26.1.bb =3D> go-crosssdk_1.26.2.bb}   | 0
>  .../go/{go-runtime_1.26.1.bb =3D> go-runtime_1.26.2.bb}     | 0
>  ...go-make-content-based-hash-generation-less-pedan.patch | 8 ++++----
>  .../go/0006-cmd-go-make-GOROOT-precious-by-default.patch  | 2 +-
>  recipes-devtools/go/{go_1.26.1.bb =3D> go_1.26.2.bb}        | 0
>  9 files changed, 9 insertions(+), 9 deletions(-)
>  rename recipes-devtools/go/{go-1.26.1.inc =3D> go-1.26.2.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.26.1.bb =3D> go-binary-
> native_1.26.2.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.1.bb =3D> go-cross-
> canadian_1.26.2.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.1.bb =3D> go-cross_1.26.2.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.1.bb =3D> go-crosssdk_1.26.=
2.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.1.bb =3D> go-runtime_1.26.2.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.26.1.bb =3D> go_1.26.2.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.1.inc b/recipes-devtools/go/go-1=
.26.2.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.26.1.inc
> rename to recipes-devtools/go/go-1.26.2.inc
> index 2e3464e..8bb10bc 100644
> --- a/recipes-devtools/go/go-1.26.1.inc
> +++ b/recipes-devtools/go/go-1.26.2.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "3172293d04b209dc1144698e7ba13f0477f6ba8c5ffd0be66c20fdbc9785dfbb"
> +SRC_URI[main.sha256sum] =3D
> "2e91ebb6947a96e9436fb2b3926a8802efe63a6d375dffec4f82aa9dbd6fd43b"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.1.bb b/recipes-
> devtools/go/go-binary-native_1.26.2.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.26.1.bb
> rename to recipes-devtools/go/go-binary-native_1.26.2.bb
> index d2652ef..3c76a67 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.1.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.2.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "031f088e5d955bab8657ede27ad4e3bc5b7c1ba281f05f245bcc304f327c987a"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "a290581cfe4fe28ddd737dde3095f3dbeb7f2e4065cab4eae44dfc53b760c2f7"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f56eed002998f5f51fa07fd4ed0c5de5e02d51cec7a4007f771c7576620d9d45"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "c958a1fe1b361391db163a485e21f5f228142d6f8b584f6bef89b26f66dc5b23"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "62b7645dd2404052535617c59e91cf03c7aa28e332dbaddbe4c0d7de7bcc6736"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.1.bb b/recipes-
> devtools/go/go-cross-canadian_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.1.bb
> rename to recipes-devtools/go/go-cross-canadian_1.26.2.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.1.bb b/recipes-devtools/go=
/go-
> cross_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.1.bb
> rename to recipes-devtools/go/go-cross_1.26.2.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.1.bb b/recipes-devtools=
/go/go-
> crosssdk_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.1.bb
> rename to recipes-devtools/go/go-crosssdk_1.26.2.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.1.bb b/recipes-devtools/=
go/go-
> runtime_1.26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.1.bb
> rename to recipes-devtools/go/go-runtime_1.26.2.bb
> diff --git a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-
> generation-less-pedan.patch b/recipes-devtools/go/go/0001-cmd-go-make-
> content-based-hash-generation-less-pedan.patch
> index af4243e..077bebe 100644
> --- a/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> +++ b/recipes-devtools/go/go/0001-cmd-go-make-content-based-hash-generati=
on-
> less-pedan.patch
> @@ -109,7 +109,7 @@ index 7b073165d5..1f618be0bb 100644
>   	}
>=20
>   	// Configuration specific to compiler toolchain.
> -@@ -2807,8 +2809,25 @@ func envList(key, def string) []string {
> +@@ -2804,8 +2806,25 @@ func envList(key, def string) []string {
>   	return args
>   }
>=20
> @@ -136,7 +136,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if cppflags, err =3D buildFlags("CPPFLAGS", "", p.CgoCPPFLAGS,
> checkCompilerFlags); err !=3D nil {
>   		return
>   	}
> -@@ -2824,6 +2843,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
> +@@ -2821,6 +2840,13 @@ func (b *Builder) CFlags(p *load.Package) (cppfla=
gs,
> cflags, cxxflags, fflags, l
>   	if ldflags, err =3D buildFlags("LDFLAGS", DefaultCFlags, p.CgoLDFLAGS,
> checkLinkerFlags); err !=3D nil {
>   		return
>   	}
> @@ -150,7 +150,7 @@ index 7b073165d5..1f618be0bb 100644
>=20
>   	return
>   }
> -@@ -2912,7 +2938,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
> +@@ -2909,7 +2935,7 @@ func (b *Builder) runCgo(ctx context.Context, a
> *Action) error {
>   	cgoExe :=3D base.Tool("cgo")
>   	cgofiles =3D mkAbsFiles(p.Dir, cgofiles)
>=20
> @@ -159,7 +159,7 @@ index 7b073165d5..1f618be0bb 100644
>   	if err !=3D nil {
>   		return err
>   	}
> -@@ -3461,7 +3487,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
> +@@ -3462,7 +3488,7 @@ func (b *Builder) swigOne(a *Action, file, objdir =
string,
> pcCFLAGS []string, cxx
>   	p :=3D a.Package
>   	sh :=3D b.Shell(a)
>=20
> diff --git a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-b=
y-
> default.patch
> index e2a0cd6..9aebc2f 100644
> --- a/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> +++ b/recipes-devtools/go/go/0006-cmd-go-make-GOROOT-precious-by-
> default.patch
> @@ -94,7 +94,7 @@ index 1f618be0bb..651fa64582 100644
>   	if err :=3D sh.Mkdir(buildAction.Objdir); err !=3D nil {
>   		return nil, err
>   	}
> -@@ -1891,6 +1908,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
> +@@ -1888,6 +1905,14 @@ func (b *Builder) linkShared(ctx context.Context,=
 a
> *Action) (err error) {
>   		return err
>   	}
>=20
> diff --git a/recipes-devtools/go/go_1.26.1.bb b/recipes-devtools/go/go_1.=
26.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.1.bb
> rename to recipes-devtools/go/go_1.26.2.bb

