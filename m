Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F350EF5845
	for <webhook@archiver.kernel.org>; Sat, 14 Feb 2026 15:44:24 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8211.1771083857029499390
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Feb 2026 07:44:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mEFutYIX;
 spf=pass (domain: siemens.com, ip: 52.101.70.40, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT3oW9OkJOtaBO+rfPs7z0JG9ZKPRCAjJV2FtLYY+OQ5InBbQ6geedfp/9cnrqQAdugDDr8bs4CtDNHtO4rly5BGtociGwtkXOxGbs2ZiGeUBrjPuyHJ1tWRhnJ0ttLUaccEq7HRu8AEYfyQho5A+b5YqiqGDk7KdNdF1U+S8bRvgTji0Iybrkzzy22XEQdnbn6duhtgY7/ZrI5TEY5vpRw1/9sBs2uWLAdLWR3EMU5a5qZ/HmBP22w8ERCmQz2BVTNkfUfbvsTqzTg9OT7MgFMcOq/qdBlXraTnPpFli0Ed5Jl+6WXSuPclUmTYFBUJ2ukZ1q8qdg/uBezEZzgTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqD7jsOl9yQuEnZrstFvVzP3pug6jSUqHnrD9egDhrE=;
 b=W1joQgZx+In2LhmQPI+/EByPxPPfl5R5KUHayRjE47fZE3Fx8oF2biiPzaGKe7DVM8m7orAPAkYoby2VDWjp3HjXheNLIwv8VUgShAboHgFwA7Ipse1NlB8v62GIUQCNycCHIsj8Nz/fiHgzy7k99OR8EXI48KClKBr/qQQ5thC5y++G/vfcTrLHeIaWp/kbcgTOh/M5mlatcR6b3uYitNumIeNXxjhpzFwL/RTHmCu9ORwIJj+dJkORkQU1Dw7Dv8nmcReeD5XCr97NBsGtH0ZItQCawRT/h3e0T35jJW5LyjPcChcC0JBZyNioeJHRZC8PzNvFtqaDmrF5BsjxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqD7jsOl9yQuEnZrstFvVzP3pug6jSUqHnrD9egDhrE=;
 b=mEFutYIXpQvHkxGE6NR5zcuWlKJv4g4LO+qhzNSg8chbZvRw4tN/ZzAD8Hp+0YIJ5AX46V6YZ95tbRwVEJqqXiqUsSHFFzZHZiTpBcSF55FjWpmA/f5Rye0g9MeS36zoRmpMrUkDIBJPW+uWyzR2JsATAkZr7FzJzCLfOxDkhTGQVQWMcSaUAkozenceuUUWrDiRvV0MemYTlX1q3vfogTdFbnjiwT17VvA0K98FXKwWiyTkIb5bjn6V6bo9mJVgAQAcrrd+R0vAGXpg/YhFbvCqGJXxtSCwzq0W0E4Ds6MP3tv9GJ6Qu1/oDtwZVHqP1vBMicM5WNKln5XA8NtJrg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by VI1PR10MB3728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sat, 14 Feb
 2026 15:44:10 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 15:44:10 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.25.6 -> 1.25.7
Thread-Index: AQHcnFVuI7xjwUGxvEa9gEOPnQXAkLWCWMXg
Date: Sat, 14 Feb 2026 15:44:10 +0000
Message-ID: 
 <AS1PR10MB5697CEA0D7B1D85969427B86FD6EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <1893965242986680.653184@lists.yoctoproject.org>
In-Reply-To: <1893965242986680.653184@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=994c491d-df0a-443d-8b14-6c833d557e1c;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-02-14T15:43:52Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|VI1PR10MB3728:EE_
x-ms-office365-filtering-correlation-id: 170c75d0-72ac-4ea9-08cb-08de6bdfe586
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|38070700021|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?acj3tfUP5MCUCgwPNmrsngeF6VjF5tP9ya1bfbmtD1bmixNdr2lOBx1dnw0G?=
 =?us-ascii?Q?QMKNQ+1ilfQeaR1+4HsYf18HVETocqflFpgMAw20dneqB9g+uqhnKs6x3VCU?=
 =?us-ascii?Q?OwJ3WYK1KftGHCV195yVhWnFG33BqzGYgUxTRyJwIDgcCHXl3gpb8GHxzJBD?=
 =?us-ascii?Q?VAHEmjQ14qUbsCzBLPHA9M3txtFx4BrcHuruEAhTnlT+lyDxFYSTD0OZdEij?=
 =?us-ascii?Q?iTy1X4RfEh/SMruOfAkyxzQrftm12h6MtbXsu6+Nl7EHDpGQHECkHoj54+8g?=
 =?us-ascii?Q?Ia7nC8Awys0w8fKnxM08WUjv26OGHCIUTm80ggLhTlt2OyKN1WhjMSKbL2D7?=
 =?us-ascii?Q?Xi7MsaAxhl7ZCs1eoFyYbiM54GdEu9gm/JT22r90GWASbqN2tLfYfOGIq5vb?=
 =?us-ascii?Q?3vXmfn2F582bqtBJZ8is7lJHg5ROBemDV5gPV2ALIP42ZQyfYtTl4YLYk+ks?=
 =?us-ascii?Q?Oj0mALuSKeq2ePJSwDzLObJLOa1cl9MDVRN2Is2rIDD7e4G6NoOXNRZv0ybb?=
 =?us-ascii?Q?ZRhtbUdFuDkpU154E3K8b5/jtfbUgIBWPgnIIVjMuAEAFYdHXpIyw0rBB9qj?=
 =?us-ascii?Q?WSFhtKMyEF1DkxT0GO8r+y9Zsshu2rCm3HfvJKTnN1Q6SCjCPPYbaEtBpsCR?=
 =?us-ascii?Q?CxEueTsqaZI55/d7CcizlYIfkQzFeejddh/geThtalwwuXV7bGtBov3h+fC1?=
 =?us-ascii?Q?zTOL56gSxrYmbndYzNCHDkigaPX1sXUMkkgY8bpro8HvzOrZCLMoMbZcQGd2?=
 =?us-ascii?Q?yh/ZAun2TjRpZ8XeTi+6Jpruqrwzjg29jW1im6HYuIIPEjeLsx9+p8Ndb3CQ?=
 =?us-ascii?Q?G2il4l3z/QzeHgs1mjPnHdlFCzlYElDgahVoO/R0b7ToItCycBLA54uDWvHS?=
 =?us-ascii?Q?c/o1TQc+Gc9Yx2DddLSwBvwlgCpGt9f6yE7NjhPdPKcZsCMev6YMgW6s2i3H?=
 =?us-ascii?Q?5CBKhMYJCZtEM/0IVBzfGN2I9P98kb6JnUTeVkmGAEvY0+MyqaxTHZ1ooWZS?=
 =?us-ascii?Q?p9IyshRuVd+00Me9kdO9BIN7nSObt4aOOxWF1A1Q8buv0uyGovuu3AVBnnHH?=
 =?us-ascii?Q?+GiA5u8aj4RfILOK74+DQ0i5Wgi/c21ePky2EKsKRA4tq3xJTF/w4KglAQQT?=
 =?us-ascii?Q?yS9MZMplUOGb8U4Hrl1jn2kIXVEeGnNoezYGyc7v+gpWOKKZsgt+524Nmtee?=
 =?us-ascii?Q?YIrcc76NBbHyJdFtA5bRCkswBHoeg7MtM/aRIaeAVxJGLqRsShV3McWgVyGc?=
 =?us-ascii?Q?CGbKQ2YJDyPT8LFbpbtYLVgeybx0EaqIZDg6+di33yYZqJnFP34l+EcqqwC/?=
 =?us-ascii?Q?5NC0SVL4G7UA4uGtPyCIippljcd6dM/Ty2yz1bMNJSJRAuDUYAMieHD8D366?=
 =?us-ascii?Q?fXxRUa4l9HH7Kb1QqqcjjoRL05X6nhf3MLX8VP5rCgmrhN1fHUPd9YTmHsp8?=
 =?us-ascii?Q?iaFJU2dtO+egDrvKzjV7a7Bes6ytHwwbqTzlcGY1yW4gtFtebFwJ6RqhRWSB?=
 =?us-ascii?Q?Pz+2wOXiE6BYXLt8Oo69s8cRa6NHqod/2pdX7PUDjm4xVpbGd7WwpNloLjz6?=
 =?us-ascii?Q?zDdermLCK80kMLr9CGfa9pc+1/H4cQggwFav+nZM?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700021)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jYi6H+r1mnFR35qYnfpIIsC+X3/qjAFgVjfjT60juOU/Rr8/m1rhEfEAhsJW?=
 =?us-ascii?Q?pxS5HeD7sH8HIOwSmEFDWMxvhtLhOR1HUlOx7XcLytYMxHm8FA9nADaGWvTG?=
 =?us-ascii?Q?SaXjEgAf2olaH2xT0WsWda2yaTtJITqTbk+TXIVymyni6vTtcvVsro+2w/zJ?=
 =?us-ascii?Q?VXDe7HdoGtgoTGfcj0UW1ZfxwS1xuZCRmU5sFC4cCTOOqyZA/dkHuUJcvZ4z?=
 =?us-ascii?Q?hiliHVfDUq7M1IVHdnbmTdQycmSZh2yUcU2Qk6Wu+aknEiS8PG9wKtEXxaBD?=
 =?us-ascii?Q?9/fbU266Z52C8eOPEeO4lfEPCB9OLp/ylVSH7wi3oYxFJWeUj4ivxKzRBU3U?=
 =?us-ascii?Q?zMOkyy09SLxCsPamYSUojZSwkHxnhp8uuYkZ3va7yaKjO55leAhMYz5yIPJ0?=
 =?us-ascii?Q?YaRVSoiz4waW+Fvuhv49Nd1ZDwcgrKb4usnjrwNkP9JG5o96ADyjwzWZDknX?=
 =?us-ascii?Q?U1jCojKcme8O8je1xfW7caiXXVPeAweDdAhHWsB5ffOJChov2T+nWwlbFsHm?=
 =?us-ascii?Q?nloEAm8MQZS2kE9iA7C2QQyf1p5VYGkrNMB5OcCJHnpWEJE/JqOJ4jIb2j55?=
 =?us-ascii?Q?CUODNRu8A5qalA1cSRK2obUNsZdYhFgSpYD6tEdrbmLYuNFOC/p5fGE54Fqf?=
 =?us-ascii?Q?tJji/qxCqoFifqsJAczZRXAybqGIFrn4xtWa9cOgvnfqZMTZOjcM4CM9AO48?=
 =?us-ascii?Q?t3I0ZjOHW5rseFIRiLH5oeULuM3CC7KF88PhKhgKNEKWloIgtB9W8pH/9L0o?=
 =?us-ascii?Q?LmiOPVvCBRrZ3YqY1mW7y7lG6MK0iggtLdMRZYCTCCspGw8cuHYs4SO6qE66?=
 =?us-ascii?Q?65ncjcIrw281G09SjDy1BBekBy6K9v6w4yU09jBzOUYlKTkr/671aJ5A5EGg?=
 =?us-ascii?Q?TF2kafBFv/g7fFo89hwMzGFSabpX7A8/y1qxAzf6QrG/TTSIPcXUdINh737T?=
 =?us-ascii?Q?wgbfF7SQmip9w6p6qnyWiU7WUKMZceuOHDafPl023iZCbS+2Ako2+3Oda4qt?=
 =?us-ascii?Q?wwbxhC3b/bEJ1eJILPohgkpTJyRzHOhRU4QxKXazwGBgV5Jy3x2YGI9ZF4Os?=
 =?us-ascii?Q?yr/FgyD19sfqYS5Q43KH2W+f87qSVclxDm6sqnLcGvMwvcVbLU8xN8JfWvQv?=
 =?us-ascii?Q?tnOHiOhCtpCN5eoB0dOGrRlevScYXefFhRHhWrHE/3dz1UuC5JCl2jP/KPUQ?=
 =?us-ascii?Q?usD6n7irhqE5AR0QIrAQZJC185HWtw1pz3Z3W7Wta8W6NLqZxQPtdefOT7Fy?=
 =?us-ascii?Q?qIsfuMbEtKQiMATgBNMfCBujhFkgrhIyxYhHmrqQh9ONDYmFP9f3jhBZVKPR?=
 =?us-ascii?Q?Ux6qX7iYyvhlkOs7cll6QCnJ109fcAaGpnLzXWHUuUszln3r/sZkEA2fUJSR?=
 =?us-ascii?Q?Xbp8v0WISSgBAoX2TZq48A33F+M+qLtHdJ7RKe1F2k2DuAlTrxbYIeBOkPm9?=
 =?us-ascii?Q?9mY4I2fK2qVFw7MmMU4ElYJ592fUvbts6O+reB7A6nX6jdk6fYUl4mW7Rfgp?=
 =?us-ascii?Q?MR2g4fEC93x5sZs6/O8rG6azTahEjLCtz/3JRClesRwC2m3t9rdT3ORtbmi9?=
 =?us-ascii?Q?w0XW59EC0fH/0ichOrSSodTcC8ke6R8X2UUb7PlcrZVYRVtMDEnEdMvguf/p?=
 =?us-ascii?Q?X28anMN+PdclRUx7aQy78JlD1ehY4L6vA+mnr+j3255EretdkgWFnqdk0ZdP?=
 =?us-ascii?Q?+ofhg2xPXh1/5++UUe0pWZrHq0W0OTWX72AeiufewYSg7OVorVQURnrF5DJl?=
 =?us-ascii?Q?h02J07JjWw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 170c75d0-72ac-4ea9-08cb-08de6bdfe586
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2026 15:44:10.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3HQQZbHklStBU6Vw/shljGd56Ke5H++gPYDQdQcWv9C2kSgx4g4DpJ5M39pZOkgyRC+FYNKGMzJC5LgBfWmtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3728
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Feb 2026 15:44:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3238

This is now merged.

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Peter Marko via
> lists.yoctoproject.org
> Sent: Thursday, February 12, 2026 20:26
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go: upgra=
de
> 1.25.6 -> 1.25.7
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.25.x release [1]:
>=20
> $ git --no-pager log --oneline go1.25.6..go1.25.7
> eaf3bc799a (tag: go1.25.7) [release-branch.go1.25] go1.25.7
> c7d189e65c [release-branch.go1.25] crypto/tls: document resumption behavi=
or
> across Configs
> 4512014530 [release-branch.go1.25] crypto/tls: revalidate whole chain on
> resumption on Windows and macOS
> d5987bff8a [release-branch.go1.25] crypto/tls: check verifiedChains roots=
 when
> resuming sessions
> c2d04c0994 [release-branch.go1.25] crypto/tls: add verifiedChains expirat=
ion
> checking during resumption
> 6b1110a40f [release-branch.go1.25] Revert "crypto/tls: don't copy auto-ro=
tated
> session ticket keys in Config.Clone"
> 0765a9d624 [release-branch.go1.25] crypto/x509: fix single label excluded=
 name
> constraints handling
> b19100991a [release-branch.go1.25] cmd/go: remove user-content from doc
> strings in cgo ASTs.
> 738bc3a33c [release-branch.go1.25] cmd/compile: during regalloc, fixedreg
> values are always available
>=20
> Fixes CVE-2025-61732 and CVE-2025-68121.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.25.6...go1.25.7
> [2] https://groups.google.com/g/golang-announce/c/K09ubi9FQFk
>=20
> (From OE-Core rev: 7a5237b7ae557136eee9ff3f98e2b0a74f39ebb7)
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.25.6.inc =3D> go-1.25.7.inc}        | 2 +-
>  ...o-binary-native_1.25.6.bb =3D> go-binary-native_1.25.7.bb} | 6 +++---
>  ...cross-canadian_1.25.6.bb =3D> go-cross-canadian_1.25.7.bb} | 0
>  .../go/{go-cross_1.25.6.bb =3D> go-cross_1.25.7.bb}           | 0
>  .../go/{go-crosssdk_1.25.6.bb =3D> go-crosssdk_1.25.7.bb}     | 0
>  .../go/{go-runtime_1.25.6.bb =3D> go-runtime_1.25.7.bb}       | 0
>  recipes-devtools/go/{go_1.25.6.bb =3D> go_1.25.7.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.25.6.inc =3D> go-1.25.7.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.25.6.bb =3D> go-binary-
> native_1.25.7.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.25.6.bb =3D> go-cross-
> canadian_1.25.7.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.25.6.bb =3D> go-cross_1.25.7.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.25.6.bb =3D> go-crosssdk_1.25.=
7.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.25.6.bb =3D> go-runtime_1.25.7.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.25.6.bb =3D> go_1.25.7.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.25.6.inc b/recipes-devtools/go/go-1=
.25.7.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.25.6.inc
> rename to recipes-devtools/go/go-1.25.7.inc
> index 2c31c4a..ab58f71 100644
> --- a/recipes-devtools/go/go-1.25.6.inc
> +++ b/recipes-devtools/go/go-1.25.7.inc
> @@ -18,4 +18,4 @@ SRC_URI +=3D "\
>      file://0011-cmd-link-stop-forcing-binutils-gold-dependency-on-aa.pat=
ch \
>      file://0001-runtime-when-using-cgo-on-386-call-C-sigaction-funct.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "58cbf771e44d76de6f56d19e33b77d745a1e489340922875e46585b975c2b059"
> +SRC_URI[main.sha256sum] =3D
> "178f2832820274b43e177d32f06a3ebb0129e427dd20a5e4c88df2c1763cf10a"
> diff --git a/recipes-devtools/go/go-binary-native_1.25.6.bb b/recipes-
> devtools/go/go-binary-native_1.25.7.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.25.6.bb
> rename to recipes-devtools/go/go-binary-native_1.25.7.bb
> index 4326dbe..74f8e3b 100644
> --- a/recipes-devtools/go/go-binary-native_1.25.6.bb
> +++ b/recipes-devtools/go/go-binary-native_1.25.7.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "f022b6aad78e362bcba9b0b94d09ad58c5a70c6ba3b7582905fababf5fe0181a"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "738ef87d79c34272424ccdf83302b7b0300b8b096ed443896089306117943dd5"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "bee02dbe034b12b839ae7807a85a61c13bee09ee38f2eeba2074bd26c0c0ab73"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "12e6d6a191091ae27dc31f6efc630e3a3b8ba409baf3573d955b196fdf086005"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "ba611a53534135a81067240eff9508cd7e256c560edd5d8c2fef54f083c07129"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "42124c0edc92464e2b37b2d7fcd3658f0c47ebd6a098732415a522be8cb88e3f"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.25.6.bb b/recipes-
> devtools/go/go-cross-canadian_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.25.6.bb
> rename to recipes-devtools/go/go-cross-canadian_1.25.7.bb
> diff --git a/recipes-devtools/go/go-cross_1.25.6.bb b/recipes-devtools/go=
/go-
> cross_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.25.6.bb
> rename to recipes-devtools/go/go-cross_1.25.7.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.25.6.bb b/recipes-devtools=
/go/go-
> crosssdk_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.25.6.bb
> rename to recipes-devtools/go/go-crosssdk_1.25.7.bb
> diff --git a/recipes-devtools/go/go-runtime_1.25.6.bb b/recipes-devtools/=
go/go-
> runtime_1.25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.25.6.bb
> rename to recipes-devtools/go/go-runtime_1.25.7.bb
> diff --git a/recipes-devtools/go/go_1.25.6.bb b/recipes-devtools/go/go_1.=
25.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.25.6.bb
> rename to recipes-devtools/go/go_1.25.7.bb
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3230): https://lists.yoctoproject.org/g/yocto-
> patches/message/3230
> Mute This Topic: https://lists.yoctoproject.org/mt/117780646/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


